import Main from './components/Main'
import AccountSearch from './components/AccountSearch'
import Account from './components/Account'
import './css/main.css';

import { BrowserRouter, Routes, Route, useParams } from "react-router-dom";
import CreateAccount from './components/CreateAccount';

function App() {

  const { accountNum } = useParams();
  
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Main />}>
          <Route path="" element={<AccountSearch />} />
          <Route path="/account/create" element={<CreateAccount />} />
          <Route path="account/:acountNumber" element={<Account />} />
        </Route>
          {/* <Route path="info" element={<ImageBrowser/>} />
          <Route path="bill" element={<ImageBrowser/>} />
          <Route path="lines" element={<ImageBrowser/>} />
        </Route>
        <Route path="/callhistory" element={<Account />} /> */}
      </Routes>
    </BrowserRouter>
  );
}

export default App;
