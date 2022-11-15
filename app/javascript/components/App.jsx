import React from 'react';
import FileUploader from './FileUploader/FileUploader'
import LogInPage from './Login'
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import Home from '../pages/home/Home'
// import 'bootstrap/dist/css/bootstrap.min.css';

import {RecoilRoot} from "recoil";

const App = () => {
  return (
    <RecoilRoot>
      <Router>
        <div>
          <Route exact path={'/dashboard'} component={Home}></Route>
          <Route exact path={'/'} component={LogInPage}></Route>
        </div>
      </Router>
    </RecoilRoot>
  );
};
  
export default App;