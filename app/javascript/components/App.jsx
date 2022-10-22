import React from 'react';
import FileUploader from './FileUploader/FileUploader'
import LogInPage from './Login'
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import Home from '../pages/home/Home'

const App = () => {
  return (
    <Router>
      <div>
        <Route exact path={'/'} component={Home}></Route>
        <Route exact path={'/login'} component={LogInPage}></Route>
      </div>
    </Router>
  );
};
  
export default App;