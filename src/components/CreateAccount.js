import { useEffect, useState } from "react";
import { useNavigate } from 'react-router-dom'

import { phone_models, state_names } from '../lists.js'
import '../css/createAccount.css'
import Axios from 'axios'

export default function CreateAccount({ setTransactionTime }) {

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

    function createAccount() {
        var startTime = performance.now();
        Axios.post(`http://localhost:3002/api/createAccount`, {
            ssn: accountSSN,
            planType: planType,
            autoPayment: autoPayment,
            streetAddress: streetAddress,
            city: city,
            state: state,
            zipCode: zipCode,
            firstName: firstName,
            lastName: lastName,
            dob: dob,
            phoneModel: phoneModel
        })
        .then(response => {
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
            console.log(response.data); 
            if(response.data[0] != 'Account Created') {
                if(response.data == 23505) {
                    setErrorMessage(' - SSN already exists.')
                }
                else if(response.data == 23514) {
                    setEmptyClass('empty')
                    setErrorMessage(' - Required Fields Missing.')
                }
                else if (response.data == 22007) {
                    setErrorMessage(' - Invalid Birthdate.')
                }
                setError(true)
                return;
            }
            navigate(`/account/${response.data[1]}`)
            console.log("Account Created")
        });

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
        getPlanRates();
    }, [planType]);

    var state_options = []
    for(let i = 0; i < state_names.length; i++) {
        state_options.push(<option value={state_names[i]}>{state_names[i]}</option>)
    }

    var phone_models_options = []
    for(let i = 0; i < phone_models.length; i++) {
        phone_models_options.push(<option value={phone_models[i]}>{phone_models[i]}</option>)
    }

    return (
    <div className="infoSection">
        {error ? <div id="errorMessage">WARNING: Account Creation Failed{errorMessage}</div> : ''}
        <h3>Create Account</h3>
        <p className="warning">WARNING: Please do not input sensitive date as this form is for test only and is not secure.</p>
        <div className="form">
            <label>Full Name:</label>
            <input id="firstNameInput" className={emptyClass} type="text" placeholder="First Name" onChange={(e) => setFirstName(e.target.value)} />
            <input id="lastNameInput" className={emptyClass} type="text" placeholder="Last Name" onChange={(e) => setLastName(e.target.value)} />
            
            <label>Address:</label>
            <input id="streetInput" className={emptyClass} type="text" placeholder="Street Address" onChange={(e) => setStreetAddress(e.target.value)} />
            <input id="cityInput" className={emptyClass} type="text" placeholder="City" onChange={(e) => setCity(e.target.value)} />
            <select id="stateInput" onChange={(e) => setState(e.target.value)}>
                {state_options}
            </select>
            <input id="zipCodeInput" className={emptyClass} type="text" placeholder="Zip Code" maxLength="5" onChange={(e) => setZipCode(e.target.value)} />
            
            <div id="birthdayColumn" className="column">
            <label>Birthday:</label>
            <input id="birthdayInput" className={emptyClass} type="date" placeholder="MM/DD/YYYY" name="birthday" onChange={(e) => parseDate(e.target.value)}></input>
            </div>

            <div id="ssnColumn" className="column">
            <label>SSN:</label>
            <input id="ssnInput" className={emptyClass} type="text" placeholder="SSN" maxLength="9" onChange={(e) => setAccountSSN(e.target.value)} />
            </div>

            <div id="paymentColumn" className="column">
                <label id="autoPayment">Payment:</label>
                <select id="autoPaymentSelect" onChange={(e) => setAutoPayment(e.target.value)}>
                    <option value="true">Auto Withdraw</option>
                    <option value="false">Manual</option>
                </select>
            </div>

            <div id="phoneModelColumn" className="column">
                <label id="planType">Phone Model:</label>
                <select id="phoneModelInput" onChange={(e) => setPhoneModel(e.target.value)}>
                    {phone_models_options}
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
            
            <div id="editCreateAccount">
                <button className="cancel" onClick={() => navigate('/')}>Cancel</button>
                <button onClick={() => createAccount()}>Create Account</button>
            </div>
        </div>
    </div>
    )

}