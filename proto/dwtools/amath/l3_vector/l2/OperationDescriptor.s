(function _OperationDescriptor_s_() {

'use strict';

let _ = _global_.wTools;

// --
// structure
// --

let OperationDescriptor0 = _.blueprint
.define
({

  name : null,
  input : null,
  output : null,

  onScalar : null,
  onScalarsBegin : null,
  onScalarsEnd : null,

  takingArguments : null,
  takingVectors : null,
  takingVectorsOnly : null,

  usingDstAsSrc : null,

  returningNumber : null,
  returningNew : null,
  returningPrimitive : null,

})

/*

"onScalar", "kind", "takingArguments", "homogeneous", "atomWise", "usingExtraSrcs", "usingDstAsSrc"

*/

let OperationDescriptor1 = _.blueprint
.define
({
  extension : _.define.extension( OperationDescriptor0 ),

  // takingArguments : null,
  // takingVectors : null,
  takingVectorsOnly : null,

  returningOnly : null,
  returningSelf : null,
  // returningNew : null,
  returningLong : null,
  // returningNumber : null,
  returningBoolean : null,
  // returningPrimitive : null,

  modifying : null,
  reducing : null,
  conditional : null,
  zipping : null,
  interruptible : null,
  homogeneous : null,
  atomWise : null,
  // usingDstAsSrc : null,
  usingExtraSrcs : null,

  // onScalar : null,
  onContinue : null,
  // onScalarsBegin : null,
  // onScalarsEnd : null,
  onVectorsBegin : null,
  onVectorsEnd : null,
  onVectors : null,

  kind : null,
  generator : null,
  postfix : null,
  atomOperation : null,

  inputWithoutLast : null,
  inputLast : null,

})

//

let OperationDescriptor2 = _.blueprint
.define
({
  extension : _.define.extension( OperationDescriptor1 ),

  special : null,

})

// --
// routines
// --


let VectorExtension =
{

  OperationDescriptor0,
  OperationDescriptor1,
  OperationDescriptor2,

}

_.mapExtend( _.vectorAdapter, VectorExtension );

})();
