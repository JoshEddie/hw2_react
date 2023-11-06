import Row from './Row'
import Table from './Table'
import SearchBar from './SearchBar'
import CreateAccount from './CreateAccount'

import '../css/row.css'
import '../css/search.css'

import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

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

export default function AccountSearch() {

    const navigate = useNavigate();

    const [searchInput, setSearchInput] = useState("")
    const [accountList, setAccountList] = useState(false);
    const [showAccounts, setShowAccounts] = useState(false)
    const [searchType, setSearchType] = useState("Phone Number")

    function getAccount(input) {
        setSearchInput(input)
        if(input.length > 0) {
            fetch(`http://localhost:3002/api/accounts/${searchType}&${input}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                setAccountList([...data]);
            });
            setShowAccounts(true)
        }
        else {
            setShowAccounts(false)
        }
      }

    var accounts = []
    for (var i = 0; i < accountList.length; i++) {
        accountList[i][0] = formatPhone(accountList[i][0]);
        accounts.push(<Row type={'cell'} items = {accountList[i]} link = {`/account/${accountList[i][3]}`} />);
    }

    var headers = ['Phone', 'First Name', 'Last Name', 'Account Number']

    return (
        <section class="infoSection">

            <h3>Which Account do you need?</h3>
            <SearchBar searchInput={searchInput} searchType={setSearchType} getAccount={getAccount} defaultText={`Search by ${searchType}`} />
            <button onClick={() => navigate('/account/create')}>Create Account</button>
            {showAccounts ? 
            <Table headers={headers} rows={accounts} />
            : ''}

        </section>
    )

}