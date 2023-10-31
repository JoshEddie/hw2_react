import Row from './Row'
import Table from './Table'
import SearchBar from './SearchBar'

import '../css/row.css'
import '../css/search.css'

import { useState, useEffect } from 'react'
import { Outlet } from 'react-router-dom'

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

export default function Main() {

    const [searchInput, setSearchInput] = useState("")
    const [accountList, setAccountList] = useState(false);
    const [showAccounts, setShowAccounts] = useState(false)

    function getAccount(number) {
        setSearchInput(number)
        if(number.length > 0) {
            fetch(`http://localhost:3002/api/accounts/${number}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                // console.log("DATA: \n" + data.split(','))
                setAccountList([...data]);
            });
            setShowAccounts(true)
        }
        else {
            setShowAccounts(false)
        }
      }
      

    // useEffect(() => {
    //     getAccount();
    // }, [])

    var accounts = []
    for (var i = 0; i < accountList.length; i++) {
        accountList[i][0] = formatPhone(accountList[i][0]);
        accounts.push(<Row type={'cell'} items = {accountList[i]} link = {`/account/${accountList[i][3]}`} />);
    }

    // console.log(accounts);

    var headers = ['Phone', 'First Name', 'Last Name', 'Account Number']

    return (
        <main>
            <h1>Database HW2</h1>
            <h2><span class="greenText">Team Seven</span> Cell Phones</h2>
            <Outlet />
        </main>
    )

}