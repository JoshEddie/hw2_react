import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import Axios from 'axios'

export default function Billing() {

    const { accountNumber } = useParams();

    const[accountBalance, setAccountBalance] = useState('0')
    const[paymentInput, setPaymentInput] = useState([""])
    const[positiveNegative, setPositiveNegative] = useState(["negative"])

    function balancePositive(balance) {
        if (balance[0] == '-') {
            setPositiveNegative('negative')
        }
        else {
            setPositiveNegative('positive')
        }
    }

    function getAccountBalance() {
        fetch(`http://localhost:3002/api/accountBill/${accountNumber}`)
            .then(response => {
                return response.text();
            })
            .then(data => {
                setAccountBalance(data);
                balancePositive(data)
            });
    }

    function makePayment() {
        Axios.post(`http://localhost:3002/api/makePayment`, {
            accountSSN: accountNumber,
            paymentAmount: paymentInput
        })
        .then(response => {
            setAccountBalance(response.data)
            setPaymentInput('')
            balancePositive(response.data)
        })
    }

    useEffect (() => {
        getAccountBalance();
    }, []);

    return (
        <>
        <h3>Balance: <span className={positiveNegative}>{accountBalance}</span></h3>
        <div id="paymentInputWrapper">$<input placeholder="0.00" value={paymentInput} onChange={(e) => setPaymentInput(e.target.value)}></input></div>
        <button onClick={() => makePayment()}>Make Payment</button>
        </>
    )

}