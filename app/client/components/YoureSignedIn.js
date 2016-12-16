import React from 'react';
import { getRequest } from '../utilities/ajax';

class YoureSignedIn extends React.Component {
  constructor(props) {
    super(props);
    this.checkWorks = this.checkWorks.bind(this);
  }
///////////////////////////////////
//checkWorksCanBeDeleted and getLocalStorageToken can be deleted after testing
//////////////////////////////////
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
  ///////////////////////////////////
  //checkWorksCanBeDeleted and getLocalStorageToken can be deleted after testing
  //////////////////////////////////

  // deleteLocalStorageToken() {
  //   localStorage.removeItem('jwt');
  //   this.props.toggleUserSignedIn();
  // }

  render() {
    return (
      <main className="u-center_block">
        <div className="u-center-block__content">
          <h1>Welcome!  You are signed in!</h1>
          <div><button className="c-button c-button--brand c-button--block" onClick={this.checkWorks}>checkWorks</button></div>
          <div><button className="c-button c-button--brand c-button--block" onClick={this.props.deleteLocalStorageToken}>Sign Out</button></div>
        </div>
      </main>
    )
  }
}

YoureSignedIn.propTypes = {
  deleteLocalStorageToken: React.PropTypes.func.isRequired,
}

export default YoureSignedIn;
