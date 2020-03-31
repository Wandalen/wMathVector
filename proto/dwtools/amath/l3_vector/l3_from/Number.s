(function _Number_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function AdapterFromNumber() {};

//

/**
 * Routine _review() makes new instance of VectorAdapter.
 * The buffer is filled by number of current vector, the length is defined by range {-crange-}.
 *
 * @param { Range } crange - Defines ranges for an adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( [ 1, 2, 3, 4, 5 ] );
 * var got = src._review( [ 1, 3 ] );
 * console.log( got.toStr() );
 * // log "2.000, 3.000, 4.000"
 *
 * @returns { VectorAdapter } - Returns instance of adapter with part of original Long.
 * @throws { Error } If routine calls by not VectorAdapter instance.
 * @throws { Error } If substruction of {-crange[ 1 ]-} and {-crange[ 0 ]-} is less then 0.
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function _review( crange )
{
  let l = crange[ 1 ] - crange[ 0 ] + 1;
  _.assert( l >= 0 );
  return this.FromMaybeNumber( this._vectorBuffer[ 0 ], l );
}

//

/**
 * Routine _toLong() returns new Long filled by content of current adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromNumber( 2, 3 );
 * var got = src._toLong();
 * console.log( got );
 * // log [ 2, 2, 2 ];
 *
 * @returns { Long } - Returns new Long with content of the vector.
 * @function _toLong
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function _toLong()
{
  let result;
  result = this.vectorAdapter.longMakeFilling( this._vectorBuffer[ 0 ], this.length ); debugger
  return result;
}

//

/**
 * Routine _bufferConstructorGet() returns constructor of original Long of current adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromNumber( 2, 3 );
 * var got = src._bufferConstructorGet();
 * console.log( got );
 * // log [function Array];
 *
 * @returns { Long } - Returns constructor of original Long.
 * @function _bufferConstructorGet
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function _bufferConstructorGet()
{
  return this._vectorBuffer.constructor;
}

//

Self.prototype =
{
  constructor : Self,
  eGet : function( index ){ return this._vectorBuffer[ 0 ]; },
  eSet : function( index, src ){ this._vectorBuffer[ 0 ] = src; },
  _review,
  _toLong,
  _bufferConstructorGet,
}

_.propertyConstant( Self.prototype,
{
  offset : 0,
  stride : 0,
});

Object.setPrototypeOf( Self.prototype, Parent.prototype );

//

/**
 * Routine fromNumber() creates vector of length `length` from value of `number`.
 *
 * @param { Number } number - Source number.
 * @param { Number } length - Length of new vector.
 *
 * @example
 * var got = wTools.vector.fromNumber( 3, 2 );
 * console.log( vec.toStr() );
 * // log "3.000, 3.000"
 *
 * @returns { VectorAdapter } - Returns new VectorAdapter instance.
 * @function fromNumber
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function fromNumber( number, length )
{
  let numberIs = _.numberIs( number );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( length >= 0 );
  _.assert( numberIs || _.vectorAdapterIs( number ) );

  if( !numberIs )
  {
    _.assert( number.length === length );
    return number;
  }

  let result = new Self();
  result._vectorBuffer = this.long.longMake( 1 );
  result._vectorBuffer[ 0 ] = number;

  // if( result._vectorBuffer[ 0 ] !== number )
  // {
  //   result._vectorBuffer = this.withDefaultLong.F64x.longMake( 1 )
  //   result._vectorBuffer[ 0 ] = number;
  // }

  _.propertyConstant( result, { length } );

  return result;
}

//

/**
 * Routine fromMaybeNumber() creates vector of length `length` from value of `number`.
 * Also, routine can make new vector from Long or VectorAdapter.
 *
 * @param { Number|Long|VectorAdapter } number - Source number, vector or array.
 * @param { Number } length - Length of new vector.
 *
 * @example
 * var got = wTools.vector.fromMaybeNumber( 3, 2 );
 * console.log( vec.toStr() );
 * // log "3.000, 3.000"
 *
 * @returns { VectorAdapter } - Returns new VectorAdapter instance.
 * @function fromMaybeNumber
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function fromMaybeNumber( number, length )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( length >= 0 );

  if( _.longIs( number ) )
  {
    _.assert( number.length === length );
    return this.fromLong( number );
  }

  let result = this.fromNumber( number, length );
  return result;
}

// --
// extension
// --

let _routinesFrom =
{

  fromNumber,
  fromMaybeNumber,

}

let VectorExtension =
{

}

_.mapSupplement( VectorExtension, _routinesFrom );
_.mapSupplement( _.vectorAdapter._routinesFrom, _routinesFrom );
_.mapSupplement( _.vectorAdapter, VectorExtension );

})();
