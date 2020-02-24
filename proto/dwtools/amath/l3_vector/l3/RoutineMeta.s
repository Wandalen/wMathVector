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

let vad = _.vectorAdapter;
let OperationDescriptor = vad.OperationDescriptor;
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

function _routinePostFrom( theRoutine, routineName )
{

  if( _.objectIs( theRoutine ) )
  {
    for( let r in theRoutine )
    _routinePostFrom( theRoutine[ r ], r );
    return;
  }

  _.assert( _.routineIs( theRoutine ), () => `routine::${routineName} is not defined` );
  _.assert( _.mapIs( theRoutine.operation ), 'operation of routine', routineName, 'is not defined' );

  let operation = theRoutine.operation;
  if( operation.valid )
  return;

  /* adjust */

  operation.returningPrimitive = !!operation.returningPrimitive;
  operation.returningLong = !!operation.returningLong;
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

  let takingArguments = operation.takingArguments;
  let takingVectors = operation.takingVectors;
  let takingVectorsOnly = operation.takingVectorsOnly;
  let atomWise = operation.atomWise;
  let homogeneous = operation.homogeneous;

  let modifying = operation.modifying;
  let reducing = operation.reducing;

  let differentReturns = 0;
  differentReturns += operation.returningNew ? 1 : 0;
  differentReturns += operation.returningSelf ? 1 : 0;
  differentReturns += operation.returningLong ? 1 : 0;
  differentReturns += operation.returningPrimitive ? 1 : 0;

  let returningOnly = operation.returningOnly;
  if( returningOnly === null || returningOnly === undefined )
  {
    returningOnly = '';
    if( differentReturns === 1 )
    {
      returningOnly = operation.returningNew ? 'new' : returningOnly;
      returningOnly = operation.returningSelf ? 'self' : returningOnly;
      returningOnly = operation.returningLong ? 'array' : returningOnly;
      returningOnly = operation.returningPrimitive ? 'atomic' : returningOnly;
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

  // _.assert( returningNew != returningSelf || !returningNew || _.strHas( operation.input[ 0 ], '|n' ) );
  _.assert( _.boolIs( operation.returningSelf ) );
  _.assert( _.boolIs( operation.returningNew ) );
  _.assert( _.boolIs( operation.returningLong ) );
  _.assert( _.boolIs( operation.returningNumber ) );
  _.assert( _.boolIs( operation.returningBoolean ) );
  _.assert( _.boolIs( operation.returningPrimitive ) );
  _.assert( _.strIs( operation.returningOnly ) );
  _.assert( operation.returningNumber ? operation.returningPrimitive : true );
  _.assert( ( !!returningOnly ) == ( differentReturns == 1 ) );

  _.assert( operation.handleAtom === undefined );
  _.assert( operation.handleVector === undefined );
  _.assert( operation.handleVectors === undefined );
  _.assert( operation.handleBegin === undefined );
  _.assert( operation.handleEnd === undefined );

  // _.accessor.forbid
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

  let _names = _.mapKeys( OperationDescriptor );
  _.arrayRemoveElementOnce( _names, 'name' );
  _.accessor.forbid
  ({
    object : theRoutine,
    names : _names,
  });

  /* adjust */

  operation.takingArguments = _.numbersFromNumber( takingArguments, 2 );
  operation.takingVectors = _.numbersFromNumber( takingVectors, 2 );
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
  _.assert( !( operation.returningNumber && operation.returningBoolean ), 'Cant return both' );

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

function methodSingleArgumentDeclare( routine, r )
{
  let op = routine.operation;

  let absLike = op.returningOnly === 'self' && op.modifying && op.atomWise && op.homogeneous;
  let reduceToScalarLike = op.returningOnly === 'atomic' && !op.modifying && op.atomWise && op.homogeneous;

  let singleArgument = _.longIdentical( op.takingArguments, [ 1, 1 ] );
  let singleVector = op.takingVectors[ 1 ] === 1;

  let oneOrTwoArguments = _.longIdentical( op.takingArguments, [ 1, 2 ] );
  let oneOrInfinity = _.longIdentical( op.takingArguments, [ 1, Infinity ] );

  let doesFit = ( singleArgument && singleVector ) || ( absLike && oneOrTwoArguments ) || ( reduceToScalarLike && ( singleArgument || oneOrInfinity ) );

  if( !doesFit )
  return false;

  _.assert( _.VectorAdapter.prototype[ r ] === undefined );

  _.VectorAdapter.prototype[ r ] = function singleArgumentRoutine()
  {
    _.assert( arguments.length === 0, 'Expects no arguments' );
    _.assert( _.vectorAdapterIs( this ) );
    return routine.call( vad, this );
  }

}

//

function methodTwoArgumentsDeclare( routine, r )
{
  let op = routine.operation;

  if( !_.longIdentical( op.takingArguments , [ 2, 2 ] ) )
  return false;

  // if( !_.longIdentical( op.takingVectors , [ 1, 1 ] ) )
  if( !_.longIdentical( op.takingVectors , [ 1, 1 ] ) && !_.longIdentical( op.takingVectors , [ 0, 1 ] ) )
  return false;

  _.assert( _.VectorAdapter.prototype[ r ] === undefined );

  _.VectorAdapter.prototype[ r ] = function scalarRoutine( scalar )
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.vectorAdapterIs( this ) );
    return routine.call( vad, this, scalar );
  }

}

//

function methodsDeclare()
{

  let routines = _.vectorAdapter._routinesMathematical;
  for( let r in routines )
  {
    let routine = routines[ r ];

    _.assert( _.routineIs( routine ) );

    this.methodSingleArgumentDeclare( routine , r );
    this.methodTwoArgumentsDeclare( routine , r );

  }

}

//

function _onAtomGenBegin( dop )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayIs( dop.input ) );
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

  if( _.longIdentical( dop.input , [ 'vw', 'vr+' ] ) || _.longIdentical( dop.input , [ 'vw', 'vr*' ] ) )
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
  else if( _.longIdentical( dop.input , [ 'vw', 's' ] ) || _.longIdentical( dop.input , [ 'vw|s', 's' ] ) )
  {

    let allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s', 's|' ] );

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
  else _.assert( 0, 'unknown kind of input', dop.input );

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
        o.dstContainer = vad.makeSimilar( src );
        o.dstContainer.assign( o.args[ 1 ] );
        dst = o.dstContainer;
      }
      else
      {
        o.dstContainer = vad.makeSimilar( src );
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
      dst = o.dstContainer = vad.withDefaultLong.Array.MakeFilling( 1 , false );
      else
      dst = o.dstContainer = vad.MakeFilling( 1 , 0 );
      o.dstContainer.assign( o.args[ 1 ] );
    }
    else
    {
      if( dop.returningBoolean )
      dst = o.dstContainer = vad.withDefaultLong.Array.MakeFilling( 1 , dst );
      else
      dst = o.dstContainer = vad.MakeFilling( 1 , dst );
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
      src = o.args[ a ] = vad.FromMaybeNumber( src, o.dstContainer.length );
    }
  }

}

//

function _vectorsCallBegin( o, dop )
{

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
    o.dstContainer = vad.makeSimilar( o.dstContainer );
  }

  /* */

  let dst = _vectorizeDst( o, dop );
  _vectorizeSrcs( o, 1 );

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
      // _.assert( _.vectorIs( src ) || _.numberIs( src ) || typeof( src ) === 'function' );
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

  _vectorsGenBegin( dop );

  let takingArguments = dop.takingArguments;
  let onVectors = null;
  let onVectorsBegin = null;
  let onVectorsBegin0 = dop.onVectorsBegin[ 0 ];
  let onAtom0 = dop.onAtom[ 0 ];

  // _.assert( dop.onVectorsBegin.length === 1, 'not tested' );
  // _.assert( dop.onAtom.length === 1, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  /* */

  if( _.longIdentical( dop.input , [ 'vw', 'vr+' ] ) || _.longIdentical( dop.input , [ 'vw', 'vr*' ] ) ) //
  {

    onVectorsBegin = function onVectorsBegin( dst, src )
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

    onVectors = function onVectors()
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
    dop.operation = dop;

    _.assert( takingArguments[ 0 ] > 0 && takingArguments[ 1 ] === Infinity );

  }
  else if( _.longIdentical( dop.input , [ 'vw', 's' ] ) || _.longIdentical( dop.input , [ 'vw|s', 's' ] ) ) //
  {

    let allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s', 's|' ] );

    onVectorsBegin = function onVectorsBegin( dst, src )
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

    onVectors = function onVectors( dst, src )
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
    dop.operation = dop;

    _.assert( takingArguments[ 0 ] === 2 && takingArguments[ 1 ] === 2 );

  }
  else _.assert( 0, 'unknown kind of input', dop.input );

  /* */

  _vectorsGenEnd( dop, onVectors, onVectorsBegin );

  return onVectors;
}

//

/*
  addScalar
  input : [ 'vw', 's' ],

  addVectorScaled
  input : [ 'vw', 'vr|s*2' ],

  addVectors
  input : [ 'vw', 'vr+' ],

  clamp
  input : [ 'vw', 'vr|s*3' ],

  mix
  input : [ 'vw', 'vr|s*3' ],
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

  _.assert( _.arrayIs( dop.takingArguments ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  _.assert( _.arrayIs( dop.input ) );
  _.assert( _.strDefined( dop.name ) );
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
  dop.inputWithoutLast = dop.input.slice( 0, dop.input.length-1 );
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
  ... OperationDescriptor,
  onAtom_functor : null,
  onVectors_functor : null,
}

// --
// atom-wise, modifying, taking single vector : self
// --

function _operationTakingDstSrcReturningSelfComponentWise_functor( o )
{

  let onEach = o.onEach;
  let onVectorsBegin0 = o.onVectorsBegin || function(){};
  let onVectorsEnd0 = o.onVectorsEnd || function(){};

  _.assert( _.objectIs( o ) );
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

  return routine;

  function _operationTakingDstSrcReturningSelfComponentWise( dst, src )
  {

    let length = dst.length;
    if( !src )
    src = dst;

    _.assert( arguments.length <= 2 );
    _.assert( dst.length === src.length, 'src and dst must have same length' );

    onVectorsBegin0.call( this, dst, src );

    for( let i = 0 ; i < length ; i++ )
    onEach.call( this, dst, src, i );

    onVectorsEnd0.call( this, dst, src );

    return dst;
  }

}

// --
// float / vector
// --

function _operationReturningSelfTakingVariantsComponentWise_functor( operation )
{
  let result = Object.create( null );

  _.assert( operation.assigning === undefined );

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
  onEach : null,
  onVectorsBegin : function(){},
  onVectorsEnd : function(){},
  onMakeIdentity : function(){},
}

//

function _operationReturningSelfTakingVariantsComponentWiseAct_functor( operation )
{

  _.assert( arguments.length === 1 );
  _.routineOptions( _operationReturningSelfTakingVariantsComponentWiseAct_functor, operation );
  _.assert( _.objectIs( operation ) );
  _.assert( _.routineIs( operation.onEach ) );
  _.assert( _.routineIs( operation.onVectorsBegin ) );
  _.assert( _.routineIs( operation.onVectorsEnd ) );
  _.assert( _.arrayIs( operation.takingArguments ) );

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
      variant = result[ v ] = _.vectorAdapter.FromLong( variant );
      else
      variant = result[ v ] = _.vectorAdapter.FromMaybeNumber( variant, length );

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
      dst = _.vectorAdapter.FromLong( this./*makeArrayOfLength*/MakeZeroed( args[ 0 ].length ) );
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

    operation.atomOperation = atomOperation;

    if( !operation.takingArguments )
    operation.takingArguments = [ 2, Infinity ];
    else
    operation.takingArguments[ 1 ] = Infinity;

    if( operation.takingArguments[ 0 ] === 1 )
    operation.input = [ 'vw', 'vr*' ];
    else if( operation.takingArguments[ 0 ] > 1 )
    operation.input = [ 'vw', 'vr+' ];
    else _.assert( 0, 'unexpected' );

    operation.name = routineName;

    routines[ routineName ] = _routineForOperation_functor( operation );

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

    routines[ routineName ] = _routineForOperation_functor( operation );

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

  _vectorsGenBegin( dop );

  let takingArguments = dop.takingArguments;
  let onVectors = null;
  let onVectorsBegin = null;
  let onVectorsBegin0 = dop.onVectorsBegin[ 0 ];
  let onAtom0 = dop.onAtom[ 0 ];

  _.assert( arguments.length === 1, 'Expects single argument' );

  /* */

  if( dop.homogeneous === false )
  {

    let allowingDstScalar = _.strHasAny( dop.inputWithoutLast[ 0 ] , [ '|s', 's|' ] );

    onVectorsBegin = function onVectorsBegin( dst )
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

    onVectors = function onVectors( dst )
    {
      let o = onVectorsBegin.apply( this, arguments );
      _vectorsCallBegin( o, dop );

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

    onVectorsBegin = function onVectorsBegin( dst )
    {

      let o = Object.create( null );
      o.dstElement = null;
      o.dstContainer = dst;
      o.srcContainers = null;
      o.srcElement = null;
      o.key = -1;
      o.args = _.longSlice( arguments, 0, arguments.length );
      o.unwrapping = 0;
      o.onEvaluate = arguments[ 1 ]; /* yyy */
      o.result = null;
      Object.preventExtensions( o );

      if( onVectorsBegin0 )
      debugger;

      if( onVectorsBegin0 )
      onVectorsBegin0( o );

      return o;
    }

    if( dop.interruptible )
    onVectors = function onVectors( dst )
    {
      debugger; //
      let o = onVectorsBegin.apply( this, arguments );

      _vectorsCallBegin( o, dop );

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
    else
    onVectors = function onVectors()
    {
      let dst = arguments[ 0 ];
      let o = onVectorsBegin.apply( this, arguments );

      _vectorsCallBegin( o, dop );

      dst = o.dstContainer;
      for( let k = 0 ; k < dst.length ; k++ )
      {
        o.key = k;
        onAtom0.call( this, o );
      }

      return _vectorsCallEnd( o, dop );
    }

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

  _vectorsGenEnd( dop, onVectors, onVectorsBegin );

  return onVectors;
}

// --
// atom-wise, homogeneous
// --

function _routineHomogeneousDeclare( operation, atomOperation, routineName )
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.routines;

  operation = this.operationSupplement( operation, atomOperation );

  if( atomOperation.postfix )
  debugger;

  _.assert( operation.atomOperation === undefined );
  _.assert( _.strDefined( operation.name ) );
  _.assert( _.routineIs( atomOperation.onAtom ) );
  _.assert( !routines[ routineName ], 'routine', routineName, 'is already defined' );

  operation.atomOperation = atomOperation;

  let def =
  {
    // returningNumber : 1,
    returningPrimitive : 1,
    takingArguments : [ 2, 3 ],
  }

  if( !operation.returningBoolean && !operation.returningNumber )
  operation.returningNumber = true;

  _.mapSupplementNulls( operation, def );

  if( operation.usingExtraSrcs )
  {
    operation.takingArguments = operation.takingArguments.slice();
    operation.takingArguments[ 1 ] = Infinity;
    operation.takingVectors = [ 0, Infinity ];
  }

  operation.input = [ 'vw|s|n', 'vr|s', 'vr*|s*' ];
  operation.name = routineName;

  operation.onAtom_functor = _onAtomAtomwise_functor;
  operation.onVectors_functor = _onVectorsAtomwise_functor;

  return routines[ routineName ] = _routineForOperation_functor( operation );
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
    this._routineHomogeneousDeclare( null, atomOperation, routineName );
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

  routines[ routineName ] = _routineForOperation_functor( operation );

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

function _normalizeOperationArity( operation )
{

  if( operation.takingArguments === undefined || operation.takingArguments === null )
  operation.takingArguments = operation.takingVectors;

  if( operation.takingVectors === undefined || operation.takingVectors === null )
  operation.takingVectors = operation.takingArguments;

  if( operation.takingArguments === undefined || operation.takingArguments === null )
  operation.takingArguments = [ 1, Infinity ];

  if( operation.takingVectors === undefined || operation.takingVectors === null )
  operation.takingVectors = [ 1, Infinity ];

  operation.takingArguments = _.numbersFromNumber( operation.takingArguments, 2 ).slice();
  operation.takingVectors = _.numbersFromNumber( operation.takingVectors, 2 ).slice();

  if( operation.takingArguments[ 0 ] < operation.takingVectors[ 0 ] )
  operation.takingArguments[ 0 ] = operation.takingVectors[ 0 ];

  if( operation.takingVectorsOnly === undefined || operation.takingVectorsOnly === null )
  if( operation.takingVectors[ 0 ] === operation.takingVectors[ 1 ] && operation.takingVectors[ 1 ] === operation.takingArguments[ 1 ] )
  operation.takingVectorsOnly = true;

  return operation;
}

//

function _normalizeOperationFunctions( operationMake, operation )
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

  _normalizeOperationArity( operation );
  _.routineOptions( __operationReduceToScalar_functor, operation );
  _normalizeOperationFunctions( __operationReduceToScalar_functor, operation );

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

  let onAtom0 = operation.onAtom[ 0 ];
  let onAtomsBegin0 = operation.onAtomsBegin[ 0 ];
  let onAtomsEnd0 = operation.onAtomsEnd[ 0 ];
  let onVectorsBegin0 = operation.onVectorsBegin[ 0 ];
  let onVectorsEnd0 = operation.onVectorsEnd[ 0 ];

  let conditional = operation.conditional;
  let takingArguments = operation.takingArguments;
  let takingVectors = operation.takingVectors;

  if( operation.conditional )
  takingArguments[ 1 ] += 1;

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

  onVectorsBegin.defaults = atomDefaults;
  onVectorsBegin.own = { onVectorsBegin : onVectorsBegin };

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

  onVectorsBegin.defaults = atomDefaults;
  onVectorsEnd.own = { onVectorsEnd : onVectorsEnd };

  /* */

  let onAtom = null;

  if( operation.interruptible )
  onAtom = function onAtom( o )
  {

    if( o.filter )
    if( !o.filter.call( this, o.element, o ) )
    return;

    let r = onAtom0.call( this, o );

    _.assert( r === undefined || r === false );
    _.assert( o.result !== undefined );

    return r;
  }
  else
  onAtom = function onAtom( o )
  {

    if( o.filter )
    if( !o.filter.call( this, o.element, o ) )
    return;

    let r = onAtom0.call( this, o );

    _.assert( r === undefined );
    _.assert( o.result !== undefined );

  }

  onAtom.defaults = atomDefaults;
  onAtom.own = { onAtom : onAtom };

  /* */

  let routine = null;

  if( operation.interruptible )
  routine = function operationReduce()
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
  else
  routine = function operationReduce()
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

  operation.onVectorsBegin.unshift( onVectorsBegin );
  operation.onVectorsEnd.unshift( onVectorsEnd );
  operation.onAtom.unshift( onAtom );
  operation.onVectors.unshift( routine );
  operation.onOperationFunctor = __operationReduceToScalar_functor;

  let operationDefaults =
  {
    takingArguments : [ 0, Infinity ],
    takingVectors : null,
    takingVectorsOnly : !conditional,
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
}

__operationReduceToScalar_functor.defaults =
{
  ... OperationDescriptor,

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

  let operation = this.operationSupplement( null, o );
  operation.conditional = false;
  result.trivial = __operationReduceToScalar_functor( operation );

  operation = this.operationSupplement( null, o );
  operation.conditional = true;
  operation.name += 'Conditional';
  result.conditional = this.__operationReduceToScalar_functor( operation );

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

  _.assertMapHasOnly( operation, _operationReduceToExtremal_functor.defaults );
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
}

// --
// zipping
// --

function _declareHomogeneousLogical2Routine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.input = [ 'vw?', 'vr', 'vr' ];
  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );

  let result = this._routineHomogeneousDeclare( operation, atomOperation, routineName );

  _.assert( result.operation.zipping === true );

  return result;
}

//

function _declareHomogeneousLogical2NotReducingRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  operation.reducing = 0;
  operation.takingArguments = [ 2, 3 ];
  operation.takingVectors = [ 0, 3 ];

  return this._declareHomogeneousLogical2Routine( operation, atomOperation, routineName );
}

//

function _declareHomogeneousLogical2ReducingRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

  _.assert( !atomOperation.usingDstAsSrc && atomOperation.usingDstAsSrc !== undefined );

  this._operationLogicalReducerAdjust( operation );

  let def =
  {
    takingArguments : [ 2, 2 ],
    takingVectors : [ 0, 2 ],
    input : [ 'vw?', 'vr', 'vr' ],
  }

  _.mapExtend( operation, def );

  _.assert( _.arrayIs( operation.onContinue ) && operation.onContinue.length );

  return this._routineHomogeneousDeclare( operation, atomOperation, routineName );
}

//

function _declareHomogeneousLogical2ReducingAllRoutine( operation, atomOperation, routineName )
{
  operation = this.operationSupplement( operation, atomOperation );

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

  return this._declareHomogeneousLogical2ReducingRoutine( operation, atomOperation, routineName );
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

  _routinePostFrom,
  _routinesDeclare,

  methodSingleArgumentDeclare,
  methodTwoArgumentsDeclare,
  methodsDeclare,

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
  routinesHomogeneousDeclare,

// atom-wise, heterogeneous

  _routinesHeterogeneousDeclare,
  routinesHeterogeneousDeclare,

  // scalarReductor

  _normalizeOperationArity,
  _normalizeOperationFunctions,

  __operationReduceToScalar_functor,
  _operationReduceToScalar_functor,
  declareReducingRoutines,

  // extremal reductor

  _operationReduceToExtremal_functor,

  // logical2 zipper

  _declareHomogeneousLogical2Routine,
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
