import Main from './components/Main'
import AccountSearch from './components/AccountSearch'
import CreateAccount from './components/CreateAccount';
import Account from './components/Account'
import AccountLines from './components/AccountLines'
import Billing from './components/Billing';
import Calls from './components/Calls';
import DataUse from './components/DataUse';
import EditInfo from './components/EditInfo';
import NetworkAdmin from './components/NetworkAdmin';
import './css/main.css';

import { HashRouter, BrowserRouter, Routes, Route, useParams } from "react-router-dom";
import { useState } from 'react';

function App() {

  const [transactionTime, setTransactionTime] = useState('0');
  
  return (
    <HashRouter>
      <Routes>
        <Route path="" element={<Main transactionTime={transactionTime}/>}>
          <Route path="admin" element={<NetworkAdmin setTransactionTime={setTransactionTime}/>} />
          <Route path="" element={<AccountSearch setTransactionTime={setTransactionTime}/>} />
          <Route path="account/create" element={<CreateAccount setTransactionTime={setTransactionTime}/>} />
          <Route path="account/:accountNumber" element={<Account setTransactionTime={setTransactionTime}/>}>
            <Route path="" element={<Billing setTransactionTime={setTransactionTime}/>}/>
            <Route path="lines" element={<AccountLines setTransactionTime={setTransactionTime}/>}/>
            <Route path="calls" element={<Calls setTransactionTime={setTransactionTime}/>}/>
            <Route path="datause" element={<DataUse setTransactionTime={setTransactionTime}/>}/>
            <Route path="editinfo" element={<EditInfo setTransactionTime={setTransactionTime}/>}/>
          </Route>
        </Route>
      </Routes>
    </HashRouter>
  );
}

export default App;
