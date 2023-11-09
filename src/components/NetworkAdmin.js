import { useEffect, useState } from "react";
import Row from './Row'
import Table from './Table'
import Warning from "./Warning";

import '../css/networkAdmin.css'
import { useNavigate } from "react-router-dom";
import Axios from 'axios'

export default function NetworkAdmin() {

    const navigate = useNavigate();

    const[error, setError] = useState(false)
    const[errorMessage, setErrorMessage] = useState('')

    const[databaseIntialized, setDatabaseIntialized] = useState(false)
    const[rowHeaders, setRowHeaders] = useState([])
    const[rows, setRows] = useState([])
    const[tableSelect, setTableSelect] = useState('account')
    const[showStatus, setShowStatus] = useState(false)
    const[databaseAction, setDatabaseAction] = useState('Database Intializing...')
    const[databaseStatus, setDatabaseStatus] = useState('')

    const[warningComponent, setWarningComponent] = useState('')

    function warning(continueAction) {

        setWarningComponent(<Warning cancelAction={setWarningComponent} continueAction={continueAction} tableSelect={''}/>)

    }

    function warningTable(continueAction) {

        setWarningComponent(<Warning cancelAction={setWarningComponent} continueAction={continueAction} tableSelect={tableSelect}/>)

    }

    function getTable(tableName) {
        let orderColumn = '';
        switch(tableName) {
            case 'account':
                orderColumn = ' ORDER BY account_ssn'
                break;
            case 'customer':
                orderColumn = ' ORDER BY account_holder_ssn'
                break;
            case 'phone_number':
                orderColumn = ' ORDER BY number'
                break;
            case 'phone_model':
                orderColumn = ' ORDER BY phone_number'
                break;
            case 'call':
                orderColumn = ' ORDER BY call_date DESC'
                break;
            case 'data':
                orderColumn = ' ORDER BY data_date DESC'
                break;
            case 'payment':
                orderColumn = ' ORDER BY payment_date DESC'
                break;
            default:
                orderColumn = ''
        }
        setError(false)
        Axios.get(`http://localhost:3002/api/getTable`, {
            params: {
                table: tableName,
                order: orderColumn
            }
        })
        .then(response => {
            return response.data;
        })
        .then(data => {
            if(data.name == "error") {
                console.log("Error")
                return;
            }
            else if(data.name == "No results") {
                setError(true)
                setErrorMessage("No results from " + tableName)
                console.log("No results")
                return;
            }
            var headers = []
            for (const [key, value] of Object.entries(data[0])) {
                headers.push(key)
            }
            var rows = []
            for(let i = 0; i < data.length; i++) {
                var row = []
                for (const [key, value] of Object.entries(data[i])) {
                    if(key == 'auto_payment' || key == 'pre_paid') {
                        row.push(value ? 'True' : 'False')
                    }
                    else {
                        row.push(value)
                    } 
                }
                rows.push(row)
            }
            setRowHeaders(headers)
            setRows(rows)
            setDatabaseIntialized(true)
        });
    }

    function deleteTable(table) {
        setShowStatus(true)
        setDatabaseAction('Deleting rows from ' + table)
        setDatabaseStatus('')
        fetch(`http://localhost:3002/api/delete/${table}`)
        .then(response => {
            setShowStatus(false)
        })
    }

    function dropTable(table) {
        setShowStatus(true)
        setDatabaseAction('Dropping ' + table)
        setDatabaseStatus('')
        fetch(`http://localhost:3002/api/drop/${table}`)
        .then(response => {
            setShowStatus(false)
        })
    }

    function droptables() {
        setShowStatus(true)
        setDatabaseAction('Dropping Tables...')
        setDatabaseStatus('')
        fetch(`http://localhost:3002/api/droptables`)
        .then(response => {
            navigate('/')
            setDatabaseStatus('')
        })
    }

    function reintializeDatabase() {
        setShowStatus(true)
        console.log("Dropping")
        setDatabaseAction('Dropping Tables...')
        setDatabaseStatus('')

        console.log("drop tables")
        fetch(`http://localhost:3002/api/droptables`)
        .then(response => {
            intializeDatabase()
        })
    }

    function intializeDatabase() {
        setShowStatus(true)
        setDatabaseAction('Database Intializing...')

        fetch(`http://localhost:3002/api/intializeDatabase`)
        .then(response => {
            return response.text();
        })
        .then(data => {
            console.log(data)
            setDatabaseStatus(data)
            intializeCallsData(1);
        });
        
    }

    function intializeCallsData(month) {

        fetch(`http://localhost:3002/api/intializeCallsData/${month}`)
        .then(response => {
            return response.text();
        })
        .then(data => {
            console.log(data)
            if (month == 10) {
                setDatabaseIntialized(true)
                getTable('account');
                setShowStatus(false)
                setDatabaseStatus('')
                return;
            }
            else {
                setDatabaseStatus(data)
                intializeCallsData(++month)
                return;
            }
        });

    }

    useEffect (() => {
        getTable('account');
    }, []);

    var rowObjects = []
    for (var i = 0; i < rows.length; i++) {
        rowObjects.push(<Row type={'cell'} items = {rows[i]} />);
    }

    return (
        <>
        <button id="switchtoAdmin" onClick={() => navigate('/')}>Account Search</button>
        <section className="infoSection" id="NetworkInfo">
        {error ? <div id="errorMessage">{errorMessage}</div> : ''}
        <h3>Network Admin</h3>
        {showStatus ? 
            <>
            <h3>{databaseAction}</h3>
            <h5>{databaseStatus}</h5>
            </>
            : 
            <>
            
            {databaseIntialized ? 
                <>
                <nav id="intializeDropDatabase">
                    <button onClick={() => warning(reintializeDatabase)}>Reintialize All Tables</button>
                    <button onClick={() => warning(droptables)}>Drop All Tables</button>
                </nav>
                <select id="tableSelectInput" onChange={(e) => setTableSelect(e.target.value)}>
                    <option value="account">Account</option>
                    <option value="customer">Customer</option>
                    <option value="phone_number">Phone Number</option>
                    <option value="phone_model">Phone Model</option>
                    <option value="call">Call</option>
                    <option value="data">Data</option>
                    <option value="payment">Payment</option>
                    <option value="bank_account">Bank Account</option>
                    <option value="plan">Plan</option>
                </select>
                <nav id="viewTables">
                    <button onClick={() => getTable(tableSelect)}>View</button>
                    <button onClick={() => warningTable(deleteTable)}>Delete</button>
                    {/* <button onClick={() => warningTable(dropTable)}>Drop</button> */}
                </nav>
                <Table headers={rowHeaders} rows={rowObjects}/>
                </>
                :
                <button onClick={() => intializeDatabase()}>Intialize All Tables</button>
            }
            </>
        }
        
        </section>
        {warningComponent}
        </>
    )
}