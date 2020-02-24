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
// From
// --

/**
* @summary Creates vector From array of length `length`.
* @param {Number} length Length of array.
*
* @example
* var vec = wTools.vector.Make( 3 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function Make
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function Make( length )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.routineIs( self ) )
  self = self.prototype;
  let srcLong = new self.longDescriptor.make( length );
  return FromLong( srcLong );
}

//

/**
* @summary Creates vector From array of length `length` and fills it with element `value`.
* @param {Number} length Length of array.
* @param {} value Element for fill operation.
*
* @example
* var vec = wTools.vector.MakeFilling( 3, 0 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function MakeFilling
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function MakeFilling( length, value )
{
  let self = this;
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  if( _.routineIs( self ) )
  self = self.prototype;
  let srcLong = new self.longDescriptor.make( length );
  for( let i = 0 ; i < length ; i++ )
  srcLong[ i ] = value;
  return self.FromLong( srcLong );
}

// --
// From
// --

function VectorFromNumber() {};
VectorFromNumber.prototype =
{
  eGet : function( index ){ return this._vectorBuffer[ 0 ]; },
  eSet : function( index, src ){ this._vectorBuffer[ 0 ] = src; },
  constructor : VectorFromNumber,
}

_.propertyConstant( VectorFromNumber.prototype,
{
  offset : 0,
  stride : 0,
});

Object.setPrototypeOf( VectorFromNumber.prototype, VectorAdapter.prototype );

/**
* @summary Creates vector of length `length` From value of `number`.
* @param {Number|Array} number Source number, vector or array.
* @param {Number} length Length of new vector.
*
* @example
* var vec = wTools.vector.FromMaybeNumber( 3, 1 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function FromMaybeNumber
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function FromMaybeNumber( number, length )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( length >= 0 );

  let numberIs = _.numberIs( number );

  _.assert( numberIs || _.longIs( number ) || _.vectorAdapterIs( number ) );

  if( !numberIs )
  {
    _.assert( number.length === length );
    return this.FromLong( number );
  }

  let result = new VectorFromNumber();
  result._vectorBuffer = [ number ];
  _.propertyConstant( result, { length } );

  return result;
}

//


/**
* @summary Creates vector From entity `srcLong`.
* @param {Array} srcLong Source array, vector, space.
*
* @example
* var srcLong = [ 1, 2, 3 ];
* var vec = wTools.vector.From( srcLong );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function From
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function From( srcLong )
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
    return srcLong.rowVectorGet( 0 );
    else
    return srcLong.colVectorGet( 0 );
  }
  else if( _.longIs( srcLong ) )
  {
    if( arguments.length === 1 )
    return this.FromLong( srcLong );
    else if( arguments.length === 3 )
    return this.FromSubLong( ... arguments );
    else if( arguments.length === 4 )
    return this.FromSubLongWithStride( ... arguments );
    else _.assert( 0 );
  }
  else _.assert( 0, 'cant make Vector From', _.strType( srcLong ) );

}

//

function VectorFromLong(){};
VectorFromLong.prototype =
{
  _lengthGet : function(){ return this._vectorBuffer.length; },
  eGet : function( index ){ return this._vectorBuffer[ index ]; },
  eSet : function( index, src ){ this._vectorBuffer[ index ] = src; },
  constructor : VectorFromLong,
}

_.accessor.readOnly
({
  object : VectorFromLong.prototype,
  prime : 0,
  names :
  {
    length : 'length',
  },
});

_.propertyConstant( VectorFromLong.prototype,
{
  offset : 0,
  stride : 1,
});

Object.setPrototypeOf( VectorFromLong.prototype, VectorAdapter.prototype );

//

/**
* @summary Creates vector From source array `srcLong`.
* @param {Array} srcLong Source array or vector.
*
* @example
* var srcLong = [ 1, 2, 3 ];
* var vec = wTools.vector.FromLong( srcLong );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function FromLong
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function FromLong( srcLong )
{

  _.assert( arguments.length === 1 );
  _.assert( _.vectorAdapterIs( srcLong ) || _.longIs( srcLong ) );

  if( srcLong._vectorBuffer )
  return srcLong;

  let result = new VectorFromLong();
  result._vectorBuffer = srcLong;

  Object.freeze( result );
  return result;
}

//

function VectorSub(){};
VectorSub.prototype =
{
  eGet : function( index )
  {
    _.assert( index < this.length );
    return this._vectorBuffer[ this.offset + index ];
  },
  eSet : function( index, src )
  {
    _.assert( index < this.length );
    this._vectorBuffer[ this.offset + index ] = src;
  },
  constructor : VectorSub,
}

_.propertyConstant( VectorSub.prototype,
{
  stride : 1,
});

Object.setPrototypeOf( VectorSub.prototype, VectorAdapter.prototype );

//

/**
* @summary Creates vector From part of source array `srcLong`.
* @param {Array} srcLong Source array.
* @param {Array} offset Offset to sub array in source array `srcLong`.
* @param {Array} length Length of new vector.
*
* @example
* var srcLong = [ 1, 2, 3 ];
* var vec = wTools.vector.FromSubLong( srcLong, 0, 2 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function FromSubLong
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

function FromSubLong( srcLong, offset, length )
{

  if( offset === undefined )
  offset = 0;

  if( length === undefined )
  length = srcLong.length-offset;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( !!srcLong );
  _.assert( offset+length <= srcLong.length );

  if( srcLong._vectorBuffer )
  {

    if( srcLong.offset )
    offset = srcLong.offset + offset*( srcLong.stride || 1 );

    length = _min( length, srcLong.length );

    if( srcLong.stride )
    return FromSubLongWithStride( srcLong._vectorBuffer, offset, length, srcLong.stride );

    srcLong = srcLong._vectorBuffer;

  }

  let result = new VectorSub();
  result._vectorBuffer = srcLong;
  result.length = length;
  result.offset = offset;

  Object.freeze( result );
  return result;
}

//

function VectorSubLongWithStride(){};
VectorSubLongWithStride.prototype =
{
  eGet : function( index )
  {
    let i = this.offset+index*this.stride;
    _.assert( index < this.length );
    _.assert( i < this._vectorBuffer.length );
    return this._vectorBuffer[ i ];
  },
  eSet : function( index, src )
  {
    let i = this.offset+index*this.stride;
    _.assert( index < this.length );
    _.assert( i < this._vectorBuffer.length );
    this._vectorBuffer[ i ] = src;
  },
  constructor : VectorSubLongWithStride,
}

Object.setPrototypeOf( VectorSubLongWithStride.prototype, VectorAdapter.prototype );

//

function FromSubLongWithStride( srcLong, offset, length, stride )
{

  _.assert( arguments.length === 4 );
  _.assert( 0 <= stride );
  _.assert( _.numberIs( offset ) );
  _.assert( _.numberIs( length ) );
  _.assert( offset+(length-1)*stride < srcLong.length );

  if( stride === 1 )
  return FromSubLong( srcLong, offset, length );

  if( srcLong._vectorBuffer )
  {
    throw _.err( 'not implemented' );
  }

  let result = new VectorSubLongWithStride();
  result._vectorBuffer = srcLong;
  result.length = length;
  result.offset = offset;
  result.stride = stride;

  Object.freeze( result );
  return result;
}

//

function FromLongWithStride( srcLong, stride )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return this.FromSubLongWithStride( srcLong, 0, Math.ceil( srcLong.length / stride ), stride );
}

// --
// Extension
// --

let routineFrom =
{

  Make, /*makeArrayOfLength*/
  MakeFilling,

  FromMaybeNumber,
  From,
  FromLong,
  FromSubLong,
  FromSubLongWithStride,
  FromLongWithStride,

}

let VectorExtension =
{

  _routinesFrom : routineFrom,

}

_.mapExtend( VectorExtension, routineFrom );
_.mapExtend( _.vectorAdapter, VectorExtension );
_.mapExtend( _.VectorAdapter, VectorExtension );

})();
