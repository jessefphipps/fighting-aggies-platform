import React from 'react';
import FileUploader from './FileUploader/FileUploader'
import Login from './Login'
import { BrowserRouter as Router, Route, Link, Routes } from 'react-router-dom';

const App = () => {
  return (
    <Router>
      <div>
        <Route exact path={'/'} component={FileUploader}></Route>
        <Route exact path={'/login'} component={Login}></Route>
      </div>
    </Router>
  );
};
  
export default App;