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
      }
    }
    postRequest(url, userInfo)
      .then(response => {
        /////////////////////////////////////////////////////
        //setting cookie for email token
        console.log(response.body.attributes.email);
        // document.cookie = `name=${response.body.email}`;
        ////////////////////////////////////////////////////
      })
      .catch(error => {
        console.log(error);
      })
  }

  render() {
    return (
      <div>
        Sign Up
        <form ref={(input) => this.userInfo = input} className='' onSubmit={(e) => this.createUser(e)}>
          <input ref={(input) => this.emailAddress = input} type='text' placeholder='email address' />
          <br/>
          <input ref={(input) => this.password = input} type='password' placeholder='password' />
          <br/>
          <button type='submit'>Create user</button>
        </form>
      </div>
    )
  }
}

export default CreateUserForm;
