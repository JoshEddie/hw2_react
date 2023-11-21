import '../css/row.css'
import '../css/search.css'

import { Outlet, useNavigate } from 'react-router-dom'

export default function Main({transactionTime}) {

    const navigate = useNavigate();

    return (
        <main>
            <button id="switchtoAdmin" onClick={() => navigate('/admin')}>Network Admin</button>
            <h1>Database HW2</h1>
            <h2><span className="greenText">Team Seven</span> Cell Phones</h2>
            <Outlet />
            <div id="transactionTime">Query/Transaction Time: {transactionTime} ms</div>
        </main>
    )

}