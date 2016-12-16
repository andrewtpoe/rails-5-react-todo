import React from 'react';
import CreateUserForm from './CreateUserForm';
import YoureSignedIn from './YoureSignedIn';
class App extends React.Component {

  constructor() {
    super();
    this.toggleUserSignedIn = this.toggleUserSignedIn.bind(this);
  }

  state = {
    signedIn: false
  }

  toggleUserSignedIn = () => {
    this.setState(
      {signedIn: !this.state.signedIn}
    )
  };

  render() {
    return (
      this.state.signedIn ? <YoureSignedIn /> : <CreateUserForm signedIn={this.state.signedIn} toggleUserSignedIn={this.toggleUserSignedIn}/ >
    )
  }
}

export default App;
