import React from 'react';

import { BrowserRouter as Router, Route, Link, Routes } from 'react-router-dom';

import Header from '../Header';
import Home from '../Home';
import LogInPage from '../LogIn';
import Success from '../Success';

import * as ROUTES from '../../constants/routes';

// Firebase API key: AIzaSyD1o5xsH4yn1ZDJqVd1bsw9B_OF2x1N-po

const App = () => {
  return (
    <Router>
      <div>
        <Route exact path={ROUTES.INDEX} component={Home}></Route>
        <Route exact path={ROUTES.HOME} component={Home}></Route>
        <Route path={ROUTES.LOG_IN} component={LogInPage}></Route>
        <Route path={ROUTES.SUCCESS} component={Success}></Route>
      </div>
    </Router>
  );
};
  
export default App;