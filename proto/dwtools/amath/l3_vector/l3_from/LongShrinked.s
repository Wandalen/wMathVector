(function _LongShrinked_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function VectorAdapterFromLongShrinked(){};

//

/**
 * Routine _review() makes new instance of VectorAdapter from current adapter.
 *
 * @param { Range } crange - Defines ranges for an adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromLongLrange( [ 1, 2, 3, 4, 5 ], 1, 4 );
 * var got = src._review( [ 1, 3 ] );
 * console.log( got.toStr() );
 * // log "3.000, 4.000, 5.000"
 *
 * @returns { VectorAdapter } - Returns instance of VectorAdapter with part of vector.
 * @throws { Error } If routine calls by not VectorAdapter instance.
 * @throws { Error } If {-crange[ 0 ]-} is less then 0.
 * @throws { Error } If {-crange[ 1 ]-} is more then vector length.
 * @throws { Error } If substruction of {-crange[ 1 ]-} and {-crange[ 0 ]-} is less then 0.
 * @memberof "module:Tools/math/Vector.wTools.vectorAdapter"
 */

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

/**
 * Routine _toLong() returns vector in Long format.
 * If current adapter uses full original Long, then routine returns original Long.
 * Otherwise, it returns new Long.
 *
 * @example
 * var srcLong = [ 1, 2, 3 ];
 * var src = _.vectorAdapter.fromLongLrange( srcLong, 0, 3 );
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
  if( this.offset !== 0 || this.length !== this._vectorBuffer.length )
  {
    result = this.vectorAdapter.longMake( this._vectorBuffer, this.length );
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


/**
 * Routine _bufferConstructorGet() returns constructor of original Long of current adapter.
 *
 * @example
 * var src = _.vectorAdapter.fromLongLrange( [ 1, 2, 3 ], 0, 3 );
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
 * @memberof module:Tools/math/Vector.wTools.vectorAdapter
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
