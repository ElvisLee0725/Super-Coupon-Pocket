import axios from 'axios';
import {
  REGISTER_SUCCESS,
  REGISTER_FAIL,
  USER_LOADED,
  UPLOAD_IMAGE,
  AUTH_ERROR,
  LOGIN_SUCCESS,
  LOGIN_FAIL,
  LOGOUT
} from './types';
import { setAlert } from './alert';
import setAuthToken from '../utils/setAuthToken';
import { getAllCoupons } from './coupon';

// Load user - use token to get user data from server
export const loadUser = () => async dispatch => {
  if (localStorage.token) {
    setAuthToken(localStorage.token);
  }

  try {
    // Only need header with token, which is done in setAuthToken()
    const res = await axios.get('/api/auth');
    // res.data is the user object
    dispatch({ type: USER_LOADED, payload: res.data });
    dispatch(getAllCoupons());
  } catch (err) {
    dispatch({ type: AUTH_ERROR });
  }
};

// Register user - get token from the server when success
export const register = ({ username, email, password }) => async dispatch => {
  const config = {
    headers: {
      'Content-Type': 'application/json'
    }
  };

  const body = JSON.stringify({ username, email, password });

  try {
    const res = await axios.post('/api/users', body, config);
    // res.data is the token
    dispatch({ type: REGISTER_SUCCESS, payload: res.data });
    dispatch(loadUser());
  } catch (err) {
    const errors = err.response.data.error;
    if (errors) {
      errors.forEach(error => {
        dispatch(setAlert(error.msg, 'danger'));
      });
    }
    dispatch({ type: REGISTER_FAIL });
  }
};

// Login user - get token from the server when success
export const login = (email, password) => async dispatch => {
  const config = {
    headers: {
      'Content-Type': 'application/json'
    }
  };

  const body = JSON.stringify({ email, password });

  try {
    const res = await axios.post('/api/auth', body, config);
    // res.data is the token
    dispatch({ type: LOGIN_SUCCESS, payload: res.data });
    dispatch(loadUser());
  } catch (err) {
    const errors = err.response.data.error;

    if (errors) {
      errors.forEach(error => dispatch(setAlert(error.msg, 'danger')));
    }
    dispatch({ type: LOGIN_FAIL });
  }
};

// Logout - Clean up everything (token, isAuthenticated, user)
export const logout = () => dispatch => {
  localStorage.removeItem('token');
  dispatch({ type: LOGOUT });
};

export const uploadUserImage = profileImg => async dispatch => {
  const formData = new FormData();
  formData.append('profileImg', profileImg);
  try {
    const res = await axios.post('/api/users/user-profile', formData, {});
    dispatch({ type: UPLOAD_IMAGE, payload: res.data });
  } catch (err) {
    const errors = err.response.data.error;
    if (errors) {
      errors.forEach(error => {
        dispatch(setAlert(error.msg, 'danger'));
      });
    }
  }
};
