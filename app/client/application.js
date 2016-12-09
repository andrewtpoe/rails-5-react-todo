import 'babel-polyfill';

import React from 'react';
import { render } from 'react-dom';
import { AppContainer } from 'react-hot-loader';

import Root from './root';

render(
  <AppContainer>
    <Root />
  </AppContainer>,
  document.querySelector('[data-js="app_main"]')
);

if (module.hot) {
  module.hot.accept('./root', () => {
    const NewRoot = require('./root').default;
    render(
      <AppContainer>
        <NewRoot />
      </AppContainer>,
      document.querySelector('[data-js="app_main"]')
    );
  });
}
