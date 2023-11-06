import Row from './Row'
import Table from './Table'
import { formatPhone } from './generalScripts'

import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

export default function AccountLines() {

    let { accountNumber } = useParams();

    var accountLinesHeaders = ['Phone Number', 'Phone Model', 'First Name', 'Last Name', 'Minutes Used', 'MB Used']
    const[accountLines, setAccountLines] = useState([])

    function getAccountLines() {
        fetch(`http://localhost:3002/api/accountLines/${accountNumber}`)
            .then(response => {
                return response.json();
            })
            .then(data => {
                setAccountLines([...data]);
            });
    }

    useEffect (() => {
        getAccountLines();
    }, []);

    var lines = []
    for (var i = 0; i < accountLines.length; i++) {
        accountLines[i][0] = formatPhone(accountLines[i][0]);
        console.log(accountLines[i][3])
        accountLines[i][3] = accountLines[i][3];
        lines.push(<Row type={'cell'} items = {accountLines[i]} />);
    }

    return (
        <>
        <h4>Account Lines:</h4>
        <Table headers={accountLinesHeaders} rows={lines} classes={'accountLines'}/>
        </>
    )

}