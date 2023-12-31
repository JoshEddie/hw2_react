import Row from './Row'
import Table from './Table'
import SearchBar from './SearchBar'
import CreateAccount from './CreateAccount'

import '../css/row.css'
import '../css/search.css'

import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import Axios from 'axios'

var customer = [
    //[first name], [last name], [phone number (pk)]
    ["John", "Doe", "1112223333"],
    ["Josh", "Eddie", "2223334444"],
    ["Rintra", "", "3334445555"],
    ["Bill", "", "4445556666"],
    ["Christine", "", "9998887777"]
]

var customers = []
for (var i = 0; i < customer.length; i++) {
    customers.push(<Row type={'cell'} items = {customer[i]} />);
}

function formatPhone(number) {

    if(number.length < 10 || number.length > 10) {
        return number;
    }

    return "(" + number.slice(0,3) + ") " + number.slice(3,6) + "-" + number.slice(6);

}

export default function AccountSearch({ setTransactionTime }) {

    const navigate = useNavigate();

    const [searchInput, setSearchInput] = useState("")
    const [accountList, setAccountList] = useState(false);
    const [showAccounts, setShowAccounts] = useState(false)
    const [searchType, setSearchType] = useState("First Name")

    function checkifAccountsExist() {

        var startTime = performance.now();

        Axios.get(`http://localhost:3002/api/getTable`, {
            params: {
                table: "phone_account",
                order: " ORDER BY account_no"
            }
        })
        .then(response => {
            return response.data;
        })
        .then(data => {
            
            if(data.name == "error") {
                console.log("Error")
                navigate('/admin')
                return;
            }
            else if(data.name == "No results") {
                console.log("No results")
                navigate('/admin')
                return;
            }

        })

        var endTime = performance.now();
        setTransactionTime(endTime - startTime)
        
    }

    function getAccount(input) {
        setSearchInput(input)
        if(input.length > 0) {
            var startTime = performance.now();
            fetch(`http://localhost:3002/api/accounts/${searchType}&${input}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                setAccountList([...data]);
                var endTime = performance.now();
                setTransactionTime(endTime - startTime)
            });
            setShowAccounts(true)
        }
        else {
            setShowAccounts(false)
        }
      }

    useEffect (() => {
        checkifAccountsExist();
    }, []);

    var accounts = []
    for (var i = 0; i < accountList.length; i++) {
        accountList[i][0] = formatPhone(accountList[i][0]);
        accounts.push(<Row type={'cell'} items = {accountList[i]} link = {`/account/${accountList[i][3]}`} />);
    }

    var headers = ['Phone', 'First Name', 'Last Name', 'Account Number']

    return (
        <section className="infoSection">

            <h3>Which Account do you need?</h3>
            <SearchBar searchInput={searchInput} searchType={setSearchType} getAccount={getAccount} defaultText={`Search by ${searchType}`} />
            <button onClick={() => navigate('/account/create')}>Create Account</button>
            {showAccounts ? 
            <Table headers={headers} rows={accounts} />
            : ''}

        </section>
    )

}