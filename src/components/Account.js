import { useEffect, useState } from "react";
import { useNavigate, useParams, Outlet } from "react-router-dom";
import Axios from 'axios'

import Row from './Row'
import Table from './Table'
import Warning from "./Warning";

import '../css/account.css';

export default function Account({accountDetails, setAccountDetails}) {

    const navigate = useNavigate();
    let { accountNumber } = useParams();

    const[warningComponent, setWarningComponent] = useState('')

    function warning() {

        setWarningComponent(<Warning 
            warningHeader= "Sign Out?"
            warningText="Are you sure you want to sign out?"
            cancelAction={setWarningComponent} 
            continueAction={() => navigate('/')} 
            tableSelect={''}/>)

    }

    function getAccountDetails() {

        fetch(`http://localhost:3002/api/accountDetails/${accountNumber}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                setAccountDetails([...data])
            });

    }

    useEffect (() => {
        getAccountDetails();
    }, []);

    var accountDetailsHeaders = ['Plan Type', 'Street', 'City', 'State', 'Zip Code']

    return (
        <>
            <section className="infoSection">

                    <h3>Account: {accountNumber}</h3>
                    <Table 
                        headers={accountDetailsHeaders} 
                        rows={
                            [<Row type={'cell'} 
                                items = {accountDetails} />
                            ]} 
                        classes={'accountDetails'}/>
                    <nav id="accountNav">
                        <button onClick={() => navigate('')}>Billing</button>
                        <button onClick={() => navigate('lines')}>Lines</button>
                        <button onClick={() => navigate('calls')}>Calls</button>
                        <button onClick={() => navigate('datause')}>Data Use</button>
                        <button onClick={() => navigate('editinfo')}>Edit Info</button>
                        <button onClick={() => warning()}>Sign Out</button>
                    </nav>
                    <Outlet />

            </section>
            {warningComponent}
            </>
    )
    
}