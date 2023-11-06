import { useEffect, useState } from "react";
import { useNavigate } from 'react-router-dom'

import '../css/createAccount.css'
import Axios from 'axios'

export default function CreateAccount() {

    const navigate = useNavigate();

    const [firstName, setFirstName] = useState("")
    const [lastName, setLastName] = useState("")
    const [accountSSN, setAccountSSN] = useState("")
    const [autoPayment, setAutoPayment] = useState(false)
    const [streetAddress, setStreetAddress] = useState("")
    const [city, setCity] = useState("")
    const [state, setState] = useState("AL")
    const [zipCode, setZipCode] = useState("")
    const [dob, setDOB] = useState("")
    const [phoneModel, setPhoneModel] = useState("")
    const [planType, setPlanType] = useState("Internet Lover")
    const [planRates, setPlanRates] = useState([0, 0])

    function parseDate(date) {
        var values = date.split('-')
        setDOB(values[1] + '/' + values[2] + '/' + values[0])
    }

    function createAccount() {
        Axios.post(`http://localhost:3002/api/createAccount`, {
            accountSSN: accountSSN,
            planType: planType,
            autoPayment: autoPayment,
            streetAddress: streetAddress,
            city: city,
            state: state,
            zipCode: zipCode,
            firstName: firstName,
            lastName: lastName,
            dob: dob
        })
        .then((response) => {
            // console.log(response);
        });
        console.log("Account Created")

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

    return (
    <div className="infoSection">
        <h3>Create Account</h3>
        <p className="warning">WARNING: Please do not input sensitive date as this form is for test only and is not secure.</p>
        <div className="form">
            <label>Full Name:</label>
            <input id="firstNameInput" type="text" placeholder="First Name" onChange={(e) => setFirstName(e.target.value)} />
            <input id="lastNameInput" type="text" placeholder="Last Name" onChange={(e) => setLastName(e.target.value)} />
            
            <label>Address:</label>
            <input id="streetInput" type="text" placeholder="Street Address" onChange={(e) => setStreetAddress(e.target.value)} />
            <input id="cityInput" type="text" placeholder="City" onChange={(e) => setCity(e.target.value)} />
            <select id="stateInput" onChange={(e) => setState(e.target.value)}>
                <option value="AL">AL</option>
                <option value="AK">AK</option>
                <option value="AZ">AZ</option>
                <option value="AR">AR</option>
                <option value="CA">CA</option>
                <option value="CO">CO</option>
                <option value="CT">CT</option>
                <option value="DE">DE</option>
                <option value="DC">DC</option>
                <option value="FL">FL</option>
                <option value="GA">GA</option>
                <option value="HI">HI</option>
                <option value="ID">ID</option>
                <option value="IL">IL</option>
                <option value="IN">IN</option>
                <option value="IA">IA</option>
                <option value="KS">KS</option>
                <option value="KY">KY</option>
                <option value="LA">LA</option>
                <option value="ME">ME</option>
                <option value="MD">MD</option>
                <option value="MA">MA</option>
                <option value="MI">MI</option>
                <option value="MN">MN</option>
                <option value="MS">MS</option>
                <option value="MO">MO</option>
                <option value="MT">MT</option>
                <option value="NE">NE</option>
                <option value="NV">NV</option>
                <option value="NH">NH</option>
                <option value="NJ">NJ</option>
                <option value="NM">NM</option>
                <option value="NY">NY</option>
                <option value="NC">NC</option>
                <option value="ND">ND</option>
                <option value="OH">OH</option>
                <option value="OK">OK</option>
                <option value="OR">OR</option>
                <option value="PA">PA</option>
                <option value="RI">RI</option>
                <option value="SC">SC</option>
                <option value="SD">SD</option>
                <option value="TN">TN</option>
                <option value="TX">TX</option>
                <option value="UT">UT</option>
                <option value="VT">VT</option>
                <option value="VA">VA</option>
                <option value="WA">WA</option>
                <option value="WV">WV</option>
                <option value="WI">WI</option>
                <option value="WY">WY</option>
            </select>
            <input id="zipCodeInput" type="text" placeholder="Zip Code" maxlength="5" onChange={(e) => setZipCode(e.target.value)} />
            
            <div id="birthdayColumn" className="column">
            <label>Birthday:</label>
            <input id="birthdayInput" type="date" name="birthday" onChange={(e) => parseDate(e.target.value)}></input>
            </div>

            <div id="ssnColumn" className="column">
            <label>SSN:</label>
            <input id="ssnInput" type="text" placeholder="SSN" maxlength="9" onChange={(e) => setAccountSSN(e.target.value)} />
            </div>

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
            
            <button onClick={() => createAccount()}>Create Account</button>
            <button onClick={() => navigate('/')}>Cancel</button>
        </div>
    </div>
    )

}