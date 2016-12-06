import React from 'react';
import ReactDOM from 'react-dom';

function application () {
  const div = document.querySelector('[data-js="app_main"]');
  if (div) {
    ReactDOM.render(
      <h1>Hello, world!</h1>, div
    );
  }
};

application();
