(function _Number_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function AdapterFromNumber() {};

//

function _review( range )
{
  let l = range[ 1 ] - range[ 0 ] + 1;
  _.assert( l >= 0 );
  return this.FromMaybeNumber( this._vectorBuffer[ 0 ], l );
}

//

function _toLong()
{
  let result;
  result = this.vectorAdapter.longMakeFilling( this._vectorBuffer[ 0 ], this.length ); debugger
  return result;
}

//

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
* @summary Creates vector of length `length` from value of `number`.
* @param {Number|Array} number Source number, vector or array.
* @param {Number} length Length of new vector.
*
* @example
* var vec = wTools.vector.fromNumber( 3, 1 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromNumber
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
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
* @summary Creates vector of length `length` from value of `number`.
* @param {Number|Array} number Source number, vector or array.
* @param {Number} length Length of new vector.
*
* @example
* var vec = wTools.vector.fromMaybeNumber( 3, 1 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromMaybeNumber
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
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
