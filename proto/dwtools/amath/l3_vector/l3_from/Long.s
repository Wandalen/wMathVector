(function _Long_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function VectorAdapterFromLong(){};

//

/**
 * Routine _review() makes new instance of VectorAdapter from original of current adapter.
 *
 * @param { Range } crange - Defines ranges for creating adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( [ 1, 2, 3, 4, 5 ] );
 * var got = src._review( [ 1, 3 ] );
 * console.log( got.toStr() );
 * // log "2.000, 3.000, 4.000"
 *
 * @returns { VectorAdapter } - Returns instance of adapter with part of original Long.
 * @throws { Error } If routine calls by not VectorAdapter instance.
 * @throws { Error } If {-crange[ 0 ]-} is less then 0.
 * @throws { Error } If {-crange[ 1 ]-} is more then vector length.
 * @throws { Error } If substruction of {-crange[ 1 ]-} and {-crange[ 0 ]-} is less then 0.
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function _review( crange )
{
  let offset = crange[ 0 ];
  let length = crange[ 1 ]-crange[ 0 ]+1;
  _.assert( crange[ 0 ] >= 0 );
  _.assert( crange[ 1 ] <= this.length );
  _.assert( length >= 0 );
  return this.FromLongLrange( this._vectorBuffer, offset, length );
}

//

/**
 * Routine _toLong() returns original Long of current adapter.
 *
 * @example
 * var srcLong = [ 1, 2, 3 ];
 * var src = _.vectorAdapter.fromLong( srcLong );
 * var got = src._toLong();
 * console.log( got );
 * // log [ 1, 2, 3 ];
 * console.log( got === srcLong );
 * // log true
 *
 * @returns { Long } - Returns original Long of the adapter.
 * @function _toLong
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function _toLong()
{
  let result;
  result = this._vectorBuffer;
  return result;
}

//

/**
 * Routine _bufferConstructorGet() returns constructor of original Long of current adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( [ 1, 2, 3 ] );
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
  _lengthGet : function(){ return this._vectorBuffer.length; },
  eGet : function( index ){ return this._vectorBuffer[ index ]; },
  eSet : function( index, src ){ this._vectorBuffer[ index ] = src; },
  _review,
  _toLong,
  _bufferConstructorGet,
}

_.accessor.readOnly
({
  object : Self.prototype,
  prime : 0,
  names :
  {
    length : 'length',
  },
});

_.propertyConstant( Self.prototype,
{
  offset : 0,
  stride : 1,
});

Object.setPrototypeOf( Self.prototype, Parent.prototype );

//

/**
* @summary Creates vector from source array `srcLong`.
* @param {Array} srcLong Source array or vector.
*
* @example
* var srcLong = [ 1, 2, 3 ];
* var vec = wTools.vector.fromLong( srcLong );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromLong
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function fromLong( srcLong )
{

  _.assert( arguments.length === 1 );
  _.assert( _.vectorAdapterIs( srcLong ) || _.longIs( srcLong ) );

  if( srcLong._vectorBuffer )
  return srcLong;

  let result = new Self();
  result._vectorBuffer = srcLong;

  Object.freeze( result );
  return result;
}

// --
// extension
// --

let _routinesFrom =
{

  fromLong,

}

let VectorExtension =
{
}

_.mapSupplement( VectorExtension, _routinesFrom );
_.mapSupplement( _.vectorAdapter._routinesFrom, _routinesFrom );
_.mapSupplement( _.vectorAdapter, VectorExtension );

})();
