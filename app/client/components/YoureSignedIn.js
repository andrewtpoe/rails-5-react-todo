import React from 'react';
import { getRequest } from '../utilities/ajax';

class YoureSignedIn extends React.Component {
///////////////////////////////////
//checkWorks can be deleted after testing
//////////////////////////////////
  checkWorks() {
    let token = this.props.getJWTFromLocalStorage();
    if (token === undefined) {
      console.log('noToken');
      return;
    }
    getRequest('api/v1/welcome/', {}, token)
      .then(response => {
        console.log(response);
      })
  }

  ///////////////////////////////////
  //checkWorks can be deleted after testing
  //////////////////////////////////

  render() {
    return (
      <main className="u-center_block">
        <div className="u-center-block__content">
          <h1>Welcome!  You are signed in!</h1>
          <div><button className="c-button c-button--brand c-button--block" onClick={(e) => this.checkWorks()}>checkWorks</button></div>
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
