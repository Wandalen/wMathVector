(function _OperationDescriptor_s_() {

'use strict';

let _ = _global_.wTools;

// --
// structure
// --

let OperationDescriptor = _.blueprint
.construct
({

  takingArguments : null,
  takingVectors : null,
  takingVectorsOnly : null,

  returningOnly : null,
  returningSelf : null,
  returningNew : null,
  returningLong : null,
  returningNumber : null,
  returningBoolean : null,
  returningPrimitive : null,

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

// --
// routines
// --


let VectorExtension =
{

  OperationDescriptor,

}

_.mapExtend( _.vectorAdapter, VectorExtension );

})();
