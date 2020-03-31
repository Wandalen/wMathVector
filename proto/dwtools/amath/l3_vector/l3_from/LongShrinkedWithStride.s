(function _LongShrinkedWithStride_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function VectorAdapterFromLongShrinkedWithStrideNumberShrinkView(){};

//

function _review( crange )
{
  let offset = this.offset + crange[ 0 ]*this.stride;
  let length = crange[ 1 ]-crange[ 0 ]+1;
  _.assert( crange[ 0 ] >= 0 );
  _.assert( crange[ 1 ] <= this.length );
  _.assert( length >= 0 );
  return this.FromLongLrangeAndStride( this._vectorBuffer, offset, length, this.stride );
}

//

function _toLong()
{
  let result;
  if( this.stride !== 1 || this.offset !== 0 || this.length !== this._vectorBuffer.length )
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

function _bufferConstructorGet()
{
  return this._vectorBuffer.constructor;
}

//

Self.prototype =
{
  constructor : Self,
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
  _review,
  _toLong,
  _bufferConstructorGet,
}

Object.setPrototypeOf( Self.prototype, Parent.prototype );

//

/**
 * Routine fromLongLrangeAndStride creates vector from part of source Long `srcLong`. The elements of the
 * vector are selected with a defined stride.
 *
 * @param { Long|VectorAdapter } srcLong - Source vector.
 * @param { Number } offset - Offset to sub array in source array `srcLong`.
 * @param { Number } length - Length of new vector.
 * @param { Number } stride - The stride to select elements of new vector.
 *
 * @example
 * var srcLong = [ 1, 2, 3, 4, 5, 6, 7 ];
 * var got = _.vector.fromLongLrangeAndStride( srcLong, 1, 3, 2 );
 * console.log( got.toStr() );
 * // log "2.000, 4.000, 6.000"
 *
 * @returns { VectorAdapter } - Returns new VectorAdapter.
 * @function fromLongLrangeAndStride
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function fromLongLrangeAndStride( srcLong, offset, length, stride )
{

  if( _.rangeIs( arguments[ 1 ] ) ) /* qqq : make sure it is covered */
  {
    [ offset, length ] = arguments[ 1 ];
    stride = arguments[ 2 ];
    _.assert( arguments.length === 3 );
  }
  else
  {
    _.assert( arguments.length === 4 );
  }

  _.assert( offset >= 0 );
  // _.assert( length <= srcLong.length-offset || length === 0 );
  _.assert( offset+(length-1)*stride < srcLong.length );

  if( stride === 1 )
  return this.fromLongLrange( srcLong, offset, length );

  if( srcLong._vectorBuffer )
  {
    throw _.err( 'not implemented' );
  }

  let result = new Self();
  result._vectorBuffer = srcLong;
  result.length = length;
  result.offset = offset;
  result.stride = stride;

  Object.freeze( result );
  return result;
}

//

/**
 * Routine fromLongWithStride creates vector from all elements of source Long `srcLong`. The elements of the
 * vector are selected with a defined stride.
 *
 * @param { Long|VectorAdapter } srcLong - Source vector.
 * @param { Number } stride - The stride to select elements of new vector.
 *
 * @example
 * var srcLong = [ 1, 2, 3, 4, 5, 6, 7 ];
 * var got = _.vector.fromLongWithStride( srcLong, 3 );
 * console.log( got.toStr() );
 * // log "1.000, 4.000, 7.000"
 *
 * @returns { VectorAdapter } - Returns new VectorAdapter.
 * @function fromLongWithStride
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

function fromLongWithStride( srcLong, stride )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return this.fromLongLrangeAndStride( srcLong, 0, Math.ceil( srcLong.length / stride ), stride );
}

// --
// extension
// --

let _routinesFrom =
{

  fromLongLrangeAndStride,
  fromLongWithStride,

}

let VectorExtension =
{

}
_.mapSupplement( VectorExtension, _routinesFrom );
_.mapSupplement( _.vectorAdapter._routinesFrom, _routinesFrom );
_.mapSupplement( _.vectorAdapter, VectorExtension );

})();
