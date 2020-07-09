(function _LongShrinked_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = VectorAdapterFromLongShrinked;
function VectorAdapterFromLongShrinked(){};

//

function _review( crange )
{
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
    result = this.vectorAdapter.longMake( this._vectorBuffer, this.length );
    for( let i = 0 ; i < this.length ; i++ )
    result[ i ] = this.eGet( i );
  }
  else
  {
    result = this._vectorBuffer;
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
    _.assert( index < this.length );
    return this._vectorBuffer[ this.offset + index ];
  },
  eSet : function( index, src )
  {
    _.assert( index < this.length );
    this._vectorBuffer[ this.offset + index ] = src;
  },
  _review,
  _toLong,
  _bufferConstructorGet,
}

_.propertyConstant( Self.prototype,
{
  stride : 1,
});

Object.setPrototypeOf( Self.prototype, Parent.prototype );

//

/**
 * Routine fromLongLrange() creates vector from part of source Long `srcLong`.
 *
 * @param { Long|VectorAdapter } srcLong - Source Long or vector.
 * @param { Number } offset - Offset in source Long.
 * @param { Number } length - Length of new vector.
 *
 * @example
 * var srcLong = [ 1, 2, 3 ];
 * var got = _.vectorAdapter.fromLongLrange( srcLong, 0, 2 );
 * console.log( got.toStr() );
 *
 * @returns { VectorAdapter } - Returns new VectorAdapter from part of source Long.
 * @function fromLongLrange
 * @namespace wTools.vectorAdapter
 * @module Tools/math/Vector
 */

function fromLongLrange( srcLong, offset, length )
{

  if( offset === undefined )
  offset = 0;

  if( length === undefined )
  length = srcLong.length-offset;

  if( _.rangeIs( arguments[ 1 ] ) ) /* qqq : make sure it is covered */
  [ offset, length ] = arguments[ 1 ];

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( !!srcLong );
  _.assert( offset+length <= srcLong.length );

  if( _.vectorAdapterIs( srcLong ) )
  {
    return srcLong._review([ offset, offset+length-1 ]);
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

  fromLongLrange, /* qqq : cover routine _.vectorAdapter.fromLongLrange and all _.vectorAdapter.from* routines. coverage should be perfect */

}

let VectorExtension =
{

}

_.mapSupplement( VectorExtension, _routinesFrom );
_.mapSupplement( _.vectorAdapter._routinesFrom, _routinesFrom );
_.mapSupplement( _.vectorAdapter, VectorExtension );

})();
