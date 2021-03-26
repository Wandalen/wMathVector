(function _VectorSpecial_s_() {

'use strict';

const _ = _global_.wTools;
const Self = _.vector;
let meta = _.vectorAdapter._meta;

// --
//
// --

function toStr( src )
{

  _.assert( _.vectorIs( src ) );
  _.assert( arguments.length === 1, 'not tested' );

  if( _.vadIs( src ) )
  return src.toStr();

  return _.entity.exportString( src );
}

// --
// declare
// --

let Extension =
{

  toStr,

}

_.mapExtend( Self, Extension );

// --
// declare
// --

_.assert( _.routineIs( _.vector.toStr ) );

})();
