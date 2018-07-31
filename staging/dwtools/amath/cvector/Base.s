(function _Base_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }


  var _ = _global_.wTools;

  _.include( 'wProto' );
  _.include( 'wMathScalar' )

}

var _ = _global_.wTools;
var _hasLength = _.hasLength;
var _min = Math.min;
var _max = Math.max;
var _arraySlice = _.longSlice;
var _sqrt = Math.sqrt;
var _abs = Math.abs;
var _sqr = _.sqr;
// var __assert = _.assert;
var _assertMapHasOnly = _.assertMapHasOnly;
var _routineIs = _.routineIs;

// debugger;
//
// if( _.accuracy === undefined )
// _.accuracy = 1e-7;
//
// if( _.accuracySqr === undefined )
// _.accuracySqr = 1e-15;

var Parent = null;
var Self = Object.create( null );

function Vector(){ throw _.err( 'should not be called' ) };
Vector.prototype = Object.create( null );
Vector.prototype._vectorBuffer = null;

// --
// from
// --

function makeArrayOfLength( length )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  var srcArray = new this.ArrayType( length );
  return fromArray( srcArray );
}

function makeArrayOfLengthWithValue( length,value )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  var srcArray = new this.ArrayType( length );
  for( var i = 0 ; i < length ; i++ )
  srcArray[ i ] = value;
  return fromArray( srcArray );
}

// --
// from
// --

function VectorFromNumber() {};
VectorFromNumber.prototype =
{
  eGet : function( index ){ return this._vectorBuffer[ 0 ]; },
  eSet : function( index,src ){ this._vectorBuffer[ 0 ] = src; },
  constructor : VectorFromNumber,
}

Object.setPrototypeOf( VectorFromNumber.prototype,Vector.prototype );

_.constant( VectorFromNumber.prototype,
{
  offset : 0,
  stride : 0,
});

function fromMaybeNumber( number,length )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( length >= 0 );

  var numberIs = _.numberIs( number );

  _.assert( numberIs || _.longIs( number ) || _.vectorIs( number ) );

  if( !numberIs )
  {
    _.assert( number.length === length );
    return this.fromArray( number );
  }

  var result = new VectorFromNumber();
  result._vectorBuffer = [ number ];
  _.constant( result,{ length : length } );

  return result;
}

//

function from( srcArray )
{

  _.assert( arguments.length === 1,'from expects single arguments { srcArray }' );

  if( _.vectorIs( srcArray ) )
  return srcArray;
  else if( _.longIs( srcArray ) )
  return fromArray( srcArray );
  else if( _.spaceIs( srcArray ) )
  {
    _.assert( srcArray.dims.length === 2 );
    _.assert( srcArray.dims[ 0 ] === 1 || srcArray.dims[ 1 ] === 1 );
    if( srcArray.dims[ 0 ] === 1 )
    return srcArray.rowVectorGet( 0 );
    else
    return srcArray.colVectorGet( 0 );
  }
  else _.assert( 0,'cant make Vector from',_.strTypeOf( srcArray ) );

}

//

function VectorFromArray(){};
VectorFromArray.prototype =
{
  '_lengthGet' : function(){ return this._vectorBuffer.length; },
  eGet : function( index ){ return this._vectorBuffer[ index ]; },
  eSet : function( index,src ){ this._vectorBuffer[ index ] = src; },
  constructor : VectorFromArray,
}

Object.setPrototypeOf( VectorFromArray.prototype,Vector.prototype );

_.accessorReadOnly
({
  object : VectorFromArray.prototype,
  prime : 0,
  names :
  {
    length : 'length',
  },
});

_.constant( VectorFromArray.prototype,
{
  offset : 0,
  stride : 1,
});

function fromArray( srcArray )
{

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.vectorIs( srcArray ) || _.longIs( srcArray ) );

  if( srcArray._vectorBuffer )
  return srcArray;

  var result = new VectorFromArray();
  result._vectorBuffer = srcArray;

  Object.freeze( result );
  return result;
}

//

function VectorSub(){};
VectorSub.prototype =
{
  eGet : function( index )
  {
    _.assert( index < this.length );
    return this._vectorBuffer[ this.offset+index ];
  },
  eSet : function( index,src )
  {
    _.assert( index < this.length );
    this._vectorBuffer[ this.offset+index ] = src;
  },
  constructor : VectorSub,
}

Object.setPrototypeOf( VectorSub.prototype, Vector.prototype );

_.constant( VectorSub.prototype,
{
  stride : 1,
});

function fromSubArray( srcArray,offset,length )
{

  if( offset === undefined )
  offset = 0;

  if( length === undefined )
  length = srcArray.length-offset;

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( !!srcArray );
  _.assert( offset+length <= srcArray.length );

  if( srcArray._vectorBuffer )
  {

    if( srcArray.offset )
    offset = srcArray.offset + offset*( srcArray.stride || 1 );

    length = _min( length,srcArray.length );

    if( srcArray.stride )
    return fromSubArrayWithStride( srcArray._vectorBuffer,offset,length,srcArray.stride );

    srcArray = srcArray._vectorBuffer;

  }

  var result = new VectorSub();
  result._vectorBuffer = srcArray;
  result.length = length;
  result.offset = offset;

  Object.freeze( result );
  return result;
}

//

function VectorSubArrayWithStride(){};
VectorSubArrayWithStride.prototype =
{
  eGet : function( index )
  {
    var i = this.offset+index*this.stride;
    _.assert( index < this.length );
    _.assert( i < this._vectorBuffer.length );
    return this._vectorBuffer[ i ];
  },
  eSet : function( index,src )
  {
    var i = this.offset+index*this.stride;
    _.assert( index < this.length );
    _.assert( i < this._vectorBuffer.length );
    this._vectorBuffer[ i ] = src;
  },
  constructor : VectorSubArrayWithStride,
}

Object.setPrototypeOf( VectorSubArrayWithStride.prototype,Vector.prototype );

function fromSubArrayWithStride( srcArray,offset,length,stride )
{

  _.assert( arguments.length === 4 );
  _.assert( 0 <= stride );
  _.assert( _.numberIs( offset ) );
  _.assert( _.numberIs( length ) );
  _.assert( offset+(length-1)*stride < srcArray.length );

  if( stride === 1 )
  return fromSubArray( srcArray,offset,length );

  if( srcArray._vectorBuffer )
  {
    throw _.err( 'not implemented' );
  }

  var result = new VectorSubArrayWithStride();
  result._vectorBuffer = srcArray;
  result.length = length;
  result.offset = offset;
  result.stride = stride;

  Object.freeze( result );
  return result;
}

//

function fromArrayWithStride( srcArray,stride )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  return this.fromSubArrayWithStride( srcArray,0,Math.ceil( srcArray.length / stride ),stride );
}

//

function variants( variants )
{
  var result = _.longSlice( variants );
  var length;

  _.assert( arguments.length === 1, 'expects single argument' );
  _.longIs( variants );

  /* */

  for( var v = 0 ; v < result.length ; v++ )
  {
    var variant = result[ v ];

    _.assert( _.numberIs( variant ) || _.longIs( variant ) || _.vectorIs( variant ) );

    if( _.numberIs( variant ) )
    continue;

    if( length !== undefined )
    _.assert( variant.length === length,'all variants should have same length' );

    length = variant.length;

  }

  if( length === undefined )
  length = 1;

  /* */

  for( var v = 0 ; v < result.length ; v++ )
  {
    var variant = result[ v ];

    if( _.vectorIs( variant ) )
    continue;

    if( _.longIs( variant ) )
    variant = result[ v ] = _.vector.fromArray( variant );
    else
    variant = result[ v ] = _.vector.fromMaybeNumber( variant,length );

  }

  /* */

  return result;
}

//

function withWrapper( o )
{

  if( _.objectIs( o.routine ) )
  {
    var result = Object.create( null );
    for( var r in o.routine )
    {
      var optionsForWrapper = _.mapExtend( null,o );
      optionsForWrapper.routine = o.routine[ r ];
      result[ r ] = withWrapper( optionsForWrapper );
    }
    return result;
  }

  /* */

  var onReturn = o.onReturn;
  var usingThisAsFirstArgument = o.usingThisAsFirstArgument ? 1 : 0;
  var theRoutine = o.routine;

  var op = theRoutine.operation;
  var takingArguments = op.takingArguments;
  var takingVectors = op.takingVectors;
  var takingVectorsOnly = op.takingVectorsOnly;
  var returningSelf = op.returningSelf;
  var returningNew = op.returningNew;
  var returningArray = op.returningArray;
  var modifying = op.modifying;
  var notMethod = op.notMethod;

  /* verification */

  _.assert( _.mapIs( op ) );
  _.assert( _.routineIs( theRoutine ) );
  _.assert( _.numberIs( takingArguments ) || _.arrayIs( takingArguments ) );
  _.assert( _.numberIs( takingVectors ) || _.arrayIs( takingVectors ) );
  _.assert( _.boolIs( takingVectorsOnly ) );
  _.assert( _.boolIs( returningSelf ) );
  _.assert( _.boolIs( returningNew ) );
  _.assert( _.boolIs( returningArray ) );
  _.assert( _.boolIs( modifying ) );

  _.assert( _.routineIs( onReturn ) );
  _.assert( _.routineIs( theRoutine ) );

  /* adjust */

  if( _.numberIs( takingArguments ) ) takingArguments = Object.freeze([ takingArguments,takingArguments ]);
  else takingArguments = Object.freeze( takingArguments.slice() );

  if( _.numberIs( takingVectors ) )
  takingVectors = Object.freeze([ takingVectors,takingVectors ]);
  else
  takingVectors = Object.freeze( takingVectors.slice() );
  var hasOptionalVectors = takingVectors[ 0 ] !== takingVectors[ 1 ];

  /* */

  function makeVector( arg )
  {
    if( _routineIs( arg ) )
    return arg;

    // if( _hasLength( arg ) && ( !_.Space || !( arg instanceof _.Space ) ) )
    if( _.longIs( arg ) )
    return Self.fromArray( arg );
    return arg;
  }

  /* */

  function vectorWrap()
  {
    var l = arguments.length + usingThisAsFirstArgument;
    var args = new Array( l );

    _.assert( takingArguments[ 0 ] <= l && l <= takingArguments[ 1 ] );

    var s = 0;
    var d = 0;
    if( usingThisAsFirstArgument )
    {
      args[ d ] = this;
      d += 1;
    }

    for( ; d < takingVectors[ 0 ] ; d++, s++ )
    {
      args[ d ] = makeVector( arguments[ s ] );
      _.assert( _.vectorIs( args[ d ] ) || ( d === 0 && returningNew ) );
    }

    if( hasOptionalVectors )
    {
      var optionalLength = _min( takingVectors[ 1 ],l );
      for( ; d < optionalLength ; d++, s++ )
      args[ d ] = makeVector( arguments[ s ] );
    }

    var optionalLength = _min( takingArguments[ 1 ],l );
    for( ; d < optionalLength ; d++, s++ )
    args[ d ] = arguments[ s ];

    var result = theRoutine.apply( Self,args );

    return onReturn.call( this,result,theRoutine );
  }

  vectorWrap.notMethod = notMethod;
  vectorWrap.operation = op;

  return vectorWrap;
}

// --
// from
// --

var routineFrom =
{

  makeArrayOfLength : makeArrayOfLength,
  makeArrayOfLengthWithValue : makeArrayOfLengthWithValue,

  fromMaybeNumber : fromMaybeNumber,
  from : from,
  fromArray : fromArray,
  fromSubArray : fromSubArray,
  fromSubArrayWithStride : fromSubArrayWithStride,
  fromArrayWithStride : fromArrayWithStride,

  variants : variants,

  withWrapper : withWrapper,

}

// --
// define class
// --

var Proto =
{


  _routineFrom : routineFrom,

}

_.mapExtend( Proto,routineFrom );
_.mapExtend( Self,Proto );

Object.setPrototypeOf( Self,wTools );
Self.constructor = function Vector(){};

_.vector = Self;
_.Vector = Vector;

_.assert( _.routineIs( Self.withWrapper ) );
_.assert( _.objectIs( Self.array ) );
_.assert( _.routineIs( Self.array.arrayFromCoercing ) );
_.assert( _.routineIs( Self.array.makeArrayOfLength ) );

_.assert( _.numberIs( _.accuracy ) );
_.assert( _.numberIs( _.accuracySqr ) );

//

if( typeof module !== 'undefined' )
{
  require( './dOperations.s' );
  require( './eRoutines.s' );
  require( './fMethods.s' );
  require( './vArray.s' );
}

})();
