import React from 'react';
import { postRequest } from '../utilities/ajax';

class CreateUserForm extends React.Component {
  // constructor(props) {
  //   super(props);
  //   this.state = {signUpForm: true};
  //   this.toggleSignInSignUp = this.toggleSignInSignUp.bind(this);
  // }

  state = (() => {
    return {
      signUpForm: true,
    };
  })();

  createOnLoginUser(event) {
    event.preventDefault();
    const url = this.state.signUpForm ? 'api/v1/users/' : 'api/v1/users/sign_in';
    const userInfo = {
      user: {
        email: this.emailAddress.value,
        password: this.password.value,
      }
    }
    postRequest(url, userInfo)
      .then(response => {
        if(response.body.auth_token) {
          this.setLocalStorage(response.body);
          this.props.toggleUserSignedIn();
        }
      })
      .catch(error => {
        console.log(error);
      })
  }

  setLocalStorage(jwtToken) {
    localStorage.setItem('jwt', JSON.stringify(jwtToken));
  }

  toggleSignInSignUp() {
    this.setState({signUpForm: !this.state.signUpForm});
  }

  _buildButton() {
    const {
      signUpForm,
    } = this.state;
    const signUpText = 'Sign Up';
    const logInText = 'Log In';
    const text = signUpForm ? `Switch to ${logInText}` : `Switch to ${signUpText}`;
    return (
      <button
        className="c-button c-button--brand c-button--block"
        onClick={(e) => {
          e.preventDefault();
          this.toggleSignInSignUp();
        }}
      >
        {text}
      </button>
    );
  }

  render() {
    const signUp = this.state.signUpForm;
    const signUpText = 'Sign Up';
    const logInText = 'Log In';
    return (
      <main className="u-center_block">
        <div className="u-center-block__content">
          <h1 className='u-centered c-heading'>{signUp ? signUpText : logInText}</h1>
          {this._buildButton()}
          <form ref={(input) => this.userInfo = input} className='' onSubmit={(e) => this.createOnLoginUser(e)}>
            <div className='o-form-element'>
              <div className="c-input-group c-input-group--stacked">
                <div className="o-field">
                <input className="c-field" ref={(input) => this.emailAddress = input} type='text' placeholder='email address' />
                </div>
              <div className="o-field">
                <input className="c-field" ref={(input) => this.password = input} type='password' placeholder='password' />
                </div>
              </div>
              <div className="o-form-element">
                <button className="c-button c-button--brand c-button--block" type='submit'>{signUp ? signUpText : logInText}</button>
              </div>
            </div>
          </form>
        </div>
      </main>
    )
  }
}

CreateUserForm.propTypes = {
  signedIn: React.PropTypes.bool.isRequired,
  toggleUserSignedIn: React.PropTypes.func.isRequired,
}

export default CreateUserForm;
