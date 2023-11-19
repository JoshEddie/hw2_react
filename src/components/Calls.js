import Axios from 'axios'
import { useState, useEffect } from "react";
import { useParams } from "react-router-dom"

import Row from './Row'
import Table from './Table'
import { formatPhone } from './generalScripts'

function timeFormat(minutes) {

    if(Number.isNaN(Number(minutes))) {
        return minutes;
    }
    var hours = Math.floor(Number(minutes) / 60);
    var mins = minutes % 60;

    return hours.toString().padStart(2, '0') + ":" + mins.toString().padStart(2, '0');
}

export default function Calls({ setTransactionTime }) {

    const { accountNumber } = useParams();

    const[accountLines, setAccountLines] = useState([])

    var callsHeaders = ['Call From', 'Call To', 'Call Length', 'Date', 'Time'];
    const[calls, setCalls] = useState([]);
    const[currentNum, setCurrentNum] = useState('')

    function getCalls(number) {
        setCurrentNum(number);
        var startTime = performance.now()
        Axios.get(`http://localhost:3002/api/getCalls`, {
            params: {
                accountNo: accountNumber,
                phone_num: number
            }
        })
        .then(response => {
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
            if(response.data != "No results") {
                setCalls(response.data);
            }
            else {
                setCalls([])
            }
        });

    }

    function simulateCall() {

        Axios.post(`http://localhost:3002/api/simulateCall`, {
            phone_num: currentNum,
            accountNo: accountNumber
        })
        .then(response => {
            getCalls(currentNum);
        })

    }

    var callRows = []
    for (var i = 0; i < calls.length; i++) {
        calls[i][0] = formatPhone(calls[i][0]);
        calls[i][1] = formatPhone(calls[i][1]);
        calls[i][2] = timeFormat(calls[i][2]);
        callRows.push(<Row type={'cell'} items = {calls[i]} />);
    }

    function getAccountLines() {
        var startTime = performance.now();
        fetch(`http://localhost:3002/api/accountLines/${accountNumber}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                var endTime = performance.now();
                setTransactionTime(endTime - startTime);
                setAccountLines([...data]);
                getCalls(data[0][0]);
            });
    }

    useEffect (() => {
        getAccountLines();
    }, []);

    var lineFilterOptions = []
    for(let i = 0; i < accountLines.length; i++) {
        lineFilterOptions.push(<option value={accountLines[i][0]}>{formatPhone(accountLines[i][0])}</option>)
    }

    return (
        <>
        <label>Filter Calls: </label>
        <select id="lineFilter" onChange={(e) => getCalls(e.target.value)}>
            {lineFilterOptions}
        </select>
        <button id="simulateCallData" onClick={() => simulateCall()}>Simulate Call for {formatPhone(currentNum)}</button>
        <Table headers={callsHeaders} rows={callRows} classes={'callsData'}/>
        </>
    );
}