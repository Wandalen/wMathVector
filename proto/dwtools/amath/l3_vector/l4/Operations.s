(function _Operations_s_() {

'use strict';

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _arraySlice = _.longSlice;
let _sqr = _.math.sqr;
let _assertMapHasOnly = _.assertMapHasOnly;
let _routineIs = _.routineIs;

let _min = Math.min;
let _max = Math.max;
let _sqrt = Math.sqrt;
let _abs = Math.abs;
let _pow = Math.pow;

let _floor = Math.floor;
let _ceil = Math.ceil;
let _round = Math.round;

let accuracy = _.accuracy;
let accuracySqr = _.accuracySqr;

let vad = _.vectorAdapter;
let operations = vad.operations = vad.operations || Object.create( null );
let meta = vad._meta;
let dop;

// --
// atomWiseSingler
// --

let inv = dop = Object.create( null );

dop.onAtom = function inv( o )
{
  o.dstElement = 1 / o.srcElement;
}

//

let invOrOne = dop = Object.create( null );

dop.onAtom = function invOrOne( o )
{
  if( o.srcElement === 0 )
  o.dstElement = 1;
  else
  o.dstElement = 1 / o.srcElement;
}

//

let floorOperation = dop = Object.create( null );

dop.onAtom = function floor( o )
{
  o.dstElement = _floor( o.srcElement );
}

//

let ceilOperation = dop = Object.create( null );

dop.onAtom = function ceil( o )
{
  o.dstElement = _ceil( o.srcElement );
}

//

let roundOperation = dop = Object.create( null );

dop.onAtom = function round( o )
{
  debugger;
  o.dstElement = _round( o.srcElement );
}

//

let floorToPowerOfTwo = dop = Object.create( null );

dop.onAtom = function floor( o )
{
  o.dstElement = _.math.floorToPowerOfTwo( o.srcElement );
}

//

let ceilToPowerOfTwo = dop = Object.create( null );

dop.onAtom = function ceil( o )
{
  o.dstElement = _.math.ceilToPowerOfTwo( o.srcElement );
}

//

let roundToPowerOfTwo = dop = Object.create( null );

dop.onAtom = function round( o )
{
  o.dstElement = _.math.roundToPowerOfTwo( o.srcElement );
}

// --
// logical1
// --

let isNumber = dop = Object.create( null );

dop.onAtom = function isNumber( o )
{
  o.dstElement = _.numberIs( o.srcElement );
}

//

let isZero = dop = Object.create( null );

dop.onAtom = function isZero( o )
{
  o.dstElement = o.srcElement === 0;
}

//

let isFinite = dop = Object.create( null );

dop.onAtom = function isFinite( o )
{
  o.dstElement = _.numberIsFinite( o.srcElement );
}

//

let isInfinite = dop = Object.create( null );

dop.onAtom = function isInfinite( o )
{
  o.dstElement = _.numberIsInfinite( o.srcElement );
}

//

let isNan = dop = Object.create( null );

dop.onAtom = function isNan( o )
{
  o.dstElement = isNaN( o.srcElement );
}

//

let isInt = dop = Object.create( null );

dop.onAtom = function isInt( o )
{
  o.dstElement = _.intIs( o.srcElement );
}

//

let isString = dop = Object.create( null );

dop.onAtom = function isString( o )
{
  o.dstElement = _.strIs( o.srcElement );
}

// --
// logical2
// --

let isIdentical = dop = Object.create( null );

isIdentical.onAtom = function isIdentical( o )
{
  o.dstElement = o.dstElement === o.srcElement;
}

//

let isNotIdentical = dop = Object.create( null );

dop.onAtom = function isNotIdentical( o )
{
  o.dstElement = o.dstElement !== o.srcElement;
}

//

let isEquivalent = dop = Object.create( null );

dop.onAtom = function isEquivalent( o )
{
  o.dstElement = _.numbersAreEquivalent( o.dstElement, o.srcElement );
}

//

let isNotEquivalent = dop = Object.create( null );

dop.onAtom = function isNotEquivalent( o )
{
  o.dstElement = !_.numbersAreEquivalent( o.dstElement, o.srcElement );
}

//

let isGreater = dop = Object.create( null );

dop.onAtom = function isGreater( o )
{
  o.dstElement = o.dstElement > o.srcElement;
}

//

let isGreaterEqual = dop = Object.create( null );

dop.onAtom = function isGreaterEqual( o )
{
  o.dstElement = o.dstElement >= o.srcElement;
}

//

let isGreaterEquivalent = dop = Object.create( null );

dop.onAtom = function isGreaterEquivalent( o )
{ 
  let result = o.dstElement > o.srcElement;
  if( !result )
  result = _.numbersAreEquivalent( o.dstElement, o.srcElement );
  o.dstElement = result;
}

//

let isLess = dop = Object.create( null );

dop.onAtom = function isLess( o )
{
  o.dstElement = o.dstElement < o.srcElement;
}

//

let isLessEqual = dop = Object.create( null );

dop.onAtom = function isLessEqual( o )
{
  o.dstElement = o.dstElement <= o.srcElement;
}

//

let isLessEquivalent = dop = Object.create( null );

dop.onAtom = function isLessEquivalent( o )
{
  let result = o.dstElement < o.srcElement;
  if( !result )
  result = _.numbersAreEquivalent( o.dstElement, o.srcElement );
  o.dstElement = result;
}

// --
// atomWiseHomogeneous
// --

let add = dop = Object.create( null );

add.onAtom = function add( o )
{
  o.dstElement = o.dstElement + o.srcElement;
}

add.onAtomsBegin = function addBegin( o )
{
  o.dstElement = 0;
}

//

let sub = dop = Object.create( null );

sub.onAtom = function sub( o )
{
  o.dstElement = o.dstElement - o.srcElement;
}

sub.onAtomsBegin = function subBegin( o )
{
  o.dstElement = 0;
}

//

let mul = dop = Object.create( null );

mul.onAtom = function mul( o )
{
  o.dstElement = o.dstElement * o.srcElement;
}

mul.onAtomsBegin = function mulBegin( o )
{
  o.dstElement = 1;
}

//

let div = dop = Object.create( null );

div.onAtom = function div( o )
{
  o.dstElement = o.dstElement / o.srcElement;
}

div.onAtomsBegin = function divBegin( o )
{
  o.dstElement = 1;
}

//

let assign = dop = Object.create( null );

assign.onAtom = function assign( o )
{
  o.dstElement = o.srcElement;
}

//

let min = dop = Object.create( null );

min.onAtom = function min( o )
{
  o.dstElement = _min( o.dstElement , o.srcElement );
}

min.onAtomsBegin = function minBegin( o )
{
  o.dstElement = +Infinity;
}

//

let max = dop = Object.create( null );

max.onAtom = function max( o )
{
  o.dstElement = _max( o.dstElement , o.srcElement );
}

max.onAtomsBegin = function maxBegin( o )
{
  o.dstElement = +Infinity;
}

// --
// atomWiseHeterogeneous
// --

let addScaled = dop = Object.create( null );

dop.onAtom = function addScaled( o )
{
  _.assert( o.srcElements.length === 3 );
  o.dstElement = o.srcElements[ 0 ] + ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3, 4 ];
dop.takingVectors = [ 0, 4 ];
dop.input = [ '?vw|?n', '3*vr|3*s' ];
dop.usingDstAsSrc = true;

//

let subScaled = dop = Object.create( null );

dop.onAtom = function subScaled( o )
{
  o.dstElement = o.srcElements[ 0 ] - ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3, 4 ];
dop.takingVectors = [ 0, 4 ];
dop.input = [ '?vw|?n', '3*vr|3*s' ];
dop.usingDstAsSrc = true;

//

let mulScaled = dop = Object.create( null );

dop.onAtom = function mulScaled( o )
{
  o.dstElement = o.srcElements[ 0 ] * ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3, 4 ];
dop.takingVectors = [ 0, 4 ];
dop.input = [ '?vw|?n', '3*vr|3*s' ];
dop.usingDstAsSrc = true;

//

let divScaled = dop = Object.create( null );

dop.onAtom = function divScaled( o )
{
  o.dstElement = o.srcElements[ 0 ] / ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3, 4 ];
dop.takingVectors = [ 0, 4 ];
dop.input = [ '?vw|?n', '3*vr|3*s' ];
dop.usingDstAsSrc = true;

//

let clamp = dop = Object.create( null );

dop.onAtom = function clamp( o )
{
  o.dstElement = _min( _max( o.srcElements[ 0 ] , o.srcElements[ 1 ] ), o.srcElements[ 2 ] );
}

dop.input = [ '?vw|?n', '3*vr|3*s' ];
dop.takingArguments = [ 3, 4 ];
dop.takingVectors = [ 0, 4 ];
// dop.takingArguments = [ 3, 4 ];
dop.returningNumber = true;
dop.returningPrimitive = true;
dop.returningNew = true;
dop.usingDstAsSrc = true;
// dop.input = [ 'vw|s', 'vr|s', 'vr|s' ];

//

let mix = dop = Object.create( null );

dop.onAtom = function mix( o )
{

  // if( o.srcElements.length === 2 )
  // o.dstElement = ( o.dstElement )*( 1-o.srcElements[ 1 ] ) + o.srcElements[ 0 ]*( o.srcElements[ 1 ] );
  // else
  // o.dstElement = ( o.srcElements[ 0 ] )*( 1-o.srcElements[ 2 ] ) + ( o.srcElements[ 1 ] )*( o.srcElements[ 2 ] );

  _.assert( o.srcElements.length === 3 );

  o.dstElement = ( o.srcElements[ 0 ] )*( 1-o.srcElements[ 2 ] ) + ( o.srcElements[ 1 ] )*( o.srcElements[ 2 ] );

}

dop.input = [ '?vw|?n', '3*vr|3*s' ];
dop.takingArguments = [ 3, 4 ];
dop.takingVectors = [ 0, 4 ];
// dop.takingArguments = [ 3, 4 ];
// dop.takingVectors = [ 0, 4 ];
dop.returningNumber = true;
dop.returningPrimitive = true;
dop.returningNew = true;
dop.usingDstAsSrc = true;
// dop.input = [ 'vw|s', 'vr|s', 'vr|s' ];

// --
// atomWiseReducing
// --

let polynomApply = dop = Object.create( null );

dop.onAtom = function polynomApply( o )
{
  let x = o.args[ 1 ];
  o.result += o.element * _pow( x, o.key );
}

dop.onAtomsBegin = function( o )
{
  o.result = 0;
}

dop.onAtomsEnd = function( o )
{
}

dop.input = 'vr s';
// dop.takingArguments = [ 2, 2 ];
// dop.takingVectors = [ 1, 1 ];
dop.takingVectorsOnly = false;

//

let mean = dop = Object.create( null );

dop.onAtom = function mean( o )
{
  o.result.total += o.element;
  o.result.nelement += 1;
}

dop.onAtomsBegin = function( o )
{
  o.result = dop = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

dop.onAtomsEnd = function( o )
{
  if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  else
  o.result = 0;
}

dop.input = 'vr';
// dop.takingArguments = 1;
// dop.takingVectors = 1;

//

let moment = dop = Object.create( null );

dop.onAtom = function moment( o )
{
  o.result.total += _pow( o.element, o.args[ 1 ] );
  o.result.nelement += 1;
}

dop.onAtomsBegin = function( o )
{
  // o.result = dop = Object.create( null );
  o.result = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

dop.onAtomsEnd = function( o )
{
  if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  else
  o.result = 0;
}

dop.input = 'vr s';
// dop.takingArguments = 2;
// dop.takingVectors = 1;

//

let _momentCentral = dop = Object.create( null );

dop.onAtom = function _momentCentral( o )
{
  let degree = o.args[ 1 ];
  let mean = o.args[ 2 ];
  o.result.total += _pow( o.element - mean, degree );
  o.result.nelement += 1;
}

dop.onAtomsBegin = function( o )
{
  let degree = o.args[ 1 ];
  let mean = o.args[ 2 ];
  _.assert( _.numberIs( degree ) )
  _.assert( _.numberIs( mean ) )
  // o.result = dop = Object.create( null );
  o.result = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

dop.onAtomsEnd = function( o )
{
  if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  else
  o.result = 0;
}

dop.input = 'vr s s';
// dop.input = [ 'vr', 's', 's' ];
// dop.takingArguments = [ 3, 3 ];
// dop.takingVectors = 1;

//

let reduceToMean = dop = Object.create( null );

dop.onAtom = function reduceToMean( o )
{
  o.result.total += o.element;
  o.result.nelement += 1;
}

dop.onAtomsBegin = function( o )
{
  // o.result = dop = Object.create( null );
  o.result = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

dop.onAtomsEnd = function( o )
{
  // if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  // else
  // o.result = 0;
}

//

let reduceToProduct = dop = Object.create( null );

dop.onAtom = function reduceToProduct( o )
{
  o.result *= o.element;
}

dop.onAtomsBegin = function( o )
{
  o.result = 1;
}

//

let reduceToSum = dop = Object.create( null );

dop.onAtom = function reduceToSum( o )
{
  o.result += o.element;
}

dop.onAtomsBegin = function( o )
{
  o.result = 0;
}

//

let reduceToAbsSum = dop = Object.create( null );

dop.onAtom = function reduceToAbsSum( o )
{
  debugger;
  o.result += abs( o.element );
}

dop.onAtomsBegin = function( o )
{
  o.result = 0;
}

//

let reduceToMagSqr = dop = Object.create( null );

dop.onAtom = function reduceToMagSqr( o )
{
  o.result += _sqr( o.element );
}

dop.onAtomsBegin = function( o )
{
  o.result = 0;
}

//

let reduceToMag = dop = _.mapExtend( null, reduceToMagSqr );

dop.onAtomsEnd = function reduceToMag( o )
{
  o.result = _sqrt( o.result );
}

// --
//
// --

/* operationSinglerAdjust, */

let atomWiseSingler = //
{

  inv,
  invOrOne,

  floor : floorOperation,
  ceil : ceilOperation,
  round : roundOperation,

  floorToPowerOfTwo,
  ceilToPowerOfTwo,
  roundToPowerOfTwo,

}

/* operationsLogical1Adjust, */

let logical1 = //
{

  isNumber,
  isZero,
  isFinite,
  isInfinite,
  isNan,
  isInt,
  isString,

}

/* operationsLogical2Adjust, */

let logical2 = //
{

  isIdentical,
  isNotIdentical,
  isEquivalent,
  isNotEquivalent,
  isGreater,
  isGreaterEqual,
  isGreaterEquivalent,
  isLess,
  isLessEqual,
  isLessEquivalent
}

/* operationHomogeneousAdjust, */

let atomWiseHomogeneous = //
{

  add,
  sub,
  mul,
  div,

  assign,
  min,
  max,

}

/* operationHeterogeneousAdjust, */

let atomWiseHeterogeneous = //
{

  addScaled,
  subScaled,
  mulScaled,
  divScaled,

  clamp,
  mix,

}

/* operationReducingAdjust, */

let atomWiseReducing = //
{

  polynomApply,

  mean,
  moment,
  _momentCentral,

  reduceToMean,
  reduceToProduct,
  reduceToSum,
  reduceToAbsSum,
  reduceToMagSqr,
  reduceToMag,

}

let Routines = meta.operationRoutines =
{

  /* operationSinglerAdjust */

  atomWiseSingler,

  /* operationsLogical1Adjust, */

  logical1,

  /* operationsLogical2Adjust, */

  logical2,

  /* operationHomogeneousAdjust */

  atomWiseHomogeneous,

  /* operationHeterogeneousAdjust */

  atomWiseHeterogeneous,

  /* operationReducingAdjust */

  atomWiseReducing,

}

meta.operationSinglerAdjust();
meta.operationsLogical1Adjust();
meta.operationsLogical2Adjust();
meta.operationHomogeneousAdjust();
meta.operationHeterogeneousAdjust();
meta.operationReducingAdjust();

_.assert( _.entityIdentical( vad.operations, Routines ) );

})();
