import { useEffect, useState } from "react";
import Row from './Row'
import Table from './Table'

import '../css/networkAdmin.css'
import { useNavigate } from "react-router-dom";

export default function NetworkAdmin() {

    const navigate = useNavigate();

    const[databaseIntialized, setDatabaseIntialized] = useState(false)
    const[rowHeaders, setRowHeaders] = useState([])
    const[rows, setRows] = useState([])
    const[intializing, setIntialzing] = useState(false)
    const[intializingStatus, setIntialzingStatus] = useState('')

    function getTable(table) {
        fetch(`http://localhost:3002/api/get/${table}`)
        .then(response => {
            // console.log(response)
            return response.json();
        })
        .then(data => {
            if(data.name == "error") {
                console.log("Error")
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

    function intializeDatabase() {
        setIntialzing(true)
        fetch(`http://localhost:3002/api/intializeDatabase`)
        .then(response => {
            return response.text();
        })
        .then(data => {
            console.log(data)
            setIntialzingStatus(data)
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
                setIntialzing(false)
                return;
            }
            else {
                setIntialzingStatus(data)
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
        <section className="infoSection">
        <h3>Network Admin</h3>
        {intializing ? 
            <>
            <h3>Database Intializing...</h3>
            <h5>{intializingStatus}</h5>
            </>
            : 
            <>
            {databaseIntialized ? 
                <>
                <nav id="viewTables">
                    <button onClick={() => getTable('account')}>View Account</button>
                    <button onClick={() => getTable('customer')}>View Customer</button>
                    <button onClick={() => getTable('phone_number')}>View Phone Number</button>
                    <button onClick={() => getTable('phone_model')}>View Phone Model</button>
                    <button onClick={() => getTable('call')}>View Call</button>
                    <button onClick={() => getTable('data')}>View Data</button>
                    <button onClick={() => getTable('payment')}>View Payment</button>
                    <button onClick={() => getTable('plan')}>View Plan</button>
                </nav>
                <Table headers={rowHeaders} rows={rowObjects}/>
                </>
                :
                <button onClick={() => intializeDatabase()}>Intialize Database</button>
            }
            </>
        }
        
        </section>
        </>
    )
}