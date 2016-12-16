//url -X POST -H 'Content-Type: application/json' -d '{"user":{"email":"kitter@gmail.com","password":"password"}}' todo.dev/api/v1/users/
import React from 'react';
import { getRequest, postRequest } from '../utilities/ajax';

class CreateUserForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {signUpForm: true};
    this.toggleSignInSignUp = this.toggleSignInSignUp.bind(this);
    this.checkWorks = this.checkWorks.bind(this);
  }

  createUser(event) {
    event.preventDefault();
    const url = this.state.signUpForm ? 'api/v1/users/' : 'api/v1/users/sign_in';
    const userInfo = {
      user: {
        email: this.emailAddress.value,
        password: this.password.value,
      }
    }
    postRequest(url, userInfo)
      .then(response => {
        this.setLocalStorage(response.body);
        this.props.toggleUserSignedIn();
        // console.log(this.props.signedIn);
        //Go to new componenet
      })
      .catch(error => {
        console.log(error);
      })
  }

  setLocalStorage(jwtToken) {
    // console.log(jwtToken);
    localStorage.setItem('jwt', JSON.stringify(jwtToken));
  }

  checkWorks() {
    let token = this.getLocalStorageToken();
    if (token === undefined) {
      console.log('noToken');
      return;
    }
    getRequest('welcome/', {}, token)
      .then(response => {
        console.log(response);
      })
  }

  getLocalStorageToken() {
    const token = JSON.parse(localStorage.getItem('jwt'));
    if (token === null) {
      console.log('noToken');
      return;
    }
    return token.auth_token;
  }

  toggleSignInSignUp() {
    this.setState({signUpForm: !this.state.signUpForm});
  }

  returnNoTokenError() {
    console.log('No token!');
  }

  deleteLocalStorageToken() {
    localStorage.removeItem('jwt');
    return;
  }

  render() {
    const signUp = this.state.signUpForm;
    const signUpText = 'Sign Up';
    const logInText = 'Log In';
    console.log('signed in', this.props.signedIn);
    return (
      <div>
        <div>
          {signUp ? signUpText : logInText}
          <button onClick={this.toggleSignInSignUp}>Switch to {signUp ? logInText : signUpText}</button>
          <form ref={(input) => this.userInfo = input} className='' onSubmit={(e) => this.createUser(e)}>
            <input ref={(input) => this.emailAddress = input} type='text' placeholder='email address' />
            <br/>
            <input ref={(input) => this.password = input} type='password' placeholder='password' />
            <br/>
            <button type='submit'>{signUp ? signUpText : logInText}</button>
          </form>
        </div>
        <div><button onClick={this.checkWorks}>checkWorks</button></div>
        <div><button onClick={this.deleteLocalStorageToken}>Sign Out</button></div>
      </div>
    )
  }
}

CreateUserForm.PropTypes = {
  signedIn: React.PropTypes.bool.isRequired,
}

export default CreateUserForm;
