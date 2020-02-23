(function _Core_s_() {

'use strict';

/**
 *@summary Collection of functions for vector math
  @namespace "wTools.vector"
  @memberof module:Tools/math/Vector
*/

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = _.longSlice;
let _sqrt = Math.sqrt;
let _abs = Math.abs;
let _sqr = _.sqr;

let Parent = null;
let Namespace = Object.create( null );

function Vector()
{
  throw _.err( 'should not be called' )
};
Vector.prototype = Object.create( null );
Vector.prototype._vectorBuffer = null;

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
* @memberof module:Tools/math/Vector.wTools.vector
*/

function Make( length )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let srcArray = new this.longDescriptor.make( length );
  return FromArray( srcArray );
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
* @memberof module:Tools/math/Vector.wTools.vector
*/

function MakeFilling( length, value )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  let srcArray = new this.longDescriptor.make( length );
  for( let i = 0 ; i < length ; i++ )
  srcArray[ i ] = value;
  return FromArray( srcArray );
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

Object.setPrototypeOf( VectorFromNumber.prototype, Vector.prototype );

_.propertyConstant( VectorFromNumber.prototype,
{
  offset : 0,
  stride : 0,
});

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
* @memberof module:Tools/math/Vector.wTools.vector
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
    return this.FromArray( number );
  }

  let result = new VectorFromNumber();
  result._vectorBuffer = [ number ];
  _.propertyConstant( result, { length } );

  return result;
}

//


/**
* @summary Creates vector From entity `srcArray`.
* @param {Array} srcArray Source array, vector, space.
*
* @example
* var srcArray = [ 1, 2, 3 ];
* var vec = wTools.vector.From( srcArray );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function From
* @memberof module:Tools/math/Vector.wTools.vector
*/

function From( srcArray )
{

  _.assert( arguments.length === 1, 'From expects single arguments { srcArray }' );

  if( _.vectorAdapterIs( srcArray ) )
  return srcArray;
  else if( _.longIs( srcArray ) )
  return FromArray( srcArray );
  else if( _.spaceIs( srcArray ) )
  {
    _.assert( srcArray.dims.length === 2 );
    _.assert( srcArray.dims[ 0 ] === 1 || srcArray.dims[ 1 ] === 1 );
    if( srcArray.dims[ 0 ] === 1 )
    return srcArray.rowVectorGet( 0 );
    else
    return srcArray.colVectorGet( 0 );
  }
  else _.assert( 0, 'cant make Vector From', _.strType( srcArray ) );

}

//

function VectorFromArray(){};
VectorFromArray.prototype =
{
  '_lengthGet' : function(){ return this._vectorBuffer.length; },
  eGet : function( index ){ return this._vectorBuffer[ index ]; },
  eSet : function( index, src ){ this._vectorBuffer[ index ] = src; },
  constructor : VectorFromArray,
}

Object.setPrototypeOf( VectorFromArray.prototype, Vector.prototype );

_.accessor.readOnly
({
  object : VectorFromArray.prototype,
  prime : 0,
  names :
  {
    length : 'length',
  },
});

_.propertyConstant( VectorFromArray.prototype,
{
  offset : 0,
  stride : 1,
});

/**
* @summary Creates vector From source array `srcArray`.
* @param {Array} srcArray Source array or vector.
*
* @example
* var srcArray = [ 1, 2, 3 ];
* var vec = wTools.vector.FromArray( srcArray );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function FromArray
* @memberof module:Tools/math/Vector.wTools.vector
*/

function FromArray( srcArray )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.vectorAdapterIs( srcArray ) || _.longIs( srcArray ) );

  if( srcArray._vectorBuffer )
  return srcArray;

  let result = new VectorFromArray();
  result._vectorBuffer = srcArray;

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
    return this._vectorBuffer[ this.offset+index ];
  },
  eSet : function( index, src )
  {
    _.assert( index < this.length );
    this._vectorBuffer[ this.offset+index ] = src;
  },
  constructor : VectorSub,
}

Object.setPrototypeOf( VectorSub.prototype, Vector.prototype );

_.propertyConstant( VectorSub.prototype,
{
  stride : 1,
});

/**
* @summary Creates vector From part of source array `srcArray`.
* @param {Array} srcArray Source array.
* @param {Array} offset Offset to sub array in source array `srcArray`.
* @param {Array} length Length of new vector.
*
* @example
* var srcArray = [ 1, 2, 3 ];
* var vec = wTools.vector.FromSubArray( srcArray, 0, 2 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function FromSubArray
* @memberof module:Tools/math/Vector.wTools.vector
*/

function FromSubArray( srcArray, offset, length )
{

  if( offset === undefined )
  offset = 0;

  if( length === undefined )
  length = srcArray.length-offset;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( !!srcArray );
  _.assert( offset+length <= srcArray.length );

  if( srcArray._vectorBuffer )
  {

    if( srcArray.offset )
    offset = srcArray.offset + offset*( srcArray.stride || 1 );

    length = _min( length, srcArray.length );

    if( srcArray.stride )
    return FromSubArrayWithStride( srcArray._vectorBuffer, offset, length, srcArray.stride );

    srcArray = srcArray._vectorBuffer;

  }

  let result = new VectorSub();
  result._vectorBuffer = srcArray;
  result.length = length;
  result.offset = offset;

  Object.freeze( result );
  return result;
}

//

function VectorSubArrayWithStride(){};
VectorSubArrayWithStride.prototype =
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
  constructor : VectorSubArrayWithStride,
}

Object.setPrototypeOf( VectorSubArrayWithStride.prototype, Vector.prototype );

function FromSubArrayWithStride( srcArray, offset, length, stride )
{

  _.assert( arguments.length === 4 );
  _.assert( 0 <= stride );
  _.assert( _.numberIs( offset ) );
  _.assert( _.numberIs( length ) );
  _.assert( offset+(length-1)*stride < srcArray.length );

  if( stride === 1 )
  return FromSubArray( srcArray, offset, length );

  if( srcArray._vectorBuffer )
  {
    throw _.err( 'not implemented' );
  }

  let result = new VectorSubArrayWithStride();
  result._vectorBuffer = srcArray;
  result.length = length;
  result.offset = offset;
  result.stride = stride;

  Object.freeze( result );
  return result;
}

//

function FromArrayWithStride( srcArray, stride )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return this.FromSubArrayWithStride( srcArray, 0, Math.ceil( srcArray.length / stride ), stride );
}

// --
// From
// --

let routineFrom =
{

  Make/*makeArrayOfLength*/,
  MakeFilling,

  FromMaybeNumber,
  From,
  FromArray,
  FromSubArray,
  FromSubArrayWithStride,
  FromArrayWithStride,

}

// --
// declare
// --

let Proto =
{

  _routineFrom : routineFrom,

}

_.mapExtend( Proto, routineFrom );
_.mapExtend( Namespace, Proto );

_.assert( _.objectIs( _.withDefaultLong.Fx ) );
Object.setPrototypeOf( Namespace, _.withDefaultLong.Fx );
Namespace.constructor = function Vector(){};

_.assert( Namespace.long === undefined );
Namespace.long = _.withDefaultLong.Fx;
_.assert( _.objectIs( Namespace.long ) );

_.vector = Namespace;
_.Vector = Vector;

_.assert( _.routineIs( Namespace.long.longFrom ) );

_.assert( _.numberIs( _.accuracy ) );
_.assert( _.numberIs( _.accuracySqr ) );

})();
