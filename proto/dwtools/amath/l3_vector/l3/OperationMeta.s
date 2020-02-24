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
let meta = vad._meta = vad._meta || Object.create( null );
vad._meta.routines = vad._meta.routines || Object.create( null );

_.assert( _.objectIs( OperationDescriptor ) );

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

function operationNormalize1( operation )
{

  if( !operation.name )
  operation.name = operation.onAtom.name;

  operation.onAtom.operation = operation;

  if( _.numberIs( operation.takingArguments ) )
  operation.takingArguments = [ operation.takingArguments, operation.takingArguments ];

  if( _.numberIs( operation.takingVectors ) )
  operation.takingVectors = [ operation.takingVectors, operation.takingVectors ];

}

//

function operationNormalize2( operation )
{

  _.assert( operation.onVectorsBegin === undefined );
  _.assert( operation.onVectorsEnd === undefined );

  _.assert( _.mapIs( operation ) );
  _.assert( _.routineIs( operation.onAtom ) );
  _.assert( _.strDefined( operation.name ) );
  _.assert( operation.onAtom.length === 1 );

  _.assert( _.boolIs( operation.usingExtraSrcs ) );
  _.assert( _.boolIs( operation.usingDstAsSrc ) );

  _.assert( _.strIs( operation.kind ) );

}

//

function operationSinglerAdjust()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.operationRoutines;
  let atomWiseSingler = operations.atomWiseSingler = operations.atomWiseSingler || Object.create( null );

  for( let name in routines.atomWiseSingler )
  {
    let operation = routines.atomWiseSingler[ name ];

    this.operationNormalize1( operation );

    operation.kind = 'singler';

    if( operation.takingArguments === undefined )
    operation.takingArguments = [ 1, 1 ];
    operation.homogeneous = true;
    operation.atomWise = true;

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !operations.atomWiseSingler[ name ] );

    this.operationNormalize2( operation );

    operations.atomWiseSingler[ name ] = operation;
  }

}

//

function operationsLogical1Adjust()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.operationRoutines;
  let logical1 = operations.logical1 = operations.logical1 || Object.create( null );

  for( let name in routines.logical1 )
  {
    let operation = routines.logical1[ name ];

    this.operationNormalize1( operation );

    operation.kind = 'logical1';

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    operation.homogeneous = true;
    operation.atomWise = true;
    operation.reducing = true;
    operation.zipping = false;
    operation.interruptible = false;

    _.assert( !operations.logical1[ name ] );

    this.operationNormalize2( operation );

    operations.logical1[ name ] = operation;
  }

}

//

function operationsLogical2Adjust()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.operationRoutines;
  let logical2 = operations.logical2 = operations.logical2 || Object.create( null );

  for( let name in routines.logical2 )
  {
    let operation = routines.logical2[ name ];

    this.operationNormalize1( operation );

    operation.kind = 'logical2';

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    operation.homogeneous = true;
    operation.atomWise = true;
    operation.reducing = true;
    operation.zipping = true;
    operation.interruptible = false;
    operation.returningBoolean = true;

    _.assert( !operations.logical2[ name ] );

    this.operationNormalize2( operation );

    operations.logical2[ name ] = operation;
  }

}

//

function operationHomogeneousAdjust()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.operationRoutines;
  let atomWiseHomogeneous = operations.atomWiseHomogeneous = operations.atomWiseHomogeneous || Object.create( null );

  for( let name in routines.atomWiseHomogeneous )
  {
    let operation = routines.atomWiseHomogeneous[ name ];

    this.operationNormalize1( operation );

    operation.kind = 'homogeneous';

    if( operation.takingArguments === undefined )
    operation.takingArguments = [ 2, 2 ];

    if( operation.takingVectors === undefined )
    operation.takingVectors = [ 0, operation.takingArguments[ 1 ] ];

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = true;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = true;

    operation.homogeneous = true;
    operation.atomWise = true;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !operations.atomWiseHomogeneous[ name ] );

    this.operationNormalize2( operation );

    operations.atomWiseHomogeneous[ name ] = operation;
  }
}

//

function operationHeterogeneousAdjust()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.operationRoutines;
  let atomWiseHeterogeneous = operations.atomWiseHeterogeneous = operations.atomWiseHeterogeneous || Object.create( null );

  for( let name in routines.atomWiseHeterogeneous )
  {
    let operation = routines.atomWiseHeterogeneous[ name ];

    this.operationNormalize1( operation );

    operation.kind = 'heterogeneous';

    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;
    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;

    operation.homogeneous = false;
    operation.atomWise = true;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !!operation.input );
    _.assert( !operations.atomWiseHeterogeneous[ name ] );

    this.operationNormalize2( operation );

    operations.atomWiseHeterogeneous[ name ] = operation;

  }

}

//

function operationReducingAdjust()
{
  let operations = _.vectorAdapter.operations;
  let routines = _.vectorAdapter._meta.operationRoutines;
  let atomWiseReducing = operations.atomWiseReducing = operations.atomWiseReducing || Object.create( null );

  for( let name in routines.atomWiseReducing )
  {
    let operation = routines.atomWiseReducing[ name ];

    this.operationNormalize1( operation );

    operation.kind = 'reducing';

    if( operation.takingArguments === undefined )
    operation.takingArguments = [ 1, Infinity ];

    operation.homogeneous = false;
    operation.atomWise = true;
    operation.reducing = true;

    if( operation.usingExtraSrcs === undefined )
    operation.usingExtraSrcs = false;
    if( operation.usingDstAsSrc === undefined )
    operation.usingDstAsSrc = false;

    _.assert( _.arrayIs( operation.takingArguments ) );
    _.assert( operation.takingArguments.length === 2 );
    _.assert( !operations.atomWiseReducing[ name ] );

    this.operationNormalize2( operation );

    operations.atomWiseReducing[ name ] = operation;
  }

}

// --
// extension
// --

let MetaExtension =
{

  operationSupplement,
  _operationLogicalReducerAdjust,

  operationNormalize1,
  operationNormalize2,

  operationSinglerAdjust,
  operationsLogical1Adjust,
  operationsLogical2Adjust,
  operationHomogeneousAdjust,
  operationHeterogeneousAdjust,
  operationReducingAdjust,

}

_.mapExtend( _.vectorAdapter._meta, MetaExtension );

})();
