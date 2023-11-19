import { useEffect, useState } from "react";
import { useNavigate, useParams } from 'react-router-dom'

import { phone_models, state_names } from '../lists.js'
import '../css/createAccount.css'
import Axios from 'axios'

export default function EditInfo({accountDetails, setAccountDetails, setTransactionTime}) {

    const navigate = useNavigate();
    const { accountNumber } = useParams();

    const[error, setError] = useState(false)
    const[errorMessage, setErrorMessage] = useState('')
    const[emptyClass, setEmptyClass] = useState('')

    const [streetAddress, setStreetAddress] = useState("")
    const [city, setCity] = useState("")
    const [state, setState] = useState("")
    const [zipCode, setZipCode] = useState("")
    const [planType, setPlanType] = useState("Talker")
    const [planRates, setPlanRates] = useState([0, 0])

    // const[accountDetails, setAccountDetails] = useState([]);

    function getAccountDetails() {

        setPlanType(accountDetails[0]);
        setStreetAddress(accountDetails[1]);
        setCity(accountDetails[2]);
        setState(accountDetails[3]);
        setZipCode(accountDetails[4]);
        setError(false);
        setEmptyClass('');

    }

    function editAccount() {

        Axios.post(`http://localhost:3002/api/updateAccountDetails`, {
            accountNo: accountNumber,
            planType: planType,
            streetAddress: streetAddress,
            city: city,
            state: state,
            zipCode: zipCode
        })
        .then(response => {
            if(response.data != 'Account Updated') {
                if(response.data == 23514) {
                    setEmptyClass('empty')
                    setErrorMessage(' - Required Fields Missing.')
                }
                setError(true)
                return;
            }
            setAccountDetails([planType, streetAddress, city, state, zipCode])
            console.log("changed saved")
        })

    }

    function getPlanRates() {

        fetch(`http://localhost:3002/api/planRates/${planType}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                setPlanRates(data)
            });

    }

    useEffect(() => {
        getAccountDetails();
        getPlanRates();
    }, []);

    var state_options = []
    for(let i = 0; i < state_names.length; i++) {
        state_options.push(<option value={state_names[i]}>{state_names[i]}</option>)
    }

    return (
        <>
        {error ? <div id="errorMessage">WARNING: Account Update Failed{errorMessage}</div> : ''}
        <h3>Edit Account</h3>
        <p className="warning">WARNING: Please do not input sensitive date as this form is for test only and is not secure.</p>
        <div className="form">            
            <label>Address:</label>
            <input id="streetInput" className={emptyClass} type="text" value={streetAddress} placeholder="Street Address" onChange={(e) => setStreetAddress(e.target.value)} />
            <input id="cityInput" className={emptyClass} type="text" value={city} placeholder="City" onChange={(e) => setCity(e.target.value)} />
            <select id="stateInput" value={state} onChange={(e) => setState(e.target.value)}>
                {state_options}
            </select>
            <input id="zipCodeInput" className={emptyClass} type="text" value={zipCode} placeholder="Zip Code" maxLength="5" onChange={(e) => setZipCode(e.target.value)} />

            <div id="planTypeColumn" className="column">
                <label id="planType">Plan Type:</label>
                <select id="planTypeSelect" value={planType} onChange={(e) => setPlanType(e.target.value)}>
                    <option value="Internet Lover">Internet Lover</option>
                    <option value="Talker">Talker</option>
                    <option value="Want it All">Want it All</option>
                    <option value="Pre-Paid">Pre-Paid</option>
                </select>
                <div className="rates">{planRates[0]} per Minute, {planRates[1]} per GB</div>
            </div>
            
            <div id="editCreateAccount">
                <button className="cancel" onClick={() => getAccountDetails()}>Revert</button>
                <button onClick={() => editAccount()}>Save Changes</button>
            </div>
            
        </div>
        </>
        )
}