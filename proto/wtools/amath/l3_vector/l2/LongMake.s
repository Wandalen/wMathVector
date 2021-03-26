(function _LongMake_s_() {

'use strict';

const _ = _global_.wTools;
let _hasLength = _.hasLength;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = _.longSlice;
let _sqrt = Math.sqrt;
let _abs = Math.abs;
let _sqr = _.math.sqr;

// --
// From
// --

/**
* @summary Creates vector From array of length `length`.
* @param {Number} length Length of array.
*
* @example
* var vec = wTools.vector.make( 3 );
* console.log( 'vec:', vec );
* console.log( 'vec.toStr():', vec.toStr() );
*
* @function make
* @namespace wTools.avector
* @module Tools/math/Vector
*/

function make( length )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.routineIs( self ) )
  self = self.prototype;
  let srcLong = new self.longDescriptor.make( length );
  return srcLong;
}

//

/**
* @summary Creates vector From array of length `length` and fills it with element `value`.
* @param {Number} length Length of array.
* @param {*} value Element for fill operation.
*
* @example
* var vec = wTools.vector.makeFilling( 3, 0 );
* console.log( 'vec:', vec );
* console.log( 'vec.toStr():', vec.toStr() );
*
* @function makeFilling
* @namespace wTools.avector
* @module Tools/math/Vector
*/

function makeFilling( length, value )
{
  let self = this;
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  if( _.routineIs( self ) )
  self = self.prototype;
  let srcLong = new self.longDescriptor.make( length );
  for( let i = 0 ; i < length ; i++ )
  srcLong[ i ] = value;
  return srcLong;
}

// --
// extension
// --

let _routinesFrom =
{

  make, /*makeArrayOfLength*/
  makeFilling,

}

let AvectorExtension =
{

  _routinesFrom : _routinesFrom,

}

_.mapExtend( AvectorExtension, _routinesFrom );
_.mapExtend( _.avector, AvectorExtension );

})();
