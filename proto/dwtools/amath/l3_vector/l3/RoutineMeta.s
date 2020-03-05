(function _OperationMeta_s_() {

'use strict';

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _arraySlice = _.longSlice;
let _sqr = _.math.sqr;
let _sqrt = _.math.sqrt;
let _assertMapHasOnly = _.assertMapHasOnly;
let _routineIs = _.routineIs;

let _min = Math.min;
let _max = Math.max;
let _pow = Math.pow;
let sqrt = Math.sqrt;
let abs = Math.abs;

let OperationDescriptor1 = _.vectorAdapter.OperationDescriptor1;
let meta = _.vectorAdapter._meta = _.vectorAdapter._meta || Object.create( null );
_.vectorAdapter._meta.routines = _.vectorAdapter._meta.routines || Object.create( null );

// --
// structure
// --

function operationSupplement( operation, atomOperation )
{
  operation = _.mapSupplement( operation, atomOperation );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

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
  operation.takingArguments = [ operation.takingArguments, operation.takingArguments ];
  else if( operation.takingArguments && operation.takingArguments === atomOperation.takingArguments )
  operation.takingArguments = operation.takingArguments.slice();

  if( _.numberIs( operation.takingVectors ) )
  operation.takingVectors = [ operation.takingVectors, operation.takingVectors ];
  else if( operation.takingVectors && operation.takingVectors === atomOperation.takingVectors )
  operation.takingVectors = operation.takingVectors.slice();

  return operation;
}

//

function _operationLogicalReducerAdjust( operation )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  let def =
  {
    usingExtraSrcs : 0,
    usingDstAsSrc : 0,
    interruptible : 1,
    reducing : 1,
    returningPrimitive : 1,
    returningBoolean : 1,
    returningNumber : 0,
    returningNew : 0,
    returningSelf : 0,
    returningLong : 0,
    modifying : 0,
  }

  _.mapExtend( operation, def );

}

//

function operationNormalizeInput( operation, routineName )
{

  let delimeter = [ 'w', 'r', 'v', 's', 'm', 'a', 'n', '?', '*', '+', '!' ];
  var tokenRoutine =
  {
    'w' : tokenWrite,
    'r' : tokenRead,
    'v' : tokenVector,
    's' : tokenScalar,
    'm' : tokenMatrix,
    'a' : tokenAnything,
    'n' : tokenNull,
    '?' : tokenTimesOptional,
    '*' : tokenTimesAny,
    '+' : tokenTimesAtLeast,
    '!' : tokenBut,
  }

  if( _.strIs( operation.input ) )
  operation.input = operation.input.split( ' ' );

  if( _.mapIs( operation.input ) )
  return operation.input;

  routineName = routineName || operation.name;

  _.assert( _.strDefined( routineName ) );
  _.assert( _.longIs( operation.input ), () => `Routine::${routineName} does not have operation.input` );

  operation.input = _.longShrink( operation.input );

  // logger.log( `operationNormalizeInput ${routineName}` );

  let definition = operation.input.join( ' ' );

  for( let i = 0 ; i < operation.input.length ; i++ )
  {
    operation.input[ i ] = argParse( operation.input[ i ] );
  }

  let inputDescriptor = Object.create( null );
  inputDescriptor.definition = definition;
  inputDescriptor.args = operation.input;
  inputDescriptor.takingArguments = [ 0, 0 ];
  inputDescriptor.takingVectors = [ 0, 0 ];
  inputDescriptor.takingVectorsOnly = true;
  operation.input = inputDescriptor;

  for( let i = 0 ; i < inputDescriptor.args.length ; i++ )
  {
    let argDescriptor = inputDescriptor.args[ i ];
    inputDescriptor.takingArguments[ 0 ] += argDescriptor.times[ 0 ];
    inputDescriptor.takingArguments[ 1 ] += argDescriptor.times[ 1 ];
    if( argDescriptor.isVector )
    {
      if( argDescriptor.isVector === true )
      inputDescriptor.takingVectors[ 0 ] += argDescriptor.times[ 0 ];
      inputDescriptor.takingVectors[ 1 ] += argDescriptor.times[ 1 ];
      if( argDescriptor.isVector === _.maybe )
      inputDescriptor.takingVectorsOnly = false;
    }
    else
    {
      inputDescriptor.takingVectorsOnly = false;
    }
  }

  return inputDescriptor;

  /* */

  function argParse( definition )
  {
    let argDescriptor = Object.create( null );
    argDescriptor.types = [];
    argDescriptor.readable = false;
    argDescriptor.writable = false;
    argDescriptor.alternatives = [];
    argDescriptor.definition = definition;
    argDescriptor.times = [ Infinity, 0 ];
    argDescriptor.isVector = null;
    let alternatives = definition.split( '|' );
    for( let i = 0 ; i < alternatives.length ; i++ )
    {
      let typeDescriptor = typeParse( alternatives[ i ] )
      typeCollect( argDescriptor, typeDescriptor );
    }
    return argDescriptor;
  }

  /* */

  function typeCollect( argDescriptor, typeDescriptor )
  {

    _.assert( _.strIs( typeDescriptor.type ) );
    argDescriptor.types.push( typeDescriptor.type );

    _.assert( _.boolIs( typeDescriptor.writable ) )
    if( typeDescriptor.writable )
    argDescriptor.writable = typeDescriptor.writable;

    _.assert( _.boolIs( typeDescriptor.readable ) )
    if( typeDescriptor.readable )
    argDescriptor.readable = typeDescriptor.readable;

    argDescriptor.times[ 0 ] = Math.min( argDescriptor.times[ 0 ], typeDescriptor.times[ 0 ] );
    argDescriptor.times[ 1 ] = Math.max( argDescriptor.times[ 1 ], typeDescriptor.times[ 1 ] );

    _.assert( typeDescriptor.isVector === _.maybe || _.boolIs( typeDescriptor.isVector ) );

    // argDescriptor.isVector = _.fuzzy.and( argDescriptor.isVector, argDescriptor.isVector ); /* xxx */

    if( argDescriptor.isVector === null )
    {
      argDescriptor.isVector = typeDescriptor.isVector;
    }
    else if( argDescriptor.isVector !== _.maybe && typeDescriptor.type !== 'n' )
    {
      if( typeDescriptor.isVector === _.maybe || argDescriptor.isVector === _.maybe )
      argDescriptor.isVector = _.maybe;
      else if( typeDescriptor.isVector === false && argDescriptor.isVector === true )
      argDescriptor.isVector = _.maybe;
      else if( typeDescriptor.isVector === true && argDescriptor.isVector === false )
      argDescriptor.isVector = _.maybe;
      else
      argDescriptor.isVector = typeDescriptor.isVector;
    }

  }

  /* */

  function tokenWrite( c )
  {
    c.typeDescriptor.writable = true;
  }

  /* */

  function tokenRead( c )
  {
    c.typeDescriptor.readable = true;
  }

  /* */

  function tokenVector( c )
  {
    _.assert( c.typeDescriptor.type === null );
    c.typeDescriptor.type = 'v';
    if( !_.longHas( c.splits, '!' ) )
    {
      _.assert( c.typeDescriptor.isVector === null );
      c.typeDescriptor.isVector = true;
    }

  }

  /* */

  function tokenScalar( c )
  {
    c.typeDescriptor.readable = true;
    _.assert( c.typeDescriptor.type === null );
    c.typeDescriptor.type = 's';
    _.assert( c.typeDescriptor.isVector === null );
    c.typeDescriptor.isVector = false;
  }

  /* */

  function tokenMatrix( c )
  {
    _.assert( c.typeDescriptor.type === null );
    c.typeDescriptor.type = 'm';
    _.assert( c.typeDescriptor.isVector === null );
    c.typeDescriptor.isVector = false;
  }

  /* */

  function tokenAnything( c )
  {
    _.assert( c.typeDescriptor.type === null );
    c.typeDescriptor.type = 'a';
    if( !_.longHas( c.splits, '!' ) )
    {
      _.assert( c.typeDescriptor.isVector === null );
      c.typeDescriptor.isVector = _.maybe;
    }
  }

  /* */

  function tokenNull( c )
  {
    _.assert( c.typeDescriptor.type === null );
    c.typeDescriptor.type = 'n';
    _.assert( c.typeDescriptor.isVector === null );
    c.typeDescriptor.isVector = false;
  }

  /* */

  function tokenTimesOptional( c )
  {
    _.assert( c.typeDescriptor.times[ 0 ] === 1 );
    c.typeDescriptor.times[ 0 ] = 0;
  }

  /* */

  function tokenTimesAny( c )
  {
    if( c.i > 0 && !_.longHas( delimeter, c.splits[ c.i-1 ] ) )
    return;
    _.assert( c.typeDescriptor.times[ 0 ] === 1 );
    _.assert( c.typeDescriptor.times[ 1 ] === 1 );
    c.typeDescriptor.times[ 0 ] = 0;
    c.typeDescriptor.times[ 1 ] = Infinity;
  }

  /* */

  function tokenTimesAtLeast( c )
  {
    _.assert( c.typeDescriptor.times[ 0 ] === 1 );
    _.assert( c.typeDescriptor.times[ 1 ] === 1 );
    c.typeDescriptor.times[ 0 ] = 1;
    c.typeDescriptor.times[ 1 ] = Infinity;
  }

  /* */

  function tokenBut( c )
  {
    _.assert( c.splits.length > c.i+1 );
    let next = c.splits[ c.i+1 ];
    c.typeDescriptor.type = '!' + next;
    c.i += 1;
    _.assert( c.typeDescriptor.isVector === null );
    if( next === 'v' || next === 'a' )
    c.typeDescriptor.isVector = false;
    else
    c.typeDescriptor.isVector = _.maybe;
  }

  /* */

  function tokenEtc( c )
  {
    // debugger;
    let times = _.numberFromStr( c.split );
    _.assert( _.numberDefined( times ) );
    _.assert( c.splits[ c.i+1 ] === '*' );
    _.assert( c.typeDescriptor.times[ 0 ] === 1 );
    _.assert( c.typeDescriptor.times[ 1 ] === 1 );
    c.typeDescriptor.times[ 0 ] = times;
    c.typeDescriptor.times[ 1 ] = times;
  }

  /* */

  function typeParse( definition )
  {
    let c = Object.create( null );
    c.typeDescriptor = Object.create( null );
    c.typeDescriptor.type = null;
    c.typeDescriptor.readable = false;
    c.typeDescriptor.writable = false;
    c.typeDescriptor.definition = definition;
    c.typeDescriptor.times = [ 1, 1 ];
    c.typeDescriptor.isVector = null;
    c.splits = _.strSplitFast({ src : definition, delimeter : delimeter, preservingEmpty : 0 });

    for( let i = 0 ; i < c.splits.length ; i++ )
    {
      c.split = c.splits[ i ];
      c.i = i;

      let routine = tokenRoutine[ c.split ];
      if( !routine )
      routine = tokenEtc;

      routine( c );
      i = c.i;
    }

    // if( c.typeDescriptor.isVector )
    // if( c.typeDescriptor.times[ 0 ] === 0 )
    // c.typeDescriptor.isVector = _.maybe;

    return c.typeDescriptor;
  }

  /* */

  /*

  'vw' 'vw|s', 'vr|s', '?vr', '*a', '3*a'

  */
}

//

function operationNormalizeArity( operation )
{

  _.assert( !!operation.input );

  if( operation.takingArguments === undefined || operation.takingArguments === null )
  operation.takingArguments = operation.input.takingArguments;
  // if( operation.takingArguments === undefined || operation.takingArguments === null )
  // operation.takingArguments = operation.takingVectors;

  if( operation.takingVectors === undefined || operation.takingVectors === null )
  operation.takingVectors = operation.input.takingVectors;
  // if( operation.takingVectors === undefined || operation.takingVectors === null )
  // operation.takingVectors = operation.takingArguments;

  if( operation.takingArguments === undefined || operation.takingArguments === null )
  operation.takingArguments = [ 1, Infinity ];

  if( operation.takingVectors === undefined || operation.takingVectors === null )
  operation.takingVectors = [ 1, Infinity ];

  operation.takingArguments = _.numbersFromNumber( operation.takingArguments, 2 ).slice();
  operation.takingVectors = _.numbersFromNumber( operation.takingVectors, 2 ).slice();

  if( operation.takingArguments[ 0 ] < operation.takingVectors[ 0 ] )
  operation.takingArguments[ 0 ] = operation.takingVectors[ 0 ];

  if( operation.takingVectorsOnly === undefined || operation.takingVectorsOnly === null )
  operation.takingVectorsOnly = operation.input.takingVectorsOnly;

  if( operation.takingVectorsOnly === undefined || operation.takingVectorsOnly === null )
  if( operation.takingVectors[ 0 ] === operation.takingVectors[ 1 ] && operation.takingVectors[ 1 ] === operation.takingArguments[ 1 ] )
  operation.takingVectorsOnly = true;

  operation.inputWithoutLast = operation.input.args.slice( 0, operation.input.args.length-1 );
  operation.inputLast = operation.input.args[ operation.input.args.length-1 ];

  return operation;
}

//

function _routinePostFrom( theRoutine, routineName )
{

  if( _.objectIs( theRoutine ) )
  {
    for( let r in theRoutine )
    _routinePostFrom( theRoutine[ r ], r );
    return;
  }

  _.assert( _.routineIs( theRoutine ), () => `routine::${routineName} is not defined` );
  _.assert( _.mapIs( theRoutine.operation ), 'op of routine', routineName, 'is not defined' );

  let op = theRoutine.operation;
  if( op.valid )
  return;

  /* adjust */

  _.mapSupplement( op, _.vectorAdapter.OperationDescriptor2.fields );
  _.assertMapHasOnly( op, _.vectorAdapter.OperationDescriptor2.fields );

  op.returningPrimitive = !!op.returningPrimitive;
  op.returningLong = !!op.returningLong;
  op.returningNumber = !!op.returningNumber;
  op.returningBoolean = !!op.returningBoolean;
  op.returningNew = !!op.returningNew;
  op.returningSelf = !!op.returningSelf;

  op.reducing = !!op.reducing;
  op.atomWise = !!op.atomWise;
  op.homogeneous = !!op.homogeneous;
  op.special = !!op.special;
  op.modifying = !!op.modifying;

  if( op.usingDstAsSrc === null )
  op.usingDstAsSrc = 1;
  if( op.usingExtraSrcs === null )
  op.usingExtraSrcs = 1;

  /* verify */

  if( Config.debug )
  {

    _.assert( op.routine === theRoutine || op.routine === undefined );
    _.assert( _.routineIs( theRoutine ) );
    _.assert( _.mapIs( op ) );
    _.assert( _.numberIs( op.takingArguments ) || _.arrayIs( op.takingArguments ) || op.takingArguments === null );
    _.assert( _.numberIs( op.takingVectors ) || _.arrayIs( op.takingVectors ) || op.takingVectors === null );
    _.assert( _.boolIs( op.atomWise ) );
    _.assert( _.boolIs( op.homogeneous ) );
    _.assert( _.boolIs( op.takingVectorsOnly ) || op.takingVectorsOnly === null );
    _.assert( _.boolIs( op.modifying ) );
    _.assert( _.boolIs( op.reducing ) );

    _.assert( _.boolIs( op.returningSelf ) );
    _.assert( _.boolIs( op.returningNew ) );
    _.assert( _.boolIs( op.returningLong ) );
    _.assert( _.boolIs( op.returningNumber ) );
    _.assert( _.boolIs( op.returningBoolean ) );
    _.assert( _.boolIs( op.returningPrimitive ) );
    _.assert( op.returningNumber ? op.returningPrimitive : true );

    _.assert( op.handleAtom === undefined );
    _.assert( op.handleVector === undefined );
    _.assert( op.handleVectors === undefined );
    _.assert( op.handleBegin === undefined );
    _.assert( op.handleEnd === undefined );

  }

  this.operationNormalizeInput( op, routineName );

  let differentReturns = 0;
  differentReturns += op.returningNew ? 1 : 0;
  differentReturns += op.returningSelf ? 1 : 0;
  differentReturns += op.returningLong ? 1 : 0;
  differentReturns += op.returningPrimitive ? 1 : 0;

  let returningOnly = op.returningOnly;
  if( returningOnly === null || returningOnly === undefined )
  {
    returningOnly = '';
    if( differentReturns === 1 )
    {
      returningOnly = op.returningNew ? 'new' : returningOnly;
      returningOnly = op.returningSelf ? 'self' : returningOnly;
      returningOnly = op.returningLong ? 'array' : returningOnly;
      returningOnly = op.returningPrimitive ? 'atomic' : returningOnly;
    }
    op.returningOnly = returningOnly;
  }

  /* adjust */

  if( op.takingArguments === null )
  op.takingArguments = op.input.takingArguments;
  if( op.takingVectors === null )
  op.takingVectors = op.input.takingVectors;

  op.takingArguments = _.numbersFromNumber( op.takingArguments, 2 );
  op.takingVectors = _.numbersFromNumber( op.takingVectors, 2 );
  op.name = routineName;
  op.routine = theRoutine;
  op.valid = 1;

  if( op.takingVectorsOnly === null )
  op.takingVectorsOnly = op.input.takingVectorsOnly;

  /* validate */

  if( Config.debug )
  {

    _.assert( _.boolIs( op.atomWise ) );
    _.assert( _.boolIs( op.homogeneous ) );
    _.assert( _.boolIs( op.takingVectorsOnly ) );
    _.assert( _.boolIs( op.modifying ) );
    _.assert( _.boolIs( op.reducing ) );

    _.assert( _.boolIs( op.returningSelf ) );
    _.assert( _.boolIs( op.returningNew ) );
    _.assert( _.boolIs( op.returningLong ) );
    _.assert( _.boolIs( op.returningNumber ) );
    _.assert( _.boolIs( op.returningBoolean ) );
    _.assert( _.boolIs( op.returningPrimitive ) );
    _.assert( _.strIs( op.returningOnly ) );
    _.assert( op.returningNumber ? op.returningPrimitive : true );
    _.assert( ( !!returningOnly ) == ( differentReturns == 1 ) );

    _.assert( op.handleAtom === undefined );
    _.assert( op.handleVector === undefined );
    _.assert( op.handleVectors === undefined );
    _.assert( op.handleBegin === undefined );
    _.assert( op.handleEnd === undefined );

  }

  if( Config.debug )
  {

    _.assert( _.routineIs( theRoutine ) );
    _.assert( _.mapIs( op ) );
    _.assert( op.name === routineName );
    _.assert( op.routine === theRoutine );
    _.assert( op.takingArguments.length === 2 );
    _.assert( op.takingVectors.length === 2 );
    _.assert( op.takingArguments[ 0 ] >= op.takingVectors[ 0 ] );
    _.assert( op.takingArguments[ 1 ] >= op.takingVectors[ 1 ] );
    _.assert( !( op.returningNumber && op.returningBoolean ), 'Cant return both' );
    _.assert( _.mapIs( op.input ), () => `Routine::${routineName} does not have op.input` );

    let good = true;
    good = good && op.input.takingArguments[ 0 ] === op.takingArguments[ 0 ];
    good = good && op.input.takingArguments[ 1 ] === op.takingArguments[ 1 ];
    good = good && op.input.takingVectors[ 0 ] === op.takingVectors[ 0 ];
    good = good && op.input.takingVectors[ 1 ] === op.takingVectors[ 1 ];
    good = good && op.input.takingVectorsOnly === op.takingVectorsOnly;

    _.assert
    (
      good,
      () => `Mismatch of routine::${routineName} operation properties\n`
        + `input.definition : ${op.input.definition}\n`
        + `input.takingArguments : ${op.input.takingArguments.join( ' ' )}   op.takingArguments : ${op.takingArguments.join( ' ' )}\n`
        + `input.takingVectors : ${op.input.takingVectors.join( ' ' )}   op.takingVectors : ${op.takingVectors.join( ' ' )}\n`
        + `input.takingVectorsOnly : ${op.input.takingVectorsOnly}   op.takingVectorsOnly : ${op.takingVectorsOnly}\n`
    );
  }

}

//

function _routinesDeclare()
{

  this.declareHomogeneousTakingVectorsRoutines();
  this.declareHomogeneousTakingScalarRoutines();

  this.routinesHomogeneousDeclare();
  this.routinesHeterogeneousDeclare();
  this.declareReducingRoutines();

  this.declareHomogeneousLogical2Routines();
  this.declareLogic1Routines();

  // this.declareZippingRoutines();

}

//

function _staticRoutinesDeclare()
{

  _.assert( _.objectIs( _.vectorAdapter._routinesFrom ) );

  for( let name in _.vectorAdapter._routinesFrom )
  {
    let routine = _.vectorAdapter._routinesFrom[ name ];
    let nameInObject = name[ 0 ].toUpperCase() + name.substring( 1 );
    this._staticRoutineDeclare( routine, nameInObject, name );
  }

}

//

function _staticRoutineDeclare( routine, nameInObject, nameInNamespace )
{

  let wrap =
  {
    [ nameInObject ] : function()
    {
      return this.vectorAdapter[ nameInNamespace ]( ... arguments );
    }
  }

  _.assert( _.VectorAdapter[ nameInObject ] === undefined );
  _.VectorAdapter[ nameInObject ] = wrap[ nameInObject ];
  _.assert( _.VectorAdapter.prototype[ nameInObject ] === undefined );
  _.VectorAdapter.prototype[ nameInObject ] = wrap[ nameInObject ];

}

//

function _methodWrapDeclare( routine, r )
{
  let op = routine.operation;

  // if( r === 'allZero' )
  // debugger;
  // if( r === 'allZero' )
  // debugger;
  // if( r === 'toStr' )
  // debugger;
  // if( !op.input )
  // debugger;
  // if( !op.input )
  // logger.log( `Routine::${r} does not have defined input` );

  // input : [ 'vr|s' ]
  let firstCouldBeVector = false;
  // debugger;
  if( op.input && op.input.args.length )
  firstCouldBeVector = _.longHas( op.input.args[ 0 ].types, 'v' )
  if( op.takingVectors[ 0 ] <= 0 && !firstCouldBeVector )
  return false;
  if( op.takingVectors[ 1 ] <= 0 )
  return false;

  _.assert( _.VectorAdapter.prototype[ r ] === undefined, () => `VectorAdapter already has method::${r} defined` );

  _.VectorAdapter.prototype[ r ] = function wrap()
  {
    // _.assert( arguments.length >= 1 );
    _.assert( _.vectorAdapterIs( this ) );
    return routine.call( this.vectorAdapter, this, ... arguments );
  }

  return _.VectorAdapter.prototype[ r ];
}

// //
//
// function methodSingleArgumentDeclare( routine, r )
// {
//   let op = routine.operation;
//
//   let absLike = op.returningOnly === 'self' && op.modifying && op.atomWise && op.homogeneous;
//   let reduceToScalarLike = op.returningOnly === 'atomic' && !op.modifying && op.atomWise && op.homogeneous;
//
//   let singleArgument = _.longIdentical( op.takingArguments, [ 1, 1 ] );
//   let singleVector = op.takingVectors[ 1 ] === 1;
//
//   let oneOrTwoArguments = _.longIdentical( op.takingArguments, [ 1, 2 ] );
//   let oneOrInfinity = _.longIdentical( op.takingArguments, [ 1, Infinity ] );
//
//   let doesFit = ( singleArgument && singleVector ) || ( absLike && oneOrTwoArguments ) || ( reduceToScalarLike && ( singleArgument || oneOrInfinity ) );
//
//   if( !doesFit )
//   return false;
//
//   _.assert( _.VectorAdapter.prototype[ r ] === undefined );
//
//   _.VectorAdapter.prototype[ r ] = function singleArgumentRoutine()
//   {
//     _.assert( arguments.length === 0, 'Expects no arguments' );
//     _.assert( _.vectorAdapterIs( this ) );
//     return routine.call( _.vectorAdapter, this );
//   }
//
// }
//
// //
//
// function methodTwoArgumentsDeclare( routine, r )
// {
//   let op = routine.operation;
//
//   if( !_.longIdentical( op.takingArguments , [ 2, 2 ] ) )
//   return false;
//
//   // if( !_.longIdentical( op.takingVectors , [ 1, 1 ] ) )
//   if( !_.longIdentical( op.takingVectors , [ 1, 1 ] ) && !_.longIdentical( op.takingVectors , [ 0, 1 ] ) )
//   return false;
//
//   _.assert( _.VectorAdapter.prototype[ r ] === undefined );
//
//   _.VectorAdapter.prototype[ r ] = function wrap( scalar )
//   {
//     _.assert( arguments.length === 1, 'Expects single argument' );
//     _.assert( _.vectorAdapterIs( this ) );
//     return routine.call( _.vectorAdapter, this, scalar );
//   }
//
// }

//

function _methodsDeclare()
{

  let routines = _.vectorAdapter._routinesMathematical;
  for( let r in routines )
  {
    let routine = routines[ r ];

    _.assert( _.routineIs( routine ) );

    this._methodWrapDeclare( routine, r );
    // this.methodSingleArgumentDeclare( routine , r );
    // this.methodTwoArgumentsDeclare( routine , r );

  }

}

//

function _containerTypeDeclare()
{
  let type = Object.create( null );

  type.name = 'VectorAdapter';
  type._elementGet = function _elementGet( container, key )
  {
    return container.eGet( key );
  }
  type._elementSet = function _elementSet( container, key, val )
  {
    return container.eSet( key, val );
  }
  type._is = function _is( src )
  {
    return _.vectorAdapterIs( src );
  }
  type._while = function _while( container, onEach )
  {
    let l = container.length;
    _.assert( _.routineIs( container.eGet ) );
    for( let i = 0 ; i < l ; i++ )
    {
      let r = onEach( container.eGet( i ), i, container );
      if( !r )
      return false;
    }
    return true;
  }

  return _.container.typeDeclare( type );
}

//

function _adapterClassDeclare()
{
  this._methodsDeclare();
  this._staticRoutinesDeclare();
  this._containerTypeDeclare();
}

//

function _onAtomGenBegin( dop )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  // _.assert( _.arrayIs( dop.input ) );
  _.assert( _.mapIs( dop.input ) );
  _.assert( _.routineIs( dop.onAtom ) || _.arrayIs( dop.onAtom ) );

}

//

function _onAtomGenEnd( dop, onAtom )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  onAtom.own = { onAtom : dop.onAtom };

  if( _.routineIs( dop.onAtom ) )
  dop.onAtom = [ dop.onAtom ];
  dop.onAtom.unshift( onAtom );

}

//

function _onAtomForRoutine_functor( dop )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !dop.onAtom_functor );

  let handleAtom = null;
  let onAtom0 = dop.onAtom[ 0 ];

  _.assert( _.routineIs( onAtom0 ) );
  _.assert( dop.onAtom.length === 1 );

  _onAtomGenBegin( dop );

  // debugger;
  // if( _.longIdentical( dop.input , [ 'vw', '+vr' ] ) || _.longIdentical( dop.input , [ 'vw', '*vr' ] ) )
  if( dop.input.definition === 'vw +vr' || dop.input.definition === 'vw *vr' )
  {

    handleAtom = function handleAtom( o )
    {

      for( let a = 0 ; a < o.srcContainers.length ; a++ )
      {
        let src = o.srcContainers[ a ];
        o.srcContainer = src;
        o.srcContainerIndex = a;
        o.srcElement = src.eGet( o.key );

        let r = onAtom0.call( this, o );
        _.assert( r === undefined );
      }

      o.dstContainer.eSet( o.key, o.dstElement );

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
  // else if( _.longIdentical( dop.input , [ 'vw', 's' ] ) || _.longIdentical( dop.input , [ 'vw|s', 's' ] ) )
  else if( dop.input.definition === 'vw s' || dop.input.definition === 'vw|s s' )
  {

    /* xxx : move out subroutines */

    // let allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s', 's|' ] );
    // debugger;
    // let allowingDstScalar = _.strHasAny( dop.input[ 0 ].definition , [ '|s', 's|' ] );
    let allowingDstScalar = _.strHasAny( dop.input.args[ 0 ].definition , 's' );

    handleAtom;
    if( allowingDstScalar )
    handleAtom = function handleAtom( o )
    {
      let r = onAtom0.call( this, o );
      _.assert( r === undefined );
      _.assert( _.numberIs( o.dstElement ) );
      if( !_.numberIs( o.dstContainer ) )
      o.dstContainer.eSet( o.key, o.dstElement );
    }
    else
    handleAtom = function handleAtom( o )
    {
      let r = onAtom0.call( this, o );
      _.assert( r === undefined );
      _.assert( _.numberIs( o.dstElement ) );
      o.dstContainer.eSet( o.key, o.dstElement );
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
  else _.assert( 0, `Unknown kind of input ${dop.input.definition}` );

  _onAtomGenEnd( dop, handleAtom );

  return handleAtom;
}

//

function _vectorizeDst( o, dop )
{

  let dst = o.dstContainer;

  o.unwrapping = 0;

  if( dst === undefined )
  return dst;

  if( !_.primitiveIs( dst ) )
  return dst;

  /* */

  for( let a = 0 ; a < o.args.length ; a++ )
  {
    let src = o.args[ a ];

    if( _.vectorAdapterIs( src ) )
    {
      if( dst === null )
      {
        o.dstContainer = this.vectorAdapter.makeSimilar( src );
        o.dstContainer.assign( o.args[ 1 ] );
        dst = o.dstContainer;
      }
      else
      {
        o.dstContainer = this.vectorAdapter.makeSimilar( src );
        o.dstContainer.assign( dst );
        dst = o.dstContainer;
      }
      o.args[ 0 ] = dst;
      _.assert( _.vectorAdapterIs( dst ) );
      return dst;
    }

  }

  /* */

  if( !_.vectorAdapterIs( dst ) )
  {
    if( dst === null )
    {
      if( dop.returningBoolean )
      dst = o.dstContainer = this.vectorAdapter.withDefaultLong.Array.makeFilling( 1 , false );
      else
      dst = o.dstContainer = this.vectorAdapter.makeFilling( 1 , 0 );
      o.dstContainer.assign( o.args[ 1 ] );
    }
    else
    {
      if( dop.returningBoolean )
      dst = o.dstContainer = this.vectorAdapter.withDefaultLong.Array.makeFilling( 1 , dst );
      else
      dst = o.dstContainer = this.vectorAdapter.makeFilling( 1 , dst );
    }
    o.unwrapping = 1;
    o.args[ 0 ] = dst;
  }

  return dst;
}

//

function _vectorizeSrcs( o, first )
{

  if( _.vectorAdapterIs( o.dstContainer ) )
  for( let a = first ; a < o.args.length ; a++ )
  {
    let src = o.args[ a ];

    // yyy
    if( !_.routineIs( src ) )
    {
      src = o.args[ a ] = this.vectorAdapter.fromMaybeNumber( src, o.dstContainer.length );
    }

  }

}

//

function _vectorsCallBegin( o, dop )
{
  let meta = this;

  let minimalCall = o.args.length === dop.takingArguments[ 0 ];
  let dstProvided = !_.primitiveIs( o.dstContainer );
  let dstIsNumber = _.numberIs( o.dstContainer );

  if( Config.debug )
  {
    _.assert(  _.vectorAdapterIs( o.dstContainer ) || o.dstContainer === null || _.numberIs( o.dstContainer ) || _.boolIs( o.dstContainer ) );
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
    o.dstContainer = this.vectorAdapter.makeSimilar( o.dstContainer );
  }

  /* */

  let dst = meta._vectorizeDst( o, dop );
  meta._vectorizeSrcs( o, 1 );

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
    _.assert( _.vectorAdapterIs( dst ) || _.numberIs( dst ) );
    _.assert( dop.takingArguments[ 0 ] <= o.args.length && o.args.length <= dop.takingArguments[ 1 ], 'Expects ', dop.takingArguments, ' arguments' );
    for( let a = 0 ; a < o.args.length ; a++ )
    {
      let src = o.args[ a ];
      // _.assert( _.vectorAdapterIs( src ) || _.numberIs( src ) || typeof( src ) === 'function' );
      // _.assert( _.numberIs( src )  || typeof( src ) === 'function' || dst.length === src.length, 'src and dst should have same length' );
      _.assert( _.vectorAdapterIs( src ) || _.numberIs( src ) );
      _.assert( _.numberIs( src ) || dst.length === src.length, 'src and dst should have same length' );
    }
  }

}

//

function _vectorsCallEnd( o, dop )
{
  let result;

  // debugger;

  if( dop.reducing )
  o.result = o.dstElement;
  else if( o.unwrapping )
  o.result = o.dstContainer.eGet( 0 );
  else
  o.result = o.dstContainer;

  if( dop.onVectorsEnd.length )
  dop.onVectorsEnd[ 0 ]( o, dop );

  return o.result;
}

//

function _vectorsGenBegin( dop )
{
  let meta = this;

  if( _.routineIs( dop.onAtom ) )
  dop.onAtom = [ dop.onAtom ];

  let takingArguments = dop.takingArguments;
  let onAtom = dop.onAtom[ 0 ];

  _.assert( arguments.length === 1, 'Expects single argument' );
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

function _vectorsGenEnd( dop, onVectors, onVectorsBegin )
{

  let takingArguments = dop.takingArguments;
  let onAtom = dop.onAtom[ 0 ];

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.arrayIs( dop.onVectors ) && dop.onVectors.length === 0 );
  _.assert( _.routineIs( onAtom ) );
  _.assert( dop.onAtom.length > 1 );
  _.assert( _.routineIs( onVectors ) );
  _.assert( _.routineIs( onVectorsBegin ) );
  _.assert( _.routineIs( dop.generator ) );

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
  let meta = this;

  meta._vectorsGenBegin( dop );

  let takingArguments = dop.takingArguments;
  let onVectors = null;
  let onVectorsBegin = null;
  let onVectorsBegin0 = dop.onVectorsBegin[ 0 ];
  let onAtom0 = dop.onAtom[ 0 ];

  // _.assert( dop.onVectorsBegin.length === 1, 'not tested' );
  // _.assert( dop.onAtom.length === 1, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  /* */

  // if( _.longIdentical( dop.input , [ 'vw', '+vr' ] ) || _.longIdentical( dop.input , [ 'vw', '*vr' ] ) ) //
  if( dop.input.definition === 'vw +vr' || dop.input.definition === 'vw *vr' )
  {

    onVectorsBegin = vonlyVectorsBegin;
    onVectors = vonlyVectors;

    onVectors.own = { onAtom : onAtom0 };
    onVectors.operation = dop;
    dop.takingArguments = takingArguments;
    dop.takingVectors = takingArguments;
    dop.takingVectorsOnly = true;
    dop.homogeneous = true;
    dop.atomWise = true;
    dop.returningSelf = true;
    dop.returningNew = false;
    dop.returningLong = false;
    dop.modifying = true;
    // dop.operation = dop; /* yyy */

    _.assert( dop.takingVectorsOnly === true );
    _.assert( takingArguments[ 0 ] > 0 && takingArguments[ 1 ] === Infinity );

  }
  // else if( _.longIdentical( dop.input , [ 'vw', 's' ] ) || _.longIdentical( dop.input , [ 'vw|s', 's' ] ) ) //
  else if( dop.input.definition === 'vw s' || dop.input.definition === 'vw|s s' )
  {

    // let allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s', 's|' ] );
    // debugger;
    // let allowingDstScalar = _.strHasAny( dop.input.args[ 0 ].definition , [ '|s', 's|' ] );
    let allowingDstScalar = _.strHasAny( dop.input.args[ 0 ].definition , 's' );

    onVectorsBegin = vsVectorsBegin;
    onVectors = vsVectors_functor( allowingDstScalar );

    onVectors.own = { onAtom : onAtom0 };
    onVectors.operation = dop;
    dop.takingArguments = [ 2, 2 ];
    if( !dop.takingVectors )
    dop.takingVectors = [ 1, 1 ];
    else
    dop.takingVectors[ 1 ] = 1;
    dop.takingVectorsOnly = false;
    dop.homogeneous = true;
    dop.atomWise = true;
    dop.returningSelf = true;
    dop.returningNew = false;
    dop.returningLong = false;
    dop.returningNumber = true;
    dop.returningPrimitive = true;
    dop.modifying = true;
    // dop.operation = dop; /* yyy */

    _.assert( takingArguments[ 0 ] === 2 && takingArguments[ 1 ] === 2 );
    _.assert( dop.takingVectorsOnly === false );

  }
  else _.assert( 0, 'unknown kind of input', dop.input );

  /* */

  meta._vectorsGenEnd( dop, onVectors, onVectorsBegin );

  return onVectors;

  /* */

  function vonlyVectorsBegin( dst, src )
  {

    dst = arguments[ 0 ];

    let o = Object.create( null );
    o.key = -1;
    o.args = arguments;
    o.result = null;
    o.dstElement = null;
    o.dstContainer = dst;
    o.srcElement = null;
    o.srcContainer = dst;
    o.srcContainerIndex = -1;
    o.srcContainers = _.longSlice( arguments, 1, arguments.length );
    Object.preventExtensions( o );

    if( onVectorsBegin0 )
    onVectorsBegin0( o );

    return o;
  }

  /* */

  function vonlyVectors()
  {

    let dst = arguments[ 0 ];

    let o = onVectorsBegin.apply( this, arguments );

    /* */

    if( Config.debug )
    {
      _.assert( _.vectorAdapterIs( dst ) );
      _.assert( arguments.length >= 1, 'Expects at least one argument' );
      _.assert( takingArguments[ 0 ] <= arguments.length && arguments.length <= takingArguments[ 1 ], 'Expects ', takingArguments, ' arguments' );
      for( let a = 0 ; a < o.srcContainers.length ; a++ )
      {
        let src = o.srcContainers[ a ];
        _.assert( _.vectorAdapterIs( src ) );
        _.assert( dst.length === src.length, 'src and dst should have same length' );
      }
    }

    /* */

    for( let k = 0 ; k < dst.length ; k++ )
    {
      o.key = k;
      o.dstElement = dst.eGet( k );
      onAtom0.call( this, o );
    }

    return dst;
  }

  /* */

  function vsVectorsBegin( dst, src )
  {

    let o = Object.create( null );
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

  /* */

  function vsVectors_functor( allowingDstScalar )
  {

    return function vsVectors( dst, src )
    {

      if( Config.debug )
      {
        _.assert( arguments.length === 2, 'Expects 2 arguments' );
        if( allowingDstScalar )
        _.assert( _.vectorAdapterIs( dst ) || _.numberIs( dst ) );
        else
        _.assert( _.vectorAdapterIs( dst ) );
        _.assert( _.numberIs( src ) );
      }

      /* */

      let o = onVectorsBegin.apply( this, arguments );

      if( allowingDstScalar && _.numberIs( dst ) )
      {
        o.key = 0;
        o.dstElement = dst;
        onAtom0.call( this, o );
        dst = o.dstElement;
      }
      else
      for( let k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        o.dstElement = dst.eGet( k );
        onAtom0.call( this, o );
      }

      return dst;
    }

  }

  /* */

}

//

/*
  addScalar
  input : [ 'vw', 's' ],

  addVectorScaled
  input : [ 'vw', 'vr|2*s' ],

  addVectors
  input : [ 'vw', '+vr' ],

  clamp
  input : [ 'vw', 'vr|3*s' ],

  mix
  input : [ 'vw', 'vr|3*s' ],
*/

function _routineForOperation_functor( dop )
{

  if( _.routineIs( dop ) )
  debugger;

  if( _.routineIs( dop ) )
  dop = _.mapExtend( null, { onAtom : dop } );
  else
  dop = _.mapExtend( null, dop );

  let onAtom = dop.onAtom[ 0 ];

  if( dop.takingArguments === undefined )
  dop.takingArguments = onAtom.takingArguments;

  dop.generator = _routineForOperation_functor;

  /* */

  _.assertMapHasOnly( dop, _routineForOperation_functor.defaults );
  _.assert( _.objectIs( dop.atomOperation ) );
  _.assert( _.routineIs( onAtom ) );
  _.assert( dop.onAtom.length === 1 );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayIs( dop.input ) || _.strIs( dop.input ) || _.mapIs( dop.input ) );
  _.assert( _.strDefined( dop.name ) );
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

  this.operationNormalizeInput( dop );
  this.operationNormalizeArity( dop );

  // dop.inputWithoutLast = dop.input.args.slice( 0, dop.input.args.length-1 );
  // dop.inputLast = dop.input.args[ dop.input.args.length-1 ];

  /* */

  if( dop.onAtom_functor )
  {
    dop.onAtom_functor.call( this, dop );
    delete dop.onAtom_functor;
  }
  else
  {
    _onAtomForRoutine_functor( dop );
  }

  /* */

  if( dop.onVectors_functor )
  {
    dop.onVectors_functor.call( this, dop );
    delete dop.onVectors_functor;
  }
  else
  {
    this._onVectorsForRoutine_functor( dop );
  }

  /* */

  _.assert( _.arrayIs( dop.takingArguments ) );
  _.assert( _.routineIs( dop.onVectors[ 0 ] ) );
  _.assert( _.arrayIs( dop.takingArguments ) );

  _.assert( dop.handleAtom === undefined );
  _.assert( dop.handleVector === undefined );
  _.assert( dop.handleVectors === undefined );
  _.assert( dop.handleBegin === undefined );
  _.assert( dop.handleEnd === undefined );

  // if( dop.name === 'addVectors' )
  // debugger;

  return dop.onVectors[ 0 ];
}

_routineForOperation_functor.defaults =
{
  ... OperationDescriptor1.fields,
  onAtom_functor : null,
  onVectors_functor : null,
}

// --
// atom-wise, modifying, taking single vector : self
// --

function _operationTakingDstSrcReturningSelfComponentWise_functor( o )
{

  _.routineOptions( _operationTakingDstSrcReturningSelfComponentWise_functor, o );

  let onEach = o.onEach;
  let onVectorsBegin0 = o.onVectorsBegin || function(){};
  let onVectorsEnd0 = o.onVectorsEnd || function(){};

  _.assert( _.routineIs( onEach ) );
  _.assert( _.routineIs( onVectorsBegin0 ) );
  _.assert( _.routineIs( onVectorsEnd0 ) );
  _.assert( arguments.length === 1 );

  let routine = _operationTakingDstSrcReturningSelfComponentWise;

  let dop = routine.operation = Object.create( null );
  dop.atomWise = true;
  dop.homogeneous = true;
  dop.takingArguments = [ 1, 2 ];
  dop.takingVectors = [ 1, 2 ];
  dop.takingVectorsOnly = true;
  dop.returningSelf = true;
  dop.returningNew = false;
  dop.returningLong = false;
  dop.modifying = true;
  dop.input = 'vw|n ?vr';

  return routine;

  function _operationTakingDstSrcReturningSelfComponentWise( dst, src )
  {

    let length = dst.length;
    if( !src )
    src = dst;

    if( dst === null ) /* qqq : cover. ask if not clear */
    dst = src.makeSimilar();

    _.assert( arguments.length <= 2 );
    _.assert( dst.length === src.length, 'src and dst must have same length' );

    onVectorsBegin0.call( this, dst, src );

    for( let i = 0 ; i < length ; i++ )
    onEach.call( this, dst, src, i );

    onVectorsEnd0.call( this, dst, src );

    return dst;
  }

}

_operationTakingDstSrcReturningSelfComponentWise_functor.defaults =
{
  onEach : null,
  onVectorsBegin : null,
  onVectorsEnd : null,
}

// --
// float / vector
// --

function _operationReturningSelfTakingVariantsComponentWise_functor( operation )
{
  let result = Object.create( null );

  _.assert( operation.assigning === undefined );
  _.assert( _.strIs( operation.input ) );

  let operationForFunctor = _.mapExtend( null, operation );
  operationForFunctor.assigning = 1;
  result.assigning = this._operationReturningSelfTakingVariantsComponentWiseAct_functor( operationForFunctor );

  operationForFunctor = _.mapExtend( null, operation );
  operationForFunctor.assigning = 0;
  result.copying = this._operationReturningSelfTakingVariantsComponentWiseAct_functor( operationForFunctor );

  return result;
}

_operationReturningSelfTakingVariantsComponentWise_functor.defaults =
{
  takingArguments : null,
  homogenous : 0,
  input : null,
  onEach : null,
  onVectorsBegin : function(){},
  onVectorsEnd : function(){},
  onMakeIdentity : function(){},
}

//

function _operationReturningSelfTakingVariantsComponentWiseAct_functor( operation )
{

  _.routineOptions( _operationReturningSelfTakingVariantsComponentWiseAct_functor, operation );
  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( operation ) );
  _.assert( _.routineIs( operation.onEach ) );
  _.assert( _.routineIs( operation.onVectorsBegin ) );
  _.assert( _.routineIs( operation.onVectorsEnd ) );
  _.assert( _.arrayIs( operation.takingArguments ) );
  _.assert( _.strIs( operation.input ) );

  let onVectorsBegin = operation.onVectorsBegin;
  let onEach = operation.onEach;
  let onVectorsEnd = operation.onVectorsEnd;
  let onMakeIdentity = operation.onMakeIdentity;
  let takingArguments = operation.takingArguments;
  let homogenous = operation.homogenous;

  /* */

  let routine = _operationReturningSelfTakingVariantsComponentWise;
  let dop = routine.operation = Object.create( null );
  dop.takingArguments = takingArguments;
  dop.takingVectors = [ 1, takingArguments[ 1 ] ];
  dop.takingVectorsOnly = false;
  dop.returningSelf = false;
  dop.returningNew = true;
  dop.modifying = true;
  dop.input = operation.input;

  return routine;

  function variants( variants )
  {
    let result = _.longSlice( variants );
    let length;

    debugger;

    _.assert( arguments.length === 1, 'Expects single argument' );
    _.longIs( variants );

    /* */

    for( let v = 0 ; v < result.length ; v++ )
    {
      let variant = result[ v ];

      _.assert( _.numberIs( variant ) || _.longIs( variant ) || _.vectorAdapterIs( variant ) );

      if( _.numberIs( variant ) )
      continue;

      if( length !== undefined )
      _.assert( variant.length === length, 'all variants should have same length' );

      length = variant.length;

    }

    if( length === undefined )
    length = 1;

    /* */

    for( let v = 0 ; v < result.length ; v++ )
    {
      let variant = result[ v ];

      if( _.vectorAdapterIs( variant ) )
      continue;

      if( _.longIs( variant ) )
      variant = result[ v ] = _.vectorAdapter.fromLong( variant );
      else
      variant = result[ v ] = _.vectorAdapter.fromMaybeNumber( variant, length );

    }

    /* */

    return result;
  }

  function _operationReturningSelfTakingVariantsComponentWise( dst )
  {

    if( operation.assigning )
    _.assert( _.vectorAdapterIs( dst ) );

    let args = variants( arguments );

    debugger;
    if( !operation.assigning )
    {
      debugger;
      dst = _.vectorAdapter.fromLong( this./*makeArrayOfLength*/MakeZeroed( args[ 0 ].length ) );
      args.unshift( dst );
      onMakeIdentity.call( args, dst );
    }

    let length = dst.length;
    _.assert( takingArguments[ 0 ] <= args.length && args.length <= takingArguments[ 1 ], args.length, operation.assigning );
    _.assert( _.vectorAdapterIs( dst ) );

    onVectorsBegin.apply( args, args, length );

    if( homogenous )
    {

      for( let i = 0 ; i < length ; i++ )
      {
        for( let a = 1 ; a < args.length ; a++ )
        {
          onEach.call( args, dst, args[ a ], i );
        }
      }

    }
    else
    {
      args.push( 0 );

      for( let i = 0 ; i < length ; i++ )
      {
        args[ args.length-1 ] = i;
        onEach.apply( args, args );
      }

    }

    onVectorsEnd.apply( args, args, length );

    return dst;
  }
}

_operationReturningSelfTakingVariantsComponentWiseAct_functor.defaults =
{
  ... _operationReturningSelfTakingVariantsComponentWise_functor.defaults,
  assigning : 0,
}

// --
// atom-wise, homogeneous, taking vectors
// --

function declareHomogeneousTakingVectorsRoutines()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  for( let _routineName in operations.atomWiseHomogeneous )
  {

    let atomOperation = operations.atomWiseHomogeneous[ _routineName ];
    let routineName = _routineName + ( atomOperation.postfix !== undefined && atomOperation.postfix !== null ? atomOperation.postfix : 'Vectors' );
    let operation = this.operationSupplement( null, atomOperation );

    _.assert( operation.atomOperation === undefined );
    _.assert( _.strDefined( operation.name ) );
    _.assert( _.routineIs( atomOperation.onAtom ) );
    _.assert( !routines[ routineName ] );

    // if( routineName === 'addVectors' )
    // debugger;

    operation.atomOperation = atomOperation;

    if( !operation.takingArguments )
    operation.takingArguments = [ 2, Infinity ];
    else
    operation.takingArguments[ 1 ] = Infinity;

    if( operation.takingArguments[ 0 ] === 1 )
    operation.input = [ 'vw', '*vr' ];
    else if( operation.takingArguments[ 0 ] > 1 )
    operation.input = [ 'vw', '+vr' ];
    else _.assert( 0, 'unexpected' );

    operation.name = routineName;

    routines[ routineName ] = this._routineForOperation_functor( operation );

  }

  _.assert( _.routineIs( routines.addVectors ) );

}

// declareHomogeneousTakingVectorsRoutines();

// --
// atom-wise, commutatuve, taking scalar
// --

function declareHomogeneousTakingScalarRoutines()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  for( let _routineName in operations.atomWiseHomogeneous )
  {
    let routineName = _routineName + 'Scalar';
    let atomOperation = operations.atomWiseHomogeneous[ _routineName ];
    let operation = this.operationSupplement( null, atomOperation );

    _.assert( operation.atomOperation === undefined );
    _.assert( _.strDefined( operation.name ) );
    _.assert( _.routineIs( atomOperation.onAtom ) );
    _.assert( !routines[ routineName ] );

    operation.atomOperation = atomOperation;
    operation.input = [ 'vw|s', 's' ];
    operation.takingArguments = [ 2, 2 ];
    operation.name = routineName;

    routines[ routineName ] = this._routineForOperation_functor( operation );

  }

  _.assert( _.routineIs( routines.addScalar ) );
  _.assert( routines.addScalar.operation.onAtom.length >= 2 );

}

// declareHomogeneousTakingScalarRoutines();

// --
// atom-wise
// --

function _onAtomAtomwise_functor( dop )
{

  let onAtom0 = dop.onAtom[ 0 ];
  let onContinue = dop.onContinue[ 0 ];
  let handleAtom = null;

  _.assert( !dop.interruptible || _.routineIs( onContinue ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayIs( dop.onContinue ) );
  _.assert( _.routineIs( onAtom0 ) );
  _.assert( _.routineIs( onContinue ) || !onContinue );
  _.assert( _.rangeIs( dop.takingArguments ) );
  _.assert( _.rangeIs( dop.takingVectors ) );
  _.assert( dop.onAtom.length === 1 );
  _onAtomGenBegin( dop );

  if( dop.homogeneous === false )
  {

    handleAtom = function handleAtom( o )
    {

      for( let a = 0 ; a < o.srcContainers.length ; a++ )
      {
        let src = o.srcContainers[ a ];
        o.srcElements[ a ] = src.eGet( o.key );
      }

      let r = onAtom0.call( this, o );
      _.assert( r === undefined );
      o.dstContainer.eSet( o.key, o.dstElement );

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

      let r = onAtom0.call( this, o );
      _.assert( r === undefined );

      if( !dop.reducing )
      o.dstContainer.eSet( o.key , o.dstElement );

      if( dop.interruptible )
      {
        r = onContinue.call( this, o );
        _.assert( r === undefined || r === false );
      }

      if( r === false )
      return false;

    }

    else if( dop.interruptible )
    handleAtom = function handleAtom( o )
    {

      o.dstElement = o.srcContainers[ 0 ].eGet( o.key );

      for( let a = 1 ; a < o.srcContainers.length ; a++ )
      {
        let src = o.srcContainers[ a ];

        //if( typeof( o.srcContainers[ 1 ] ) !== 'function' )
        o.srcElement = src.eGet( o.key );

        let r = onAtom0.call( this, o );
        _.assert( r === undefined );

        r = onContinue.call( this, o );
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

      for( let a = 1 ; a < o.srcContainers.length ; a++ )
      {
        let src = o.srcContainers[ a ];

        //if( typeof( o.srcContainers[ 1 ] ) !== 'function' )
        o.srcElement = src.eGet( o.key );

        let r = onAtom0.call( this, o );
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
  else _.assert( 0, 'unknown kind of input', dop.input );

  _onAtomGenEnd( dop, handleAtom );

  return handleAtom;
}

//

function _onVectorsAtomwise_functor( dop )
{
  let meta = this;

  meta._vectorsGenBegin( dop );

  let takingArguments = dop.takingArguments;
  let onVectors = null;
  let onVectorsBegin = null;
  let onVectorsBegin0 = dop.onVectorsBegin[ 0 ];
  let onAtom0 = dop.onAtom[ 0 ];

  _.assert( arguments.length === 1, 'Expects single argument' );

  /* */

  if( dop.homogeneous === false )
  {

    // debugger;
    // let allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s', 's|' ] );
    // let allowingDstScalar = _.strHasAny( dop.input.args[ 0 ].definition , [ '|s', 's|' ] );
    let allowingDstScalar = _.strHasAny( dop.input.args[ 0 ].definition , 's' );

    onVectorsBegin = heterogenousVectorsBegin;
    onVectors = heterogenousVectors;

    dop.takingArguments = takingArguments;
    if( _.nothingIs( dop.takingVectors ) )
    dop.takingVectors = [ 1, takingArguments[ 1 ] ];

    let def =
    {
      takingVectorsOnly : false,
      homogeneous : false,
      atomWise : true,
      returningSelf : true,
      returningNew : true,
      returningLong : false,
      modifying : true,
    }

    _.mapSupplementNulls( dop, def );
    _.assert( takingArguments[ 0 ] >= 2 && takingArguments[ 1 ] >= 2 );

  }
  else if( dop.homogeneous === true )
  {

    // debugger; /* xxx : move out routines */

    onVectorsBegin = homogenousVectorsBegin;

    if( dop.interruptible )
    onVectors = homogenousInterruptibleVectors;
    else
    onVectors = homogenousUninterruptibleVectors;

    /* */

    dop.takingArguments = takingArguments;
    if( _.nothingIs( dop.takingVectors ) )
    dop.takingVectors = [ 1, takingArguments[ 1 ] ];

    let def =
    {
      takingVectorsOnly : false,
      homogeneous : true,
      atomWise : true,
      returningSelf : true,
      returningNew : true,
      returningLong : false,
      modifying : true,
    }

    _.mapSupplementNulls( dop, def );
    // _.assert( takingArguments[ 0 ] === 2 && takingArguments[ 1 ] >= 2 );

  }
  else _.assert( 0, 'unknown kind of input', dop.input );

  /* */

  meta._vectorsGenEnd( dop, onVectors, onVectorsBegin );

  return onVectors;

  /* */

  function heterogenousVectorsBegin( dst )
  {

    let o = Object.create( null );
    o.key = -1;
    o.args = _.longSlice( arguments );;
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

  /* */

  function heterogenousVectors( dst )
  {
    let o = onVectorsBegin.apply( this, arguments );
    meta._vectorsCallBegin( o, dop );

    /* */

    _.assert( takingArguments[ 0 ]-1 <= o.srcContainers.length && o.srcContainers.length <= takingArguments[ 1 ] );

    dst = o.dstContainer;
    for( let k = 0 ; k < dst.length ; k++ )
    {
      o.key = k;
      o.dstElement = dst.eGet( k );
      onAtom0.call( this, o );
    }

    /* */

    return _vectorsCallEnd( o, dop );
  }

  /* */

  function homogenousVectorsBegin( dst )
  {

    let o = Object.create( null );
    o.dstElement = null;
    o.dstContainer = dst;
    o.srcContainers = null;
    o.srcElement = null;
    o.key = -1;
    o.args = _.longSlice( arguments, 0, arguments.length );
    o.unwrapping = 0;
    // o.onEvaluate = arguments[ 1 ]; /* yyy */
    o.result = null;
    Object.preventExtensions( o );

    if( onVectorsBegin0 )
    debugger;

    if( onVectorsBegin0 )
    onVectorsBegin0( o );

    return o;
  }

  /* */

  function homogenousInterruptibleVectors( dst )
  {
    let o = onVectorsBegin.apply( this, arguments );

    meta._vectorsCallBegin( o, dop );

    dst = o.dstContainer;
    for( let k = 0 ; k < dst.length ; k++ )
    {
      o.key = k;
      let r = onAtom0.call( this, o );
      if( r === false )
      break;
    }

    return _vectorsCallEnd( o, dop );
  }

  /* */

  function homogenousUninterruptibleVectors()
  {
    let dst = arguments[ 0 ];
    let o = onVectorsBegin.apply( this, arguments );

    meta._vectorsCallBegin( o, dop );

    dst = o.dstContainer;
    for( let k = 0 ; k < dst.length ; k++ )
    {
      o.key = k;
      onAtom0.call( this, o );
    }

    return _vectorsCallEnd( o, dop );
  }

  /* */

}

// --
// atom-wise, homogeneous
// --

function _routineHomogeneousDeclare( operation, atomOperation, routineName )
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  operation = this.operationSupplement( operation, atomOperation );

  _.assert( operation.atomOperation === undefined );
  _.assert( _.strDefined( operation.name ) );
  _.assert( _.routineIs( atomOperation.onAtom ) );
  _.assert( !routines[ routineName ], 'routine', routineName, 'is already defined' );

  operation.atomOperation = atomOperation;

  let def =
  {
    // returningNumber : 1,
    returningPrimitive : 1,
    // takingArguments : [ 2, 3 ],
  }

  if( !operation.returningBoolean && !operation.returningNumber )
  operation.returningNumber = true;

  _.mapSupplementNulls( operation, def );

  if( operation.usingExtraSrcs )
  {
    // operation.takingArguments = operation.takingArguments.slice();
    // operation.takingArguments[ 1 ] = Infinity;
    if( !operation.takingArguments )
    operation.takingArguments = [ 2, Infinity ];
    if( !operation.takingVectors )
    operation.takingVectors = [ 0, Infinity ];
  }

  if( !operation.input )
  operation.input = 'vw|s|n vr|s *vr|*s';
  operation.name = routineName;

  operation.onAtom_functor = _onAtomAtomwise_functor;
  operation.onVectors_functor = _onVectorsAtomwise_functor;

  return routines[ routineName ] = this._routineForOperation_functor( operation );
}

//

function _routineHomogeneousDeclare2( operation, atomOperation, routineName )
{

  if( operation === null )
  operation = Object.create( null );

  if( !operation.takingArguments )
  operation.takingArguments = null;
  if( !operation.takingVectors )
  operation.takingVectors = null;

  return this._routineHomogeneousDeclare( operation, atomOperation, routineName );
}

//

function routinesHomogeneousDeclare()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  _.assert( !routines.add );
  _.assert( !routines.assign );
  _.assert( !routines.min );
  _.assert( !routines.max );

  /* */

  for( let routineName in operations.atomWiseHomogeneous )
  {
    let atomOperation = operations.atomWiseHomogeneous[ routineName ];
    _.assert( atomOperation.usingDstAsSrc );
    // if( routineName === 'add' )
    // debugger;
    this._routineHomogeneousDeclare2( null, atomOperation, routineName );
  }

  /* */

  _.assert( _.routineIs( routines.add ) );
  _.assert( routines.add.operation.usingDstAsSrc );
  _.assert( _.longIdentical( routines.add.operation.takingVectors, [ 0, Infinity ] ) );
  _.assert( _.routineIs( routines.min ) );
  _.assert( _.routineIs( routines.max ) );

}

// routinesHomogeneousDeclare();

// --
// atom-wise, heterogeneous
// --

function _routinesHeterogeneousDeclare( atomOperation, routineName )
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  let operation = this.operationSupplement( null, atomOperation );

  _.assert( operation.atomOperation === undefined );
  _.assert( !routines[ routineName ] );
  _.assert( operation.homogeneous === false );

  operation.atomOperation = atomOperation;
  operation.name = routineName;

  operation.onAtom_functor = _onAtomAtomwise_functor;
  operation.onVectors_functor = _onVectorsAtomwise_functor;

  routines[ routineName ] = this._routineForOperation_functor( operation );

}

//

function routinesHeterogeneousDeclare()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  for( let routineName in operations.atomWiseHeterogeneous )
  this._routinesHeterogeneousDeclare( operations.atomWiseHeterogeneous[ routineName ], routineName );

  _.assert( _.routineIs( routines.addScaled ) );

}

// routinesHeterogeneousDeclare();

// --
// reduce to element
// --

function _operationReduceNormalizeFunctions( operationMake, operation )
{

  let atomDefaults = operationMake.atomDefaults;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( atomDefaults ) );

  normalize( 'onAtom' );
  normalize( 'onVectorsBegin' );
  normalize( 'onVectorsEnd' );
  normalize( 'onVectors' );

  return operation;

  /* */

  function normalize( name )
  {
    if( _.routineIs( operation[ name ] ) )
    operation[ name ] = [ operation[ name ] ];
    else if( operation[ name ] === undefined || operation[ name ] === null )
    operation[ name ] = [];
    else if( !_.arrayIs( operation[ name ] ) )
    _.assert( 0, 'unexpected type of operation function', name, _.strType( operation[ name ] ) );

    if( operation[ name ][ 0 ] )
    if( operation[ name ][ 0 ].defaults === atomDefaults )
    operation[ name ].splice( 0, 1 );
  }

}

//

function __operationReduceToScalar_functor( operation )
{
  let atomDefaults = __operationReduceToScalar_functor.atomDefaults;

  this.operationNormalizeInput( operation );
  this.operationNormalizeArity( operation );

  _.routineOptions( __operationReduceToScalar_functor, operation );
  this._operationReduceNormalizeFunctions( __operationReduceToScalar_functor, operation );

  operation.generator = __operationReduceToScalar_functor; /* xxx */

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

  let onAtom0 = operation.onAtom[ 0 ];
  let onAtomsBegin0 = operation.onAtomsBegin[ 0 ];
  let onAtomsEnd0 = operation.onAtomsEnd[ 0 ];
  let onVectorsBegin0 = operation.onVectorsBegin[ 0 ];
  let onVectorsEnd0 = operation.onVectorsEnd[ 0 ];
  let conditional = operation.conditional;
  let takingArguments = operation.takingArguments;
  let takingVectors = operation.takingVectors;

  // if( _.strHas( operation.name, 'mag' ) || _.strHas( operation.name, 'Mag' ) )
  // debugger;

  // if( operation.conditional ) /* yyy */
  // takingArguments[ 1 ] += 1;

  _.assert( takingVectors.length === 2 );
  _.assert( takingArguments.length === 2 );
  _.assert( _.strDefined( operation.name ) );

  _.assert( _.objectIs( operation ) );
  _.assert( operation.onVectors.length === 0 );
  _.assert( _.routineIs( onAtom0 ) );
  _.assert( _.routineIs( onAtomsBegin0 ) );
  _.assert( _.routineIs( onAtomsEnd0 ) );
  _.assert( onAtom0.length === 1 );
  _.assert( onAtomsBegin0.length === 1 );
  _.assert( onAtomsEnd0.length === 1 );

  _.assert( !operation.onVectorsBegin.length, 'not tested' );
  _.assert( !operation.onVectorsEnd.length, 'not tested' );
  _.assert( _.boolLike( operation.interruptible ) );
  _.assert( !!operation.input, () => `Operation of routine::${operation.name} deos not have defined input` );

  /* */

  this.operationNormalizeInput( operation, operation.name );
  _.assert( _.boolIs( operation.input.takingVectorsOnly ) );

  /* */

  onVectorsBegin.defaults = atomDefaults;
  onVectorsBegin.own = { onVectorsBegin : onVectorsBegin };

  onVectorsEnd.defaults = atomDefaults;
  onVectorsEnd.own = { onVectorsEnd : onVectorsEnd };

  /* */

  let onAtom = null;

  if( operation.interruptible )
  onAtom = handleAtomInterruptible;
  else
  onAtom = handleAtom;

  onAtom.defaults = atomDefaults;
  onAtom.own = { onAtom : onAtom };

  /* */

  let routine = null;

  if( operation.interruptible )
  routine = operationReduceInterruptible;
  else
  routine = operationReduce;

  /* */

  operation.onVectorsBegin.unshift( onVectorsBegin );
  operation.onVectorsEnd.unshift( onVectorsEnd );
  operation.onAtom.unshift( onAtom );
  operation.onVectors.unshift( routine );
  // operation.onOperationFunctor = __operationReduceToScalar_functor; /* yyy */

  let operationDefaults =
  {
    takingArguments : [ 0, Infinity ],
    takingVectors : null,
    // takingVectorsOnly : !conditional,
    takingVectorsOnly : operation.input.takingVectorsOnly,
    returningSelf : false,
    returningNew : false,
    returningLong : false,
    returningNumber : ( operation.returningNumber !== undefined && operation.returningNumber !== null ? !!operation.returningNumber : true ),
    returningPrimitive : ( operation.returningPrimitive !== undefined && operation.returningPrimitive !== null ? !!operation.returningPrimitive : true ),
    modifying : false,
    reducing : true,
  }

  _.mapSupplementNulls( operation, operationDefaults );
  routine.operation = operation;
  routine.own =
  {
    onAtom,
    onVectorsBegin,
    onVectorsEnd,
  };

  return routine;

  /* */

  function handleAtomInterruptible( o )
  {

    if( o.filter )
    if( !o.filter.call( this, o.element, o ) )
    return;

    let r = onAtom0.call( this, o );

    _.assert( r === undefined || r === false );
    _.assert( o.result !== undefined );

    return r;
  }

  /* */

  function handleAtom( o )
  {

    if( o.filter )
    if( !o.filter.call( this, o.element, o ) )
    return;

    let r = onAtom0.call( this, o );

    _.assert( r === undefined );
    _.assert( o.result !== undefined );

  }

  /* */

  function operationReduceInterruptible()
  {
    let op = onVectorsBegin({ args : arguments });
    onAtomsBegin0( op );

    for( let a = 0 ; a < op.numberOfArguments ; a++ )
    {

      op.container = arguments[ a ]
      _.assert( _.vectorAdapterIs( op.container ), 'Expects vector' );

      let length = op.container.length;
      for( let key = 0 ; key < length ; key++ )
      {
        op.key = key;
        op.element = op.container.eGet( key );
        let continuing = onAtom.call( this, op );
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

  /* */

  function operationReduce()
  {
    let op = onVectorsBegin({ args : arguments });
    onAtomsBegin0( op );

    for( let a = 0 ; a < op.numberOfArguments ; a++ )
    {

      op.container = arguments[ a ]
      _.assert( _.vectorAdapterIs( op.container ), 'Expects vector' );

      let length = op.container.length;
      for( let key = 0 ; key < length ; key++ )
      {
        op.key = key;
        op.element = op.container.eGet( key );
        onAtom.call( this, op );
      }

    }

    onAtomsEnd0( op );
    return onVectorsEnd( op );
    // return op.result;
  }

  /* */

  function onVectorsEnd( op )
  {
    if( onVectorsEnd0 )
    {
      let r = onVectorsEnd0.call( this, op );
      _.assert( r === undefined );
      _.assert( op.result !== undefined );
    }
    return op.result;
  }

  /* */

  function onVectorsBegin( o )
  {

    _.assert( arguments.length === 1, 'Expects single argument' );

    let op = Object.create( null );
    _.mapExtend( op , atomDefaults );
    Object.preventExtensions( op );

    _.mapExtend( op, o );
    _.assert( !!op.args );

    if( onVectorsBegin0 )
    {
      let r = onVectorsBegin0.call( this, op );
      _.assert( r === undefined );
      _.assert( op.result !== undefined );
    }

    /* */

    if( Config.debug && takingArguments )
    {
      _.assert( takingArguments[ 0 ] <= o.args.length && o.args.length <= takingArguments[ 1 ] );
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

    op.numberOfArguments = _.math.clamp( op.numberOfArguments, takingVectors );

    /* */

    // let r = onAtomsBegin0.call( this, op );
    // _.assert( r === undefined );
    // _.assert( op.result !== undefined );

    return op;
  }

}

__operationReduceToScalar_functor.defaults =
{
  ... OperationDescriptor1.fields,

  onAtom : null,
  onVectorsBegin : null,
  onVectorsEnd : null,
  conditional : null,
  takingArguments : [ 0, Infinity ],
  takingVectors : [ 0, Infinity ],
  reducing : true,
}

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
  let result = Object.create( null );
  let conditional = o.conditional;

  _.assert( _.strDefined( o.name ) );
  _.assert( _.objectIs( o ) );
  _.assertMapHasOnly( o, _operationReduceToScalar_functor.defaults );

  {
    let operation = this.operationSupplement( null, o );
    operation.conditional = false;
    if( operation.input === undefined || operation.input === null )
    operation.input = '+vr';
    result.trivial = this.__operationReduceToScalar_functor( operation );
  }

  {
    let operation = this.operationSupplement( null, o );
    operation.conditional = true;
    operation.name += 'Conditional';
    if( operation.input === undefined || operation.input === null )
    {
      operation.input = '+vr s';
    }
    else
    {
      _.assert( _.strIs( operation.input ) ); /* xxx */
      if( _.strIs( operation.input ) )
      operation.input += ' s';
    }
    result.conditional = this.__operationReduceToScalar_functor( operation );
  }

  return result;
}

_operationReduceToScalar_functor.defaults =
{
  ... __operationReduceToScalar_functor.defaults,
}

//

function declareReducingRoutines()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  for( let routineName in operations.atomWiseReducing )
  {
    let atomOperation = operations.atomWiseReducing[ routineName ];
    let operation = this.operationSupplement( null, atomOperation );

    _.assert( operation.atomOperation === undefined );
    _.assert( _.strDefined( operation.name ) );
    _.assert( _.routineIs( atomOperation.onAtom ) );
    _.assert( !routines[ routineName ] );

    operation.homogeneous = true;
    operation.atomOperation = atomOperation;
    operation.name = routineName;

    if( operation.interruptible === undefined || operation.interruptible === null )
    operation.interruptible = false;

    let r = this._operationReduceToScalar_functor( operation );
    routines[ r.trivial.operation.name ] = r.trivial;
    routines[ r.conditional.operation.name ] = r.conditional;

  }

  _.assert( _.routineIs( routines.reduceToMean ) );
  _.assert( _.routineIs( routines.reduceToMeanConditional ) );

}

// --
// extremal reductor
// --

function _operationReduceToExtremal_functor( operation )
{

  _.routineOptions( _operationReduceToExtremal_functor, operation );
  _.assert( _.strDefined( operation.name ) );
  _.assert( _.objectIs( operation ) );
  _.assert( _.routineIs( operation.onDistance ) );
  _.assert( _.routineIs( operation.onIsGreater ) );
  _.assert( _.numberIs( operation.distanceOnBegin ) );
  _.assert( operation.onDistance.length === 1 );
  _.assert( operation.onIsGreater.length === 2 );

  let onDistance = operation.onDistance;
  let onIsGreater = operation.onIsGreater;
  let distanceOnBegin = operation.distanceOnBegin;
  let valueName = operation.valueName;
  let input = operation.input;

  // if( input === null )
  // input = 'vr !vr';
  if( input === null )
  input = 'vr *vr';

  _.assert( _.strDefined( valueName ) );

  let _gened = this._operationReduceToScalar_functor
  ({
    onAtom : function( o )
    {

      _.assert( o.container.length, 'not tested' );

      let distance = onDistance( o );
      if( onIsGreater( distance, o.result.value ) )
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
    input : input,
    takingVectors : operation.takingVectors,
    returningNumber : false,
    returningPrimitive : false,
    interruptible : false,
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
  input : null,
}

// --
// zipping
// --

// function _declareHomogeneousLogical2Routine( operation, atomOperation, routineName )
// {
//   operation = this.operationSupplement( operation, atomOperation );
//
//
//   operation.input = [ 'vw?', 'vr', 'vr' ];
//
//   _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );
//
//   let result = this._routineHomogeneousDeclare( operation, atomOperation, routineName );
//
//   _.assert( result.operation.zipping === true );
//
//   return result;
// }

//

function _declareHomogeneousLogical2NotReducingRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.reducing = 0;

  // operation.takingArguments = [ 2, 3 ];
  // operation.takingVectors = [ 0, 3 ];

  if( !operation.input )
  operation.input = [ 'vw?|n?', 'vr|s', 'vr|s' ];

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );

  // debugger;
  let result = this._routineHomogeneousDeclare( operation, atomOperation, routineName );

  _.assert( result.operation.zipping === true );

  // return this._declareHomogeneousLogical2Routine( operation, atomOperation, routineName );

  return result;
}

//

function _declareHomogeneousLogical2ReducingRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );
  operation.name = routineName;

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );

  this._operationLogicalReducerAdjust( operation );

  if( operation.input )
  {

    this.operationNormalizeInput( operation );

    if( _.longIdentical( operation.input.args[ 0 ].times, [ 0, 1 ] ) )
    {
      operation.input = operation.input.args.slice( 1 ).map( ( arg ) => arg.definition ).join( ' ' );
      delete operation.takingArguments;
      delete operation.takingVectors;
      this.operationNormalizeInput( operation );
      this.operationNormalizeArity( operation );
      // debugger;
    }
    else
    {
      debugger;
      operationAdjust( operation );
    }

  }
  else
  {
    operationAdjust( operation );
  }

  _.assert( _.arrayIs( operation.onContinue ) && operation.onContinue.length );

  return this._routineHomogeneousDeclare( operation, atomOperation, routineName );

  function operationAdjust( operation )
  {

    let def =
    {
      takingArguments : [ 2, 2 ],
      takingVectors : [ 0, 2 ],
      input : 'vr|s vr|s',
    }

    _.mapExtend( operation, def );

  }

}

//

function _declareHomogeneousLogical2ReducingAllRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return this._declareHomogeneousLogical2ReducingRoutine( operation, atomOperation, routineName );

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

}

//

function _declareHomogeneousLogical2ReducingAnyRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

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

  return this._declareHomogeneousLogical2ReducingRoutine( operation, atomOperation, routineName );
}

//

function _declareHomogeneousLogical2ReducingNoneRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  _.assert( !operation.onContinue.length );
  _.assert( !operation.onVectorsEnd.length );

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return this._declareHomogeneousLogical2ReducingRoutine( operation, atomOperation, routineName );

  function onContinue( o )
  {
    if( o.dstElement === true )
    return false;
  }

  function onVectorsEnd( o )
  {
    o.result = !o.result;
  }

}

//

function declareHomogeneousLogical2Routines()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  _.assert( !routines.isIdentical );
  _.assert( !routines.allIdentical );
  _.assert( !routines.anyIdentical );
  _.assert( !routines.noneIdentical );
  _.assert( !routines.isGreater );
  _.assert( !routines.all );
  _.assert( !routines.any );
  _.assert( !routines.none );

  /* */

  for( let routineName in operations.logical2 )
  {
    let atomOperation = operations.logical2[ routineName ];
    this._declareHomogeneousLogical2NotReducingRoutine( null, atomOperation, routineName );
  }

  /* */

  for( let name in operations.logical2 )
  {

    let routineName = 'all' + _.strRemoveBegin( name, 'is' );
    let atomOperation = operations.logical2[ name ];
    this._declareHomogeneousLogical2ReducingAllRoutine( null, atomOperation, routineName );

    routineName = 'any' + _.strRemoveBegin( name, 'is' );
    atomOperation = operations.logical2[ name ];
    this._declareHomogeneousLogical2ReducingAnyRoutine( null, atomOperation, routineName );

    routineName = 'none' + _.strRemoveBegin( name, 'is' );
    atomOperation = operations.logical2[ name ];
    this._declareHomogeneousLogical2ReducingNoneRoutine( null, atomOperation, routineName );

  }

  /* */

  _.assert( _.routineIs( routines.isIdentical ) );
  _.assert( _.routineIs( routines.allIdentical ) );
  _.assert( _.routineIs( routines.anyIdentical ) );
  _.assert( _.routineIs( routines.noneIdentical ) );
  _.assert( _.routineIs( routines.isGreater ) );
  _.assert( !routines.all );
  _.assert( !routines.any );
  _.assert( !routines.none );

  _.assert( _.longIdentical( routines.isIdentical.operation.takingArguments, [ 2, 3 ] ) );
  _.assert( _.longIdentical( routines.allIdentical.operation.takingArguments, [ 2, 2 ] ) );

}

// declareHomogeneousLogical2Routines();

// --
// logical1 singler
// --

function _declareLogic1SinglerRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let def =
  {
    usingExtraSrcs : 0,
    usingDstAsSrc : 0,
    interruptible : 0,
    reducing : 0,
    returningPrimitive : 1,
    returningBoolean : 1,
    returningNumber : 0,
    returningNew : 1,
    returningSelf : 1,
    returningLong : 0,
    takingArguments : [ 1, 2 ],
    takingVectors : [ 0, 2 ],
    input : [ 'vw?', 'vr|s' ],
  }

  _.mapExtend( operation, def );

  return this._routineHomogeneousDeclare( operation, atomOperation, routineName );
}

//

function _declareLogic1ReducingSinglerRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  this._operationLogicalReducerAdjust( operation );

  let def =
  {

    takingArguments : [ 1, 1 ],
    takingVectors : [ 0, 1 ],
    input : [ 'vr|s' ],
  }

  _.mapExtend( operation, def );

  return this._routineHomogeneousDeclare( operation, atomOperation, routineName );
}

//

function _declareLogic1ReducingSinglerAllRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return this._declareLogic1ReducingSinglerRoutine( operation, atomOperation, routineName );

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

}

//

function _declareLogic1ReducingSinglerAnyRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return this._declareLogic1ReducingSinglerRoutine( operation, atomOperation, routineName );

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

}

//

function _declareLogic1ReducingSinglerNoneRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.onContinue.unshift( onContinue );
  operation.onVectorsEnd.unshift( onVectorsEnd );

  return this._declareLogic1ReducingSinglerRoutine( operation, atomOperation, routineName );

  function onContinue( o )
  {
    if( o.dstElement === true )
    return false;
  }

  function onVectorsEnd( o )
  {
    o.result = !o.result;
  }

}

//

function declareLogic1Routines()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  _.assert( !routines.isZero );
  _.assert( !routines.allZero );
  _.assert( !routines.anyZero );
  _.assert( !routines.noneZero );

  /* */

  for( let routineName in operations.logical1 )
  {
    let atomOperation = operations.logical1[ routineName ];
    this._declareLogic1SinglerRoutine( null, atomOperation, routineName );
  }

  /* */

  for( let name in operations.logical1 )
  {
    let atomOperation = operations.logical1[ name ];

    // if( name === 'isZero' )
    // debugger;

    let routineName = 'all' + _.strRemoveBegin( name, 'is' );
    this._declareLogic1ReducingSinglerAllRoutine( null, atomOperation, routineName );

    routineName = 'any' + _.strRemoveBegin( name, 'is' );
    this._declareLogic1ReducingSinglerAnyRoutine( null, atomOperation, routineName );

    routineName = 'none' + _.strRemoveBegin( name, 'is' );
    this._declareLogic1ReducingSinglerNoneRoutine( null, atomOperation, routineName );

  }

  /* */

  _.assert( _.routineIs( routines.isZero ) );
  _.assert( _.routineIs( routines.allZero ) );
  _.assert( _.routineIs( routines.anyZero ) );
  _.assert( _.routineIs( routines.noneZero ) );

  _.assert( _.longIdentical( routines.isZero.operation.takingArguments, [ 1, 2 ] ) );
  _.assert( _.longIdentical( routines.allZero.operation.takingArguments, [ 1, 1 ] ) );

}

// --
// extension
// --

let MetaExtension =
{

  operationSupplement,
  _operationLogicalReducerAdjust,
  operationNormalizeInput,
  operationNormalizeArity,

  _routinePostFrom,
  _routinesDeclare,

  _staticRoutinesDeclare,
  _staticRoutineDeclare,
  // methodSingleArgumentDeclare,
  // methodTwoArgumentsDeclare,
  _methodWrapDeclare,
  _methodsDeclare,
  _containerTypeDeclare,
  _adapterClassDeclare,

  _onAtomGenBegin,
  _onAtomGenEnd,
  _onAtomForRoutine_functor,

  _vectorizeDst,
  _vectorizeSrcs,
  _vectorsCallBegin,
  _vectorsCallEnd,
  _vectorsGenBegin,
  _vectorsGenEnd,
  _onVectorsForRoutine_functor,

  _routineForOperation_functor,

  // atom-wise, modifying, taking single vector : self

  _operationTakingDstSrcReturningSelfComponentWise_functor,

  // atom-wise, assigning, mixed : self

  _operationReturningSelfTakingVariantsComponentWise_functor,
  _operationReturningSelfTakingVariantsComponentWiseAct_functor,

  // atom-wise, homogeneous, taking vectors

  /* vectors only -> self */

  declareHomogeneousTakingVectorsRoutines,

  // atom-wise, homogeneous, taking scalar

  /* 1 vector , 1 scalar -> self */

  declareHomogeneousTakingScalarRoutines,

  // atom-wise

  _onAtomAtomwise_functor,
  _onVectorsAtomwise_functor,

// atom-wise, homogeneous

  _routineHomogeneousDeclare,
  _routineHomogeneousDeclare2,
  routinesHomogeneousDeclare,

// atom-wise, heterogeneous

  _routinesHeterogeneousDeclare,
  routinesHeterogeneousDeclare,

  // scalarReductor

  _operationReduceNormalizeFunctions,
  __operationReduceToScalar_functor,
  _operationReduceToScalar_functor,
  declareReducingRoutines,

  // extremal reductor

  _operationReduceToExtremal_functor,

  // logical2 zipper

  // _declareHomogeneousLogical2Routine,
  _declareHomogeneousLogical2NotReducingRoutine,
  _declareHomogeneousLogical2ReducingRoutine,
  _declareHomogeneousLogical2ReducingAllRoutine,
  _declareHomogeneousLogical2ReducingAnyRoutine,
  _declareHomogeneousLogical2ReducingNoneRoutine,
  declareHomogeneousLogical2Routines,

  // logical1 singler

  _declareLogic1SinglerRoutine,
  _declareLogic1ReducingSinglerRoutine,
  _declareLogic1ReducingSinglerAllRoutine,
  _declareLogic1ReducingSinglerAnyRoutine,
  _declareLogic1ReducingSinglerNoneRoutine,
  declareLogic1Routines,

}

_.mapExtend( _.vectorAdapter._meta, MetaExtension );

})();
