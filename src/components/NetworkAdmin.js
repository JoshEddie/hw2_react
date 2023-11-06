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

    function getTable(table) {
        fetch(`http://localhost:3002/api/get/${table}`)
        .then(response => {
            // console.log(response)
            return response.json();
        })
        .then(data => {
            console.log(data)
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
        fetch(`http://localhost:3002/api/intializeDatabase`)
        .then(response => {
            return response.json();
        })
        .then(data => {
            // setAccountList([...data]);
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
        {/* <h4>{databaseIntialized ? "Database Intialized" : "Database Needs to be Intialized"}</h4> */}
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
        
        </section>
        </>
    )
}