import React, { Fragment, useState, useEffect } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { getAllCoupons, getCategories } from '../actions/coupon';
import PropTypes from 'prop-types';
import CouponFilters from './CouponFilters';
import CouponItem from './CouponItem';
import CouponUsedExpired from './CouponUsedExpired';
import selectCoupons from '../selectors/coupons';
import selectUsedExpired from '../selectors/couponsUsedExpired';
import selectUsedNotExpired from '../selectors/couponsUsedNotExpired';
import selectExpired from '../selectors/couponsExpired';
import Spinner from './Spinner';

const Dashboard = ({
  getAllCoupons,
  getCategories,
  coupon: { coupons, loading },
  filter
}) => {
  const [openingCouponId, setOpeningCouponId] = useState(undefined);
  const [openUsedCoupons, toggleUsedCoupons] = useState(false);
  const [openExpiredCoupons, toggleExpiredCoupons] = useState(false);

  useEffect(() => {
    getAllCoupons();
    getCategories();
  }, []);

  const couponsFiltered = selectCoupons(coupons, filter);
  const couponsUsedandExpired = selectUsedExpired(coupons);
  const couponsUsednotExpired = selectUsedNotExpired(couponsUsedandExpired);
  const couponsExpired = selectExpired(couponsUsedandExpired);

  return loading ? (
    <Spinner />
  ) : coupons.length > 0 ? (
    <Fragment>
      <div className='container page-container'>
        <CouponFilters />

        {couponsFiltered.map(coupon => (
          <CouponItem
            key={coupon.id}
            coupon={coupon}
            openCouponTab={coupon.id === openingCouponId}
            setOpeningCouponId={setOpeningCouponId}
          />
        ))}
        <div className='text-center'>
          <div className='btn-addCoupon my-4'>
            <Link className='btn-addCoupon__icon-text' to='/add-coupon'>
              <i className='fas fa-2x fa-plus-circle'></i>
              Add coupon
            </Link>
          </div>
        </div>

        <div className='usedExpired pt-3 mb-3'>
          <a
            className='usedExpired__toggle'
            data-toggle='collapse'
            href='#usedArea'
            role='button'
            aria-expanded='false'
            aria-controls='usedArea'
            onClick={() => toggleUsedCoupons(!openUsedCoupons)}
          >
            <i
              className={`fas fa-chevron-right ${
                openUsedCoupons ? 'open-used-coupons' : ''
              }`}
            ></i>
            &nbsp;{' '}
            {couponsUsednotExpired.length > 0 &&
              `(${couponsUsednotExpired.length})`}{' '}
            Coupons Used
          </a>
        </div>

        <div className='collapse mb-3' id='usedArea'>
          <CouponUsedExpired coupons={couponsUsednotExpired} />
        </div>

        <div className='usedExpired pt-3 mb-3'>
          <a
            className='usedExpired__toggle'
            data-toggle='collapse'
            href='#expiredArea'
            role='button'
            aria-expanded='false'
            aria-controls='expiredArea'
            onClick={() => toggleExpiredCoupons(!openExpiredCoupons)}
          >
            <i
              className={`fas fa-chevron-right ${
                openExpiredCoupons ? 'open-used-coupons' : ''
              }`}
            ></i>
            &nbsp;{' '}
            {couponsExpired.length > 0 &&
              `(${couponsExpired.length})`}{' '}
            Coupons Expired
          </a>
        </div>
        <div className='collapse mb-3' id='expiredArea'>
          <CouponUsedExpired coupons={couponsExpired} />
        </div>

      </div>
    </Fragment>
  ) : (
    <Fragment>
      <div className='container page-container text-center pt-5'>
        <img
          src='https://ubuntu-ec2-s3.s3-us-west-1.amazonaws.com/scp/images/no-coupon.png'
          style={{ width: '300px' }}
        />
        <h4>Welcome, please add some coupons into your pocket!</h4>

        <div className='btn-addCoupon mt-5'>
          <Link className='btn-addCoupon__icon-text' to='/add-coupon'>
            <i className='fas fa-2x fa-plus-circle'></i>
            Add coupon
          </Link>
        </div>
      </div>
    </Fragment>
  );
};

Dashboard.propTypes = {
  getAllCoupons: PropTypes.func.isRequired,
  getCategories: PropTypes.func.isRequired,
  coupon: PropTypes.object.isRequired,
  filter: PropTypes.object.isRequired
};

const mapStateToProps = state => ({
  coupon: state.coupon,
  filter: state.filter
});

export default connect(mapStateToProps, { getAllCoupons, getCategories })(
  Dashboard
);
