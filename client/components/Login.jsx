import React, { Fragment, useState } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { connect } from 'react-redux';
import { login, guestLogin } from '../actions/auth';
import PropTypes from 'prop-types';

const Login = ({ login, guestLogin, isAuthenticated }) => {
  const [formData, setFormData] = useState({
    email: '',
    password: ''
  });

  const { email, password } = formData;

  const handleChange = e => {
    // setFormData is like this.setState to set state fields equal to the inputs
    return setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = e => {
    e.preventDefault();
    login(email, password);
  };

  // Redirect to /dashboard if user is logged in
  if (isAuthenticated) {
    return <Redirect to='/dashboard' />;
  }

  return (
    <Fragment>
      <div className='box-layout'>
        <div className='box-layout__box'>
          <img
            src='/images/scp-logo.png'
            className='img-fluid mb-5'
            alt='SCP Logo'
          />

          <form onSubmit={e => handleSubmit(e)}>
            <div className='form-group form-group--insertIcon insertIcon-left'>
              <input
                type='email'
                className='form-control input-field font-italic'
                placeholder='Email'
                name='email'
                value={email}
                onChange={e => handleChange(e)}
                required
              />
              <i className='far fa-envelope'></i>
            </div>
            <div className='form-group form-group--insertIcon insertIcon-left'>
              <input
                type='password'
                className='form-control input-field font-italic'
                placeholder='Password'
                name='password'
                value={password}
                onChange={e => handleChange(e)}
                minLength='6'
              />
              <i className='fas fa-lock'></i>
            </div>
            <button type='submit' className='btn btn-themeBlue btn-block'>
              Login
            </button>
          </form>
          <button
            className='btn btn-themeBlue btn-block mt-3'
            onClick={() => guestLogin()}
          >
            Guest login (Demo)
          </button>
          <div className='my-4 font-weight-bold'>OR</div>
          <Link to='/register' className='btn btn-themeBlue btn-block'>
            Sign up
          </Link>
        </div>
      </div>
    </Fragment>
  );
};

Login.propTypes = {
  login: PropTypes.func.isRequired,
  guestLogin: PropTypes.func.isRequired,
  isAuthenticated: PropTypes.bool
};

const mapStateToProps = state => ({
  isAuthenticated: state.auth.isAuthenticated
});

export default connect(mapStateToProps, { login, guestLogin })(Login);
