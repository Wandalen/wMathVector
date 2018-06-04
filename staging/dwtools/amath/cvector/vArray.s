(function _vArray_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }


  require( './Base.s' );

}

var _ = _global_.wTools;
var _row = _.vector;
var _min = Math.min;
var _max = Math.max;
var _arraySlice = Array.prototype.slice;
var _sqrt = Math.sqrt;
var _sqr = _.sqr;

var Parent = null;
var Self = Object.create( null );

// --
// proto
// --

var Proto =
{
}

_.accessorForbid
({
  object : Self,
  names : _.vector.Forbidden,
});

// --
// row wrap
// --

var routines = _row.RoutinesMathematical;
for( var r in routines )
{

  if( Self[ r ] )
  {
    debugger;
    continue;
  }

  function onReturn( result,theRoutine )
  {
    var op = theRoutine.operation;

    if( op.returningAtomic && _.primitiveIs( result ) )
    {
      return result;
    }
    else if( op.returningSelf )
    {
      return result.toArray();
    }
    else if( op.returningNew && _.vectorIs( result ) )
    {
      return result.toArray();
    }
    else if( op.returningArray )
    {
      _.assert( _.arrayIs( result ) || _.bufferTypedIs( result ),'unexpected' );
      return result;
    }
    else return result;
  }

  Proto[ r ] = _.vector.withWrapper
  ({
    routine : routines[ r ],
    onReturn : onReturn,
    usingThisAsFirstArgument : 0,
  });

}

// --
// proto extension
// --

Object.setPrototypeOf( Self,wTools );

_.mapExtend( Self,Proto );

_.avector = Self;

// debugger;
_._arrayDescriptorsApplyTo( Self );
// debugger;
_.assert( _.mapOwnKey( _.avector,'withArray' ) );
_.assert( _.avector.withArray );
_.assert( _.avector.withArray.Array );
_.assert( _.avector.withArray.Float32 );
// debugger;

_.assert( Object.getPrototypeOf( Self ) === wTools );
_.assert( _.objectIs( _row.RoutinesMathematical ) );
_.assert( !_.avector.isValid );
_.assert( _.avector.allFinite );

})();
