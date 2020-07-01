import {
  GET_CURCOUPON,
  GET_COUPONS,
  GET_CATEGORIES,
  COUPON_ERROR,
  CLEAR_CURCOUPON,
  UPDATE_COUPON,
  DELETE_COUPON
} from '../actions/types';

const initialState = {
  coupons: [],
  curCoupon: null,
  categories: [],
  loading: true,
  error: {}
};

export default (state = initialState, action) => {
  const { type, payload } = action;
  switch (type) {
    case GET_CURCOUPON:
      return {
        ...state,
        curCoupon: payload,
        loading: false
      };

    case CLEAR_CURCOUPON:
      return {
        ...state,
        curCoupon: null,
        loading: false
      };

    case UPDATE_COUPON:
      return {
        ...state,
        coupons: state.coupons.map(coupon =>
          coupon.id === payload.id ? payload : coupon
        ),
        loading: false
      };

    case DELETE_COUPON:
      return {
        ...state,
        curCoupon: null,
        coupons: state.coupons.filter(coupon => coupon.id !== payload),
        loading: false
      };

    case GET_COUPONS:
      return {
        ...state,
        coupons: payload,
        loading: false
      };

    case GET_CATEGORIES:
      return {
        ...state,
        categories: payload,
        loading: false
      };

    case COUPON_ERROR:
      return {
        ...state,
        loading: false,
        error: payload,
        curCoupon: null
      };

    default:
      return state;
  }
};
