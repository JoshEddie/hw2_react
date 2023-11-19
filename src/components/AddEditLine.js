import { phone_models } from '../lists.js'
import { useEffect, useState } from "react";
import { useNavigate, useParams } from 'react-router-dom'
import Axios from 'axios'

export default function AddEditLine({setTransactionTime}) {

    const navigate = useNavigate();
    let { accountNumber, phoneNumber } = useParams();

    const[error, setError] = useState(false)
    const[errorMessage, setErrorMessage] = useState('')
    const[emptyClass, setEmptyClass] = useState('')

    const [firstName, setFirstName] = useState("")
    const [lastName, setLastName] = useState("")
    const [accountSSN, setAccountSSN] = useState("")
    const [dob, setDOB] = useState("")
    const [dobValue, setDOBValue] = useState("")
    const [phoneModel, setPhoneModel] = useState(phone_models[0])

    function parseDate(date) {
        var values = date.split('-')
        setDOBValue(date)
        setDOB(values[1] + '/' + values[2] + '/' + values[0])
    }

    function getLineDetails() {

        var startTime = performance.now();
        Axios.get(`http://localhost:3002/api/getLineInfo`, {
            params: {
                phoneNumber: phoneNumber
            }
        })
        .then(response => {

            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
            if(response.data == "No results") {
                return;
            }

            setFirstName(response.data[0].first_name);
            setLastName(response.data[0].last_name);
            setDOB(response.data[0].birthday.substring(0, 10));
            setDOBValue(response.data[0].birthday.substring(0, 10))
            setAccountSSN(response.data[0].ssn);
            setPhoneModel(response.data[0].model);
        });

    }

    function updateLine() {

        var startTime = performance.now();
        Axios.post(`http://localhost:3002/api/updateLine`, {
            ssn: accountSSN,
            firstName: firstName,
            lastName: lastName,
            phoneModel: phoneModel
        })
        .then(response => {
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
            if(response.data != 'Line Updated') {
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
            navigate(`/account/${accountNumber}/lines`)
        })

    }

    function createLine() {

        var startTime = performance.now();
        Axios.post(`http://localhost:3002/api/createLine`, {
            accountNo: accountNumber,
            ssn: accountSSN,
            firstName: firstName,
            lastName: lastName,
            dob: dob,
            phoneModel: phoneModel
        })
        .then(response => {
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
            if(response.data != 'Line Created') {
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
            navigate(`/account/${accountNumber}/lines`)
        })

    }

    function saveLine() {

        if(phoneNumber == '0') {
            createLine();
        }
        else {
            updateLine();
        }

    }

    var phone_models_options = []
    for(let i = 0; i < phone_models.length; i++) {
        phone_models_options.push(<option value={phone_models[i]}>{phone_models[i]}</option>)
    }

    useEffect (() => {
        getLineDetails();
    }, []);

    return(
        <>
        {error ? <div id="errorMessage">WARNING: Account Creation Failed{errorMessage}</div> : ''}
        <h3>{phoneNumber === '0' ? "Add" : "Edit"} Line:</h3>
        <p className="warning">WARNING: Please do not input sensitive date as this form is for test only and is not secure.</p>
        <div className="form">
            <label>Full Name:</label>
            <input id="firstNameInput" className={emptyClass} type="text" value={firstName} placeholder="First Name" onChange={(e) => setFirstName(e.target.value)} />
            <input id="lastNameInput" className={emptyClass} type="text" value={lastName} placeholder="Last Name" onChange={(e) => setLastName(e.target.value)} />
            
            <div id="birthdayColumn" className="column">
            <label>Birthday:</label>
            <input id="birthdayInput" className={phoneNumber === '0' ? emptyClass : emptyClass + ' lockedInput'} type="date" value={dobValue} placeholder="MM/DD/YYYY" name="birthday" onChange={(e) => parseDate(e.target.value)} readOnly={phoneNumber === '0' ? false : true}></input>
            </div>

            <div id="ssnColumn" className="column">
            <label>SSN:</label>
            <input id="ssnInput" className={phoneNumber === '0' ? emptyClass : emptyClass + ' lockedInput'} type="text" value={accountSSN} placeholder="SSN" maxLength="9" onChange={(e) => setAccountSSN(e.target.value)} readOnly={phoneNumber === '0' ? false : true}/>
            </div>

            <div id="phoneModelColumn" className="column">
                <label id="planType">Phone Model:</label>
                <select id="phoneModelInput" value={phoneModel} onChange={(e) => setPhoneModel(e.target.value)}>
                    {phone_models_options}
                </select>
            </div>
            
            <div id="editCreateAccount">
                <button className="cancel" onClick={() => navigate(`/account/${accountNumber}/lines`)}>Cancel</button>
                <button onClick={() => saveLine()}>{phoneNumber === '0' ? "Create Line" : "Save Change"}</button>
            </div>
        </div>
        </>
    )

}