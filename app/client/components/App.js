import React from 'react';
import CreateOrLoginUserForm from './CreateOrLoginUserForm';
import YoureSignedIn from './YoureSignedIn';
import { getRequest } from '../utilities/ajax'

class App extends React.Component {

  constructor() {
    super();
    this.toggleUserSignedIn = this.toggleUserSignedIn.bind(this);
  }

  state = {
    signedIn: false
  }

  componentDidMount() {
    //if token exists - check against server, if it's good, signedIn should be true
    let jwtToken = this.getJWTFromLocalStorage;
    if(jwtToken) {
      this.authenticateTokenAndSignIn();
    }
  }

  authenticateTokenAndSignIn() {
    let token = this.getJWTFromLocalStorage();
    if (token === undefined) {
      console.log('noToken');
      return;
    }
    getRequest('welcome/', {}, token)
      .then(response => {
        if(response.body.logged_in) {this.toggleUserSignedIn()}
      }).catch(error => {
        console.log(error);
      })
  }

  getJWTFromLocalStorage() {
    const token = JSON.parse(localStorage.getItem('jwt'));
    if (token === null) {
      console.log('noToken');
      return;
    }
    return token.auth_token;
  }

  toggleUserSignedIn = () => {
    console.log('intoggle');
    this.setState(
      {signedIn: !this.state.signedIn}
    )
  };

  render() {
    return (
      this.state.signedIn ? <YoureSignedIn signedIn={this.state.signedIn} toggleUserSignedIn={this.toggleUserSignedIn} /> : <CreateOrLoginUserForm signedIn={this.state.signedIn} toggleUserSignedIn={this.toggleUserSignedIn}/ >
    )
  }
}

export default App;
