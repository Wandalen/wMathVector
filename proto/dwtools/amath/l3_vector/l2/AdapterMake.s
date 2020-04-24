(function _AdapterMake_s_() {

'use strict';

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = _.longSlice;
let _sqrt = Math.sqrt;
let _abs = Math.abs;
let _sqr = _.math.sqr;

let vectorAdapter = _.vectorAdapter;
let VectorAdapter = _.VectorAdapter;
let avector = _.avector;

// --
// make
// --

/**
* @summary Creates vector from long of length `length`.
* @param {Number} length Length of long.
*
* @example
* var vec = wTools.vector.make( 3 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function make
* @namespace wTools.vectorAdapter
* @module Tools/math/Vector
*/

function make( length )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.routineIs( self ) )
  self = self.prototype;
  let srcLong = new self.longDescriptor.make( length );
  return self.fromLong( srcLong );
}

//

/**
* @summary Creates vector from long of length `length` and fills it with element `value`.
* @param {Number} length Length of long.
* @param {} value Element for fill operation.
*
* @example
* var vec = wTools.vector.makeFilling( 3, 0 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function makeFilling
* @namespace wTools.vectorAdapter
* @module Tools/math/Vector
*/

function makeFilling( length, value )
{
  let self = this;
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  if( _.routineIs( self ) )
  self = self.prototype;
  let srcLong = new self.longDescriptor.make( length );
  for( let i = 0 ; i < srcLong.length ; i++ )
  srcLong[ i ] = value;
  return self.fromLong( srcLong );
}

// --
// from
// --

/**
* @summary Creates vector from entity `srcLong`.
* @param {Array} srcLong Source array, vector, space.
*
* @example
* var srcLong = [ 1, 2, 3 ];
* var vec = wTools.vector.from( srcLong );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function from
* @namespace wTools.vectorAdapter
* @module Tools/math/Vector
*/

function from( srcLong )
{

  _.assert
  (
    arguments.length === 1 || arguments.length === 3 || arguments.length === 4,
    () => `Expects either 1, 3, 4 argument, got ${arguments.length}`
  );

  if( _.vectorAdapterIs( srcLong ) )
  return srcLong;
  else if( _.matrixIs( srcLong ) )
  {
    _.assert( arguments.length === 1 );
    _.assert( srcLong.dims.length === 2 );
    _.assert( srcLong.dims[ 0 ] === 1 || srcLong.dims[ 1 ] === 1 );
    if( srcLong.dims[ 0 ] === 1 )
    return srcLong.rowGet( 0 );
    else
    return srcLong.colGet( 0 );
  }
  else if( _.longIs( srcLong ) )
  {
    if( arguments.length === 1 )
    return this.fromLong( srcLong );
    else if( arguments.length === 3 )
    return this.fromLongLrange( ... arguments );
    else if( arguments.length === 4 )
    return this.fromLongLrangeAndStride( ... arguments );
    else _.assert( 0 );
  }
  else _.assert( 0, 'Cant make VectorAdapter from', _.strType( srcLong ) );

}

// --
// Extension
// --

let _routinesFrom =
{

  make, /*makeArrayOfLength*/
  makeFilling,

  from,

}

let VectorExtension =
{

  _routinesFrom,

}

_.mapExtend( VectorExtension, _routinesFrom );
_.mapExtend( _.vectorAdapter, VectorExtension );

})();
