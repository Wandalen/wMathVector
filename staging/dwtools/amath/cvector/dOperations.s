(function _fVectorOperations_s_() {

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
var _pow = Math.pow;

var _floor = Math.floor;
var _ceil = Math.ceil;
var _round = Math.round;

var EPS = _.EPS;
var EPS2 = _.EPS2;

var Parent = null;
var vector = wTools.vector;
var Self = vector.operations = vector.operations || Object.create( null );
var dop;

// --
//
// --

function operationNormalize1( operation )
{

  if( !operation.name )
  operation.name = operation.onAtom.name;

  operation.onAtom.operation = operation;

  if( _.numberIs( operation.takingArguments ) )
  operation.takingArguments = [ operation.takingArguments,operation.takingArguments ];

  if( _.numberIs( operation.takingVectors ) )
  operation.takingVectors = [ operation.takingVectors,operation.takingVectors ];

}

//

function operationNormalize2( operation )
{

  _.assert( operation.onVectorsBegin === undefined );
  _.assert( operation.onVectorsEnd === undefined );

  _.assert( _.mapIs( operation ) );
  _.assert( _.routineIs( operation.onAtom ) );
  _.assert( _.strIsNotEmpty( operation.name ) );
  _.assert( operation.onAtom.length === 1 );

  _.assert( _.boolIs( operation.usingExtraSrcs ) );
  _.assert( _.boolIs( operation.usingDstAsSrc ) );

  _.assert( operation.kind );

}

// --
// atomWiseSingler
// --

var inv = dop = Object.create( null );

dop.onAtom = function inv( o )
{
  o.dstElement = 1 / o.srcElement;
}

//

var invOrOne = dop = Object.create( null );

dop.onAtom = function invOrOne( o )
{
  if( o.srcElement === 0 )
  o.dstElement = 1;
  else
  o.dstElement = 1 / o.srcElement;
}

//

var floorOperation = dop = Object.create( null );

dop.onAtom = function floor( o )
{
  o.dstElement = _floor( o.srcElement );
}

//

var ceilOperation = dop = Object.create( null );

dop.onAtom = function ceil( o )
{
  o.dstElement = _ceil( o.srcElement );
}

//

var roundOperation = dop = Object.create( null );

dop.onAtom = function round( o )
{
  debugger;
  o.dstElement = _round( o.srcElement );
}

//

var floorOperation = dop = Object.create( null );

dop.onAtom = function floor( o )
{
  o.dstElement = _floor( o.srcElement );
}

//

var ceilOperation = dop = Object.create( null );

dop.onAtom = function ceil( o )
{
  o.dstElement = _ceil( o.srcElement );
}

//

var roundOperation = dop = Object.create( null );

dop.onAtom = function round( o )
{
  debugger;
  o.dstElement = _round( o.srcElement );
}

//

var floorToPowerOfTwo = dop = Object.create( null );

dop.onAtom = function floor( o )
{
  o.dstElement = _.floorToPowerOfTwo( o.srcElement );
}

//

var ceilToPowerOfTwo = dop = Object.create( null );

dop.onAtom = function ceil( o )
{
  o.dstElement = _.ceilToPowerOfTwo( o.srcElement );
}

//

var roundToPowerOfTwo = dop = Object.create( null );

dop.onAtom = function round( o )
{
  o.dstElement = _.roundToPowerOfTwo( o.srcElement );
}

//

function operationSinglerAdjust()
{
  var atomWiseSingler = Self.atomWiseSingler = Self.atomWiseSingler || Object.create( null );

  for( var dop in Routines.atomWiseSingler )
  {
    var operation = Routines.atomWiseSingler[ dop ];

    operationNormalize1( operation );

    operation.kind = 'singler';

    if( operation.takingArguments === undefined )
    operation.takingArguments = [ 1,1 ];
    // else if( _.numberIs( operation.takingArguments ) )
    // operation.takingArguments = [ operation.takingArguments,operation.takingArguments ];
    operation.homogeneous = true;
    operation.atomWise = true;

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !Self.atomWiseSingler[ dop ] );

    operationNormalize2( operation );

    Self.atomWiseSingler[ dop ] = operation;
  }

}

// --
// logic1
// --

var isZero = dop = Object.create( null );

dop.onAtom = function isZero( o )
{
  o.dstElement = o.srcElement === 0;
}

//

var isNumber = dop = Object.create( null );

dop.onAtom = function isNumber( o )
{
  o.dstElement = _.numberIs( o.srcElement );
}

//

var isFinite = dop = Object.create( null );

dop.onAtom = function isFinite( o )
{
  o.dstElement = _.numberIsFinite( o.srcElement );
}

//

var isInfinite = dop = Object.create( null );

dop.onAtom = function isInfinite( o )
{
  o.dstElement = _.numberIsInfinite( o.srcElement );
}

//

var isNan = dop = Object.create( null );

dop.onAtom = function isNan( o )
{
  o.dstElement = isNaN( o.srcElement );
}

//

var isInt = dop = Object.create( null );

dop.onAtom = function isInt( o )
{
  o.dstElement = _.numberIsInt( o.srcElement );
}

//

var isString = dop = Object.create( null );

dop.onAtom = function isString( o )
{
  o.dstElement = _.strIs( o.srcElement );
}

//

function operationsLogical1Adjust()
{
  var logic1 = Self.logic1 = Self.logic1 || Object.create( null );

  for( var dop in Routines.logic1 )
  {
    var operation = Routines.logic1[ dop ];

    operationNormalize1( operation );

    operation.kind = 'logical1';

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    // if( _.numberIs( operation.takingArguments ) )
    // operation.takingArguments = [ operation.takingArguments,operation.takingArguments ];
    // else if( operation.takingArguments === undefined )
    // operation.takingArguments = [ 2,2 ];

    operation.homogeneous = true;
    operation.atomWise = true;
    operation.reducing = true;
    operation.zipping = false;
    operation.interruptible = false;

    // operation.onAtom.operation = operation;
    // if( !operation.name )
    // operation.name = operation.onAtom.name;

    // _.assert( _.mapIs( operation ) );
    // _.assert( _.routineIs( operation.onAtom ) );
    // // _.assert( _.arrayIs( operation.takingArguments ) );
    // // _.assert( operation.takingArguments.length === 2 );
    // _.assert( _.strIsNotEmpty( operation.name ) );
    // _.assert( operation.onAtom.length === 1 );
    _.assert( !Self.logic1[ dop ] );

    operationNormalize2( operation );

    Self.logic1[ dop ] = operation;
  }

}

// --
// logical2
// --

var isIdentical = dop = Object.create( null );

isIdentical.onAtom = function isIdentical( o )
{
  o.dstElement = o.dstElement === o.srcElement;
}

//

var isNotIdentical = dop = Object.create( null );

dop.onAtom = function isNotIdentical( o )
{
  o.dstElement = o.dstElement !== o.srcElement;
}

//

var isEquivalent = dop = Object.create( null );

dop.onAtom = function isEquivalent( o )
{
  o.dstElement = _.numbersAreEquivalent( o.dstElement,o.srcElement );
}

//

var isNotEquivalent = dop = Object.create( null );

dop.onAtom = function isNotEquivalent( o )
{
  o.dstElement = !_.numbersAreEquivalent( o.dstElement,o.srcElement );
}

//

var isGreater = dop = Object.create( null );

dop.onAtom = function isGreater( o )
{
  o.dstElement = o.dstElement > o.srcElement;
}

//

var isGreaterEqual = dop = Object.create( null );

dop.onAtom = function isGreaterEqual( o )
{
  o.dstElement = o.dstElement >= o.srcElement;
}

//

var isLess = dop = Object.create( null );

dop.onAtom = function isLess( o )
{
  o.dstElement = o.dstElement < o.srcElement;
}

//

var isLessEqual = dop = Object.create( null );

dop.onAtom = function isLessEqual( o )
{
  o.dstElement = o.dstElement <= o.srcElement;
}

//

function operationsLogical2Adjust()
{
  var logical2 = Self.logical2 = Self.logical2 || Object.create( null );

  for( var dop in Routines.logical2 )
  {
    var operation = Routines.logical2[ dop ];

    operationNormalize1( operation );

    operation.kind = 'logical2';

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    // if( _.numberIs( operation.takingArguments ) )
    // operation.takingArguments = [ operation.takingArguments,operation.takingArguments ];
    // else if( operation.takingArguments === undefined )
    // operation.takingArguments = [ 2,2 ];

    operation.homogeneous = true;
    operation.atomWise = true;
    operation.reducing = true;
    operation.zipping = true;
    operation.interruptible = false;

    // operation.onAtom.operation = operation;

    _.assert( !Self.logical2[ dop ] );

    operationNormalize2( operation );

    Self.logical2[ dop ] = operation;
  }

}

// --
// atomWiseHomogeneous
// --

var add = dop = Object.create( null );

add.onAtom = function add( o )
{
  o.dstElement = o.dstElement + o.srcElement;
}

add.onAtomsBegin = function addBegin( o )
{
  o.dstElement = 0;
}

//

var sub = dop = Object.create( null );

sub.onAtom = function sub( o )
{
  o.dstElement = o.dstElement - o.srcElement;
}

sub.onAtomsBegin = function subBegin( o )
{
  o.dstElement = 0;
}

//

var mul = dop = Object.create( null );

mul.onAtom = function mul( o )
{
  o.dstElement = o.dstElement * o.srcElement;
}

mul.onAtomsBegin = function mulBegin( o )
{
  o.dstElement = 1;
}

//

var div = dop = Object.create( null );

div.onAtom = function div( o )
{
  o.dstElement = o.dstElement / o.srcElement;
}

div.onAtomsBegin = function divBegin( o )
{
  o.dstElement = 1;
}

//

var assign = dop = Object.create( null );

assign.onAtom = function assign( o )
{
  o.dstElement = o.srcElement;
}

//

var min = dop = Object.create( null );

min.onAtom = function min( o )
{
  o.dstElement = _min( o.dstElement , o.srcElement );
}

min.onAtomsBegin = function minBegin( o )
{
  o.dstElement = +Infinity;
}

//

var max = dop = Object.create( null );

max.onAtom = function max( o )
{
  o.dstElement = _max( o.dstElement , o.srcElement );
}

max.onAtomsBegin = function maxBegin( o )
{
  o.dstElement = +Infinity;
}

//

function operationHomogeneousAdjust()
{
  var atomWiseHomogeneous = Self.atomWiseHomogeneous = Self.atomWiseHomogeneous || Object.create( null );

  for( var dop in Routines.atomWiseHomogeneous )
  {
    var operation = Routines.atomWiseHomogeneous[ dop ];

    operationNormalize1( operation );

    operation.kind = 'homogeneous';

    if( operation.takingArguments === undefined )
    operation.takingArguments = [ 2,2 ];

    if( operation.takingVectors === undefined )
    operation.takingVectors = [ 0,operation.takingArguments[ 1 ] ];

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = true;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = true;

    operation.homogeneous = true;
    operation.atomWise = true;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !Self.atomWiseHomogeneous[ dop ] );

    operationNormalize2( operation );

    Self.atomWiseHomogeneous[ dop ] = operation;
  }
}

// --
// atomWiseHeterogeneous
// --

var addScaled = dop = Object.create( null );

dop.onAtom = function addScaled( o )
{
  _.assert( o.srcElements.length === 3 );
  o.dstElement = o.srcElements[ 0 ] + ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3,4 ];
dop.input = [ 'vw','vr|s*2' ];
dop.usingDstAsSrc = true;

//

var subScaled = dop = Object.create( null );

dop.onAtom = function subScaled( o )
{
  o.dstElement = o.srcElements[ 0 ] - ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3,4 ];
dop.input = [ 'vw','vr|s*2' ];
dop.usingDstAsSrc = true;

//

var mulScaled = dop = Object.create( null );

dop.onAtom = function mulScaled( o )
{
  o.dstElement = o.srcElements[ 0 ] * ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3,4 ];
dop.input = [ 'vw','vr|s*2' ];
dop.usingDstAsSrc = true;

//

var divScaled = dop = Object.create( null );

dop.onAtom = function divScaled( o )
{
  o.dstElement = o.srcElements[ 0 ] / ( o.srcElements[ 1 ]*o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3,4 ];
dop.input = [ 'vw','vr|s*2' ];
dop.usingDstAsSrc = true;

//

var clamp = dop = Object.create( null );

dop.onAtom = function clamp( o )
{
  o.dstElement = _min( _max( o.srcElements[ 0 ] , o.srcElements[ 1 ] ),o.srcElements[ 2 ] );
}

dop.takingArguments = [ 3,4 ];
dop.returningNumber = true;
dop.returningAtomic = true;
dop.returningNew = true;
dop.usingDstAsSrc = true;
dop.input = [ 'vw|s','vr|s*3' ];

//

var mix = dop = Object.create( null );

dop.onAtom = function mix( o )
{

  // if( o.srcElements.length === 2 )
  // o.dstElement = ( o.dstElement )*( 1-o.srcElements[ 1 ] ) + o.srcElements[ 0 ]*( o.srcElements[ 1 ] );
  // else
  // o.dstElement = ( o.srcElements[ 0 ] )*( 1-o.srcElements[ 2 ] ) + ( o.srcElements[ 1 ] )*( o.srcElements[ 2 ] );

  _.assert( o.srcElements.length === 3 );

  o.dstElement = ( o.srcElements[ 0 ] )*( 1-o.srcElements[ 2 ] ) + ( o.srcElements[ 1 ] )*( o.srcElements[ 2 ] );

}

dop.takingArguments = [ 3,4 ];
dop.takingVectors = [ 0,4 ];
dop.returningNumber = true;
dop.returningAtomic = true;
dop.returningNew = true;
dop.usingDstAsSrc = true;
dop.input = [ 'vw|s','vr|s*3' ];

//

function operationHeterogeneousAdjust()
{
  var atomWiseHeterogeneous = Self.atomWiseHeterogeneous = Self.atomWiseHeterogeneous || Object.create( null );

  for( var dop in Routines.atomWiseHeterogeneous )
  {
    var operation = Routines.atomWiseHeterogeneous[ dop ];

    operationNormalize1( operation );

    operation.kind = 'heterogeneous';

    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;
    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;

    operation.homogeneous = false;
    operation.atomWise = true;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( operation.input );
    _.assert( !Self.atomWiseHeterogeneous[ dop ] );

    operationNormalize2( operation );

    Self.atomWiseHeterogeneous[ dop ] = operation;

  }
}

// var atomWiseHeterogeneous = Self.atomWiseHeterogeneous = Self.atomWiseHeterogeneous || Object.create( null );
// operationHeterogeneousAdjust();

// --
// atomWiseReducing
// --

var polynomApply = dop = Object.create( null );

polynomApply.onAtom = function polynomApply( o )
{
  debugger;
  var x = o.args[ 1 ];
  o.result += o.element * _pow( x,o.key );
}

polynomApply.onAtomsBegin = function( o )
{
  debugger;
  o.result = 0;
}

polynomApply.onAtomsEnd = function( o )
{
  debugger;
}

polynomApply.takingArguments = [ 2,2 ];
polynomApply.takingVectors = [ 1,1 ];
polynomApply.takingVectorsOnly = false;

//

var mean = dop = Object.create( null );

mean.onAtom = function mean( o )
{
  o.result.total += o.element;
  o.result.nelement += 1;
}

mean.onAtomsBegin = function( o )
{
  o.result = dop = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

mean.onAtomsEnd = function( o )
{
  if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  else
  o.result = 0;
}

mean.input = [ 'vr' ];
mean.takingArguments = 1;
mean.takingVectors = 1;

//

var moment = dop = Object.create( null );

moment.onAtom = function moment( o )
{
  o.result.total += _pow( o.element,o.args[ 1 ] );
  o.result.nelement += 1;
}

moment.onAtomsBegin = function( o )
{
  o.result = dop = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

moment.onAtomsEnd = function( o )
{
  if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  else
  o.result = 0;
}

moment.input = [ 'vr','s' ];
moment.takingArguments = 2;
moment.takingVectors = 1;

//

var _momentCentral = dop = Object.create( null );

_momentCentral.onAtom = function _momentCentral( o )
{
  var degree = o.args[ 1 ];
  var mean = o.args[ 2 ];
  o.result.total += _pow( o.element - mean,degree );
  o.result.nelement += 1;
}

_momentCentral.onAtomsBegin = function( o )
{
  var degree = o.args[ 1 ];
  var mean = o.args[ 2 ];
  _.assert( _.numberIs( degree ) )
  _.assert( _.numberIs( mean ) )
  o.result = dop = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

_momentCentral.onAtomsEnd = function( o )
{
  if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  else
  o.result = 0;
}

_momentCentral.input = [ 'vr','s','s' ];
_momentCentral.takingArguments = [ 3,3 ];
_momentCentral.takingVectors = 1;

//

var reduceToMean = dop = Object.create( null );

reduceToMean.onAtom = function reduceToMean( o )
{
  o.result.total += o.element;
  o.result.nelement += 1;
}

reduceToMean.onAtomsBegin = function( o )
{
  o.result = dop = Object.create( null );
  o.result.total = 0;
  o.result.nelement = 0;
}

reduceToMean.onAtomsEnd = function( o )
{
  // if( o.result.nelement )
  o.result = o.result.total / o.result.nelement;
  // else
  // o.result = 0;
}

//

var reduceToProduct = dop = Object.create( null );

reduceToProduct.onAtom = function reduceToProduct( o )
{
  o.result *= o.element;
}

reduceToProduct.onAtomsBegin = function( o )
{
  o.result = 1;
}

//

var reduceToSum = dop = Object.create( null );

reduceToSum.onAtom = function reduceToSum( o )
{
  o.result += o.element;
}

reduceToSum.onAtomsBegin = function( o )
{
  o.result = 0;
}

//

var reduceToAbsSum = dop = Object.create( null );

reduceToAbsSum.onAtom = function reduceToAbsSum( o )
{
  debugger;
  o.result += abs( o.element );
}

reduceToAbsSum.onAtomsBegin = function( o )
{
  o.result = 0;
}

//

var reduceToMagSqr = dop = Object.create( null );

reduceToMagSqr.onAtom = function reduceToMagSqr( o )
{
  o.result += _sqr( o.element );
}

reduceToMagSqr.onAtomsBegin = function( o )
{
  o.result = 0;
}

//

var reduceToMag = _.mapExtend( null,reduceToMagSqr );

reduceToMag.onAtomsEnd = function reduceToMag( o )
{
  o.result = _sqrt( o.result );
}

//

function operationReducingAdjust()
{
  var atomWiseReducing = Self.atomWiseReducing = Self.atomWiseReducing || Object.create( null );

  for( var dop in Routines.atomWiseReducing )
  {
    var operation = Routines.atomWiseReducing[ dop ];

    operationNormalize1( operation );

    operation.kind = 'reducing';

    if( operation.takingArguments === undefined )
    operation.takingArguments = [ 1,Infinity ];

    operation.homogeneous = false;
    operation.atomWise = true;
    operation.reducing = true;

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !Self.atomWiseReducing[ dop ] );

    operationNormalize2( operation );

    Self.atomWiseReducing[ dop ] = operation;
  }
}

// --
//
// --

var Routines =
{

  /*
  operationNormalize1 : operationNormalize1,
  operationNormalize2 : operationNormalize2,
  */


  atomWiseSingler : //
  {

    inv : inv,
    invOrOne : invOrOne,

    floor : floorOperation,
    ceil : ceilOperation,
    round : roundOperation,

    floorToPowerOfTwo : floorToPowerOfTwo,
    ceilToPowerOfTwo : ceilToPowerOfTwo,
    roundToPowerOfTwo : roundToPowerOfTwo,

  },

  /* operationSinglerAdjust : operationSinglerAdjust, */

  logic1 : //
  {

    isNumber : isNumber,
    isZero : isZero,
    isFinite : isFinite,
    isInfinite : isInfinite,
    isNan : isNan,
    isInt : isInt,
    isString : isString,

  },

  /* operationsLogical1Adjust : operationsLogical1Adjust, */

  logical2 : //
  {

    isIdentical : isIdentical,
    isNotIdentical : isNotIdentical,
    isEquivalent : isEquivalent,
    isNotEquivalent : isNotEquivalent,
    isGreater : isGreater,
    isGreaterEqual : isGreaterEqual,
    isLess : isLess,
    isLessEqual : isLessEqual,

  },

  /* operationsLogical2Adjust : operationsLogical2Adjust, */

  atomWiseHomogeneous : //
  {

    add : add,
    sub : sub,
    mul : mul,
    div : div,

    assign : assign,
    min : min,
    max : max,

  },

  /* operationHomogeneousAdjust : operationHomogeneousAdjust, */

  atomWiseHeterogeneous : //
  {

    addScaled : addScaled,
    subScaled : subScaled,
    mulScaled : mulScaled,
    divScaled : divScaled,

    clamp : clamp,
    mix : mix,

  },

  /* operationHeterogeneousAdjust : operationHeterogeneousAdjust, */

  atomWiseReducing : //
  {

    polynomApply : polynomApply,

    mean : mean,
    moment : moment,
    _momentCentral : _momentCentral,

    reduceToMean : reduceToMean,
    reduceToProduct : reduceToProduct,
    reduceToSum : reduceToSum,
    reduceToAbsSum : reduceToAbsSum,
    reduceToMagSqr : reduceToMagSqr,
    reduceToMag : reduceToMag,

    // allFinite : allFinite,
    // anyNan : anyNan,
    // allInt : allInt,
    // allZero : allZero,

  },

  /* operationReducingAdjust : operationReducingAdjust, */

}

operationSinglerAdjust();
operationsLogical1Adjust();
operationsLogical2Adjust();
operationHomogeneousAdjust();
operationHeterogeneousAdjust();
operationReducingAdjust();

_.assert( _.entityIdentical( vector.operations,Routines ) );

})();
