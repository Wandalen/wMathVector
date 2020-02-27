(function _LongShrinkedWithStride_s_() {

'use strict';

let _ = _global_.wTools;
let Parent = _.VectorAdapter;

// --
//
// --

let Self = function VectorAdapterFromLongShrinkedWithStrideNumberShrinkView(){};

//

function _shrinkView( crange )
{
  debugger;
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
  _shrinkView,
  _toLong,
}

Object.setPrototypeOf( Self.prototype, Parent.prototype );

// //
//
// function fromLongLrangeAndStride( srcLong, crange, stride )
// {
//
//   _.assert( arguments.length === 3 );
//   _.assert( 0 <= stride );
//   _.assert( _.rangeIs( crange ); )
//   _.assert( crange[ 0 ] + crange[ 1 ]*stride < srcLong.length );
//
//   if( stride === 1 )
//   return fromLongLrange( srcLong, offset, length );
//
//   if( srcLong._vectorBuffer )
//   {
//     throw _.err( 'not implemented' );
//   }
//
//   let result = new Self();
//   result._vectorBuffer = srcLong;
//   result.length = length;
//   result.offset = offset;
//   result.stride = stride;
//
//   Object.freeze( result );
//   return result;
// }
//
// //
//
// function fromLongLrangeAndStride_old( srcLong, offset, length, stride )
// {
//
//   _.assert( arguments.length === 4 );
//   _.assert( 0 <= stride );
//   _.assert( _.numberIs( offset ) );
//   _.assert( _.numberIs( length ) );
//   _.assert( offset+(length-1)*stride < srcLong.length );
//
//   return this.fromLongLrangeAndStride( srcLong, [ offset, offset + length - 1 ], stride );
// }


//

function fromLongLrangeAndStride( srcLong, offset, length, stride ) /* xxx */
{

  _.assert( arguments.length === 4 );
  _.assert( 0 <= stride );
  _.assert( _.numberIs( offset ) );
  _.assert( _.numberIs( length ) );
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
  // fromLongLrangeAndStride_old,
  fromLongWithStride,

}

let VectorExtension =
{

}
_.mapSupplement( VectorExtension, _routinesFrom );
_.mapSupplement( _.vectorAdapter._routinesFrom, _routinesFrom );
_.mapSupplement( _.vectorAdapter, VectorExtension );

})();
