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

function App() {
  
  return (
    <HashRouter>
      <Routes>
        <Route path="" element={<Main />}>
          <Route path="admin" element={<NetworkAdmin />} />
          <Route path="" element={<AccountSearch />} />
          <Route path="account/create" element={<CreateAccount />} />
          <Route path="account/:accountNumber" element={<Account />}>
            <Route path="" element={<Billing />}/>
            <Route path="lines" element={<AccountLines />}/>
            <Route path="calls" element={<Calls />}/>
            <Route path="datause" element={<DataUse />}/>
            <Route path="editinfo" element={<EditInfo />}/>
          </Route>
        </Route>
      </Routes>
    </HashRouter>
  );
}

export default App;
