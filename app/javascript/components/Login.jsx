import React, { Component } from 'react';
import { Link, withRouter, Redirect} from 'react-router-dom';

import { withFirebase } from './Firebase';

// import * as ROUTES from '../../constants/routes';
// import Header from '../Header';

const LogInPage = () => {
  return (
    <div>
      <LogInForm />
    </div>
  );
};

const INITIAL_STATE = {
  email: '',
  password: '',
  error: null,
};

class LogInFormBase extends Component {
  constructor(props) {
    super(props);

    this.state = { ...INITIAL_STATE };
  }

  onSubmit = event => {
    const { email, password } = this.state;

    this.props.firebase
      .doSignInWithEmailAndPassword(email, password)
      .then(() => {
        // alert('success');
        sessionStorage.setItem('user', email);
        this.setState({ ...INITIAL_STATE });
        this.props.history.push('/dashboard');
      })
      .catch(error => {
        // alert('error');
        this.setState({ error });
      });

    event.preventDefault();
  };

  onChange = event => {
    this.setState({ [event.target.name]: event.target.value });
  };

  render() {
    const { email, password, error } = this.state;
    
    const isInvalid = password === '' || email === '';
    
    const user = sessionStorage.getItem('user');

    if (user != null) return <Redirect to='/dashboard' />;
    return (
      <div id='loginPageBody' style={{backgroundImage: `url('https://cdn.eis.tamu.edu/public/images/newbackground7.jpg')` }}>
        <div className='row'>
          <div className='col-12 col-md-6 offset-md-3' id='loginPanel'>
            <div className='row' id='platformName'>
              <div id='logoBox'>
                <img id='platformImage' src='https://github.com/jessefphipps/fighting-aggies-platform/blob/main/app/assets/images/tam_white.png?raw=true' />
              </div>
              <h2><i><strong>Fightin Aggies Analytics Platform</strong></i></h2>
            </div>
            
            <div id='loginForm'>
              <h3 style={{margin: '1px'}}>Login</h3>
              <hr />
              <form onSubmit={this.onSubmit}>
                <div className='mb-3'>
                  <span>
                    <span className='form-label'>Email</span>
                    <input
                      name="email"
                      value={email}
                      onChange={this.onChange}
                      type="text"
                      placeholder="Email Address"
                      className='form-control'
                      id='username'
                    />
                  </span>
                
                  <span>
                    <span className='form-label'>Password</span>
                    <input
                      name="password"
                      value={password}
                      onChange={this.onChange}
                      type="password"
                      placeholder="Password"
                      className='form-control'
                      id='password'
                    />
                  </span>
                  
                  <button disabled={isInvalid} type="submit" className='btn btn-primary' id='login-button'>
                    Continue
                  </button>
  
                  {error && <div className='form-text' id='error-message'>{error.message}</div>}
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    );
  };
}

const LogInForm = withRouter(withFirebase(LogInFormBase));

export default LogInPage;

export { LogInForm };