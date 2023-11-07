import Row from './Row'
import Table from './Table'
import SearchBar from './SearchBar'
import { formatPhone } from './generalScripts'

import '../css/row.css'
import '../css/search.css'

import { useState, useEffect } from 'react'
import { Outlet, useNavigate } from 'react-router-dom'

export default function Main() {

    const navigate = useNavigate();

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
        <main>
            <button id="switchtoAdmin" onClick={() => navigate('/admin')}>Network Admin</button>
            <h1>Database HW2</h1>
            <h2><span className="greenText">Team Seven</span> Cell Phones</h2>
            <Outlet />
        </main>
    )

}