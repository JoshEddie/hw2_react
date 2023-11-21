import Axios from 'axios'
import { useState, useEffect } from "react";
import { useParams } from "react-router-dom"

import Row from './Row'
import Table from './Table'
import { formatPhone } from './generalScripts'

export default function DataUse({ setTransactionTime }) {

    const { accountNumber } = useParams();

    const[accountLines, setAccountLines] = useState([])

    var dataHeaders = ['Phone Number', 'MB Used', 'Date', 'Time'];
    const[dataUse, setDataUse] = useState([]);
    const[currentNum, setCurrentNum] = useState('')

    function getData(number) {
        setCurrentNum(number);
        var startTime = performance.now()
        Axios.get(`http://localhost:3002/api/getData`, {
            params: {
                accountNo: accountNumber,
                phone_num: number
            }
        })
        .then(response => {
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
            if(response.data != "No results") {
                setDataUse(response.data);
            }
            else {
                setDataUse([])
            }
        });
    }

    function simulateData() {

        var startTime = performance.now()
        Axios.post(`http://localhost:3002/api/simulateData`, {
            phone_num: currentNum,
            accountNo: accountNumber
        })
        .then(response => {
            getData(currentNum);
            var endTime = performance.now();
            setTransactionTime(endTime - startTime);
        })

    }

    var dataRows = []
    for (var i = 0; i < dataUse.length; i++) {
        dataUse[i][0] = formatPhone(dataUse[i][0]);
        dataRows.push(<Row type={'cell'} items = {dataUse[i]} />);
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
                getData(data[0][0]);
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
        <label>Filter Data: </label>
        <select id="lineFilter" onChange={(e) => getData(e.target.value)}>
            {lineFilterOptions}
        </select>
        <button id="simulateCallData" onClick={() => simulateData()}>Simulate Data for {formatPhone(currentNum)}</button>
        <Table headers={dataHeaders} rows={dataRows} classes={'callsData'}/>
        </>
    );
}