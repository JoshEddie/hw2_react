import Row from './Row'
import Table from './Table'
import { formatPhone } from './generalScripts'

import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

export default function AccountLines({ setTransactionTime }) {

    const navigate = useNavigate();
    let { accountNumber } = useParams();

    var accountLinesHeaders = ['Phone Number', 'Phone Model', 'First Name', 'Last Name', 'Minutes Used', 'MB Used']
    const[accountLines, setAccountLines] = useState([])

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
            });
    }

    useEffect (() => {
        getAccountLines();
    }, []);

    var lines = []
    for (var i = 0; i < accountLines.length; i++) {
        const unformattedPhone = accountLines[i][0];
        accountLines[i][0] = formatPhone(accountLines[i][0]);
        accountLines[i][3] = accountLines[i][3];
        lines.push(<Row type={'cell'} items = {accountLines[i]} link = {`${unformattedPhone}`}/>);
    }

    return (
        <>
        <h4>Account Lines:</h4>
        <Table headers={accountLinesHeaders} rows={lines} classes={'accountLines'}/>
        <button onClick={() => navigate(`0`)}>Add Line</button>
        </>
    )

}