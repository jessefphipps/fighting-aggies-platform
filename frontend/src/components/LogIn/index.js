import React, { Component } from 'react';
import { Link, withRouter } from 'react-router-dom';

import { withFirebase } from '../Firebase';

import * as ROUTES from '../../constants/routes';
import Header from '../Header';

// TO DO: session management

const LogInPage = () => {
  return (
    <div>
      <Header />
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
        this.setState({ ...INITIAL_STATE });
        this.props.history.push(ROUTES.SUCCESS);
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

    return (
      <div className='container mt-5'>
        <div className='row'>
          <div className='col-8 offset-2'>
            <h2>Log In Page</h2>
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
                />
              </span>
                
              <button disabled={isInvalid} type="submit" className='btn btn-primary'>
                Sign In
              </button>

              {error && <div className='form-text'>{error.message}</div>}
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

const LogInForm = withRouter(withFirebase(LogInFormBase));

export default LogInPage;

export { LogInForm };