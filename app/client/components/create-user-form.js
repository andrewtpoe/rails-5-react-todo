//url -X POST -H 'Content-Type: application/json' -d '{"user":{"email":"kitter@gmail.com","password":"password"}}' todo.dev/api/v1/users/
import React from 'react';
import { postRequest } from '../utilities/ajax';

class CreateUserForm extends React.Component {

  createUser(event) {
    event.preventDefault();
    const url = 'api/v1/users/';
    const userInfo = {
      user: {
        email: this.emailAddress.value,
        password: this.password.value,
        // passwordConfirmation: this.passwordConfirmation.value
      }
    }
    console.log(userInfo);
    postRequest(url, userInfo);
  }

  render() {
    return (
      <form ref={(input) => this.userInfo = input} className='' onSubmit={(e) => this.createUser(e)}>
        <input ref={(input) => this.emailAddress = input} type='text' placeholder='email address' />
        <br/>
        <input ref={(input) => this.password = input} type='password' placeholder='password' />
        <br/>
        <input ref={(input) => this.passwordConfirmation = input} type='password' placeholder='confirm password' />
        <button type='submit'>Create user</button>
      </form>
    )
  }
}

export default CreateUserForm;
