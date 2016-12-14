//url -X POST -H 'Content-Type: application/json' -d '{"user":{"email":"kitter@gmail.com","password":"password"}}' todo.dev/api/v1/users/
import React from 'react';
import { postRequest } from '../utilities/ajax';

class CreateUserForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {signUpForm: true};
    this.toggleSignInSignUp = this.toggleSignInSignUp.bind(this);
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
        //Go to new componenet
      })
      .catch(error => {
        console.log(error);
      })
  }

  setLocalStorage(jwtToken) {
    // console.log(jwtToken);
    localStorage.setItem('jwtToken', JSON.stringify(jwtToken));
  }



  toggleSignInSignUp() {
    console.log("in toggle");
    console.log(this.state.signUpForm);
    this.setState({signUpForm: !this.state.signUpForm});
  }

  render() {
    const signUp = this.state.signUpForm;
    const signUpText = 'Sign Up';
    const logInText = 'Log In';
    return (
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
    )
  }
}

export default CreateUserForm;
