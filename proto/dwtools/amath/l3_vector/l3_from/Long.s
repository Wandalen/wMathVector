(function _Long_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function VectorAdapterFromLong(){};

//

function _shrinkView( crange )
{
  debugger;
  let offset = crange[ 0 ];
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
  result = this._vectorBuffer;
  return result;
}

//

Self.prototype =
{
  constructor : Self,
  _lengthGet : function(){ return this._vectorBuffer.length; },
  eGet : function( index ){ return this._vectorBuffer[ index ]; },
  eSet : function( index, src ){ this._vectorBuffer[ index ] = src; },
  _shrinkView,
  _toLong,
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
