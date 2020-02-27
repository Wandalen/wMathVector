(function _LongShrinked_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function VectorAdapterFromLongShrinked(){};

//

function _shrinkView( crange )
{
  debugger;
  let offset = this.offset + crange[ 0 ];
  let length = crange[ 1 ]-crange[ 0 ]+1;
  _.assert( crange[ 0 ] >= 0 );
  _.assert( crange[ 1 ] <= this.length );
  _.assert( length >= 0 );
  return this.FromLongLrange( this._vectorBuffer, offset, length );
}

//

function _toLong()
{
  let result;
  if( this.offset !== 0 || this.length !== this._vectorBuffer.length )
  {
    result = this.vectorAdapter.longMake( this._vectorBuffer, this.length ); debugger
    for( let i = 0 ; i < this.length ; i++ )
    result[ i ] = this.eGet( i );
  }
  else
  {
    result = this._vectorBuffer; debugger;
  }
  return result;
}

//

Self.prototype =
{
  constructor : Self,
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
  _shrinkView,
  _toLong,
}

_.propertyConstant( Self.prototype,
{
  stride : 1,
});

Object.setPrototypeOf( Self.prototype, Parent.prototype );

//

/**
* @summary Creates vector from part of source array `srcLong`.
* @param {Array} srcLong Source array.
* @param {Array} offset Offset to sub array in source array `srcLong`.
* @param {Array} length Length of new vector.
*
* @example
* var srcLong = [ 1, 2, 3 ];
* var vec = wTools.vector.fromLongLrange( srcLong, 0, 2 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromLongLrange
* @memberof module:Tools/math/Vector.wTools.vectorAdapter
*/

// // function fromLongLrange( srcLong, offset, length )
// function fromLongLrange( srcLong, crange )
// {
//
//   // if( offset === undefined )
//   // offset = 0;
//   //
//   // if( length === undefined )
//   // length = srcLong.length-offset;
//
//   // _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
//   _.assert( arguments.length === 2 );
//   _.assert( _.longIs( srcLong ) );
//   _.assert( _.rangeIs( crange ) );
//   _.assert( crange[ 1 ]+1 <= srcLong.length );
//   // _.assert( offset+length <= srcLong.length );
//
//   if( srcLong._vectorBuffer )
//   {
//
//     debugger; xxx
//     return srcLong._shrinkView( crange );
//
//     // if( srcLong.offset )
//     // offset = srcLong.offset + offset*( srcLong.stride || 1 );
//     //
//     // length = Math.min( length, srcLong.length );
//     //
//     // if( srcLong.stride )
//     // return fromLongLrangeAndStride( srcLong._vectorBuffer, offset, length, srcLong.stride );
//     //
//     // srcLong = srcLong._vectorBuffer;
//
//   }
//
//   let result = new Self();
//   result._vectorBuffer = srcLong;
//   result.length = length;
//   result.offset = offset;
//
//   Object.freeze( result );
//   return result;
// }
//
// //
//
// /**
// * @summary Creates vector from part of source array `srcLong`.
// * @param {Array} srcLong Source array.
// * @param {Array} offset Offset to sub array in source array `srcLong`.
// * @param {Array} length Length of new vector.
// *
// * @example
// * var srcLong = [ 1, 2, 3 ];
// * var vec = wTools.vector.fromLongLrange( srcLong, 0, 2 );
// * console.log( 'vec: ', vec );
// * console.log( 'vec.toStr(): ', vec.toStr() );
// *
// * @function fromLongLrange
// * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// function fromLongLrange_old( srcLong, offset, length )
// {
//
//   if( offset === undefined )
//   offset = 0;
//
//   if( length === undefined )
//   length = srcLong.length-offset;
//
//   return this.fromLongLrange( srcLong, [ offset, offset + length - 1 ] );
// }

function fromLongLrange( srcLong, offset, length )  /* xxx */
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

    length = Math.min( length, srcLong.length );

    if( srcLong.stride )
    return fromLongLrangeAndStride( srcLong._vectorBuffer, offset, length, srcLong.stride );

    srcLong = srcLong._vectorBuffer;

  }

  let result = new Self();
  result._vectorBuffer = srcLong;
  result.length = length;
  result.offset = offset;

  Object.freeze( result );
  return result;
}

// --
// extension
// --

let _routinesFrom =
{

  fromLongLrange,
  // fromLongLrange_old,

}

let VectorExtension =
{

}

_.mapSupplement( VectorExtension, _routinesFrom );
_.mapSupplement( _.vectorAdapter._routinesFrom, _routinesFrom );
_.mapSupplement( _.vectorAdapter, VectorExtension );

})();
