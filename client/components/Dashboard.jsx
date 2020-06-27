import React, { Fragment, useEffect } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { getAllCoupons, getCategories } from '../actions/coupon';
import PropTypes from 'prop-types';

const Dashboard = ({ getAllCoupons, coupon: { coupons, loading } }) => {
  useEffect(() => {
    getAllCoupons();
  }, [getAllCoupons]);

  return coupons.length > 0 ? (
    <Fragment>
      <div className='container'>
        <h1>Dashboard Page...</h1>
        {coupons.map(c => (
          <li key={c.id}>{c.merchant}</li>
        ))}
        <div className='text-center'>
          <Link className='btn btn-primary' to='/add-coupon'>
            Add coupon
          </Link>
        </div>
      </div>
    </Fragment>
  ) : (
    <Fragment>
      <div className='container text-center'>
        <h2>You have no coupon.</h2>
      </div>
      <div className='text-center'>
        <Link className='btn btn-primary' to='/add-coupon'>
          Add coupon
        </Link>
      </div>
    </Fragment>
  );
};

Dashboard.propTypes = {
  getAllCoupons: PropTypes.func.isRequired,
  getCategories: PropTypes.func.isRequired,
  coupon: PropTypes.object.isRequired
};

const mapStateToProps = state => ({
  coupon: state.coupon
});

export default connect(mapStateToProps, { getAllCoupons, getCategories })(
  Dashboard
);
