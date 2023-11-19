import { useEffect, useState } from "react";
import { useNavigate } from 'react-router-dom'

import { phone_models, state_names } from '../lists.js'
import '../css/createAccount.css'
import Axios from 'axios'

export default function EditInfo() {

    const navigate = useNavigate();

    const[error, setError] = useState(false)
    const[errorMessage, setErrorMessage] = useState('')
    const[emptyClass, setEmptyClass] = useState('')

    const [firstName, setFirstName] = useState("")
    const [lastName, setLastName] = useState("")
    const [accountSSN, setAccountSSN] = useState("")
    const [autoPayment, setAutoPayment] = useState(false)
    const [streetAddress, setStreetAddress] = useState("")
    const [city, setCity] = useState("")
    const [state, setState] = useState(state_names[0])
    const [zipCode, setZipCode] = useState("")
    const [dob, setDOB] = useState("")
    const [phoneModel, setPhoneModel] = useState(phone_models[0])
    const [planType, setPlanType] = useState("Internet Lover")
    const [planRates, setPlanRates] = useState([0, 0])

    function parseDate(date) {
        var values = date.split('-')
        setDOB(values[1] + '/' + values[2] + '/' + values[0])
    }

    function editAccount() {

    }

    var state_options = []
    for(let i = 0; i < state_names.length; i++) {
        state_options.push(<option value={state_names[i]}>{state_names[i]}</option>)
    }

    var phone_models_options = []
    for(let i = 0; i < phone_models.length; i++) {
        phone_models_options.push(<option value={phone_models[i]}>{phone_models[i]}</option>)
    }

    return (
        <>
        <h3>Edit Account</h3>
        <p className="warning">WARNING: Please do not input sensitive date as this form is for test only and is not secure.</p>
        <div className="form">            
            <label>Address:</label>
            <input id="streetInput" className={emptyClass} type="text" placeholder="Street Address" onChange={(e) => setStreetAddress(e.target.value)} />
            <input id="cityInput" className={emptyClass} type="text" placeholder="City" onChange={(e) => setCity(e.target.value)} />
            <select id="stateInput" onChange={(e) => setState(e.target.value)}>
                {state_options}
            </select>
            <input id="zipCodeInput" className={emptyClass} type="text" placeholder="Zip Code" maxlength="5" onChange={(e) => setZipCode(e.target.value)} />

            <div id="paymentColumn" className="column">
                <label id="autoPayment">Payment:</label>
                <select id="autoPaymentSelect" onChange={(e) => setAutoPayment(e.target.value)}>
                    <option value="true">Auto Withdraw</option>
                    <option value="false">Manual</option>
                </select>
            </div>

            <div id="planTypeColumn" className="column">
                <label id="planType">Plan Type:</label>
                <select id="planTypeSelect" onChange={(e) => setPlanType(e.target.value)}>
                    <option value="Internet Lover">Internet Lover</option>
                    <option value="Talker">Talker</option>
                    <option value="Want it All">Want it All</option>
                    <option value="Pre-Paid">Pre-Paid</option>
                </select>
                <div className="rates">{planRates[0]} per Minute, {planRates[1]} per GB</div>
            </div>
            
            
            <button onClick={() => editAccount()}>Save Changes</button>
            <button onClick={() => navigate('/')}>Cancel</button>
        </div>
        </>
        )
}