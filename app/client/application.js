import 'babel-polyfill';

import React from 'react';
import { render } from 'react-dom';
import { AppContainer } from 'react-hot-loader';
import App from './components/App';

import Root from './root';

render(
  <AppContainer>
    <App />
  </AppContainer>,
  document.querySelector('[data-js="app_main"]')
);

if (module.hot) {
  module.hot.accept('./components/App', () => {
    const NewRoot = require('./components/App').default;
    render(
      <AppContainer>
        <App />
      </AppContainer>,
      document.querySelector('[data-js="app_main"]')
    );
  });
}
