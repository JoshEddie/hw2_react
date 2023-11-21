import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import Axios from 'axios'
import Row from './Row'
import Table from './Table'

export default function Billing({ setTransactionTime }) {

    const { accountNumber } = useParams();

    const[paymentInput, setPaymentInput] = useState([""])

    const[phoneAccountBalance, setPhoneAccountBalance] = useState('0')
    const[phonePositiveNegative, setPhonePositiveNegative] = useState(["negative"])

    const[bankAccountBalance, setBankAccountBalance] = useState('0')
    const[bankPositiveNegative, setBankPositiveNegative] = useState(["negative"])

    const[rowHeaders, setRowHeaders] = useState([])
    const[rows, setRows] = useState([])

    const[startTime, setStartTime] = useState('');
    const[endTime, setEndTime] = useState('')

    function balancePositive(balance, tableName) {
        let negPos = 'positive'
        if (balance[0] == '-') {
            negPos = 'negative'
        }

        if(tableName == 'phone_account') {
            setPhonePositiveNegative(negPos);
        }
        else if(tableName == 'bank_account') {
            setBankPositiveNegative(negPos);
        }

    }

    function getAccountBalance() {
        Axios.get(`http://localhost:3002/api/accountBill`, {
            params: {
                accountNumber: accountNumber,
            }
        })
        .then(response => {
            setPhoneAccountBalance(response.data[0]);
            balancePositive(response.data[0], 'phone_account')
            setBankAccountBalance(response.data[1]);
            balancePositive(response.data[1], 'bank_account')
        });
    }

    function makePayment() {
        setStartTime(performance.now());
        Axios.post(`http://localhost:3002/api/makePayment`, {
            accountNo: accountNumber,
            paymentAmount: paymentInput
        })
        .then(response => {
            console.log(response.data)
            setPhoneAccountBalance(response.data[0])
            setBankAccountBalance(response.data[1])
            setPaymentInput('')
            balancePositive(response.data[0], 'phone_account')
            balancePositive(response.data[1], 'bank_account')
            getPayments();
            setEndTime(performance.now());
            setTransactionTime(endTime - startTime)
        })
    }

    function getPayments() {
        Axios.get(`http://localhost:3002/api/getPayments`, {
            params: {
                accountNo: accountNumber
            }
        })
        .then(response => {
            return response.data;
        })
        .then(data => {

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

        })

    }

    useEffect (() => {
        getAccountBalance();
        getPayments();
    }, []);

    var rowObjects = []
    for (var i = 0; i < rows.length; i++) {
        rowObjects.push(<Row type={'cell'} items = {rows[i]} />);
    }

    return (
        <>
        <h3>Account Balance: <span className={phonePositiveNegative}>{phoneAccountBalance}</span></h3>
        <div id="paymentInputWrapper">$<input placeholder="0.00" value={paymentInput} onChange={(e) => setPaymentInput(e.target.value)}></input></div>
        <button onClick={() => makePayment()}>Make Payment</button>

        <h3>Bank Balance: <span className={bankPositiveNegative}>{bankAccountBalance}</span></h3>
        <div id="paymentsTable" >
            <Table headers={rowHeaders} rows={rowObjects}/>
        </div>
        </>
    )

}