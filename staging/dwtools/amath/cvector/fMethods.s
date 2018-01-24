(function _fVectorMethods_s_() {

'use strict';

var _ = wTools;
var _hasLength = _.hasLength;
var _arraySlice = _.arraySlice;
var _sqr = _.sqr;
var _assert = _.assert;
var _assertMapHasOnly = _.assertMapHasOnly;
var _routineIs = _.routineIs;

var _min = Math.min;
var _max = Math.max;
var _sqrt = Math.sqrt;
var _abs = Math.abs;

var EPS = _.EPS;
var EPS2 = _.EPS2;

var Parent = null;
var Self = wTools.Vector;
var vector = wTools.vector;

// --
// etc
// --

function to( cls )
{
  var self = this;
  var result,array;

  _.assert( arguments.length === 1 );

  if( _.clsLikeArray( cls ) )
  {
    result = new cls( self.length );
    array = result;
    for( var i = 0 ; i < result.length ; i++ )
    array[ i ] = self.eGet( i );
    return result;
  }
  else if( _.clsIsVector( cls ) )
  {
    return this;
  }
  else if( _.clsIsSpace( cls ) )
  {
    return _.Space.makeCol( this )
  }

  _.assert( 0,'unknown class to convert to',_.strTypeOf( cls ) );
}

//

function eGet( index )
{
  var self = this;
  _.assert( arguments.length === 1 );
  return vector.eGet( self,index );
}

//

function eSet( index,val )
{
  var self = this;
  _.assert( arguments.length === 2 );
  return vector.eGet( self,index,val );
}

//

function assign()
{
  var self = this;
  var args = _.arraySlice( arguments );
  args.unshift( self );
  return vector.assign.apply( vector,args );
}

//

function copy( src )
{
  var self = this;
  _.assert( arguments.length === 1 );
  return vector.assign( self,src );
}

//

// function clone()
// {
//   var self = this;
//   _.assert( arguments.length === 0 );
//   _.assert( _.vectorIs( self ) );
//   return vector.clone( self );
// }

//

function makeSimilar( length )
{
  var self = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  return vector.makeSimilar( self,length );
}

//

function slice( b,e )
{
  var self = this;

  _.assert( arguments.length <= 2 );
  _.assert( _.vectorIs( self ) );

  return vector.slice( self,b,e );
}

//

function slicedArray( b,e )
{
  var self = this;

  _.assert( arguments.length <= 2 );
  _.assert( _.vectorIs( self ) );

  return vector.slicedArray( self,b,e );
}

//

function slicedVector( b,e )
{
  var self = this;

  _.assert( arguments.length <= 2 );
  _.assert( _.vectorIs( self ) );

  return vector.slicedVector( self,b,e );
}

//

function resizedArray( first,last,val )
{
  var self = this;
  _.assert( arguments.length <= 3 );
  var result = vector.resizedArray( self,first,last,val );
  return result;
}

//

function resizedVector( first,last,val )
{
  var self = this;
  _.assert( arguments.length <= 3 );
  var result = vector.resizedVector( self,first,last,val );
  return result;
}

//

function subarray( first,last )
{
  var self = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  return vector.subarray( self,first,last );
}

//

function toArray()
{
  var self = this;

  _.assert( arguments.length === 0 );
  _.assert( _.vectorIs( self ) );

  return vector.toArray( self );
}

//

function toStr( o )
{
  var self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.mapIs( o ) || o === undefined );
  _.assert( _.vectorIs( self ) );

  return vector._toStr( self,o );
}

//

// function equalWith( src,o )
// {
//   var self = this;
//
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   return vector.equalWith( self,src,o );
// }

//

function _equalWith( src2,iterator )
{
  var src1 = this;
  _.assert( arguments.length === 2 );
  debugger;
  return vector._equalAre( src1,src2,iterator );
}

equalWith.takingArguments = 2;
equalWith.takingVectors = 2;
equalWith.takingVectorsOnly = true;
equalWith.returningSelf = false;
equalWith.returningNew = false;
equalWith.modifying = false;

//

function equalWith( src2,iterator )
{
  var src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  return vector.equalAre( src1,src2,iterator );
}

equalWith.takingArguments = 2;
equalWith.takingVectors = 2;
equalWith.takingVectorsOnly = true;
equalWith.returningSelf = false;
equalWith.returningNew = false;
equalWith.modifying = false;

//

function identicalWith( src2,iterator )
{
  var src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger;
  return vector.identicalAre( src1,src2,iterator );
}

identicalWith.takingArguments = 2;
identicalWith.takingVectors = 2;
identicalWith.takingVectorsOnly = true;
identicalWith.returningSelf = false;
identicalWith.returningNew = false;
identicalWith.modifying = false;

//

function equivalentWith( src2,iterator )
{
  var src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger;
  return vector.equivalentAre( src1,src2,iterator );
}

equivalentWith.takingArguments = [ 2,3 ];
equivalentWith.takingVectors = 2;
equivalentWith.takingVectorsOnly = false;
equivalentWith.returningSelf = false;
equivalentWith.returningNew = false;
equivalentWith.modifying = false;

//

function sameWith( src2 )
{
  var src1 = this;
  _.assert( arguments.length === 1 );
  if( src1._vectorBuffer !== src2._vectorBuffer )
  return false;
  if( src1.offset !== src2.offset )
  return false;
  if( src1.length !== src2.length )
  return false;
  debugger;
  return true;
}

sameWith.takingArguments = [ 2,3 ];
sameWith.takingVectors = 2;
sameWith.takingVectorsOnly = false;
sameWith.returningSelf = false;
sameWith.returningNew = false;
sameWith.modifying = false;

//

function hasShape( src )
{
  if( _.spaceIs( src ) )
  return src.dims.length === 2 && src.dims[ 0 ] === self.length && src.dims[ 1 ] === 1;
  return this.length === src.length;
}

hasShape.takingArguments = 2;
hasShape.takingVectors = 2;
hasShape.takingVectorsOnly = true;
hasShape.returningSelf = false;
hasShape.returningNew = false;
hasShape.modifying = false;

// --
// proto
// --

var Proto =
{

  to : to,

  eGet : eGet,
  eSet : eSet,

  assign : assign,
  copy : copy,

  makeSimilar : makeSimilar,

  slice : slice,
  slicedArray : slicedArray,
  slicedVector : slicedVector,

  resizedArray : resizedArray,
  resizedVector : resizedVector,

  subarray : subarray,

  // toArray : toArray,
  toStr : toStr,

  equalWith : equalWith,
  identicalWith : identicalWith,
  equivalentWith : equivalentWith,
  sameWith : sameWith,

  hasShape : hasShape,

}

_.mapExtend( Self.prototype,Proto );

// --
// declare
// --

function declareSingleArgumentRoutine( routine, r )
{

  var op = routine.operation;

  // if( r === 'allZero' )
  // debugger;

  var absLike = op.returningOnly === 'self' && op.modifying && op.atomWise && op.homogeneous;
  var reduceToScalarLike = op.returningOnly === 'atomic' && !op.modifying && op.atomWise && op.homogeneous;

  var singleArgument = _.arrayIdentical( op.takingArguments, [ 1,1 ] );
  var oneOrTwoArguments = _.arrayIdentical( op.takingArguments, [ 1,2 ] );
  var oneOrInfinity = _.arrayIdentical( op.takingArguments, [ 1,Infinity ] );

  var doesFit = singleArgument || ( absLike && oneOrTwoArguments ) || ( reduceToScalarLike && ( singleArgument || oneOrInfinity ) );

  if( !doesFit )
  return false;

  _.assert( Self.prototype[ r ] === undefined );

  Self.prototype[ r ] = function singleArgumentRoutine()
  {
    _.assert( arguments.length === 0 );
    _.assert( _.vectorIs( this ) );
    return routine.call( vector,this );
  }

}

//

function declareTwoArgumentsRoutine( routine, r )
{
  var op = routine.operation;

  // if( r === 'mulScalar' )
  // debugger;

  if( !_.arrayIdentical( op.takingArguments , [ 2,2 ] ) )
  return false;
  // if( !_.arrayIdentical( op.takingVectors , [ 1,1 ] ) )
  if( !_.arrayIdentical( op.takingVectors , [ 1,1 ] ) && !_.arrayIdentical( op.takingVectors , [ 0,1 ] ) )
  return false;

  _.assert( Self.prototype[ r ] === undefined );

  Self.prototype[ r ] = function scalarRoutine( scalar )
  {
    _.assert( arguments.length === 1 );
    _.assert( _.vectorIs( this ) );
    return routine.call( vector,this,scalar );
  }

}

//

var routines = _.vector.RoutinesMathematical;
for( var r in routines )
{
  var routine = routines[ r ];

  _.assert( _.routineIs( routine ) );

  declareSingleArgumentRoutine( routine , r );
  declareTwoArgumentsRoutine( routine , r );

}

_.assert( Self.prototype.mag );
_.assert( Self.prototype.magSqr );

_.assert( Self.prototype.toArray );

_.assert( Self.prototype.abs );
_.assert( Self.prototype.makeSimilar );
_.assert( Self.prototype.assign );
_.assert( Self.prototype.slice );

_.assert( Self.prototype.allZero );

})();
