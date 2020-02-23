(function _Long_s_() {

'use strict';

let _ = _global_.wTools;
let _row = _.vector;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = Array.prototype.slice;
let _sqrt = Math.sqrt;
let _sqr = _.sqr;

let Parent = null;
let Self = Object.create( null );

// --
// declare
// --

let Proto =
{
}

_.accessor.forbid
({
  object : Self,
  names : _.vector.Forbidden,
});

//

function LongWrapper_functor( o )
{

  o = _.routineOptions( LongWrapper_functor, arguments );

  if( _.objectIs( o.routine ) )
  {
    let result = Object.create( null );
    for( let r in o.routine )
    {
      let optionsForWrapper = _.mapExtend( null, o );
      optionsForWrapper.routine = o.routine[ r ];
      result[ r ] = LongWrapper_functor( optionsForWrapper );
    }
    return result;
  }

  let op = o.routine.operation;

  /* if routine does not take vector than this is not used at all */

  if( op.takingVectors && op.takingVectors[ 1 ] === 0 )
  o.usingThisAsFirstArgument = 0;

  /* */

  // let onReturn = o.onReturn;
  let usingThisAsFirstArgument = o.usingThisAsFirstArgument ? 1 : 0;
  let theRoutine = o.routine;

  let takingArguments = op.takingArguments;
  let takingVectors = op.takingVectors;
  let takingVectorsOnly = op.takingVectorsOnly;
  let returningSelf = op.returningSelf;
  let returningNew = op.returningNew;
  let returningArray = op.returningArray;
  let modifying = op.modifying;
  let notMethod = op.notMethod;

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

  // _.assert( _.routineIs( onReturn ) );
  _.assert( _.routineIs( theRoutine ) );

  /* adjust */

  if( _.numberIs( takingArguments ) ) takingArguments = Object.freeze([ takingArguments, takingArguments ]);
  else takingArguments = Object.freeze( takingArguments.slice() );

  if( _.numberIs( takingVectors ) )
  takingVectors = Object.freeze([ takingVectors, takingVectors ]);
  else
  takingVectors = Object.freeze( takingVectors.slice() );
  let hasOptionalVectors = takingVectors[ 0 ] !== takingVectors[ 1 ];

  vectorWrap.notMethod = notMethod;
  vectorWrap.operation = op;

  return vectorWrap;

  /* */

  function end( result, theRoutine )
  {
    let op = theRoutine.operation; debugger;

    if( op.returningPrimitive && _.primitiveIs( result ) )
    {
      return result;
    }
    else if( op.returningSelf )
    {
      return result.toArray();
    }
    else if( op.returningNew && _.vectorAdapterIs( result ) )
    {
      return result.toArray();
    }
    else if( op.returningArray )
    {
      _.assert( _.arrayIs( result ) || _.bufferTypedIs( result ), 'unexpected' );
      return result;
    }
    else return result;
  }

  /* */

  function makeVector( arg )
  {
    if( _.routineIs( arg ) )
    return arg;

    // if( _hasLength( arg ) && ( !_.Space || !( arg instanceof _.Space ) ) )
    if( _.longIs( arg ) )
    return _.vector.FromArray( arg );
    return arg;
  }

  /* */

  function vectorWrap()
  {
    let l = arguments.length + usingThisAsFirstArgument;
    let args = new Array( l );

    _.assert( takingArguments[ 0 ] <= l && l <= takingArguments[ 1 ] );

    let s = 0;
    let d = 0;
    if( usingThisAsFirstArgument )
    {
      args[ d ] = this;
      d += 1;
    }

    for( ; d < takingVectors[ 0 ] ; d++, s++ )
    {
      args[ d ] = makeVector( arguments[ s ] );
      _.assert( _.vectorAdapterIs( args[ d ] ) || ( d === 0 && returningNew ) );
    }

    let optionalLength;
    if( hasOptionalVectors )
    {
      optionalLength = _min( takingVectors[ 1 ], l );
      for( ; d < optionalLength ; d++, s++ )
      args[ d ] = makeVector( arguments[ s ] );
    }

    optionalLength = _min( takingArguments[ 1 ], l );
    for( ; d < optionalLength ; d++, s++ )
    args[ d ] = arguments[ s ];

    let result = theRoutine.apply( _.vector, args );

    return end.call( this, result, theRoutine );
  }

}

LongWrapper_functor.defaults =
{
  usingThisAsFirstArgument : null,
  routine : null,
  // onReturn : null,
}

var VectorExtension =
{
  LongWrapper_functor,
}

_.mapExtend( _.vector, VectorExtension );

// --
// row wrap
// --

let routines = _row.RoutinesMathematical;
for( let r in routines )
{

  if( Self[ r ] )
  {
    debugger;
    continue;
  }

  // function onReturn( result, theRoutine )
  // {
  //   let op = theRoutine.operation; debugger;
  //
  //   if( op.returningPrimitive && _.primitiveIs( result ) )
  //   {
  //     return result;
  //   }
  //   else if( op.returningSelf )
  //   {
  //     return result.toArray();
  //   }
  //   else if( op.returningNew && _.vectorAdapterIs( result ) )
  //   {
  //     return result.toArray();
  //   }
  //   else if( op.returningArray )
  //   {
  //     _.assert( _.arrayIs( result ) || _.bufferTypedIs( result ), 'unexpected' );
  //     return result;
  //   }
  //   else return result;
  // }

  Proto[ r ] = _.vector.LongWrapper_functor
  ({
    routine : routines[ r ],
    // onReturn,
    usingThisAsFirstArgument : 0,
  });

}

// --
// declare extension
// --

Object.setPrototypeOf( Self, wTools );

_.mapExtend( Self, Proto );

_.avector = Self;

_.LongDescriptorProducer.applyTo( Self, 'Fx' );
_.assert( _.mapOwnKey( _.avector, 'withDefaultLong' ) );

_.assert( _.objectIs( _.avector.withDefaultLong ) );
_.assert( _.objectIs( _.avector.withDefaultLong.Array ) );
_.assert( _.objectIs( _.avector.withDefaultLong.F32x ) );
// _.assert( _.objectIs( _.avector.withDefaultLong.Fx ) );

_.assert( Object.getPrototypeOf( Self ) === wTools );
_.assert( _.objectIs( _row.RoutinesMathematical ) );
_.assert( !_.avector.isValid );
_.assert( _.routineIs( _.avector.allFinite ) );

})();
