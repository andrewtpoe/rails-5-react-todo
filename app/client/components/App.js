import React from 'react';
import CreateUserForm from './CreateUserForm';
class App extends React.Component {

  state = {
    signedIn: false
  }

  setUserSignedIn() {
    this.setState(
      {signedIn: !signedIn}
    )
  }

  render() {
    return <CreateUserForm signedIn={this.state.signedIn}/>
  }
}

export default App;
