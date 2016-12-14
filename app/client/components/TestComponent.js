import React from 'react';

Class TestComponent extends React.component {
  constructor {
    super(props);
  }

  // componentDidMount() {
  //   const jwt = this.getLocalStorageToken;
  //   getRequest('welcome', {}, localStorage.getItem('jwtToken'))
  //     .then(response => {
  //       console.log(response.body);
  // }

  getLocalStorageToken() {
    const jwtToken = localStorage.getItem('jwtToken');
  }

  render() {
    console.log(getRequest('welcome', {}, localStorage.getItem('jwtToken')))
    <h1>Welcome.  You are logged in</h1>
  }
}
