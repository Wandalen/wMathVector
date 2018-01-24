(function _fVectorRoutines_s_() {

'use strict';

var _ = wTools;
var _hasLength = _.hasLength;
var _arraySlice = _.arraySlice;
var _sqr = _.sqr;
var _sqrt = _.sqrt;
var _assert = _.assert;
var _assertMapHasOnly = _.assertMapHasOnly;
var _routineIs = _.routineIs;

var _min = Math.min;
var _max = Math.max;
var _pow = Math.pow;
var sqrt = Math.sqrt;
var abs = Math.abs;

var EPS = _.EPS;
var EPS2 = _.EPS2;
var sqrt2 = sqrt( 2 );
var sqrt2Inv = 1 / sqrt2;

var vector = wTools.vector;
var operations = vector.operations;
var Parent = null;
var Self = vector;
var Routines = Object.create( null );

/*

- split _onVectorsAtomwise_functor !!!

*/

_.assert( operations );

// --
// structure
// --

var OperationDescriptor = _.like()
.also
({

  takingArguments : null,
  takingVectors : null,
  takingVectorsOnly : null,

  returningOnly : null,
  returningSelf : null,
  returningNew : null,
  returningArray : null,
  returningNumber : null,
  returningBoolean : null,
  returningAtomic : null,

  modifying : null,
  reducing : null,
  conditional : null,
  zipping : null,
  interruptible : null,
  homogeneous : null,
  atomWise : null,
  usingDstAsSrc : null,
  usingExtraSrcs : null,

  onContinue : null,
  onAtom : null,
  onAtomsBegin : null,
  onAtomsEnd : null,
  onVectorsBegin : null,
  onVectorsEnd : null,
  onVectors : null,

  name : null,
  kind : null,
  generator : null,
  postfix : null,
  atomOperation : null,
  input : null,

})
.end

//

function operationSupplement( operation,atomOperation )
{
  var operation = _.mapSupplement( operation,atomOperation );

  _.assert( arguments.length === 2 );

  /* */

  if( _.routineIs( operation.onContinue ) )
  operation.onContinue = [ operation.onContinue ];
  else if( !operation.onContinue )
  operation.onContinue = [];

  if( _.routineIs( operation.onAtom ) )
  operation.onAtom = [ operation.onAtom ];
  else if( !operation.onAtom )
  operation.onAtom = [];

  if( _.routineIs( operation.onAtomsBegin ) )
  operation.onAtomsBegin = [ operation.onAtomsBegin ];
  else if( !operation.onAtomsBegin )
  operation.onAtomsBegin = [];

  if( _.routineIs( operation.onAtomsEnd ) )
  operation.onAtomsEnd = [ operation.onAtomsEnd ];
  else if( !operation.onAtomsEnd )
  operation.onAtomsEnd = [];

  if( _.routineIs( operation.onVectorsBegin ) )
  operation.onVectorsBegin = [ operation.onVectorsBegin ];
  else if( !operation.onVectorsBegin )
  operation.onVectorsBegin = [];

  if( _.routineIs( operation.onVectorsEnd ) )
  operation.onVectorsEnd = [ operation.onVectorsEnd ];
  else if( !operation.onVectorsEnd )
  operation.onVectorsEnd = [];

  if( _.routineIs( operation.onVectors ) )
  operation.onVectors = [ operation.onVectors ];
  else if( !operation.onVectors )
  operation.onVectors = [];

  /* */

  if( operation.onContinue === atomOperation.onContinue )
  operation.onContinue = operation.onContinue.slice();

  if( operation.onAtom === atomOperation.onAtom )
  operation.onAtom = operation.onAtom.slice();

  if( operation.onAtomsBegin === atomOperation.onAtomsBegin )
  operation.onAtomsBegin = operation.onAtomsBegin.slice();

  if( operation.onAtomsEnd === atomOperation.onAtomsEnd )
  operation.onAtomsEnd = operation.onAtomsEnd.slice();

  if( operation.onVectorsBegin === atomOperation.onVectorsBegin )
  operation.onVectorsBegin = operation.onVectorsBegin.slice();

  if( operation.onVectorsEnd === atomOperation.onVectorsEnd )
  operation.onVectorsEnd = operation.onVectorsEnd.slice();

  if( operation.onVectors === atomOperation.onVectors )
  operation.onVectors = operation.onVectors.slice();

  /* */

  if( _.numberIs( operation.takingArguments ) )
  operation.takingArguments = [ operation.takingArguments,operation.takingArguments ];
  else if( operation.takingArguments && operation.takingArguments === atomOperation.takingArguments )
  operation.takingArguments = operation.takingArguments.slice();

  if( _.numberIs( operation.takingVectors ) )
  operation.takingVectors = [ operation.takingVectors,operation.takingVectors ];
  else if( operation.takingVectors && operation.takingVectors === atomOperation.takingVectors )
  operation.takingVectors = operation.takingVectors.slice();

  return operation;
}

//

function _operationLogicalReducerAdjust( operation )
{

  _.assert( arguments.length === 1 );

  var def =
  {
    usingExtraSrcs : 0,
    usingDstAsSrc : 0,
    interruptible : 1,
    reducing : 1,
    returningAtomic : 1,
    returningBoolean : 1,
    returningNumber : 0,
    returningNew : 0,
    returningSelf : 0,
    returningArray : 0,
    modifying : 0,
  }

  _.mapExtend( operation,def );

}

//

function _routineAdjust( theRoutine,routineName )
{

  if( _.objectIs( theRoutine ) )
  {
    for( var r in theRoutine )
    _routineAdjust( theRoutine[ r ],r );
    return;
  }

  _.assert( _.routineIs( theRoutine ),'routine',routineName,'is not defined' );
  _.assert( _.mapIs( theRoutine.operation ),'operation of routine',routineName,'is not defined' );

  var operation = theRoutine.operation;
  if( operation.valid )
  return;

  /* adjust */

  operation.returningAtomic = !!operation.returningAtomic;
  operation.returningArray = !!operation.returningArray;
  operation.returningNumber = !!operation.returningNumber;
  operation.returningBoolean = !!operation.returningBoolean;
  operation.returningNew = !!operation.returningNew;
  operation.returningSelf = !!operation.returningSelf;

  operation.reducing = !!operation.reducing;
  operation.atomWise = !!operation.atomWise;
  operation.homogeneous = !!operation.homogeneous;
  operation.special = !!operation.special;
  operation.modifying = !!operation.modifying;

  if( operation.usingDstAsSrc === null )
  operation.usingDstAsSrc = 1;
  if( operation.usingExtraSrcs === null )
  operation.usingExtraSrcs = 1;

  /* var */

  var takingArguments = operation.takingArguments;
  var takingVectors = operation.takingVectors;
  var takingVectorsOnly = operation.takingVectorsOnly;
  var atomWise = operation.atomWise;
  var homogeneous = operation.homogeneous;

  var modifying = operation.modifying;
  var reducing = operation.reducing;

  var differentReturns = 0;
  differentReturns += operation.returningNew ? 1 : 0;
  differentReturns += operation.returningSelf ? 1 : 0;
  differentReturns += operation.returningArray ? 1 : 0;
  differentReturns += operation.returningAtomic ? 1 : 0;

  var returningOnly = operation.returningOnly;
  if( returningOnly === null || returningOnly === undefined )
  {
    returningOnly = '';
    if( differentReturns === 1 )
    {
      returningOnly = operation.returningNew ? 'new' : returningOnly;
      returningOnly = operation.returningSelf ? 'self' : returningOnly;
      returningOnly = operation.returningArray ? 'array' : returningOnly;
      returningOnly = operation.returningAtomic ? 'atomic' : returningOnly;
    }
    operation.returningOnly = returningOnly;
  }

  /* verify */

  // _.assert( operation.name === routineName || operation.name === undefined );
  _.assert( operation.routine === theRoutine || operation.routine === undefined );
  _.assert( _.routineIs( theRoutine ) );
  _.assert( _.mapIs( operation ) );
  _.assert( _.numberIs( takingArguments ) || _.arrayIs( takingArguments ) );
  _.assert( _.numberIs( takingVectors ) || _.arrayIs( takingVectors ) );
  _.assert( _.boolIs( atomWise ) );
  _.assert( _.boolIs( homogeneous ) );
  _.assert( _.boolIs( takingVectorsOnly ) );
  _.assert( _.boolIs( modifying ) );
  _.assert( _.boolIs( reducing ) );

  // _.assert( returningNew != returningSelf || !returningNew || _.strHas( operation.input[ 0 ],'|n' ) );
  _.assert( _.boolIs( operation.returningSelf ) );
  _.assert( _.boolIs( operation.returningNew ) );
  _.assert( _.boolIs( operation.returningArray ) );
  _.assert( _.boolIs( operation.returningNumber ) );
  _.assert( _.boolIs( operation.returningBoolean ) );
  _.assert( _.boolIs( operation.returningAtomic ) );
  _.assert( _.strIs( operation.returningOnly ) );
  _.assert( operation.returningNumber ? operation.returningAtomic : true );
  _.assert( ( !!returningOnly ) == ( differentReturns == 1 ) );

  _.assert( operation.handleAtom === undefined );
  _.assert( operation.handleVector === undefined );
  _.assert( operation.handleVectors === undefined );
  _.assert( operation.handleBegin === undefined );
  _.assert( operation.handleEnd === undefined );

  // _.accessorForbid
  // ({
  //   object : operation,
  //   names :
  //   {
  //     handleAtom : 'handleAtom',
  //     handleVector : 'handleVector',
  //     handleVectors : 'handleVectors',
  //     handleBegin : 'handleBegin',
  //     handleEnd : 'handleEnd',
  //     onBegin : 'onBegin',
  //     onEnd : 'onEnd',
  //   },
  // });

  var _names = _.mapKeys( OperationDescriptor );
  _.arrayRemoveOnce( _names,'name' );
  _.accessorForbid
  ({
    object : theRoutine,
    names : _names,
  });

  /* adjust */

  operation.takingArguments = _.numbersFromNumber( takingArguments,2 );
  operation.takingVectors = _.numbersFromNumber( takingVectors,2 );
  operation.name = routineName;
  operation.routine = theRoutine;
  operation.valid = 1;

  /* validate */

  _.assert( _.routineIs( theRoutine ) );
  _.assert( _.mapIs( operation ) );
  _.assert( operation.name === routineName );
  _.assert( operation.routine === theRoutine );
  _.assert( operation.takingArguments.length === 2 );
  _.assert( operation.takingVectors.length === 2 );
  _.assert( operation.takingArguments[ 0 ] >= operation.takingVectors[ 0 ] );
  _.assert( operation.takingArguments[ 1 ] >= operation.takingVectors[ 1 ] );

  // if( operation.name === 'subScaled' )
  // debugger;

}

//

function _routinesDeclare()
{

  // declareHomogeneousTakingVectorsRoutines();
  // declareHomogeneousTakingScalarRoutines();
  //
  // routinesHomogeneousDeclare();
  // routinesHeterogeneousDeclare();
  // declareReducingRoutines();
  // // declareZippingRoutines();

}

//

function _onAtomGenBegin( dop )
{

  _.assert( arguments.length === 1 );
  _.assert( _.arrayIs( dop.input ) );
  _.assert( _.routineIs( dop.onAtom ) || _.arrayIs( dop.onAtom ) );

}

//

function _onAtomGenEnd( dop,onAtom )
{

  _.assert( arguments.length === 2 );

  onAtom.own = { onAtom : dop.onAtom };

  if( _.routineIs( dop.onAtom ) )
  dop.onAtom = [ dop.onAtom ];
  dop.onAtom.unshift( onAtom );

}

//

function _onAtomForRoutine_functor( dop )
{

  _.assert( arguments.length === 1 );
  _.assert( !dop.onAtom_functor );

  var handleAtom = null;
  var onAtom0 = dop.onAtom[ 0 ];

  _.assert( _.routineIs( onAtom0 ) );
  _.assert( dop.onAtom.length === 1 );

  _onAtomGenBegin( dop );

  if( _.arrayIdentical( dop.input , [ 'vw','vr+' ] ) || _.arrayIdentical( dop.input , [ 'vw','vr*' ] ) )
  {

    handleAtom = function handleAtom( o )
    {

      for( var a = 0 ; a < o.srcContainers.length ; a++ )
      {
        var src = o.srcContainers[ a ];
        o.srcContainer = src;
        o.srcContainerIndex = a;
        o.srcElement = src.eGet( o.key );

        var r = onAtom0.call( this,o );
        _.assert( r === undefined );
      }

      o.dstContainer.eSet( o.key,o.dstElement );

    }

    handleAtom.defaults =
    {
      key : -1,
      args : null,
      dstElement : null,
      dstContainer : null,
      srcElement : null,
      srcContainer : null,
      srcContainerIndex : -1,
      srcContainers : null,
      unwrapping : 0,
      result : null,
    }

  }
  else if( _.arrayIdentical( dop.input , [ 'vw','s' ] ) || _.arrayIdentical( dop.input , [ 'vw|s','s' ] ) )
  {

    var allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s','s|' ] );

    var handleAtom;
    if( allowingDstScalar )
    handleAtom = function handleAtom( o )
    {
      var r = onAtom0.call( this,o );
      _.assert( r === undefined );
      _.assert( _.numberIs( o.dstElement ) );
      if( !_.numberIs( o.dstContainer ) )
      o.dstContainer.eSet( o.key,o.dstElement );
    }
    else
    handleAtom = function handleAtom( o )
    {
      var r = onAtom0.call( this,o );
      _.assert( r === undefined );
      _.assert( _.numberIs( o.dstElement ) );
      o.dstContainer.eSet( o.key,o.dstElement );
    }

    handleAtom.defaults =
    {
      key : -1,
      args : null,
      dstElement : null,
      dstContainer : null,
      srcElement : null,
      result : null,
    }

  }
  else _.assert( 0,'unknown kind of input',dop.input );

  _onAtomGenEnd( dop,handleAtom );

  return handleAtom;
}

//

function _vectorizeDst( o )
{

  var dst = o.dstContainer;

  o.unwrapping = 0;

  if( dst === undefined )
  return dst;

  if( !_.atomicIs( dst ) )
  return dst;

  /* */

  for( var a = 0 ; a < o.args.length ; a++ )
  {
    var src = o.args[ a ];

    if( _.vectorIs( src ) )
    {
      if( dst === null )
      {
        o.dstContainer = vector.makeSimilar( src );
        o.dstContainer.assign( o.args[ 1 ] );
        dst = o.dstContainer;
      }
      else
      {
        o.dstContainer = vector.makeSimilar( src );
        o.dstContainer.assign( dst );
        dst = o.dstContainer;
      }
      o.args[ 0 ] = dst;
      _.assert( _.vectorIs( dst ) );
      return dst;
    }

  }

  /* */

  if( !_.vectorIs( dst ) )
  {
    if( dst === null )
    {
      dst = o.dstContainer = vector.makeArrayOfLengthWithValue( 1 , 0 );
      o.dstContainer.assign( o.args[ 1 ] );
    }
    else
    {
      dst = o.dstContainer = vector.makeArrayOfLengthWithValue( 1 , dst );
    }
    o.unwrapping = 1;
    o.args[ 0 ] = dst;
  }

  return dst;
}

//

function _vectorizeSrcs( o,first )
{

  if( _.vectorIs( o.dstContainer ) )
  for( var a = first ; a < o.args.length ; a++ )
  {
    var src = o.args[ a ];
    src = o.args[ a ] = vector.fromMaybeNumber( src,o.dstContainer.length );
  }

}

//

function _vectorsCallBegin( o,dop )
{

  var minimalCall = o.args.length === dop.takingArguments[ 0 ];
  var dstProvided = !_.atomicIs( o.dstContainer );
  var dstIsNumber = _.numberIs( o.dstContainer );

  if( Config.debug )
  {
    _.assert(  _.vectorIs( o.dstContainer ) || o.dstContainer === null || _.numberIs( o.dstContainer ) || _.boolIs( o.dstContainer ) );
    _.assert( o.dstContainer !== null || o.args.length > dop.takingArguments[ 0 ] );
    if( dop.usingExtraSrcs )
    _.assert( dop.takingArguments[ 0 ] < dop.takingArguments[ 1 ] );
    else
    _.assert( dop.takingArguments[ 1 ] - dop.takingArguments[ 0 ] <= 1 );
  }

  // debugger;

  if( !dop.reducing && !dop.usingDstAsSrc )
  if( minimalCall && dstProvided )
  {
    o.dstContainer = vector.makeSimilar( o.dstContainer );
  }

  /* */

  var dst = _vectorizeDst( o );
  _vectorizeSrcs( o,1 );

  /* */

  if( dstProvided )
  {

    if( dop.usingDstAsSrc )
    {
      if( !dop.usingExtraSrcs && !minimalCall )
      o.srcContainers = o.args.slice( 1 );
      else
      o.srcContainers = o.args.slice( 0 );
      // o.srcContainers = o.args.slice( minimalCall ? 0 : 1 );
    }
    else
    {
      if( dop.usingExtraSrcs || minimalCall )
      o.srcContainers = o.args.slice( 0 );
      else
      o.srcContainers = o.args.slice( 1 );

    }

  }
  else
  {

    if( dstIsNumber )
    {
      // o.firstSrcContainer = dst;

      if( dop.usingDstAsSrc )
      {

        if( dop.usingExtraSrcs || minimalCall )
        {
          o.srcContainers = o.args.slice( 0 );
        }
        else
        {
          o.srcContainers = o.args.slice( 1 );
        }

        // o.srcContainers = o.args.slice( minimalCall ? 0 : 1 );
        // if( minimalCall )
        // o.srcContainers[ 0 ] = dst;

      }
      else
      {
        o.srcContainers = o.args.slice( minimalCall ? 0 : 1 );
      }

    }
    else
    {
      // o.firstSrcContainer = o.args[ 1 ];
      // o.srcContainers = o.args.slice( minimalCall ? 0 : 1 );
      o.srcContainers = o.args.slice( minimalCall ? 0 : 1 );
    }

  }

  /* */

  if( Config.debug )
  {
    _.assert( _.vectorIs( dst ) || _.numberIs( dst ) );
    _.assert( dop.takingArguments[ 0 ] <= o.args.length && o.args.length <= dop.takingArguments[ 1 ],'expects ', dop.takingArguments, ' arguments' );
    for( var a = 0 ; a < o.args.length ; a++ )
    {
      var src = o.args[ a ];
      _.assert( _.vectorIs( src ) || _.numberIs( src ) );
      _.assert( _.numberIs( src ) || dst.length === src.length,'src and dst should have same length' );
    }
  }

}

//

function _vectorsCallEnd( o,dop )
{
  var result;

  // debugger;

  if( dop.reducing )
  o.result = o.dstElement;
  else if( o.unwrapping )
  o.result = o.dstContainer.eGet( 0 );
  else
  o.result = o.dstContainer;

  if( dop.onVectorsEnd.length )
  dop.onVectorsEnd[ 0 ]( o,dop );

  return o.result;
}

//

function _vectorsGenBegin( dop )
{

  if( _.routineIs( dop.onAtom ) )
  dop.onAtom = [ dop.onAtom ];

  var takingArguments = dop.takingArguments;
  var onAtom = dop.onAtom[ 0 ];

  _.assert( arguments.length === 1 );
  _.assert( takingArguments.length === 2 );
  _.assert( dop.handleAtom === undefined );
  _.assert( _.arrayIs( dop.onAtom ) );
  _.assert( _.routineIs( onAtom ) );
  _.assert( dop.onAtom.length > 1 );
  _.assert( dop.usingDstAsSrc !== undefined && dop.usingDstAsSrc !== null );
  _.assert( dop.usingExtraSrcs !== undefined && dop.usingExtraSrcs !== null );

  // _.assert( dop.onVectorsBegin.length === 0 );

}

//

function _vectorsGenEnd( dop,onVectors,onVectorsBegin )
{

  var takingArguments = dop.takingArguments;
  var onAtom = dop.onAtom[ 0 ];

  _.assert( arguments.length === 3 );
  _.assert( _.arrayIs( dop.onVectors ) && dop.onVectors.length === 0 );
  _.assert( _.routineIs( onAtom ) );
  _.assert( dop.onAtom.length > 1 );
  _.assert( _.routineIs( onVectors ) );
  _.assert( _.routineIs( onVectorsBegin ) );
  _.assert( dop.generator );

  onVectors.own = { onAtom : onAtom };
  onVectors.operation = dop;

  if( !dop.onVectors )
  dop.onVectors = [];
  dop.onVectors.unshift( onVectors );

  if( !dop.onVectorsBegin )
  dop.onVectorsBegin = [];
  dop.onVectorsBegin.unshift( onVectorsBegin );

}

//

function _onVectorsForRoutine_functor( dop )
{

  _vectorsGenBegin( dop );

  var takingArguments = dop.takingArguments;
  var onVectors = null;
  var onVectorsBegin = null;
  var onVectorsBegin0 = dop.onVectorsBegin[ 0 ];
  var onAtom0 = dop.onAtom[ 0 ];

  _.assert( arguments.length === 1 );

  /* */

  if( _.arrayIdentical( dop.input , [ 'vw','vr+' ] ) || _.arrayIdentical( dop.input , [ 'vw','vr*' ] ) ) //
  {

    onVectorsBegin = function onVectorsBegin( dst,src )
    {

      var dst = arguments[ 0 ];

      var o = Object.create( null );
      o.key = -1;
      o.args = arguments;
      o.result = null;
      o.dstElement = null;
      o.dstContainer = dst;
      o.srcElement = null;
      o.srcContainer = dst;
      o.srcContainerIndex = -1;
      o.srcContainers = _.arraySlice( arguments,1,arguments.length );
      Object.preventExtensions( o );

      if( onVectorsBegin0 )
      onVectorsBegin0( o );

      return o;
    }

    onVectors = function onVectors()
    {

      var dst = arguments[ 0 ];

      var o = onVectorsBegin.apply( this,arguments );

      /* */

      if( Config.debug )
      {
        _.assert( _.vectorIs( dst ) );
        _.assert( arguments.length >= 1,'expects at least one argument' );
        _.assert( takingArguments[ 0 ] <= arguments.length && arguments.length <= takingArguments[ 1 ],'expects ', takingArguments, ' arguments' );
        for( var a = 0 ; a < o.srcContainers.length ; a++ )
        {
          var src = o.srcContainers[ a ];
          _.assert( _.vectorIs( src ) );
          _.assert( dst.length === src.length,'src and dst should have same length' );
        }
      }

      /* */

      for( var k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        o.dstElement = dst.eGet( k );
        onAtom0.call( this,o );
      }

      return dst;
    }

    onVectors.own = { onAtom : onAtom0 };
    onVectors.operation = dop;
    dop.takingArguments = takingArguments;
    dop.takingVectors = takingArguments;
    dop.takingVectorsOnly = true;
    dop.homogeneous = true;
    dop.atomWise = true;
    dop.returningSelf = true;
    dop.returningNew = false;
    dop.returningArray = false;
    dop.modifying = true;
    dop.operation = dop;

    _.assert( takingArguments[ 0 ] > 0 && takingArguments[ 1 ] === Infinity );

  }
  else if( _.arrayIdentical( dop.input , [ 'vw','s' ] ) || _.arrayIdentical( dop.input , [ 'vw|s','s' ] ) ) //
  {

    var allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s','s|' ] );

    onVectorsBegin = function onVectorsBegin( dst,src )
    {

      var o = Object.create( null );
      o.key = -1;
      o.args = arguments;
      o.dstContainer = dst;
      o.srcElement = src;
      o.dstElement = null;
      o.result = null;
      Object.preventExtensions( o );

      if( onVectorsBegin0 )
      onVectorsBegin0( o );

      return o;
    }

    onVectors = function onVectors( dst,src )
    {

      if( Config.debug )
      {
        _.assert( arguments.length === 2,'expects 2 arguments' );
        if( allowingDstScalar )
        _.assert( _.vectorIs( dst ) || _.numberIs( dst ) );
        else
        _.assert( _.vectorIs( dst ) );
        _.assert( _.numberIs( src ) );
      }

      /* */

      var o = onVectorsBegin.apply( this,arguments );

      if( allowingDstScalar && _.numberIs( dst ) )
      {
        o.key = 0;
        o.dstElement = dst;
        onAtom0.call( this,o );
        dst = o.dstElement;
      }
      else
      for( var k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        o.dstElement = dst.eGet( k );
        onAtom0.call( this,o );
      }

      return dst;
    }

    onVectors.own = { onAtom : onAtom0 };
    onVectors.operation = dop;
    dop.takingArguments = [ 2,2 ];
    if( !dop.takingVectors )
    dop.takingVectors = [ 1,1 ];
    else
    dop.takingVectors[ 1 ] = 1;
    dop.takingVectorsOnly = false;
    dop.homogeneous = true;
    dop.atomWise = true;
    dop.returningSelf = true;
    dop.returningNew = false;
    dop.returningArray = false;
    dop.returningNumber = true;
    dop.returningAtomic = true;
    dop.modifying = true;
    dop.operation = dop;

    _.assert( takingArguments[ 0 ] === 2 && takingArguments[ 1 ] === 2 );

  }
  else _.assert( 0,'unknown kind of input',dop.input );

  /* */

  _vectorsGenEnd( dop,onVectors,onVectorsBegin );

  return onVectors;
}

//

/*
  addScalar
  input : [ 'vw','s' ],

  addVectorScaled
  input : [ 'vw','vr|s*2' ],

  addVectors
  input : [ 'vw','vr+' ],

  clamp
  input : [ 'vw','vr|s*3' ],

  mix
  input : [ 'vw','vr|s*3' ],
*/

function _routineForOperation_functor( dop )
{

  if( _.routineIs( dop ) )
  debugger;

  if( _.routineIs( dop ) )
  dop = _.mapExtend( null,{ onAtom : dop } );
  else
  dop = _.mapExtend( null,dop );

  var onAtom = dop.onAtom[ 0 ];
  if( dop.takingArguments === undefined )
  dop.takingArguments = onAtom.takingArguments;

  dop.generator = _routineForOperation_functor;

  /* */

  _.assertMapHasOnly( dop,_routineForOperation_functor.defaults );
  _.assert( dop.atomOperation );
  _.assert( _.routineIs( onAtom ) );
  _.assert( dop.onAtom.length === 1 );

  _.assert( _.arrayIs( dop.takingArguments ) );
  _.assert( arguments.length === 1 );

  _.assert( dop.input );
  _.assert( _.strIsNotEmpty( dop.name ) );
  _.assert( _.arrayIs( dop.input ) || _.arrayIs( dop.input ) );
  _.assert( _.boolIs( dop.homogeneous ) || _.boolIs( dop.homogeneous ) );

  _.assert( dop.handleAtom === undefined );
  _.assert( dop.handleVector === undefined );
  _.assert( dop.handleVectors === undefined );
  _.assert( dop.handleBegin === undefined );
  _.assert( dop.handleEnd === undefined );

  /* */

  if( dop.homogeneous === null )
  dop.homogeneous = onAtom.homogeneous;

  if( dop.input === null )
  dop.input = onAtom.input;
  dop.inputWithoutLast = dop.input.slice( 0,dop.input.length-1 );
  dop.inputLast = dop.input[ dop.input.length-1 ];

  /* */

  if( dop.onAtom_functor )
  {
    dop.onAtom_functor( dop );
    delete dop.onAtom_functor;
  }
  else
  {
    _onAtomForRoutine_functor( dop );
  }

  if( dop.onVectors_functor )
  {
    dop.onVectors_functor( dop );
    delete dop.onVectors_functor;
  }
  else
  {
    _onVectorsForRoutine_functor( dop );
  }

  /* */

  _.assert( _.arrayIs( dop.takingArguments ) );
  _.assert( _.routineIs( dop.onVectors[ 0 ] ) );

  _.assert( dop.handleAtom === undefined );
  _.assert( dop.handleVector === undefined );
  _.assert( dop.handleVectors === undefined );
  _.assert( dop.handleBegin === undefined );
  _.assert( dop.handleEnd === undefined );

  return dop.onVectors[ 0 ];
}

_routineForOperation_functor.defaults =
{
  onAtom_functor : null,
  onVectors_functor : null,
}

_routineForOperation_functor.defaults.__proto__ = OperationDescriptor;

// --
// basic
// --

function assign( dst )
{
  var length = dst.length;
  var alength = arguments.length;

  if( alength === 2 )
  {
    if( _.numberIs( arguments[ 1 ] ) )
    this.assignScalar( dst,arguments[ 1 ] );
    else if( _hasLength( arguments[ 1 ] ) )
    this.assignVector( dst,_.vector.fromArray( arguments[ 1 ] ) );
    else _.assert( 0,'unknown arguments' );
  }
  else if( alength === 1 + length )
  {
    this.assign.call( this,dst,_.vector.fromArray( _arraySlice( arguments,1,alength ) ) );
  }
  else _.assert( 0,'assign :','unknown arguments' );

  return dst;
}

var dop = assign.operation = Object.create( null );
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1,Infinity ];
dop.takingVectors = [ 1,2 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function assignVector( dst,src )
{
  var length = dst.length;

  _assert( dst && src,'vector :','expects ( src ) and ( dst )' );
  _assert( dst.length === src.length,'vector :','src and dst should have same length' );
  _assert( _.vectorIs( dst ) );
  _assert( _.vectorIs( src ) );

  for( var s = 0 ; s < length ; s++ )
  {
    dst.eSet( s,src.eGet( s ) );
  }

  return dst;
}

var dop = assignVector.operation = Object.create( null );
dop.atomWise = true;
dop.homogeneous = true;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;
dop.special = true;

//

function clone( src )
{
  var length = src.length;
  var dst = this.makeSimilar( src );

  _.assert( arguments.length === 1 )

  for( var s = 0 ; s < length ; s++ )
  dst.eSet( s,src.eGet( s ) );

  return dst;
}

var dop = clone.operation = Object.create( null );
dop.atomWise = true;
dop.homogeneous = true;
dop.takingArguments = 1;
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = true;
dop.modifying = false;
dop.special = true;

//

function makeSimilar( src,length )
{
  if( length === undefined )
  length = src.length;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( length ) );

  var dst = _.vector.fromArray( new src._vectorBuffer.constructor( length ) );

  return dst;
}

var dop = makeSimilar.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,2 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = true;
dop.modifying = false;
dop.special = true;

//

/*
  if( _.numberIs( array ) && f === undefined && l === undefined )
  return array;

  var result;
  var f = f !== undefined ? f : 0;
  var l = l !== undefined ? l : array.length;

  _.assert( _.arrayLike( array ) );
  _.assert( _.numberIs( f ) );
  _.assert( _.numberIs( l ) );
  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( f < 0 )
  f = 0;
  if( l > array.length )
  l = array.length;
  if( l < f )
  l = f;

  if( _.bufferTypedIs( array ) )
  result = new array.constructor( l-f );
  else
  result = new Array( l-f );

  for( var r = f ; r < l ; r++ )
  result[ r-f ] = array[ r ];

  return result;
*/

function slice( src,first,last )
{
  var result = this.slicedArray.apply( this,arguments );
  return result;
}

var dop = slice.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningArray = true;
dop.modifying = false;

//

function slicedArray( src,first,last )
{
  var length = src.length;
  var f = f !== undefined ? first : 0;
  var l = l !== undefined ? last : src.length;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );
  _.assert( src._vectorBuffer,'expects vector as argument' );

  var result;
  if( src.stride !== 1 || src.offset !== 0 || src._vectorBuffer.length !== l || f !== 0 )
  {
    result = new src._vectorBuffer.constructor( l-f );
    for( var i = f ; i < l ; i++ )
    result[ i-f ] = src.eGet( i );
  }
  else
  {
    debugger;
    return result = src._vectorBuffer.slice( f,l );
  }

  return result;
}

var dop = slicedArray.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningArray = true;
dop.modifying = false;

//

function slicedVector( src,first,last )
{
  var result = this.slicedArray.apply( this,arguments );
  return this.fromArray( result );
}

var dop = slicedVector.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningArray = true;
dop.modifying = false;

//

function resizedArray( src,first,last,val )
{
  var length = src.length;
  var f = f !== undefined ? first : 0;
  var l = l !== undefined ? last : src.length;

  if( l < f )
  l = f;

  var lsrc = Math.min( src.length,l );

  _.assert( 1 <= arguments.length && arguments.length <= 4 );
  _.assert( src._vectorBuffer,'expects vector as argument' );

  var result;
  if( src.stride !== 1 || src.offset !== 0 || src._vectorBuffer.length !== l || f !== 0 )
  {
    debugger;
    result = new src._vectorBuffer.constructor( l-f );
    for( var r = Math.max( f,0 ) ; r < lsrc ; r++ )
    result[ r-f ] = src.eGet( r );
  }
  else
  {
    debugger;
    result = src._vectorBuffer.slice();
  }

  /* */

  if( val !== undefined )
  if( f < 0 || l > array.length )
  {
    for( var r = 0 ; r < -f ; r++ )
    {
      result[ r ] = val;
    }
    var r = Math.max( lsrc-f, 0 );
    for( ; r < result.length ; r++ )
    {
      result[ r ] = val;
    }
  }

  return result;
}

var dop = resizedArray.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,4 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningArray = true;
dop.modifying = false;

//

function resizedVector( src,first,last,val )
{
  var result = this.resizedArray.apply( this,arguments );
  return this.fromArray( result );
}

var dop = resizedVector.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,4 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningArray = true;
dop.modifying = false;

//

function subarray( src,first,last )
{
  var result;
  var length = src.length;
  var first = first || 0;
  var last = _.numberIs( last ) ? last : length;

  if( last > length )
  last = length;
  if( first < 0 )
  first = 0;
  if( first > last )
  first = last;

  _assert( arguments.length === 2 || arguments.length === 3 );
  _assert( src._vectorBuffer,'expects vector as argument' );
  _assert( src.offset >= 0 );

  if( src.stride !== 1 )
  {
    result = _.vector.fromSubArrayWithStride( src._vectorBuffer , src.offset + first*src.stride , last-first , src.stride );
  }
  else
  {
    result = _.vector.fromSubArray( src._vectorBuffer , src.offset + first , last-first );
  }

  return result;
}

var dop = subarray.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = true;
dop.modifying = false;

//

function toArray( src )
{
  var result;
  var length = src.length;

  _assert( _.vectorIs( src ) || _.arrayLike( src ), 'expects vector as a single argument' );
  _assert( arguments.length === 1 );

  if( _.arrayLike( src ) )
  return src;

  if( src.stride !== 1 || src.offset !== 0 || src.length !== src._vectorBuffer.length )
  {
    result = _.arrayMakeSimilar( src._vectorBuffer,src.length );
    for( var i = 0 ; i < src.length ; i++ )
    result[ i ] = src.eGet( i );
  }
  else
  {
    result = src._vectorBuffer;
  }

  return result;
}

var dop = toArray.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 1;
dop.takingVectors = [ 0,1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningArray = true;
dop.modifying = false;

//

function _toStr( src,o )
{
  var result = '';
  var length = src.length;

  if( !o ) o = Object.create( null );
  if( o.percision === undefined ) o.percision = 4;

  if( length )
  if( o.percision === 0 )
  {
    throw _.err( 'not tested' );
    for( var i = 0,l = length-1 ; i < l ; i++ )
    {
      result += String( src.eGet( i ) ) + ' ';
    }
    result += String( src.eGet( i ) );
  }
  else
  {
    for( var i = 0,l = length-1 ; i < l ; i++ )
    {
      result += src.eGet( i ).toPrecision( o.percision ) + ' ';
    }
    result += src.eGet( i ).toPrecision( o.percision );
  }

  return result;
}

var dop = _toStr.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,2 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function gather( dst,srcs )
{

  var atomsPerElement = srcs.length;
  var l = dst.length / srcs.length;

  _.assert( arguments.length === 2 );
  _.assert( _.vectorIs( dst ) );
  _.assert( _.arrayIs( srcs ) );
  _.assert( _.numberIsInt( l ) );

  debugger;

  /* */

  for( var s = 0 ; s < srcs.length ; s++ )
  {
    var src = srcs[ s ];
    _.assert( _.numberIs( src ) || _.vectorIs( src ) || _.arrayLike( src ) );
    if( _.numberIs( src ) )
    continue;
    if( _.arrayLike( src ) )
    src = srcs[ s ] = _.vector.fromArray( src );
    _.assert( src.length === l );
  }

  /* */

  for( var e = 0 ; e < l ; e++ )
  {
    for( var s = 0 ; s < srcs.length ; s++ )
    {
      var v = _.numberIs( srcs[ s ] ) ? srcs[ s ] : srcs[ s ].eGet( e );
      dst.eSet( e*atomsPerElement + s , v );
    }
  }

  return dst;
}

var dop = gather.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

// --
// not atom-wise : self
// --

function sort( dst,comparator )
{
  var length = dst.length;

  if( !comparator ) comparator = function( a,b ){ return a-b };

  function _sort( left,right )
  {

    if( left >= right ) return;

    //console.log( '_sort :',left,right );

    var m = Math.floor( ( left+right ) / 2 );
    var mValue = dst.eGet( m );
    var l = left;
    var r = right;

    do
    {

      while( comparator( dst.eGet( l ),mValue ) < 0 )
      l += 1;

      while( comparator( dst.eGet( r ),mValue ) > 0 )
      r -= 1;

      if( l <= r )
      {
        var v = dst.eGet( l );
        dst.eSet( l,dst.eGet( r ) );
        dst.eSet( r,v );
        r -= 1;
        l += 1;
      }

    }
    while( l <= r );

    _sort( left,r );
    _sort( l,right );

  }

  _sort( 0,length-1 );

  return dst;
}

var dop = sort.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1,2 ];
dop.takingVectors = [ 1,1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function randomInRadius( dst,radius )
{
  var length = dst.length;
  var o = Object.create( null );

  if( _.objectIs( radius ) )
  {
    o = radius;
    radius = o.radius;
  }

  if( o.attempts === undefined )
  o.attempts = 32;

  _assert( _.numberIs( radius ) );

  var radiusSqrt = sqrt( radius );
  var radiusSqr = _sqr( radius );
  var attempts = o.attempts;
  for( var a = 0 ; a < attempts ; a++ )
  {

    this.randomInRangeAssigning( dst,-radiusSqrt,+radiusSqrt );
    var m = this.magSqr( dst );
    if( m < radiusSqr ) break;

  }

  return dst;
}

var dop = randomInRadius.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 2,2 ];
dop.takingVectors = [ 1,1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function crossWithPoints( a, b, c, result )
{
  throw _.err( 'not tested' );

  _assert( a.length === 3 && b.length === 3 && c.length === 3,'implemented only for 3D' );

  debugger;
  var result = result || this.array.makeArrayOfLength( 3 );

  var ax = a.eGet( 0 )-c.eGet( 0 ), ay = a.eGet( 1 )-c.eGet( 1 ), az = a.eGet( 2 )-c.eGet( 2 );
  var bx = b.eGet( 0 )-c.eGet( 0 ), by = b.eGet( 1 )-c.eGet( 1 ), bz = b.eGet( 2 )-c.eGet( 2 );

  result.eSet( 0, ay * bz - az * by );
  result.eSet( 1, az * bx - ax * bz );
  result.eSet( 2, ax * by - ay * bx );

  return result;
}

var dop = crossWithPoints.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 3,4 ];
dop.takingVectors = [ 3,4 ];
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function _cross3( dst, src1, src2 )
{

  var src1x = src1.eGet( 0 );
  var src1y = src1.eGet( 1 );
  var src1z = src1.eGet( 2 );

  var src2x = src2.eGet( 0 );
  var src2y = src2.eGet( 1 );
  var src2z = src2.eGet( 2 );

  dst.eSet( 0, src1y * src2z - src1z * src2y );
  dst.eSet( 1, src1z * src2x - src1x * src2z );
  dst.eSet( 2, src1x * src2y - src1y * src2x );

  return dst;
}

var dop = _cross3.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 3;
dop.takingVectors = 3;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function cross3( dst, src1, src2 )
{

  _.assert( arguments.length === 3 );
  _.assert( dst.length === 3,'implemented only for 3D' );
  _.assert( src1.length === 3,'implemented only for 3D' );
  _.assert( src2.length === 3,'implemented only for 3D' );

  dst = _.vector.from( dst );
  src1 = _.vector.from( src1 );
  src2 = _.vector.from( src2 );

  return this._cross3( dst, src1, src2 );
}

var dop = cross3.operation = _.mapExtend( null,_cross3.operation );

//

function cross( dst )
{

  var firstSrc = 1;
  if( dst === null )
  {
    dst = _.vector.from( arguments[ 1 ].slice() );
    firstSrc = 2;
    _.assert( arguments.length >= 3 );
  }

  _.assert( arguments.length >= 2 );
  _.assert( dst.length === 3,'implemented only for 3D' );

  for( var a = firstSrc ; a < arguments.length ; a++ )
  {
    var src = arguments[ a ];
    _.assert( src.length === 3,'implemented only for 3D' );
    this._cross3( dst, dst, src );
  }

  return dst;
}

var dop = cross.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 2,Infinity ];
dop.takingVectors = [ 2,Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = true;
dop.modifying = true;

//

function quaternionApply( dst,q )
{

  _assert( dst.length === 3 && q.length === 4,'quaternionApply :','expects vector and quaternion as arguments' );

  var x = dst.eGet( 0 );
  var y = dst.eGet( 1 );
  var z = dst.eGet( 2 );

  var qx = q.eGet( 0 );
  var qy = q.eGet( 1 );
  var qz = q.eGet( 2 );
  var qw = q.eGet( 3 );

  //

  var ix = + qw * x + qy * z - qz * y;
  var iy = + qw * y + qz * x - qx * z;
  var iz = + qw * z + qx * y - qy * x;
  var iw = - qx * x - qy * y - qz * z;

  //

  dst.eSet( 0, ix * qw + iw * - qx + iy * - qz - iz * - qy );
  dst.eSet( 1, iy * qw + iw * - qy + iz * - qx - ix * - qz );
  dst.eSet( 2, iz * qw + iw * - qz + ix * - qy - iy * - qx );

  //
/*
  clone.quaternionApply2( q );
  var err = clone.distanceSqr( this );
  if( abs( err ) > 0.0001 )
  throw _.err( 'Vector :','Something wrong' );
*/
  //

  return dst;
}

var dop = quaternionApply.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

/*
v' = q * v * conjugate(q)
--
t = 2 * cross(q.xyz, v)
v' = v + q.w * t + cross(q.xyz, t)
*/

function quaternionApply2( dst,q )
{

  _assert( dst.length === 3 && q.length === 4,'quaternionApply :','expects vector and quaternion as arguments' );
  throw _.err( 'not tested' );
  var qvector = this.fromSubArray( dst,0,3 );

  var cross1 = this.cross( qvector,dst );
  this.mulScalar( cross1,2 );

  var cross2 = this.cross( qvector,cross1 );
  this.mulScalar( cross1,q.eGet( 3 ) );

  dst.eSet( 0, dst.eSet( 0 ) + cross1.eGet( 0 ) + cross2.eGet( 0 ) );
  dst.eSet( 1, dst.eGet( 1 ) + cross1.eGet( 1 ) + cross2.eGet( 1 ) );
  dst.eSet( 2, dst.eGet( 2 ) + cross1.eGet( 2 ) + cross2.eGet( 2 ) );

  return dst;
}

var dop = quaternionApply2.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function eulerApply( v,e )
{

  _.assert( arguments.length === 2 );

  throw _.err( 'not implemented' )

}

var dop = eulerApply.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function reflect( v,normal )
{

  _.assert( arguments.length === 2 );
  _.assert( _.vectorIs( v ) );
  _.assert( _.vectorIs( normal ) );

  debugger;
  throw _.err( 'not tested' );

  var result = this.mulScalar( normal.clone() , 2*this.dot( v,normal ) );

  return result;
}

var dop = reflect.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function matrixApplyTo( dst,srcMatrix )
{
  _.assert( arguments.length === 2 );
  _.assert( _.spaceIs( srcMatrix ) );
  debugger;
  return _.space.mul( dst,[ srcMatrix,dst ] );
}

var dop = matrixApplyTo.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.takindistanceSqrgVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function matrixHomogenousApply( dst,srcMatrix )
{
  _.assert( arguments.length === 2 );
  _.assert( _.spaceIs( srcMatrix ) );
  return srcMatrix.matrixHomogenousApply( dst );
}

var dop = matrixHomogenousApply.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function matrixDirectionsApply( v,m )
{
  _.assrt( arguments.length === 2 );
  m.matrixDirectionsApply( v );
  return v;
}

var dop = matrixDirectionsApply.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function swapVectors( v1,v2 )
{

  _assert( arguments.length === 2 );
  _assert( v1.length === v2.length );

  for( var i = 0 ; i < v1.length ; i++ )
  {
    var val = v1.eGet( i );
    v1.eSet( i,v2.eGet( i ) );
    v2.eSet( i,val );
  }

}

var dop = swapVectors.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = true;

//

function swapAtoms( v,i1,i2 )
{

  _assert( arguments.length === 3 );
  _assert( 0 <= i1 && i1 < v.length );
  _assert( 0 <= i2 && i2 < v.length );
  _assert( _.numberIs( i1 ) );
  _assert( _.numberIs( i2 ) );

  var val = v.eGet( i1 );
  v.eSet( i1,v.eGet( i2 ) );
  v.eSet( i2,val );

  return v;
}

var dop = swapAtoms.operation = Object.create( null );
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 3;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function formate( dst,srcs )
{
  var ape = srcs.length;
  var l = dst.length / ape;

  _.assert( _.arrayIs( srcs ) );
  _.assert( _.numberIsInt( l ) );

  // debugger;

  for( var a = 0 ; a < ape ; a++ )
  {
    var src = srcs[ a ];

    if( _.numberIs( src ) )
    {
      for( var i = 0 ; i < l ; i++ )
      dst.eSet( i*ape+a , src );
    }
    else
    {
      src = _.vector.from( src );
      _.assert( src.length === l );
      for( var i = 0 ; i < l ; i++ )
      dst.eSet( i*ape+a , src.eGet( i ) );
    }
  }

  // debugger;
  return dst;
}

var dop = formate.operation = Object.create( null );
dop.takingArguments = [ 1,2 ];
dop.takingVectors = [ 1,1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;
dop.reducing = false;
dop.homogeneous = false;

// --
// atom-wise, modifying, taking single vector : self
// --

function _operationTakingDstSrcReturningSelfComponentWise_functor( o )
{

  var onEach = o.onEach;
  var onVectorsBegin0 = o.onVectorsBegin || function(){};
  var onVectorsEnd0 = o.onVectorsEnd || function(){};

  _assert( _.objectIs( o ) );
  _assert( _.routineIs( onEach ) );
  _assert( _.routineIs( onVectorsBegin0 ) );
  _assert( _.routineIs( onVectorsEnd0 ) );
  _assert( arguments.length === 1 );

  var routine = function _operationTakingDstSrcReturningSelfComponentWise( dst,src )
  {

    var length = dst.length;
    if( !src )
    src = dst;

    _assert( arguments.length <= 2 );
    _assert( dst.length === src.length,'src and dst must have same length' );

    onVectorsBegin0.call( this,dst,src );

    for( var i = 0 ; i < length ; i++ )
    onEach.call( this,dst,src,i );

    onVectorsEnd0.call( this,dst,src );

    return dst;
  }

  var dop = routine.operation = Object.create( null );
  dop.atomWise = true;
  dop.homogeneous = true;
  dop.takingArguments = [ 1,2 ];
  dop.takingVectors = [ 1,2 ];
  dop.takingVectorsOnly = true;
  dop.returningSelf = true;
  dop.returningNew = false;
  dop.returningArray = false;
  dop.modifying = true;

  return routine;
}

//

var inv = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _inv( dst,src,i )
  {
    dst.eSet( i, 1 / src.eGet( i ) );
  }
});

//

var invOrOne = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _invOrOne( dst,src,i )
  {
    if( src.eGet( i ) === 0 )
    dst.eSet( i,1 );
    else
    dst.eSet( i,1 / src.eGet( i ) );
  }
});

//

var absRoutine = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _abs( dst,src,i )
  {
    dst.eSet( i, Math.abs( src.eGet( i ) ) );
  }
});

//

var floorRoutine = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _floor( dst,src,i )
  {
    dst.eSet( i, Math.floor( src.eGet( i ) ) );
  }
});

//

var ceilRoutine = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _ceil( dst,src,i )
  {
    dst.eSet( i, Math.ceil( src.eGet( i ) ) );
  }
});

//

var roundRoutine = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _round( dst,src,i )
  {
    debugger;
    dst.eSet( i, Math.round( src.eGet( i ) ) );
  }
});

//

var ceilToPowerOfTwo = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _ceil( dst,src,i )
  {
    dst.eSet( i, _.ceilToPowerOfTwo( src.eGet( i ) ) );
  }
});

//

var _normalizeM;
var normalize = _operationTakingDstSrcReturningSelfComponentWise_functor
({
  onVectorsBegin : function normalize( dst,src )
  {
    _normalizeM = this.mag( src );
    if( !_normalizeM )
    _normalizeM = 1;
    _normalizeM = 1 / _normalizeM;
  },
  onEach : function normalize( dst,src,i )
  {
    dst.eSet( i,src.eGet( i ) * _normalizeM );
  },
});

// --
// float / vector
// --

function _operationReturningSelfTakingVariantsComponentWise_functor( operation )
{
  var result = Object.create( null );

  _.assert( operation.assigning === undefined );

  var operationForFunctor = _.mapExtend( null,operation );
  operationForFunctor.assigning = 1;
  result.assigning = _operationReturningSelfTakingVariantsComponentWiseAct_functor( operationForFunctor );

  var operationForFunctor = _.mapExtend( null,operation );
  operationForFunctor.assigning = 0;
  result.copying = _operationReturningSelfTakingVariantsComponentWiseAct_functor( operationForFunctor );

  return result;
}

_operationReturningSelfTakingVariantsComponentWise_functor.defaults =
{
  takingArguments : null,
  homogenous : 0,
  onEach : null,
  onVectorsBegin : function(){},
  onVectorsEnd : function(){},
  onMakeIdentity : function(){},
}

//

function _operationReturningSelfTakingVariantsComponentWiseAct_functor( operation )
{

  _assert( arguments.length === 1 );
  _.routineOptions( _operationReturningSelfTakingVariantsComponentWiseAct_functor,operation );
  _assert( _.objectIs( operation ) );
  _assert( _.routineIs( operation.onEach ) );
  _assert( _.routineIs( operation.onVectorsBegin ) );
  _assert( _.routineIs( operation.onVectorsEnd ) );
  _assert( _.arrayIs( operation.takingArguments ) );

  var onVectorsBegin = operation.onVectorsBegin;
  var onEach = operation.onEach;
  var onVectorsEnd = operation.onVectorsEnd;
  var onMakeIdentity = operation.onMakeIdentity;
  var takingArguments = operation.takingArguments;
  var homogenous = operation.homogenous;

  /* */

  var routine = function _operationReturningSelfTakingVariantsComponentWise( dst )
  {

    if( operation.assigning )
    _.assert( _.vectorIs( dst ) );

    var args = _.vector.variants( arguments );

    if( !operation.assigning )
    {
      dst = _.vector.fromArray( this.makeArrayOfLengthZeroed( args[ 0 ].length ) );
      args.unshift( dst );
      onMakeIdentity.call( args,dst );
    }

    var length = dst.length;
    _.assert( takingArguments[ 0 ] <= args.length && args.length <= takingArguments[ 1 ],args.length,operation.assigning );
    _.assert( _.vectorIs( dst ) );

    onVectorsBegin.apply( args,args,length );

    if( homogenous )
    {

      for( var i = 0 ; i < length ; i++ )
      {
        for( var a = 1 ; a < args.length ; a++ )
        {
          onEach.call( args,dst,args[ a ],i );
        }
      }

    }
    else
    {
      args.push( 0 );

      for( var i = 0 ; i < length ; i++ )
      {
        args[ args.length-1 ] = i;
        onEach.apply( args,args );
      }

    }

    onVectorsEnd.apply( args,args,length );

    return dst;
  }

  var dop = routine.operation = Object.create( null );
  dop.takingArguments = takingArguments;
  dop.takingVectors = [ 1,takingArguments[ 1 ] ];
  dop.takingVectorsOnly = false;
  dop.returningSelf = false;
  dop.returningNew = true;
  dop.modifying = true;

  return routine;
}

_operationReturningSelfTakingVariantsComponentWiseAct_functor.defaults =
{
  assigning : 0,
}

_operationReturningSelfTakingVariantsComponentWiseAct_functor.defaults.__proto__ = _operationReturningSelfTakingVariantsComponentWise_functor.defaults;

//

var add = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 2,Infinity ],
  homogenous : 1,
  onEach : function add( dst,src,i )
  {
    var d = dst.eGet( i );
    var s = src.eGet( i );

    var r = d + s;

    dst.eSet( i,r );
  }
});

//

var sub = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 2,Infinity ],
  homogenous : 1,
  onEach : function sub( dst,src,i )
  {
    var d = dst.eGet( i );
    var s = src.eGet( i );

    var r = d - s;

    dst.eSet( i,r );
  }
});

//

var mul = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 2,Infinity ],
  homogenous : 1,
  onMakeIdentity : function( dst )
  {
    _.vector.assignScalar( dst,1 );
  },
  onEach : function mul( dst,src,i )
  {
    var d = dst.eGet( i );
    var s = src.eGet( i );

    var r = d * s;

    dst.eSet( i,r );
  }
});

//

var div = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 2,Infinity ],
  homogenous : 1,
  onMakeIdentity : function( dst )
  {
    debugger;
    _.vector.assignScalar( dst,1 );
  },
  onEach : function div( dst,src,i )
  {
    debugger;
    var d = dst.eGet( i );
    var s = src.eGet( i );

    var r = d / s;

    dst.eSet( i,r );
  }
});

//

var min = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 2,Infinity ],
  homogenous : 1,
  onMakeIdentity : function( dst )
  {
    debugger;
    _.vector.assignScalar( dst,+Infinity );
  },
  onEach : function min( dst,src,i )
  {
    var d = dst.eGet( i );
    var s = src.eGet( i );

    var r = _min( d,s );

    dst.eSet( i,r );
  }
});

//

var max = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 2,Infinity ],
  homogenous : 1,
  onMakeIdentity : function( dst )
  {
    debugger;
    _.vector.assignScalar( dst,-Infinity );
  },
  onEach : function max( dst,src,i )
  {
    var d = dst.eGet( i );
    var s = src.eGet( i );

    var r = _max( d,s );

    dst.eSet( i,r );
  }
});

//

var clamp = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 3,3 ],
  onEach : function clamp( dst,min,max,i )
  {
    var vmin = min.eGet( i );
    var vmax = max.eGet( i );
    if( dst.eGet( i ) > vmax ) dst.eSet( i,vmax );
    else if( dst.eGet( i ) < vmin ) dst.eSet( i,vmin );
  }
});

//

var randomInRange = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 3,3 ],
  onEach : function randomInRange( dst,min,max,i )
  {
    var vmin = min.eGet( i );
    var vmax = max.eGet( i );
    dst.eSet( i,vmin + Math.random()*( vmax-vmin ) );
  }
});

//

var mix = _operationReturningSelfTakingVariantsComponentWise_functor
({
  takingArguments : [ 3,3 ],
  onEach : function mix( dst,src,progress,i )
  {
    debugger;
    throw _.err( 'not tested' );
    var v1 = dst.eGet( i );
    var v2 = src.eGet( i );
    var p = progress.eGet( i );
    dst.eSet( i,v1*( 1-p ) + v2*( p ) );
  }
});

  // add : add,
  // sub : sub,
  // mul : mul,
  // div : div,
  // min : min,
  // max : max,

// --
// atom-wise, homogeneous, taking vectors
// --

function declareHomogeneousTakingVectorsRoutines()
{

  for( var _routineName in operations.atomWiseHomogeneous )
  {

    var atomOperation = operations.atomWiseHomogeneous[ _routineName ];
    var routineName = _routineName + ( atomOperation.postfix !== undefined && atomOperation.postfix !== null ? atomOperation.postfix : 'Vectors' );
    var operation = operationSupplement( null,atomOperation );

    _.assert( operation.atomOperation === undefined );
    _.assert( _.strIsNotEmpty( operation.name ) );
    _.assert( _.routineIs( atomOperation.onAtom ) );
    _.assert( !Routines[ routineName ] );

    operation.atomOperation = atomOperation;

    if( !operation.takingArguments )
    operation.takingArguments = [ 2,Infinity ];
    else
    operation.takingArguments[ 1 ] = Infinity;

    if( operation.takingArguments[ 0 ] === 1 )
    operation.input = [ 'vw','vr*' ];
    else if( operation.takingArguments[ 0 ] > 1 )
    operation.input = [ 'vw','vr+' ];
    else _.assert( 0,'unexpected' );

    operation.name = routineName;

    Routines[ routineName ] = _routineForOperation_functor( operation );

  }

  _.assert( Routines.addVectors );

}

declareHomogeneousTakingVectorsRoutines();

// --
// atom-wise, commutatuve, taking scalar
// --

function declareHomogeneousTakingScalarRoutines()
{

  for( var _routineName in operations.atomWiseHomogeneous )
  {
    var routineName = _routineName + 'Scalar';
    var atomOperation = operations.atomWiseHomogeneous[ _routineName ];
    var operation = operationSupplement( null,atomOperation );

    _.assert( operation.atomOperation === undefined );
    _.assert( _.strIsNotEmpty( operation.name ) );
    _.assert( _.routineIs( atomOperation.onAtom ) );
    _.assert( !Routines[ routineName ] );

    operation.atomOperation = atomOperation;
    operation.input = [ 'vw|s','s' ];
    operation.takingArguments = [ 2,2 ];
    operation.name = routineName;

    Routines[ routineName ] = _routineForOperation_functor( operation );

  }

  _.assert( Routines.addScalar );
  _.assert( Routines.addScalar.operation.onAtom.length >= 2 );

}

declareHomogeneousTakingScalarRoutines();

// --
// atom-wise
// --

function _onAtomAtomwise_functor( dop )
{

  var onAtom0 = dop.onAtom[ 0 ];
  var onContinue = dop.onContinue[ 0 ];
  var handleAtom = null;

  _.assert( !dop.interruptible || onContinue );
  _.assert( arguments.length === 1 );
  _.assert( _.arrayIs( dop.onContinue ) );
  _.assert( _.routineIs( onAtom0 ) );
  _.assert( _.routineIs( onContinue ) || !onContinue );
  _.assert( dop.onAtom.length === 1 );
  _onAtomGenBegin( dop );

  if( dop.homogeneous === false )
  {

    handleAtom = function handleAtom( o )
    {

      for( var a = 0 ; a < o.srcContainers.length ; a++ )
      {
        var src = o.srcContainers[ a ];
        o.srcElements[ a ] = src.eGet( o.key );
      }

      var r = onAtom0.call( this,o );
      _.assert( r === undefined );
      o.dstContainer.eSet( o.key,o.dstElement );

    }

    handleAtom.defaults =
    {
      key : -1,
      args : null,
      dstElement : null,
      dstContainer : null,
      srcElements : null,
      srcContainers : null,
      unwrapping : 0,
    }

  }
  else if( dop.homogeneous === true )
  {

    if( !dop.usingExtraSrcs && !dop.usingDstAsSrc && dop.takingArguments[ 0 ] === 1 && dop.takingArguments[ 1 ] <= 2 )
    handleAtom = function handleAtom( o )
    {

      o.srcElement = o.srcContainers[ 0 ].eGet( o.key );

      var r = onAtom0.call( this,o );
      _.assert( r === undefined );

      if( !dop.reducing )
      o.dstContainer.eSet( o.key , o.dstElement );

      if( dop.interruptible )
      {
        var r = onContinue.call( this,o );
        _.assert( r === undefined || r === false );
      }

      if( r === false )
      return false;

    }

    else if( dop.interruptible )
    handleAtom = function handleAtom( o )
    {

      o.dstElement = o.srcContainers[ 0 ].eGet( o.key );

      for( var a = 1 ; a < o.srcContainers.length ; a++ )
      {
        var src = o.srcContainers[ a ];
        o.srcElement = src.eGet( o.key );

        var r = onAtom0.call( this,o );
        _.assert( r === undefined );

        var r = onContinue.call( this,o );
        _.assert( r === undefined || r === false );

        if( r === false )
        return false;
      }

      if( !dop.reducing )
      o.dstContainer.eSet( o.key , o.dstElement );

    }
    else
    handleAtom = function handleAtom( o )
    {

      o.dstElement = o.srcContainers[ 0 ].eGet( o.key );

      for( var a = 1 ; a < o.srcContainers.length ; a++ )
      {
        var src = o.srcContainers[ a ];
        o.srcElement = src.eGet( o.key );
        var r = onAtom0.call( this,o );
        _.assert( r === undefined );
      }

      o.dstContainer.eSet( o.key , o.dstElement );

    }

    handleAtom.defaults =
    {
      dstElement : null,
      dstContainer : null,
      srcElement : null,
      srcContainers : null,
      srcContainerIndex : -1,
      key : -1,
      args : null,
      unwrapping : 0,
    }

  }
  else _.assert( 0,'unknown kind of input',dop.input );

  _onAtomGenEnd( dop,handleAtom );

  return handleAtom;
}

//

function _onVectorsAtomwise_functor( dop )
{

  _vectorsGenBegin( dop );

  var takingArguments = dop.takingArguments;
  var onVectors = null;
  var onVectorsBegin = null;
  var onVectorsBegin0 = dop.onVectorsBegin[ 0 ];
  var onAtom0 = dop.onAtom[ 0 ];

  _.assert( arguments.length === 1 );

  /* */

  if( dop.homogeneous === false )
  {

    var allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s','s|' ] );

    onVectorsBegin = function onVectorsBegin( dst )
    {

      var o = Object.create( null );
      o.key = -1;
      o.args = _.arraySlice( arguments );;
      o.dstElement = null
      o.dstContainer = dst;
      o.srcElements = [];
      o.srcContainers = null;
      o.unwrapping = 0;
      o.result = null;
      Object.preventExtensions( o );

      if( onVectorsBegin0 )
      onVectorsBegin0( o );

      return o;
    }

    onVectors = function onVectors( dst )
    {
      var o = onVectorsBegin.apply( this,arguments );
      _vectorsCallBegin( o,dop );

      /* */

      _.assert( takingArguments[ 0 ]-1 <= o.srcContainers.length && o.srcContainers.length <= takingArguments[ 1 ] );

      var dst = o.dstContainer;
      for( var k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        o.dstElement = dst.eGet( k );
        onAtom0.call( this,o );
      }

      /* */

      return _vectorsCallEnd( o,dop );
    }

    dop.takingArguments = takingArguments;
    if( _.nothingIs( dop.takingVectors ) )
    dop.takingVectors = [ 1,takingArguments[ 1 ] ];

    var def =
    {
      takingVectorsOnly : false,
      homogeneous : false,
      atomWise : true,
      returningSelf : true,
      returningNew : true,
      returningArray : false,
      modifying : true,
    }

    _.mapSupplementNulls( dop,def );
    _.assert( takingArguments[ 0 ] >= 2 && takingArguments[ 1 ] >= 2 );

  }
  else if( dop.homogeneous === true )
  {

    onVectorsBegin = function onVectorsBegin( dst )
    {

      var o = Object.create( null );
      o.dstElement = null;
      o.dstContainer = dst;
      o.srcContainers = null;
      o.srcElement = null;
      o.key = -1;
      o.args = _.arraySlice( arguments,0,arguments.length );
      o.unwrapping = 0;
      o.result = null;
      Object.preventExtensions( o );

      if( onVectorsBegin0 )
      onVectorsBegin0( o );

      return o;
    }

    if( dop.interruptible )
    onVectors = function onVectors( dst )
    {
      var o = onVectorsBegin.apply( this,arguments );

      _vectorsCallBegin( o,dop );

      var dst = o.dstContainer;
      for( var k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        var r = onAtom0.call( this,o );
        if( r === false )
        break;
      }

      return _vectorsCallEnd( o,dop );
    }
    else
    onVectors = function onVectors()
    {
      var dst = arguments[ 0 ];
      var o = onVectorsBegin.apply( this,arguments );

      _vectorsCallBegin( o,dop );

      var dst = o.dstContainer;
      for( var k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        onAtom0.call( this,o );
      }

      return _vectorsCallEnd( o,dop );
    }

    /* */

    dop.takingArguments = takingArguments;
    if( _.nothingIs( dop.takingVectors ) )
    dop.takingVectors = [ 1,takingArguments[ 1 ] ];

    var def =
    {
      takingVectorsOnly : false,
      homogeneous : true,
      atomWise : true,
      returningSelf : true,
      returningNew : true,
      returningArray : false,
      modifying : true,
    }

    _.mapSupplementNulls( dop,def );
    // _.assert( takingArguments[ 0 ] === 2 && takingArguments[ 1 ] >= 2 );

  }
  else _.assert( 0,'unknown kind of input',dop.input );

  /* */

  _vectorsGenEnd( dop,onVectors,onVectorsBegin );

  return onVectors;
}

// --
// atom-wise, homogeneous
// --

function _routineHomogeneousDeclare( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  if( atomOperation.postfix )
  debugger;

  _.assert( operation.atomOperation === undefined );
  _.assert( _.strIsNotEmpty( operation.name ) );
  _.assert( _.routineIs( atomOperation.onAtom ) );
  _.assert( !Routines[ routineName ],'routine',routineName,'is already defined' );

  operation.atomOperation = atomOperation;

  var def =
  {
    returningNumber : 1,
    returningAtomic : 1,
    takingArguments : [ 2,3 ],
  }

  _.mapSupplementNulls( operation,def );

  if( operation.usingExtraSrcs )
  {
    operation.takingArguments = operation.takingArguments.slice();
    operation.takingArguments[ 1 ] = Infinity;
    operation.takingVectors = [ 0,Infinity ];
  }

  operation.input = [ 'vw|s|n','vr|s','vr*|s*' ];
  operation.name = routineName;

  operation.onAtom_functor = _onAtomAtomwise_functor;
  operation.onVectors_functor = _onVectorsAtomwise_functor;

  Routines[ routineName ] = _routineForOperation_functor( operation );

}

//

function routinesHomogeneousDeclare()
{

  _.assert( !Routines.add );
  _.assert( !Routines.assign );
  _.assert( !Routines.min );
  _.assert( !Routines.max );

  /* */

  for( var routineName in operations.atomWiseHomogeneous )
  {
    var atomOperation = operations.atomWiseHomogeneous[ routineName ];
    _.assert( atomOperation.usingDstAsSrc );
    _routineHomogeneousDeclare( null,atomOperation,routineName );
  }

  /* */

  _.assert( Routines.add );
  _.assert( Routines.add.operation.usingDstAsSrc );
  _.assert( _.arrayIdentical( Routines.add.operation.takingVectors,[ 0,Infinity ] ) );
  _.assert( Routines.min );
  _.assert( Routines.max );

}

routinesHomogeneousDeclare();

// --
// atom-wise, heterogeneous
// --

function _routinesHeterogeneousDeclare( atomOperation,routineName )
{

  var operation = operationSupplement( null,atomOperation );

  _.assert( operation.atomOperation === undefined );
  _.assert( !Routines[ routineName ] );
  _.assert( operation.homogeneous === false );

  operation.atomOperation = atomOperation;
  operation.name = routineName;

  operation.onAtom_functor = _onAtomAtomwise_functor;
  operation.onVectors_functor = _onVectorsAtomwise_functor;

  Routines[ routineName ] = _routineForOperation_functor( operation );

}

//

function routinesHeterogeneousDeclare()
{

  for( var routineName in operations.atomWiseHeterogeneous )
  _routinesHeterogeneousDeclare( operations.atomWiseHeterogeneous[ routineName ],routineName );

  _.assert( Routines.addScaled );

}

routinesHeterogeneousDeclare();

// --
// reduce to element
// --

function _normalizeOperationArity( operation )
{

  if( operation.takingArguments === undefined || operation.takingArguments === null )
  operation.takingArguments = operation.takingVectors;

  if( operation.takingVectors === undefined || operation.takingVectors === null )
  operation.takingVectors = operation.takingArguments;

  if( operation.takingArguments === undefined || operation.takingArguments === null )
  operation.takingArguments = [ 1,Infinity ];

  if( operation.takingVectors === undefined || operation.takingVectors === null )
  operation.takingVectors = [ 1,Infinity ];

  operation.takingArguments = _.numbersFromNumber( operation.takingArguments,2 ).slice();
  operation.takingVectors = _.numbersFromNumber( operation.takingVectors,2 ).slice();

  if( operation.takingArguments[ 0 ] < operation.takingVectors[ 0 ] )
  operation.takingArguments[ 0 ] = operation.takingVectors[ 0 ];

  if( operation.takingVectorsOnly === undefined || operation.takingVectorsOnly === null )
  if( operation.takingVectors[ 0 ] === operation.takingVectors[ 1 ] && operation.takingVectors[ 1 ] === operation.takingArguments[ 1 ] )
  operation.takingVectorsOnly = true;

  return operation;
}

//

function _normalizeOperationFunctions( operationMake,operation )
{

  var atomDefaults = operationMake.atomDefaults;

  _.assert( arguments.length === 2 );
  _.assert( _.objectIs( atomDefaults ) );

  function normalize( name )
  {
    if( _.routineIs( operation[ name ] ) )
    operation[ name ] = [ operation[ name ] ];
    else if( operation[ name ] === undefined || operation[ name ] === null )
    operation[ name ] = [];
    else if( !_.arrayIs( operation[ name ] ) )
    _.assert( 0,'unexpected type of operation function',name,_.strTypeOf( operation[ name ] ) );

    if( operation[ name ][ 0 ] )
    if( operation[ name ][ 0 ].defaults === atomDefaults )
    operation[ name ].splice( 0,1 );
  }

  normalize( 'onAtom' );
  normalize( 'onVectorsBegin' );
  normalize( 'onVectorsEnd' );
  normalize( 'onVectors' );

  return operation;
}

//

function __operationReduceToScalar_functor( operation )
{

  // debugger;
  // if( operation.name === 'distributionRangeSummary' )
  // debugger;

  var atomDefaults = __operationReduceToScalar_functor.atomDefaults;

  _normalizeOperationArity( operation );
  _.routineOptions( __operationReduceToScalar_functor,operation );
  _normalizeOperationFunctions( __operationReduceToScalar_functor,operation );

  operation.generator = __operationReduceToScalar_functor;

  if( !operation.onAtomsBegin.length )
  operation.onAtomsBegin.push( function onVectorsBegin( o )
  {
    debugger;
    o.result = 0;
  });

  if( !operation.onAtomsEnd.length )
  operation.onAtomsEnd.push( function onVectorsEnd( o )
  {
  });

  var onAtom0 = operation.onAtom[ 0 ];
  var onAtomsBegin0 = operation.onAtomsBegin[ 0 ];
  var onAtomsEnd0 = operation.onAtomsEnd[ 0 ];
  var onVectorsBegin0 = operation.onVectorsBegin[ 0 ];
  var onVectorsEnd0 = operation.onVectorsEnd[ 0 ];

  var conditional = operation.conditional;
  var takingArguments = operation.takingArguments;
  var takingVectors = operation.takingVectors;

  // debugger;
  // if( operation.takingVectorsOnly === undefined )
  // operation.takingVectorsOnly =

  // debugger;
  // if( operation.conditional )
  // debugger;

  if( operation.conditional )
  takingArguments[ 1 ] += 1;

  _.assert( takingVectors.length === 2 );
  _.assert( takingArguments.length === 2 );
  _.assert( _.strIsNotEmpty( operation.name ) );

  _.assert( _.objectIs( operation ) );
  _.assert( operation.onVectors.length === 0 );
  _.assert( _.routineIs( onAtom0 ) );
  _.assert( _.routineIs( onAtomsBegin0 ) );
  _.assert( _.routineIs( onAtomsEnd0 ) );
  _.assert( onAtom0.length === 1 );
  _.assert( onAtomsBegin0.length === 1 );
  _.assert( onAtomsEnd0.length === 1 );

  _.assert( !operation.onVectorsBegin.length,'not tested' );
  _.assert( !operation.onVectorsEnd.length,'not tested' );
  // _.assert( _.boolLike( operation.interruptible ) );

  /* */

  function onVectorsBegin( o )
  {

    _.assert( arguments.length === 1 );

    var op = Object.create( null );
    _.mapExtend( op , atomDefaults );
    Object.preventExtensions( op );

    _.mapExtend( op,o );
    _.assert( op.args );

    if( onVectorsBegin0 )
    {
      var r = onVectorsBegin0.call( this,op );
      _.assert( r === undefined );
      _.assert( op.result !== undefined );
    }

    /* */

    if( Config.debug && takingArguments )
    {
      _assert( takingArguments[ 0 ] <= o.args.length && o.args.length <= takingArguments[ 1 ] );
    }

    op.filter = null;
    op.numberOfArguments = o.args.length;
    if( conditional )
    {
      op.numberOfArguments -= 1;
      op.filter = o.args[ op.numberOfArguments ];
      _.routineIs( op.filter );
      _.assert( op.filter.length === 2 );
    }

    op.numberOfArguments = _.clamp( op.numberOfArguments,takingVectors );

    /* */

    // var r = onAtomsBegin0.call( this,op );
    // _.assert( r === undefined );
    // _.assert( op.result !== undefined );

    return op;
  }

  onVectorsBegin.defaults = atomDefaults;
  onVectorsBegin.own = { onVectorsBegin : onVectorsBegin };

  /* */

  function onVectorsEnd( op )
  {
    if( onVectorsEnd0 )
    {
      var r = onVectorsEnd0.call( this,op );
      _.assert( r === undefined );
      _.assert( op.result !== undefined );
    }
    return op.result;
  }

  onVectorsBegin.defaults = atomDefaults;
  onVectorsEnd.own = { onVectorsEnd : onVectorsEnd };

  /* */

  var onAtom = null;

  if( operation.interruptible )
  onAtom = function onAtom( o )
  {

    if( o.filter )
    if( !o.filter.call( this,o.element,o ) )
    return;

    var r = onAtom0.call( this,o );

    _.assert( r === undefined || r === false );
    _.assert( o.result !== undefined );

    return r;
  }
  else
  onAtom = function onAtom( o )
  {

    if( o.filter )
    if( !o.filter.call( this,o.element,o ) )
    return;

    var r = onAtom0.call( this,o );

    _.assert( r === undefined );
    _.assert( o.result !== undefined );

  }

  onAtom.defaults = atomDefaults;
  onAtom.own = { onAtom : onAtom };

  /* */

  var routine = null;

  if( operation.interruptible )
  routine = function operationReduce()
  {
    var op = onVectorsBegin({ args : arguments });
    onAtomsBegin0( op );

    for( var a = 0 ; a < op.numberOfArguments ; a++ )
    {

      op.container = arguments[ a ]
      _.assert( _.vectorIs( op.container ),'expects vector' );

      var length = op.container.length;
      for( var key = 0 ; key < length ; key++ )
      {
        op.key = key;
        op.element = op.container.eGet( key );
        var continuing = onAtom.call( this,op );
        if( continuing === false )
        break;
      }

      if( continuing === false )
      break;
    }

    onAtomsEnd0( op );
    return onVectorsEnd( op );
    // return op.result;
  }
  else
  routine = function operationReduce()
  {
    var op = onVectorsBegin({ args : arguments });
    onAtomsBegin0( op );

    for( var a = 0 ; a < op.numberOfArguments ; a++ )
    {

      op.container = arguments[ a ]
      _.assert( _.vectorIs( op.container ),'expects vector' );

      var length = op.container.length;
      for( var key = 0 ; key < length ; key++ )
      {
        op.key = key;
        op.element = op.container.eGet( key );
        onAtom.call( this,op );
      }

    }

    onAtomsEnd0( op );
    return onVectorsEnd( op );
    // return op.result;
  }

  /* */

  operation.onVectorsBegin.unshift( onVectorsBegin );
  operation.onVectorsEnd.unshift( onVectorsEnd );
  operation.onAtom.unshift( onAtom );
  operation.onVectors.unshift( routine );
  operation.onOperationMake = __operationReduceToScalar_functor;

  var operationDefaults =
  {
    takingArguments : [ 0,Infinity ],
    takingVectors : null,
    takingVectorsOnly : !conditional,
    returningSelf : false,
    returningNew : false,
    returningArray : false,
    returningNumber : ( operation.returningNumber !== undefined && operation.returningNumber !== null ? !!operation.returningNumber : true ),
    returningAtomic : ( operation.returningAtomic !== undefined && operation.returningAtomic !== null ? !!operation.returningAtomic : true ),
    modifying : false,
    reducing : true,
  }

  _.mapSupplementNulls( operation,operationDefaults );
  routine.operation = operation;
  routine.own =
  {
    onAtom : onAtom,
    onVectorsBegin : onVectorsBegin,
    onVectorsEnd : onVectorsEnd,
  };

  return routine;
}

__operationReduceToScalar_functor.defaults =
{
  onAtom : null,
  onVectorsBegin : null,
  onVectorsEnd : null,
  conditional : null,
  takingArguments : [ 0,Infinity ],
  takingVectors : [ 0,Infinity ],
  reducing : true,
}

__operationReduceToScalar_functor.defaults.__proto__ = OperationDescriptor;

__operationReduceToScalar_functor.atomDefaults =
{
  container : null,
  key : -1,
  element : null,
  result : null,
  args : null,
  filter : null,
  numberOfArguments : null,
}

//

function _operationReduceToScalar_functor( o )
{
  var result = Object.create( null );
  var conditional = o.conditional;

  _.assert( _.strIsNotEmpty( o.name ) );
  _.assert( _.objectIs( o ) );
  _.assertMapHasOnly( o,_operationReduceToScalar_functor.defaults );

  var operation = operationSupplement( null,o );
  operation.conditional = false;
  result.trivial = __operationReduceToScalar_functor( operation );

  var operation = operationSupplement( null,o );
  operation.conditional = true;
  operation.name += 'Conditional';
  result.conditional = __operationReduceToScalar_functor( operation );

  return result;
}

_operationReduceToScalar_functor.defaults =
{
}

_operationReduceToScalar_functor.defaults.__proto__ = __operationReduceToScalar_functor.defaults;

//

function declareReducingRoutines()
{

  for( var routineName in operations.atomWiseReducing )
  {

    var atomOperation = operations.atomWiseReducing[ routineName ];
    var operation = operationSupplement( null,atomOperation );

    _.assert( operation.atomOperation === undefined );
    _.assert( _.strIsNotEmpty( operation.name ) );
    _.assert( _.routineIs( atomOperation.onAtom ) );
    _.assert( !Routines[ routineName ] );

    operation.homogeneous = true;
    operation.atomOperation = atomOperation;
    operation.name = routineName;

    var r = _operationReduceToScalar_functor( operation );
    Routines[ r.trivial.operation.name ] = r.trivial;
    Routines[ r.conditional.operation.name ] = r.conditional;

  }

  _.assert( _.routineIs( Routines.reduceToMean ) );
  _.assert( _.routineIs( Routines.reduceToMeanConditional ) );
  // _.assert( _.routineIs( !Routines.allFinite ) );
  // _.assert( Routines.allFinite.operation.takingVectorsOnly );
  // _.assert( _.routineIs( Routines.allFiniteConditional ) );

}

declareReducingRoutines();

// --
// extremal reductor
// --

function _operationReduceToExtremal_functor( operation )
{

  _.assertMapHasOnly( operation,_operationReduceToExtremal_functor.defaults );
  _.assert( _.strIsNotEmpty( operation.name ) );
  _.assert( _.objectIs( operation ) );
  _.assert( _.routineIs( operation.onDistance ) );
  _.assert( _.routineIs( operation.onIsGreater ) );
  _.assert( _.numberIs( operation.distanceOnBegin ) );

  _.assert( operation.onDistance.length === 1 );
  _.assert( operation.onIsGreater.length === 2 );

  var onDistance = operation.onDistance;
  var onIsGreater = operation.onIsGreater;
  var distanceOnBegin = operation.distanceOnBegin;
  var valueName = _.nameUnfielded( operation.valueName ).coded;

  var _gened = _operationReduceToScalar_functor
  ({
    onAtom : function( o )
    {

      _.assert( o.container.length,'not tested' );

      var distance = onDistance( o );
      if( onIsGreater( distance,o.result.value ) )
      {
        o.result.container = o.container;
        o.result[ valueName ] = distance;
        o.result.index = o.key;
      }

    },
    onAtomsBegin : function( o )
    {
      o.result = Object.create( null );
      o.result.container = null;
      o.result.index = -1;
      o.result[ valueName ] = distanceOnBegin;
    },
    takingVectors : operation.takingVectors,
    returningNumber : false,
    returningAtomic : false,
    name : operation.name,
  });

  return _gened;
}

_operationReduceToExtremal_functor.defaults =
{
  onDistance : null,
  onIsGreater : null,
  takingArguments : null,
  takingVectors : null,
  distanceOnBegin : null,
  valueName : null,
  name : null,
}

//

var reduceToClosest = _operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    debugger;
    _.assert( o.container.length,'not tested' );
    _.assert( 0,'not tested' );
    return abs( o.result.instance - o.element );
  },
  onIsGreater : function( a,b )
  {
    return a < b;
  },
  takingArguments : 2,
  takingVectors : 1,
  distanceOnBegin : +Infinity,
  valueName : { distance : 'distance' },
  name : 'reduceToClosest',
});

//

var reduceToFurthest = _operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    debugger;
    _.assert( o.container.length,'not tested' );
    _.assert( 0,'not tested' );
    return abs( o.result.instance - o.element );
  },
  onIsGreater : function( a,b )
  {
    return a > b;
  },
  takingArguments : 2,
  takingVectors : 1,
  distanceOnBegin : -Infinity,
  valueName : { distance : 'distance' },
  name : 'reduceToFurthest',
});

//

var reduceToMin = _operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    debugger;
    _.assert( o.container.length,'not tested' );
    _.assert( 0,'not tested' );
    return o.element;
  },
  onIsGreater : function( a,b )
  {
    return a < b;
  },
  distanceOnBegin : +Infinity,
  valueName : { value : 'value' },
  name : 'reduceToMin',
});

//

var reduceToMinAbs = _operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    _.assert( o.container.length,'not tested' );
    return abs( o.element );
  },
  onIsGreater : function( a,b )
  {
    return a < b;
  },
  distanceOnBegin : -Infinity,
  valueName : { value : 'value' },
  name : 'reduceToMinAbs',
});

//

var reduceToMax = _operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    _.assert( o.container.length,'not tested' );
    return o.element;
  },
  onIsGreater : function( a,b )
  {
    return a > b;
  },
  distanceOnBegin : -Infinity,
  valueName : { value : 'value' },
  name : 'reduceToMax',
});

//

var reduceToMaxAbs = _operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    _.assert( o.container.length,'not tested' );
    return abs( o.element );
  },
  onIsGreater : function( a,b )
  {
    return a > b;
  },
  distanceOnBegin : -Infinity,
  valueName : { value : 'value' },
  name : 'reduceToMaxAbs',
});

//

function _distributionRangeSummaryBegin( o )
{

  o.result = { min : Object.create( null ), max : Object.create( null ), };

  o.result.min.value = +Infinity;
  o.result.min.index = -1;
  o.result.min.container = null;
  o.result.max.value = -Infinity;
  o.result.max.index = -1;
  o.result.max.container = null;

}

function _distributionRangeSummaryEach( o )
{

  _.assert( o.container.length,'not tested' );

  if( o.element > o.result.max.value )
  {
    o.result.max.value = o.element;
    o.result.max.index = o.key;
    o.result.max.container = o.container;
  }

  if( o.element < o.result.min.value )
  {
    o.result.min.value = o.element;
    o.result.min.index = o.key;
    o.result.min.container = o.container;
  }

}

function _distributionRangeSummaryEnd( o )
{
  if( o.result.min.index === -1 )
  {
    o.result.min.value = NaN;
    o.result.max.value = NaN;
  }
  o.result.median = ( o.result.min.value + o.result.max.value ) / 2;
}

var distributionRangeSummary = _operationReduceToScalar_functor
({
  onAtom : _distributionRangeSummaryEach,
  onAtomsBegin : _distributionRangeSummaryBegin,
  onAtomsEnd : _distributionRangeSummaryEnd,
  returningNumber : false,
  returningAtomic : false,
  name : 'distributionRangeSummary',
});

_.assert( distributionRangeSummary.trivial.operation.reducing );

//

function reduceToMinValue()
{
  var result = Self.reduceToMin.apply( Self,arguments );
  return result.value;
}

var dop = reduceToMinValue.operation = Object.create( null );
dop.takingArguments = [ 1,Infinity ];
dop.takingVectors = [ 1,Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningNumber = true;
dop.returningAtomic = true;
dop.modifying = false;

//

function reduceToMaxValue()
{
  var result = Self.reduceToMax.apply( Self,arguments );
  return result.value;
}

var dop = reduceToMaxValue.operation = Object.create( null );
dop.takingArguments = [ 1,Infinity ];
dop.takingVectors = [ 1,Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningNumber = true;
dop.returningAtomic = true;
dop.modifying = false;

//

function distributionRangeSummaryValue()
{
  var result = Self.distributionRangeSummary.apply( Self,arguments );
  return [ result.min.value,result.max.value ];
}

var dop = distributionRangeSummaryValue.operation = Object.create( null );
dop.takingArguments = [ 1,Infinity ];
dop.takingVectors = [ 1,Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningNumber = false;
dop.modifying = false;

// --
// zipping
// --

function _declareHomogeneousLogical2Routine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  operation.input = [ 'vw?','vr','vr' ];
  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );

  return _routineHomogeneousDeclare( operation,atomOperation,routineName );
}

//

function _declareHomogeneousLogical2NotReducingRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  operation.reducing = 0;
  operation.takingArguments = [ 2,3 ];
  operation.takingVectors = [ 0,3 ];

  return _declareHomogeneousLogical2Routine( operation,atomOperation,routineName );
}

//

function _declareHomogeneousLogical2ReducingRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );

  _operationLogicalReducerAdjust( operation );

  var def =
  {

    // usingExtraSrcs : 0,
    // usingDstAsSrc : 0,
    // interruptible : 1,
    // reducing : 1,
    // returningAtomic : 1,
    // returningBoolean : 1,
    // returningNumber : 0,
    // returningNew : 0,
    // returningSelf : 0,
    // returningArray : 0,

    takingArguments : [ 2,2 ],
    takingVectors : [ 0,2 ],
    input : [ 'vw?','vr','vr' ],
  }

  _.mapExtend( operation,def );

  _.assert( _.arrayIs( operation.onContinue ) && operation.onContinue.length );

  return _routineHomogeneousDeclare( operation,atomOperation,routineName );
}

//

function _declareHomogeneousLogical2ReducingAllRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  function onContinue( o )
  {
    if( o.dstElement === false )
    return false;
  }

  function onVectorsEnd( o )
  {
    if( o.result === null )
    o.result = true;
  }

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return _declareHomogeneousLogical2ReducingRoutine( operation,atomOperation,routineName );
}

//

function _declareHomogeneousLogical2ReducingAnyRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  function onContinue( o )
  {
    if( o.dstElement === true )
    return false;
  }

  function onVectorsEnd( o )
  {
    if( o.result === null )
    o.result = true;
  }

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return _declareHomogeneousLogical2ReducingRoutine( operation,atomOperation,routineName );
}

//

function _declareHomogeneousLogical2ReducingNoneRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  _.assert( !operation.onContinue.length );
  _.assert( !operation.onVectorsEnd.length );

  function onContinue( o )
  {
    if( o.dstElement === true )
    return false;
  }

  function onVectorsEnd( o )
  {
    o.result = !o.result;
  }

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return _declareHomogeneousLogical2ReducingRoutine( operation,atomOperation,routineName );
}

//

function declareHomogeneousLogical2Routines()
{

  _.assert( !Routines.isIdentical );
  _.assert( !Routines.allIdentical );
  _.assert( !Routines.anyIdentical );
  _.assert( !Routines.noneIdentical );
  _.assert( !Routines.isGreater );

  /* */

  for( var routineName in operations.logical2 )
  {
    var atomOperation = operations.logical2[ routineName ];
    _declareHomogeneousLogical2NotReducingRoutine( null,atomOperation,routineName );
  }

  /* */

  for( var name in operations.logical2 )
  {

    var routineName = 'all' + _.strRemoveBegin( name,'is' );
    var atomOperation = operations.logical2[ name ];
    _declareHomogeneousLogical2ReducingAllRoutine( null,atomOperation,routineName );

    var routineName = 'any' + _.strRemoveBegin( name,'is' );
    var atomOperation = operations.logical2[ name ];
    _declareHomogeneousLogical2ReducingAnyRoutine( null,atomOperation,routineName );

    var routineName = 'none' + _.strRemoveBegin( name,'is' );
    var atomOperation = operations.logical2[ name ];
    _declareHomogeneousLogical2ReducingNoneRoutine( null,atomOperation,routineName );

  }

  /* */

  _.assert( Routines.isIdentical );
  _.assert( Routines.allIdentical );
  _.assert( Routines.anyIdentical );
  _.assert( Routines.noneIdentical );
  _.assert( Routines.isGreater );

  _.assert( _.arrayIdentical( Routines.isIdentical.operation.takingArguments,[ 2,3 ] ) );
  _.assert( _.arrayIdentical( Routines.allIdentical.operation.takingArguments,[ 2,2 ] ) );

}

declareHomogeneousLogical2Routines();

//

function gt( dst,src )
{
  return _.vector.isGreater.apply( this,arguments );
}

var dop = gt.operation = Routines.isGreater.operation;
_.assert( dop );

//

function ge( dst,src )
{
  return _.vector.isGreaterEqual.apply( this,arguments );
}

var dop = ge.operation = Routines.isGreaterEqual.operation;
_.assert( dop );

//

function lt( dst,src )
{
  return _.vector.isLess.apply( this,arguments );
}

var dop = lt.operation = Routines.isLess.operation;
_.assert( dop );

//

function le( dst,src )
{
  return _.vector.isLessEqual.apply( this,arguments );
}

var dop = le.operation = Routines.isLessEqual.operation;
_.assert( dop );

//

function dot( dst,src )
{
  var result = 0;
  var length = dst.length;

  _assert( _.vectorIs( dst ) );
  _assert( _.vectorIs( src ) );
  _assert( dst.length === src.length,'src and dst should have same length' );
  _assert( arguments.length === 2 );

  for( var s = 0 ; s < length ; s++ )
  {
    result += dst.eGet( s ) * src.eGet( s );
  }

  return result;
}

var dop = dot.operation = Object.create( null );
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function distance( src1,src2 )
{
  var result = this.distanceSqr( src1,src2 );
  result = sqrt( result );
  return result;
}

var dop = distance.operation = Object.create( null );
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function distanceSqr( src1,src2 )
{
  var result = 0;
  var length = src1.length;

  _assert( src1.length === src2.length,'vector.distanceSqr :','src1 and src2 should have same length' );

  for( var s = 0 ; s < length ; s++ )
  {
    result += _sqr( src1.eGet( s ) - src2.eGet( s ) );
  }

  return result;
}

var dop = distanceSqr.operation = Object.create( null );
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

// --
// logical1 singler
// --

function _declareLogic1SinglerRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );
  _.assert( arguments.length === 3 );

  var def =
  {
    usingExtraSrcs : 0,
    usingDstAsSrc : 0,
    interruptible : 0,
    reducing : 0,
    returningAtomic : 1,
    returningBoolean : 1,
    returningNumber : 0,
    returningNew : 1,
    returningSelf : 1,
    returningArray : 0,
    takingArguments : [ 1,2 ],
    takingVectors : [ 0,2 ],
    input : [ 'vw?','vr|s' ],
  }

  _.mapExtend( operation,def );

  return _routineHomogeneousDeclare( operation,atomOperation,routineName );
}

//

function _declareLogic1ReducingSinglerRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );
  _.assert( arguments.length === 3 );

  _operationLogicalReducerAdjust( operation );

  var def =
  {

    // usingExtraSrcs : 0,
    // usingDstAsSrc : 0,
    // interruptible : 1,
    // reducing : 1,
    // returningAtomic : 1,
    // returningBoolean : 1,
    // returningNumber : 0,
    // returningNew : 0,
    // returningSelf : 0,
    // returningArray : 0,

    takingArguments : [ 1,1 ],
    takingVectors : [ 0,1 ],
    input : [ 'vr|s' ],
  }

  _.mapExtend( operation,def );

  return _routineHomogeneousDeclare( operation,atomOperation,routineName );
}

//

function _declareLogic1ReducingSinglerAllRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  function onContinue( o )
  {
    if( o.dstElement === false )
    return false;
  }

  function onVectorsEnd( o )
  {
    if( o.result === null )
    o.result = true;
  }

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return _declareLogic1ReducingSinglerRoutine( operation,atomOperation,routineName );
}

//

function _declareLogic1ReducingSinglerAnyRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  function onContinue( o )
  {
    if( o.dstElement === true )
    return false;
  }

  function onVectorsEnd( o )
  {
    if( o.result === null )
    o.result = true;
  }

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return _declareLogic1ReducingSinglerRoutine( operation,atomOperation,routineName );
}

//

function _declareLogic1ReducingSinglerNoneRoutine( operation,atomOperation,routineName )
{
  var operation = operationSupplement( operation,atomOperation );

  function onContinue( o )
  {
    if( o.dstElement === true )
    return false;
  }

  function onVectorsEnd( o )
  {
    o.result = !o.result;
  }

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return _declareLogic1ReducingSinglerRoutine( operation,atomOperation,routineName );
}

//

function declareLogic1Routines()
{

  _.assert( !Routines.isZero );
  // _.assert( !Routines.allZero );
  _.assert( !Routines.anyZero );
  _.assert( !Routines.noneZero );

  /* */

  for( var routineName in operations.logic1 )
  {
    var atomOperation = operations.logic1[ routineName ];
    _declareLogic1SinglerRoutine( null,atomOperation,routineName );
  }

  /* */

  for( var name in operations.logic1 )
  {
    var atomOperation = operations.logic1[ name ];

    var routineName = 'all' + _.strRemoveBegin( name,'is' );
    _declareLogic1ReducingSinglerAllRoutine( null,atomOperation,routineName );

    var routineName = 'any' + _.strRemoveBegin( name,'is' );
    _declareLogic1ReducingSinglerAnyRoutine( null,atomOperation,routineName );

    var routineName = 'none' + _.strRemoveBegin( name,'is' );
    _declareLogic1ReducingSinglerNoneRoutine( null,atomOperation,routineName );

  }

  /* */

  _.assert( Routines.isZero );
  _.assert( Routines.allZero );
  _.assert( Routines.anyZero );
  _.assert( Routines.noneZero );

  _.assert( _.arrayIdentical( Routines.isZero.operation.takingArguments,[ 1,2 ] ) );
  _.assert( _.arrayIdentical( Routines.allZero.operation.takingArguments,[ 1,1 ] ) );

}

declareLogic1Routines();

// --
// interruptible reductor with bool result
// --

function _equalAre( src1,src2,iterator )
{
  var length = src2.length;

  _assert( arguments.length === 3 );

  if( !( src1.length >= 0 ) )
  return false;

  if( !( src2.length >= 0 ) )
  return false;

  if( !_.vectorIs( src1 ) )
  return false;
  if( !_.vectorIs( src2 ) )
  return false;

  if( iterator.strict )
  if( src1._vectorBuffer.constructor !== src2._vectorBuffer.constructor )
  return false;

  if( !iterator.contain )
  if( src1.length !== length )
  return false;

  if( !length )
  return true;

  for( var i = 0 ; i < length ; i++ )
  {
    if( !iterator.onSameNumbers( src1.eGet( i ),src2.eGet( i ) ) )
    return false;
  }

  return true;
}

var dop = _equalAre.operation = Object.create( null );
dop.takingArguments = 3;
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function equalAre( src1,src2,iterator )
{
  var iterator = _._entityEqualIteratorMake( iterator );
  _assert( arguments.length === 2 || arguments.length === 3 );
  return this._equalAre( src1,src2,iterator )
}

var dop = equalAre.operation = Object.create( null );
dop.takingArguments = [ 2,3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function identicalAre( src1,src2,iterator )
{
  iterator = iterator || Object.create( null );
  iterator.strict = 1;
  iterator = _._entityEqualIteratorMake( iterator );
  _assert( arguments.length === 2 || arguments.length === 3 );
  return this._equalAre( src1,src2,iterator )
}

var dop = identicalAre.operation = Object.create( null );
dop.takingArguments = [ 2,3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function equivalentAre( src1,src2,iterator )
{
  iterator = iterator || Object.create( null );
  iterator.strict = 0;
  iterator = _._entityEqualIteratorMake( iterator );
  _assert( arguments.length === 2 || arguments.length === 3 );
  return this._equalAre( src1,src2,iterator );
}

var dop = equivalentAre.operation = Object.create( null );
dop.takingArguments = [ 2,3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function areParallel( src1,src2,eps )
{
  var length = src1.length;
  var eps = ( eps !== undefined ) ? eps : EPS;

  _.assert( src1.length === src2.length,'vector.distanceSqr :','src1 and src2 should have same length' );

  if( !length ) return true;

  var ratio = 0;
  var s = 0;
  while( s < length )
  {

    var allZero1 = src1.eGet( s ) === 0;
    var allZero2 = src2.eGet( s ) === 0;

    if( allZero1 ^ allZero2 )
    return false;

    if( allZero1 )
    {
      s += 1;
      continue;
    }

    var ratio = src1.eGet( s ) / src2.eGet( s );
    break;

    s += 1;

  }

  while( s < length )
  {

    var r = src1.eGet( s ) / src2.eGet( s );

    if( abs( r - ratio ) > eps )
    return false;

    s += 1;

  }

  return true;
}

var dop = areParallel.operation = Object.create( null );
dop.takingArguments = [ 2,3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

// --
// before
// --

_routinesDeclare();

// --
// helper
// --

function mag( v )
{

  _assert( arguments.length === 1 );

  return this.reduceToMag( v );
}

var dop = mag.operation = _.mapExtend( null , Routines.reduceToMag.operation );
dop.takingArguments = [ 1,1 ];
dop.takingVectors = [ 1,1 ];

//

function magSqr( v )
{

  _assert( arguments.length === 1 );

  return this.reduceToMagSqr( v );
}

var dop = magSqr.operation = _.mapExtend( null , Routines.reduceToMagSqr.operation );
dop.takingArguments = [ 1,1 ];
dop.takingVectors = [ 1,1 ];


// --
// statistics
// --

function median( v )
{
  debugger;
  var result = this.distributionRangeSummary( v ).median;
  debugger;
  return result;
}

var dop = median.operation = _.mapExtend( null , distributionRangeSummary.trivial.operation );

//

function momentCentral( v,degree,mean )
{
  _assert( arguments.length === 2 || arguments.length === 3 );

  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  return this._momentCentral( v,degree,mean );
}

var dop = momentCentral.operation = _.mapExtend( null , Routines._momentCentral.operation );
dop.takingArguments = [ 2,3 ];

//

function momentCentralConditional( v,degree,mean,filter )
{
  _assert( arguments.length === 3 || arguments.length === 4 );

  if( _.routineIs( mean ) )
  {
    _assert( filter === undefined );
    filter = mean;
    mean = null;
  }

  debugger;
  if( mean === undefined || mean === null )
  mean = _.avector.meanConditional( v,filter );

  return this._momentCentralConditional( v,degree,mean,filter );
}

var dop = momentCentralConditional.operation = _.mapExtend( null , Routines._momentCentralConditional.operation );
dop.takingArguments = [ 3,4 ];

//

function distributionSummary( v )
{
  var result = Object.create( null );

  result.range = this.distributionRangeSummary( v );
  delete result.range.min.container;
  delete result.range.max.container;

  result.mean = this.mean( v );
  result.variance = this.variance( v,result.mean );
  result.standardDeviation = this.standardDeviation( v,result.mean );
  result.kurtosisExcess = this.kurtosisExcess( v,result.mean );
  result.skewness = this.skewness( v,result.mean );

  return result;
}

var dop = distributionSummary.operation = _.mapExtend( null , Routines._momentCentral.operation );
dop.takingArguments = [ 1,1 ];

//

function variance( v,mean )
{
  _assert( arguments.length === 1 || arguments.length === 2 );
  var degree = 2;
  return this.momentCentral( v,degree,mean );
}

var dop = variance.operation = _.mapExtend( null , momentCentral.operation );
dop.takingArguments = [ 1,2 ];

//

function varianceConditional( v,mean,filter )
{
  _assert( arguments.length === 2 || arguments.length === 3 );

  if( _.routineIs( mean ) )
  {
    _assert( filter === undefined );
    filter = mean;
    mean = null;
  }

  var degree = 2;
  return this.momentCentralConditional( v,degree,mean,filter );
}

var dop = varianceConditional.operation = _.mapExtend( null , momentCentralConditional.operation );
dop.takingArguments = [ 1,2 ];

//

function standardDeviation()
{
  var result = this.variance.apply( this,arguments );
  return _sqrt( result );
}

var dop = standardDeviation.operation = _.mapExtend( null , variance.operation );

//

function standardDeviationNormalized( v,mean )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  var result = this.variance( v,mean );

  return _sqrt( result ) / mean;
}

var dop = standardDeviationNormalized.operation = _.mapExtend( null , variance.operation );

//

function kurtosis( v,mean )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  var variance = this.variance( v,mean );
  var result = this.momentCentral( v,4,mean );

  return result / _pow( variance,2 );
}

var dop = kurtosis.operation = _.mapExtend( null , variance.operation );

//

/* kurtosis of normal distribution is three */

function kurtosisNormalized( v,mean )
{
  var result = this.kurtosis.apply( this,arguments );
  return result - 3;
}

var dop = kurtosisNormalized.operation = _.mapExtend( null , variance.operation );

//

function skewness( v,mean )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  var moment = this.moment( v,3 );
  var std = this.std( v,mean );

  return moment / _pow( std,3 );
}

var dop = skewness.operation = _.mapExtend( null , variance.operation );

// --
// routines
// --

var RoutinesMathematical =
{

  // meta

  /*

  operationSupplement : operationSupplement,
  _operationLogicalReducerAdjust : _operationLogicalReducerAdjust,

  _routineAdjust : _routineAdjust,
  _routinesDeclare : _routinesDeclare,

  _onAtomGenBegin : _onAtomGenBegin,
  _onAtomGenEnd : _onAtomGenEnd,
  _onAtomForRoutine_functor : _onAtomForRoutine_functor,

  _vectorizeDst : _vectorizeDst,
  _vectorizeSrcs : _vectorizeSrcs,
  _vectorsCallBegin : _vectorsCallBegin,
  _vectorsCallEnd : _vectorsCallEnd,
  _vectorsGenBegin : _vectorsGenBegin,
  _vectorsGenEnd : _vectorsGenEnd,
  _onVectorsForRoutine_functor : _onVectorsForRoutine_functor,

  _routineForOperation_functor : _routineForOperation_functor,

  */


  // basic

  assign : assign,
  assignVector : assignVector,

  clone : clone,
  makeSimilar : makeSimilar,

  slice : slice,
  slicedArray : slicedArray,
  slicedVector : slicedVector,

  resizedArray : resizedArray,
  resizedVector : resizedVector,

  subarray : subarray,

  toArray : toArray,
  _toStr : _toStr,

  gather : gather,


  // special

  sort : sort,
  randomInRadius : randomInRadius,

  crossWithPoints : crossWithPoints,
  _cross3 : _cross3,
  cross3 : cross3,
  cross : cross,

  quaternionApply : quaternionApply,
  quaternionApply2 : quaternionApply2,
  eulerApply : eulerApply,

  reflect : reflect,

  matrixApplyTo : matrixApplyTo,
  matrixHomogenousApply : matrixHomogenousApply,
  matrixDirectionsApply : matrixDirectionsApply,

  swapVectors : swapVectors,
  swapAtoms : swapAtoms,

  formate : formate,


  // atom-wise, modifying, taking single vector : self

  /* _operationTakingDstSrcReturningSelfComponentWise_functor */

  inv : inv,
  invOrOne : invOrOne,

  floor : floorRoutine,
  ceil : ceilRoutine,
  abs : absRoutine,
  round : roundRoutine,

  ceilToPowerOfTwo : ceilToPowerOfTwo,

  normalize : normalize,


  // atom-wise, assigning, mixed : self

  /* _operationReturningSelfTakingVariantsComponentWise_functor */
  /* _operationReturningSelfTakingVariantsComponentWiseAct_functor */

  addAssigning : add.assigning,
  subAssigning : sub.assigning,
  mulAssigning : mul.assigning,
  divAssigning : div.assigning,

  minAssigning : min.assigning,
  maxAssigning : max.assigning,
  clampAssigning : clamp.assigning,
  randomInRangeAssigning : randomInRange.assigning,
  mixAssigning : mix.assigning,


  // atom-wise, copying, mixed : self

  addCopying : add.copying,
  subCopying : sub.copying,
  mulCopying : mul.copying,
  divCopying : div.copying,

  minCopying : min.copying,
  maxCopying : max.copying,
  clampCopying : clamp.copying,
  randomInRangeCopying : randomInRange.copying,
  mixCopying : mix.copying,


  // atom-wise, homogeneous, taking vectors
  // vectors only -> self

  /*
  declareHomogeneousTakingVectorsRoutines : declareHomogeneousTakingVectorsRoutines,
  */

  addVectors : Routines.addVectors,
  subVectors : Routines.subVectors,
  mulVectors : Routines.mulVectors,
  divVectors : Routines.divVectors,

  assignVectors : Routines.assignVectors,
  minVectors : Routines.minVectors,
  maxVectors : Routines.maxVectors,


  // atom-wise, homogeneous, taking scalar
  // 1 vector , 1 scalar -> self

  /*
  declareHomogeneousTakingScalarRoutines : declareHomogeneousTakingScalarRoutines,
  */

  addScalar : Routines.addScalar,
  subScalar : Routines.subScalar,
  mulScalar : Routines.mulScalar,
  divScalar : Routines.divScalar,

  assignScalar : Routines.assignScalar,
  minScalar : Routines.minScalar,
  maxScalar : Routines.maxScalar,


  // atom-wise

  /*
  _onAtomAtomwise_functor : _onAtomAtomwise_functor,
  _onVectorsAtomwise_functor : _onVectorsAtomwise_functor,
  */


// atom-wise, homogeneous

  /*
  _routineHomogeneousDeclare : _routineHomogeneousDeclare,
  routinesHomogeneousDeclare : routinesHomogeneousDeclare,
  */

  add : Routines.add,
  sub : Routines.sub,
  mul : Routines.mul,
  div : Routines.div,

  min : Routines.min,
  max : Routines.max,


// atom-wise, heterogeneous

  /*
  _routinesHeterogeneousDeclare : _routinesHeterogeneousDeclare,
  routinesHeterogeneousDeclare : routinesHeterogeneousDeclare,
  */

  addScaled : Routines.addScaled,
  subScaled : Routines.subScaled,
  mulScaled : Routines.mulScaled,
  divScaled : Routines.divScaled,

  clamp : Routines.clamp,
  mix : Routines.mix,


  // scalarReductor

/*

  _normalizeOperationArity : _normalizeOperationArity,
  _normalizeOperationFunctions : _normalizeOperationFunctions,

  __operationReduceToScalar_functor : __operationReduceToScalar_functor,
  _operationReduceToScalar_functor : _operationReduceToScalar_functor,
  declareReducingRoutines : declareReducingRoutines,

*/

  polynomApply : Routines.polynomApply,
  mean : Routines.mean,
  moment : Routines.moment,
  _momentCentral : Routines._momentCentral,
  reduceToMean : Routines.reduceToMean,
  reduceToProduct : Routines.reduceToProduct,
  reduceToSum : Routines.reduceToSum,
  reduceToAbsSum : Routines.reduceToAbsSum,
  reduceToMag : Routines.reduceToMag,
  reduceToMagSqr : Routines.reduceToMagSqr,

  polynomApplyConditional : Routines.polynomApplyConditional,
  meanConditional : Routines.meanConditional,
  momentConditional : Routines.momentConditional,
  _momentCentralConditional : Routines._momentCentralConditional,
  reduceToMeanConditional : Routines.reduceToMeanConditional,
  reduceToProductConditional : Routines.reduceToProductConditional,
  reduceToSumConditional : Routines.reduceToSumConditional,
  reduceToAbsSumConditional : Routines.reduceToAbsSumConditional,
  reduceToMagConditional : Routines.reduceToMagConditional,
  reduceToMagSqrConditional : Routines.reduceToMagSqrConditional,

  // allFinite : Routines.allFinite,
  // anyNan : Routines.anyNan,
  // allInt : Routines.allInt,
  // allZero : Routines.allZero,

  // allFiniteConditional : Routines.allFiniteConditional,
  // anyNanConditional : Routines.anyNanConditional,
  // allIntConditional : Routines.allIntConditional,
  // allZeroConditional : Routines.allZeroConditional,


  // extremal reductor

  /* _operationReduceToExtremal_functor*/

  reduceToClosest : reduceToClosest.trivial,
  reduceToFurthest : reduceToFurthest.trivial,
  reduceToMin : reduceToMin.trivial,
  reduceToMinAbs : reduceToMinAbs.trivial,
  reduceToMax : reduceToMax.trivial,
  reduceToMaxAbs : reduceToMaxAbs.trivial,
  distributionRangeSummary : distributionRangeSummary.trivial,

  reduceToClosestConditional : reduceToClosest.conditional,
  reduceToFurthestConditional : reduceToFurthest.conditional,
  reduceToMinConditional : reduceToMin.conditional,
  reduceToMinAbsConditional : reduceToMinAbs.conditional,
  reduceToMaxConditional : reduceToMax.conditional,
  reduceToMaxAbsConditional : reduceToMaxAbs.conditional,
  distributionRangeSummaryConditional : distributionRangeSummary.conditional,

  reduceToMinValue : reduceToMinValue,
  reduceToMaxValue : reduceToMaxValue,
  distributionRangeSummaryValue : distributionRangeSummaryValue,


  // logical2 zipper

/*
  _declareHomogeneousLogical2Routine : _declareHomogeneousLogical2Routine,
  _declareHomogeneousLogical2NotReducingRoutine : _declareHomogeneousLogical2NotReducingRoutine,
  _declareHomogeneousLogical2ReducingRoutine : _declareHomogeneousLogical2ReducingRoutine,
  _declareHomogeneousLogical2ReducingAllRoutine : _declareHomogeneousLogical2ReducingAllRoutine,
  _declareHomogeneousLogical2ReducingAnyRoutine : _declareHomogeneousLogical2ReducingAnyRoutine,
  _declareHomogeneousLogical2ReducingNoneRoutine : _declareHomogeneousLogical2ReducingNoneRoutine,
  declareHomogeneousLogical2Routines : declareHomogeneousLogical2Routines,
*/

  gt : gt,
  ge : ge,
  lt : lt,
  le : le,

  isIdentical : Routines.isIdentical,
  isNotIdentical : Routines.isNotIdentical,
  isEquivalent : Routines.isEquivalent,
  isNotEquivalent : Routines.isNotEquivalent,
  isGreater : Routines.isGreater,
  isGreaterEqual : Routines.isGreaterEqual,
  isLess : Routines.isLess,
  isLessEqual : Routines.isLessEqual,


    // logical2 reductor

  allIdentical : Routines.allIdentical,
  allNotIdentical : Routines.allNotIdentical,
  allEquivalent : Routines.allEquivalent,
  allNotEquivalent : Routines.allNotEquivalent,
  allGreater : Routines.allGreater,
  allGreaterEqual : Routines.allGreaterEqual,
  allLess : Routines.allLess,
  allLessEqual : Routines.allLessEqual,

  anyIdentical : Routines.anyIdentical,
  anyNotIdentical : Routines.anyNotIdentical,
  anyEquivalent : Routines.anyEquivalent,
  anyNotEquivalent : Routines.anyNotEquivalent,
  anyGreater : Routines.anyGreater,
  anyGreaterEqual : Routines.anyGreaterEqual,
  anyLess : Routines.anyLess,
  anyLessEqual : Routines.anyLessEqual,

  noneIdentical : Routines.noneIdentical,
  noneNotIdentical : Routines.noneNotIdentical,
  noneEquivalent : Routines.noneEquivalent,
  noneNotEquivalent : Routines.noneNotEquivalent,
  noneGreater : Routines.noneGreater,
  noneGreaterEqual : Routines.noneGreaterEqual,
  noneLess : Routines.noneLess,
  noneLessEqual : Routines.noneLessEqual,

  dot : dot,
  distance : distance,
  distanceSqr : distanceSqr,


  // logical1 singler

/*
  _declareLogic1SinglerRoutine : _declareLogic1SinglerRoutine,
  _declareLogic1ReducingSinglerRoutine : _declareLogic1ReducingSinglerRoutine,
  _declareLogic1ReducingSinglerAllRoutine : _declareLogic1ReducingSinglerAllRoutine,
  _declareLogic1ReducingSinglerAnyRoutine : _declareLogic1ReducingSinglerAnyRoutine,
  _declareLogic1ReducingSinglerNoneRoutine : _declareLogic1ReducingSinglerNoneRoutine,
  declareLogic1Routines : declareLogic1Routines,
*/

  isNumber : Routines.isNumber,
  isZero : Routines.isZero,
  isFinite : Routines.isFinite,
  isInfinite : Routines.isInfinite,
  isNan : Routines.isNan,
  isInt : Routines.isInt,
  isString : Routines.isString,

  allNumber : Routines.allNumber,
  allZero : Routines.allZero,
  allFinite : Routines.allFinite,
  allInfinite : Routines.allInfinite,
  allNan : Routines.allNan,
  allInt : Routines.allInt,
  allString : Routines.allString,

  anyNumber : Routines.anyNumber,
  anyZero : Routines.anyZero,
  anyFinite : Routines.anyFinite,
  anyInfinite : Routines.anyInfinite,
  anyNan : Routines.anyNan,
  anyInt : Routines.anyInt,
  anyString : Routines.anyString,

  noneNumber : Routines.noneNumber,
  noneZero : Routines.noneZero,
  noneFinite : Routines.noneFinite,
  noneInfinite : Routines.noneInfinite,
  noneNan : Routines.noneNan,
  noneInt : Routines.noneInt,
  noneString : Routines.noneString,


  // interruptible reductor with bool result

  _equalAre : _equalAre,
  equalAre : equalAre,
  identicalAre : identicalAre,
  equivalentAre : equivalentAre,

  areParallel : areParallel,


  // helper

  mag : mag,
  magSqr : magSqr,


  // statistics

  median : median,

  momentCentral : momentCentral,
  momentCentralConditional : momentCentralConditional,

  distributionSummary : distributionSummary,

  variance : variance,
  varianceConditional : varianceConditional,

  std : standardDeviation,
  standardDeviation : standardDeviation,
  coefficientOfVariation : standardDeviationNormalized,
  standardDeviationNormalized : standardDeviationNormalized,

  kurtosis : kurtosis,
  kurtosisNormalized : kurtosisNormalized,
  kurtosisExcess : kurtosisNormalized,

  skewness : skewness,


}

//

for( var r in Routines )
_.assert( RoutinesMathematical[ r ],'routine',r,'was not declared explicitly in the proto map as it should' );

//

var Forbidden =
{
  randomInRange : 'randomInRange',
}

// --
// after
// --

_.assert( RoutinesMathematical.assign );
_.assert( RoutinesMathematical.assign.operation );
_.assert( RoutinesMathematical.assign.operation.takingArguments );

for( var r in RoutinesMathematical )
_routineAdjust( RoutinesMathematical[ r ],r );

// --
// proto
// --

var Proto =
{

  RoutinesMathematical : RoutinesMathematical,

  EPS : EPS,
  EPS2 : EPS2,

  Forbidden : Forbidden,

}

_.mapExtend( Proto,RoutinesMathematical );
_.mapExtend( Self,Proto );

//

_.assert( _.vector.reduceToMean );
_.assert( !_.vector.isValid );
_.assert( _.vector.allFinite );
_.assert( _.vector.reduceToMaxValue );
_.assert( RoutinesMathematical.reduceToMaxValue );

_.assert( _.vector.floor );
_.assert( _.vector.ceil );
_.assert( _.vector.abs );
_.assert( _.vector.round );

_.assert( _.vector.allIdentical );
_.assert( _.arrayIdentical( _.vector.allIdentical.operation.takingArguments,[ 2,2 ] ) );

_.assert( _.vector.EPS >= 0 );
_.assert( _.vector.EPS2 >= 0 );

_.accessorForbid
({
  object : Self,
  names : Forbidden,
});

})();
