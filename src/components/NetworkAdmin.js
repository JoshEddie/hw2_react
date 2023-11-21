import { useEffect, useState } from "react";
import Row from './Row'
import Table from './Table'
import Warning from "./Warning";

import '../css/networkAdmin.css'
import { useNavigate } from "react-router-dom";
import Axios from 'axios'

export default function NetworkAdmin({ setTransactionTime }) {

    const navigate = useNavigate();

    const[error, setError] = useState(false)
    const[errorMessage, setErrorMessage] = useState('')

    const[databaseIntialized, setDatabaseIntialized] = useState(false)
    const[rowHeaders, setRowHeaders] = useState([])
    const[rows, setRows] = useState([])
    const[tableSelect, setTableSelect] = useState('phone_account')
    const[showStatus, setShowStatus] = useState(false)
    const[databaseAction, setDatabaseAction] = useState('Database Intializing...')
    const[databaseStatus, setDatabaseStatus] = useState('')

    const[startTime, setStartTime] = useState('');
    const[endTime, setEndTime] = useState('')

    const[warningComponent, setWarningComponent] = useState('')

    function warning(continueAction) {

        setWarningComponent(<Warning 
            warningHeader = "Warning"
            warningText="Proceeding may cause the database to no longer function. Would you like to continue?"
            cancelAction={setWarningComponent} 
            continueAction={continueAction} 
            tableSelect={''}/>)

    }

    function warningTable(continueAction) {

        setWarningComponent(<Warning cancelAction={setWarningComponent} continueAction={continueAction} tableSelect={tableSelect}/>)

    }

    function extractTable(data) {

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

    }

    function getReport(reportName) {

        var startTime = performance.now()
        Axios.get(`http://localhost:3002/api/report/${reportName}`)
        .then(response => {
            extractTable(response.data);
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
        })

    }

    function getTable(tableName) {
        let orderColumn = '';
        switch(tableName) {
            case 'phone_account':
                orderColumn = ' ORDER BY account_no'
                break;
            case 'customer':
                orderColumn = ' ORDER BY account_no'
                break;
            case 'phone':
                orderColumn = ' ORDER BY number'
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
            case 'bank_account':
                orderColumn = ' ORDER BY account_no'
                break;
            default:
                orderColumn = ''
        }
        setError(false)

        setStartTime(performance.now());

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
            setEndTime(performance.now());
            setTransactionTime(endTime - startTime)

            extractTable(data);

            setDatabaseIntialized(true)
        });

    }

    function deleteTable(table) {
        setShowStatus(true)
        setDatabaseAction('Deleting rows from ' + table)
        setDatabaseStatus('')
        setStartTime(performance.now());
        fetch(`http://localhost:3002/api/delete/${table}`)
        .then(response => {
            setShowStatus(false)
            setEndTime(performance.now());
            setTransactionTime(endTime - startTime);
        })
    }

    function droptables() {
        setShowStatus(true)
        setDatabaseAction('Dropping Tables...')
        setDatabaseStatus('')
        setStartTime(performance.now());
        fetch(`http://localhost:3002/api/droptables`)
        .then(response => {
            setEndTime(performance.now());
            setTransactionTime(endTime - startTime);
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
                getTable('phone_account');
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
        getTable('phone_account');
    }, []);

    var rowObjects = []
    for (var i = 0; i < rows.length; i++) {
        rowObjects.push(<Row type={'cell'} items = {rows[i]} />);
    }

    return (
        <>
        <button id="switchtoAdmin" onClick={() => navigate('/')}>User Interface</button>
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
                    <option value="phone_account">Phone Account</option>
                    <option value="customer">Customer</option>
                    <option value="phone">Phone</option>
                    <option value="call">Call</option>
                    <option value="data">Data</option>
                    <option value="payment">Payment</option>
                    <option value="payment_method">Payment Method</option>
                    <option value="bank_account">Bank Account</option>
                    <option value="plan">Plan</option>
                </select>
                <nav id="viewTables">
                    <button onClick={() => getTable(tableSelect)}>View</button>
                    <button onClick={() => warningTable(deleteTable)}>Delete</button>
                    {/* <button onClick={() => warningTable(dropTable)}>Drop</button> */}
                </nav>
                <nav id="reportNav">
                        <button onClick={() => getReport('maxMinAvgSpend')}>High/Low/Avg Spend</button>
                        <button onClick={() => getReport('highestGrossingPlan')}>Plan Gross</button>
                        <button onClick={() => getReport('mostPopularPlan')}>Popular Plan</button>
                        <button onClick={() => getReport('mostPopularPhoneModel')}>Popular Models</button>
                        <button onClick={() => getReport('numberCustomersPerState')}>Customer Location</button>
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