(function _Routines_s_() {

'use strict';

let _ = _global_.wTools;
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
let operations = vad.operations;
let meta = vad._meta;
let Routines = meta.routines;

/*

- split _onVectorsAtomwise_functor !!!

*/

_.assert( _.objectIs( operations ) );

// --
// basic
// --

/**
 * Routine assign() assigns the values of second argument to the vector {-dst-}. If arguments.length is more then two, then routine assigns elements of pseudo array {-arguments-} to the vector {-dst-}. The assigning starts from the index 1.
 *
 * @param { Long|VectorAdapter } dst - Destination vector.
 * @param { Long|VectorAdapter } ... - Source vector. If arguments.length is 2, then source vector is second argument. Otherwise, the source vector is copy of arguments starting from index 1.
 *
 * @returns { Long|VectorAdapter } - Returns original {-dst-} vector filled by values from source vector.
 * @function assign
 * @throws { Error } If length of {-src-} and {-dst-} vectors are different.
 * @memberof module:Tools/math/Vector.wTools.vectorAdapter
 * @memberof module:Tools/math/Vector.wTools.avector
*/

function assign( dst )
{
  let length = dst.length;
  let alength = arguments.length;

  if( alength === 2 )
  {
    let src = arguments[ 1 ];
    if( _.numberIs( src ) )
    {
      for( let i = 0 ; i < dst.length ; i++ )
      dst.eSet( i, src );
    }
    else if( _.hasLength( src ) )
    {
      src = _.vectorAdapter.fromLong( src );
      _.assert( src.length === dst.length );
      for( let i = 0 ; i < dst.length ; i++ )
      dst.eSet( i, src.eGet( i ) );
    }
    else _.assert( 0, 'unknown arguments' );
    // if( _.numberIs( arguments[ 1 ] ) )
    // this.assignScalar( dst, arguments[ 1 ] );
    // else if( _.hasLength( arguments[ 1 ] ) )
    // this.assignVector( dst, _.vectorAdapter.fromLong( arguments[ 1 ] ) );
    // else _.assert( 0, 'unknown arguments' );
  }
  else if( alength === 1 + length )
  {
    this.assign.call( this, dst, _.vectorAdapter.fromLong( _arraySlice( arguments, 1, alength ) ) );
  }
  else _.assert( 0, 'assign :', 'unknown arguments' );

  return dst;
}

let dop = assign.operation = Object.create( null );
dop.input = 'vw ?ar *!vr';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, Infinity ];
dop.takingVectors = [ 1, 2 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function assignVector( dst, src )
{
  let length = dst.length;

  _.assert( !!dst && !!src, 'Expects {-src-} and ( dst )' );
  _.assert( dst.length === src.length, 'src and dst should have same length' );
  _.assert( _.vectorAdapterIs( dst ) );
  _.assert( _.vectorAdapterIs( src ) );

  for( let s = 0 ; s < length ; s++ )
  {
    dst.eSet( s, src.eGet( s ) );
  }

  return dst;
}

dop = assignVector.operation = Object.create( null );
dop.input = 'vw vr';
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
  let length = src.length;
  let dst = this.makeSimilar( src );

  _.assert( arguments.length === 1 )

  for( let s = 0 ; s < length ; s++ )
  dst.eSet( s, src.eGet( s ) );

  return dst;
}

dop = clone.operation = Object.create( null );
dop.input = 'vr';
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

function makeSimilar( src, length )
{
  if( length === undefined )
  length = src.length;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( length ) );

  let dst = _.vectorAdapter.fromLong( new src._vectorBuffer.constructor( length ) );

  return dst;
}

dop = makeSimilar.operation = Object.create( null );
dop.input = 'vr ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
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

  let result;
  let f = f !== undefined ? f : 0;
  let l = l !== undefined ? l : array.length;

  _.assert( _.longIs( array ) );
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

  for( let r = f ; r < l ; r++ )
  result[ r-f ] = array[ r ];

  return result;
*/

function slice( src, first, last )
{
  let crange = [ first, last ]
  if( !crange[ 0 ] )
  crange[ 0 ] = 0;
  if( crange[ 1 ] === undefined )
  crange[ 1 ] = src.length;
  let result = this.shrinkLong.call( this, src, crange );
  return result;
}

dop = slice.operation = Object.create( null );
dop.input = 'vr ?s ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = true;
dop.modifying = false;

//

// function slicedLong( src, first, last )
// {
//   _.assert( !!src );
//   _.assert( 1 <= arguments.length && arguments.length <= 3 );
//   _.assert( !!src._vectorBuffer, 'Expects vector as argument' );
//
//   let length = src.length;
//   let f = first !== undefined ? first : 0;
//   let l = last !== undefined ? last : src.length;
//   let result;
//   if( src.stride !== 1 || src.offset !== 0 || src._vectorBuffer.length !== l || f !== 0 )
//   {
//     result = new src._vectorBuffer.constructor( l-f );
//     for( let i = f ; i < l ; i++ )
//     result[ i-f ] = src.eGet( i );
//   }
//   else
//   {
//     debugger;
//     return result = src._vectorBuffer.slice( f, l );
//   }
//
//   return result;
// }
//
// dop = slicedLong.operation = Object.create( null );
// dop.input = 'vr ?s ?s';
// dop.atomWise = false;
// dop.homogeneous = false;
// dop.takingArguments = [ 1, 3 ];
// dop.takingVectors = 1;
// dop.takingVectorsOnly = false;
// dop.returningSelf = false;
// dop.returningNew = false;
// dop.returningLong = true;
// dop.modifying = false;
//
// //
//
// function slicedAdapter( src, first, last )
// {
//   let result = this.slicedLong.apply( this, arguments );
//   return this.fromLong( result );
// }
//
// dop = slicedAdapter.operation = Object.create( null );
// dop.input = 'vr ?s ?s';
// dop.atomWise = false;
// dop.homogeneous = false;
// dop.takingArguments = [ 1, 3 ];
// dop.takingVectors = 1;
// dop.takingVectorsOnly = false;
// dop.returningSelf = false;
// dop.returningNew = false;
// dop.returningLong = true;
// dop.modifying = false;
//
// //
//
// function resizedLong( src, first, last, val )
// {
//   let length = src.length;
//   let f = first !== undefined ? first : 0;
//   let l = last !== undefined ? last : src.length;
//
//   if( l < f )
//   l = f;
//
//   let lsrc = Math.min( src.length, l );
//
//   _.assert( 1 <= arguments.length && arguments.length <= 4 );
//   _.assert( !!src._vectorBuffer, 'Expects vector as argument' );
//
//   let result;
//   if( src.stride !== 1 || src.offset !== 0 || src._vectorBuffer.length !== l || f !== 0 )
//   {
//     debugger;
//     result = new src._vectorBuffer.constructor( l-f );
//     for( let r = Math.max( f, 0 ) ; r < lsrc ; r++ )
//     result[ r-f ] = src.eGet( r );
//   }
//   else
//   {
//     debugger;
//     result = src._vectorBuffer.slice();
//   }
//
//   /* */
//
//   if( val !== undefined )
//   if( f < 0 || l > array.length )
//   {
//     for( let r = 0 ; r < -f ; r++ )
//     {
//       result[ r ] = val;
//     }
//     let r = Math.max( lsrc-f, 0 );
//     for( ; r < result.length ; r++ )
//     {
//       result[ r ] = val;
//     }
//   }
//
//   return result;
// }
//
// dop = resizedLong.operation = Object.create( null );
// dop.input = 'vr ?s ?s ?s';
// dop.atomWise = false;
// dop.homogeneous = false;
// dop.takingArguments = [ 1, 4 ];
// dop.takingVectors = 1;
// dop.takingVectorsOnly = false;
// dop.returningSelf = false;
// dop.returningNew = false;
// dop.returningLong = true;
// dop.modifying = false;
//
// //
//
// function resizedAdapter( src, first, last, val )
// {
//   let result = this.resizedLong.apply( this, arguments );
//   return this.fromLong( result );
// }
//
// dop = resizedAdapter.operation = Object.create( null );
// dop.input = 'vr ?s ?s ?s';
// dop.atomWise = false;
// dop.homogeneous = false;
// dop.takingArguments = [ 1, 4 ];
// dop.takingVectors = 1;
// dop.takingVectorsOnly = false;
// dop.returningSelf = false;
// dop.returningNew = false;
// dop.returningLong = true;
// dop.modifying = false;

//

function growAdapter( src, crange, val )
{
  let result = this.growLong.apply( this, arguments );
  return this.fromLong( result );
}

dop = growAdapter.operation = Object.create( null );
dop.input = 'vr ?s ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = true;
dop.modifying = false;

//

function growLong( src, crange, val )
{

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );

  if( val === undefined )
  val = 0;
  if( crange === undefined )
  crange = [ 0, src.length ];

  if( crange[ 0 ] >= 0 )
  crange[ 0 ] = 0;
  if( crange[ 1 ] <= src.length-1 )
  crange[ 1 ] = src.length-1;

  let l = crange[ 1 ] - crange[ 0 ] + 1;
  let result = this.longMakeUndefined( this.bufferConstructorOf( src ), l );

  /* qqq : optimize */

  let l2 = -crange[ 0 ];
  for( let i = 0 ; i < l2 ; i++ )
  result[ i ] = val;

  let l3 = src.length-crange[ 0 ];
  for( let i = -crange[ 0 ] ; i < l3 ; i++ )
  result[ i ] = src.eGet( i );

  let l4 = l;
  for( let i = crange[ 1 ]+1 ; i < l4 ; i++ )
  result[ i ] = val;

  return result;
}

dop = growLong.operation = Object.create( null );
dop.input = 'vr ?s ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 3 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = true;
dop.modifying = false;

//

function shrinkAdapter( src, crange )
{
  let result = this.shrinkLong.apply( this, arguments );
  return this.fromLong( result );
}

dop = shrinkAdapter.operation = Object.create( null );
dop.input = 'vr ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = true;
dop.modifying = false;

//

function shrinkLong( src, crange )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( crange === undefined )
  crange = [ 0, src.length ];
  if( crange[ 0 ] < 0 )
  crange[ 0 ] = 0;
  if( crange[ 1 ] > src.length-1 )
  crange[ 1 ] = src.length-1;

  let l = crange[ 1 ] - crange[ 0 ] + 1;
  let result = this.longMakeUndefined( this.bufferConstructorOf( src ), l );

  /* qqq : optimize */

  let l2 = crange[ 1 ];
  for( let i = crange[ 0 ] ; i <= l2 ; i++ )
  result[ i ] = src.eGet( i );

  return result;
}

dop = shrinkLong.operation = Object.create( null );
dop.input = 'vr ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = true;
dop.modifying = false;

//

function review( src, crange )
{

  if( _.numberIs( crange ) )
  crange = [ crange, src.length-1 ];

  _.assert( arguments.length === 2 );
  _.assert( _.rangeIs( crange ) );
  _.assert( crange[ 0 ] >= 0 );
  _.assert( crange[ 1 ] <= src.length-1 );

  if( crange[ 0 ] === 0 && crange[ 1 ] === src.length-1 )
  return this.fromLong( src );

  src = this.fromLong( src );

  // if( src.stride !== 1 )
  // {
  //   result = _.vectorAdapter.fromLongLrangeAndStride( src._vectorBuffer , src.offset + first*src.stride , last-first , src.stride );
  // }
  // else
  // {
  //   result = _.vectorAdapter.fromLongLrange( src._vectorBuffer , src.offset + first , last-first );
  // }

  let result = src._review( crange );

  return result;
}

dop = review.operation = Object.create( null );
dop.input = 'vr s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = true;
dop.returningLong = false;
dop.modifying = false;

//

function bufferConstructorOf( src )
{
  if( _.routineIs( src ) )
  return src;
  else if( _.vectorAdapterIs( src ) )
  return src._bufferConstructorGet();
  else if( _.longIs( src ) )
  return src.constructor;
  else _.assert( 0 );
}

dop = bufferConstructorOf.operation = Object.create( null );
dop.input = 'vr|s';
dop.atomWise = false;
dop.homogeneous = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = false;
dop.modifying = false;

//

// function subarray( src, first, last )
// {
//   let result;
//   let length = src.length;
//   first = first || 0;
//   last = _.numberIs( last ) ? last : length;
//
//   if( last > length )
//   last = length;
//   if( first < 0 )
//   first = 0;
//   if( first > last )
//   first = last;
//
//   _.assert( arguments.length === 2 || arguments.length === 3 );
//   _.assert( !!src._vectorBuffer, 'Expects vector as argument' );
//   _.assert( src.offset >= 0 );
//
//   if( src.stride !== 1 )
//   {
//     result = _.vectorAdapter.fromLongLrangeAndStride( src._vectorBuffer , src.offset + first*src.stride , last-first , src.stride );
//   }
//   else
//   {
//     result = _.vectorAdapter.fromLongLrange( src._vectorBuffer , src.offset + first , last-first );
//   }
//
//   return result;
// }
//
// dop = subarray.operation = Object.create( null );
// dop.input = 'vr s ?s';
// dop.atomWise = false;
// dop.homogeneous = false;
// dop.takingArguments = [ 2, 3 ];
// dop.takingVectors = 1;
// dop.takingVectorsOnly = false;
// dop.returningSelf = false;
// dop.returningNew = true;
// dop.modifying = false;

//

function toLong( src )
{
  let result;
  let length = src.length;

  _.assert( _.vectorAdapterIs( src ) || _.longIs( src ), 'Expects vector as a single argument' );
  _.assert( arguments.length === 1 );

  if( _.longIs( src ) )
  return src;

  return src._toLong();
}

dop = toLong.operation = Object.create( null );
dop.input = 'vr';
dop.output = 'l';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 1;
dop.takingVectors = 1;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = true;
dop.modifying = false;

//

/* zzz : redo */
function _toStr( src, o )
{
  let result = '';
  let length = src.length;

  if( !o ) o = Object.create( null );
  if( o.percision === undefined ) o.percision = 4;

  if( length )
  if( o.percision === 0 )
  {
    throw _.err( 'not tested' );
    for( let i = 0, l = length-1 ; i < l ; i++ )
    {
      result += String( src.eGet( i ) ) + ' ';
    }
    result += String( src.eGet( i ) );
  }
  else
  {
    let i = 0;
    let l = length-1;
    for(  ; i < l ; i++ )
    {
      let e = src.eGet( i );
      if( _.numberIs( e ) )
      result += e.toPrecision( o.percision ) + ' ';
      else
      result += e + ' ';
    }
    let e = src.eGet( i );
    if( _.numberIs( e ) )
    result += e.toPrecision( o.percision );
    else
    result += e;
  }

  return result;
}

dop = _toStr.operation = Object.create( null );
dop.input = 'vr ?t';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function gather( dst, srcs )
{

  let atomsPerElement = srcs.length;
  let l = dst.length / srcs.length;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.vectorAdapterIs( dst ) );
  _.assert( _.arrayIs( srcs ) );
  _.assert( _.intIs( l ) );

  debugger;

  /* */

  for( let s = 0 ; s < srcs.length ; s++ )
  {
    let src = srcs[ s ];
    _.assert( _.numberIs( src ) || _.vectorAdapterIs( src ) || _.longIs( src ) );
    if( _.numberIs( src ) )
    continue;
    if( _.longIs( src ) )
    src = srcs[ s ] = _.vectorAdapter.fromLong( src );
    _.assert( src.length === l );
  }

  /* */

  for( let e = 0 ; e < l ; e++ )
  {
    for( let s = 0 ; s < srcs.length ; s++ )
    {
      let v = _.numberIs( srcs[ s ] ) ? srcs[ s ] : srcs[ s ].eGet( e );
      dst.eSet( e*atomsPerElement + s , v );
    }
  }

  return dst;
}

dop = gather.operation = Object.create( null );
dop.input = 'vw !vw'; /* xxx : introduce (*vw) */
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function map( dst, src, onEach )
{

  if( arguments.length < 3 || _.routineIs( arguments[ 1 ] ) )
  {
    src = arguments[ 0 ];
    onEach = arguments[ 1 ];
    _.assert( arguments[ 2 ] === undefined );
  }

  if( onEach === undefined || onEach === null )
  onEach = onEach0;

  if( dst === null )
  dst = this.make( src.length );

  let l = src.length;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( _.vectorAdapterIs( dst ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( src.length === dst.length );
  _.assert( _.intIs( l ) );

  for( let i = 0 ; i < l ; i++ )
  {
    let r = onEach( src.eGet( i ), i, src, dst );
    if( r !== undefined )
    dst.eSet( i, r );
  }

  return dst;

  /* */

  function onEach0( e, k, src, dst )
  {
  }
}

dop = map.operation = Object.create( null );
dop.input = 'vw|n ?vr ?s';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, 3 ];
dop.takingVectors = [ 1, 2 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = true;
dop.modifying = true;

//

function filter( dst, src, onEach )
{

  if( arguments.length < 3 || _.routineIs( arguments[ 1 ] ) )
  {
    src = dst;
    onEach = arguments[ 1 ];
    _.assert( arguments[ 2 ] === undefined );
  }

  if( onEach === undefined || onEach === null )
  onEach = onEach0;

  if( dst === null )
  dst = this.make( src.length );

  let l = src.length;

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( _.vectorAdapterIs( dst ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( _.intIs( l ) );

  if( src === dst )
  {
    let dsti = 0;
    for( let i = 0 ; i < l ; i++ )
    {
      let r = onEach( src.eGet( i ), i, src, dst );
      if( r === undefined )
      continue;
      dst.eSet( dsti, r );
      dsti += 1;
    }
    if( dst.length !== dsti )
    throw _.err( `Length of destination container is ${dst.length}, but filtering preserved only ${dsti} elements` );
  }
  else
  {
    let dsti = 0;
    for( let i = 0 ; i < l ; i++ )
    {
      let r = onEach( src.eGet( i ), i, src, dst );
      if( r === undefined )
      continue;
      dst.eSet( dsti, r );
      dsti += 1;
    }
    if( dst.length !== dsti )
    dst = dst.shrinkAdapter([ 0, dsti-1 ]);
  }

  return dst;

  function onEach0( e, k, src, dst )
  {
    return e;
  }
}

dop = filter.operation = Object.create( null );
dop.input = 'vw|n ?vr ?s';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, 3 ];
dop.takingVectors = [ 1, 2 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = true;
dop.modifying = true;

//

function _while( dst, src, onEach )
{

  if( arguments.length < 3 || _.routineIs( arguments[ 1 ] ) )
  {
    src = dst;
    onEach = arguments[ 1 ];
    _.assert( arguments[ 2 ] === undefined );
  }

  if( onEach === undefined || onEach === null )
  onEach = onEach0;

  if( dst === null )
  dst = this.make( src.length );

  let l = src.length;

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( _.vectorAdapterIs( dst ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( _.intIs( l ) );

  if( src === dst )
  {
    let dsti = 0;
    for( let i = 0 ; i < l ; i++ )
    {
      let r = onEach( src.eGet( i ), i, src, dst );
      if( r === undefined )
      break;
      dst.eSet( dsti, r );
      dsti += 1;
    }
    if( dst.length !== dsti )
    throw _.err( `Length of destination container is ${dst.length}, but filtering preserved only ${dsti} elements` );
  }
  else
  {
    let dsti = 0;
    for( let i = 0 ; i < l ; i++ )
    {
      let r = onEach( src.eGet( i ), i, src, dst );
      if( r === undefined )
      break;
      dst.eSet( dsti, r );
      dsti += 1;
    }
    debugger;
    if( dst.length !== dsti )
    dst = dst.shrinkAdapter([ 0, dsti-1 ]);
  }

  return dst;

  function onEach0( e, k, src, dst )
  {
    return e;
  }
}

dop = _while.operation = Object.create( null );
dop.input = 'vw|n ?vr ?s';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, 3 ];
dop.takingVectors = [ 1, 2 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = true;
dop.modifying = true;

// --
// not atom-wise : self
// --

function sort( dst, comparator )
{
  let length = dst.length;

  if( !comparator )
  comparator = function( a, b ){ return a-b };

  _sort( 0, length-1 );

  return dst;

  function _sort( left, right )
  {

    if( left >= right )
    return;

    let m = Math.floor( ( left+right ) / 2 );
    let mValue = dst.eGet( m );
    let l = left;
    let r = right;

    do
    {

      while( comparator( dst.eGet( l ), mValue ) < 0 )
      l += 1;

      while( comparator( dst.eGet( r ), mValue ) > 0 )
      r -= 1;

      if( l <= r )
      {
        let v = dst.eGet( l );
        dst.eSet( l, dst.eGet( r ) );
        dst.eSet( r, v );
        r -= 1;
        l += 1;
      }

    }
    while( l <= r );

    _sort( left, r );
    _sort( l, right );

  }

}

dop = sort.operation = Object.create( null );
dop.input = 'vw ?s';
dop.atomWise = false;
dop.homogeneous = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function randomInRadius( dst, radius )
{
  let length = dst.length;
  let o = Object.create( null );

  if( _.objectIs( radius ) )
  {
    o = radius;
    radius = o.radius;
  }

  if( o.attempts === undefined )
  o.attempts = 32;

  _.assert( _.numberIs( radius ) );

  let radiusSqrt = sqrt( radius );
  let radiusSqr = _sqr( radius );
  let attempts = o.attempts;
  for( let a = 0 ; a < attempts ; a++ )
  {

    this.randomInRangeAssigning( dst, -radiusSqrt, +radiusSqrt );
    let m = this.magSqr( dst );
    if( m < radiusSqr ) break;

  }

  return dst;
}

dop = randomInRadius.operation = Object.create( null );
dop.input = 'vw s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 2, 2 ];
dop.takingVectors = [ 1, 1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

// function crossWithPoints( a, b, c, result )
function crossWithPoints( dst, a, b, c )
{
  _.assert( arguments.length === 4 );
  _.assert( a.length === 3 && b.length === 3 && c.length === 3, 'implemented only for 3D' );

  _.assert( 0, 'not tested' );
  dst = dst || this.make( 3 );
  // dst = dst || this.long.longMake( 3 );

  let ax = a.eGet( 0 )-c.eGet( 0 ), ay = a.eGet( 1 )-c.eGet( 1 ), az = a.eGet( 2 )-c.eGet( 2 );
  let bx = b.eGet( 0 )-c.eGet( 0 ), by = b.eGet( 1 )-c.eGet( 1 ), bz = b.eGet( 2 )-c.eGet( 2 );

  dst.eSet( 0, ay * bz - az * by );
  dst.eSet( 1, az * bx - ax * bz );
  dst.eSet( 2, ax * by - ay * bx );

  return dst;
}

dop = crossWithPoints.operation = Object.create( null );
dop.input = 'vw|n vr vr vr';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 4, 4 ];
dop.takingVectors = [ 4, 4 ];
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function _cross3( dst, src1, src2 )
{

  let src1x = src1.eGet( 0 );
  let src1y = src1.eGet( 1 );
  let src1z = src1.eGet( 2 );

  let src2x = src2.eGet( 0 );
  let src2y = src2.eGet( 1 );
  let src2z = src2.eGet( 2 );

  dst = dst || this.make( 3 );

  dst.eSet( 0, src1y * src2z - src1z * src2y );
  dst.eSet( 1, src1z * src2x - src1x * src2z );
  dst.eSet( 2, src1x * src2y - src1y * src2x );

  return dst;
}

dop = _cross3.operation = Object.create( null );
dop.input = 'vw|n vr vr';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 3;
dop.takingVectors = 3;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

/* aaa : cover */
/* Dmytro : covered */

function cross3( dst, src1, src2 )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( dst.length === 3, 'implemented only for 3D' );
  _.assert( src1.length === 3, 'implemented only for 3D' );
  _.assert( src2.length === 3, 'implemented only for 3D' );

  dst = _.vectorAdapter.from( dst );
  src1 = _.vectorAdapter.from( src1 );
  src2 = _.vectorAdapter.from( src2 );

  return this._cross3( dst, src1, src2 );
}

dop = cross3.operation = _.mapExtend( null, _cross3.operation );

//

function cross( dst )
{

  let firstSrc = 1;
  if( dst === null )
  {
    dst = _.vectorAdapter.from( arguments[ 1 ].slice() );
    firstSrc = 2;
    _.assert( arguments.length >= 3, 'Expects at least three arguments' );
  }

  _.assert( arguments.length >= 2, 'Expects at least two arguments' );
  _.assert( dst.length === 3, 'implemented only for 3D' );

  for( let a = firstSrc ; a < arguments.length ; a++ )
  {
    let src = arguments[ a ];
    _.assert( src.length === 3, 'implemented only for 3D' );
    this._cross3( dst, dst, src );
  }

  return dst;
}

dop = cross.operation = Object.create( null );
dop.input = 'vw|n vr *vr';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = [ 2, Infinity ];
dop.takingVectors = [ 2, Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = true;
dop.modifying = true;

//

function quaternionApply( dst, q )
{

  _.assert( dst.length === 3 && q.length === 4, 'quaternionApply :', 'Expects vector and quaternion as arguments' );

  let x = dst.eGet( 0 );
  let y = dst.eGet( 1 );
  let z = dst.eGet( 2 );

  let qx = q.eGet( 0 );
  let qy = q.eGet( 1 );
  let qz = q.eGet( 2 );
  let qw = q.eGet( 3 );

  /* */

  let ix = + qw * x + qy * z - qz * y;
  let iy = + qw * y + qz * x - qx * z;
  let iz = + qw * z + qx * y - qy * x;
  let iw = - qx * x - qy * y - qz * z;

  /* */

  dst.eSet( 0, ix * qw + iw * - qx + iy * - qz - iz * - qy );
  dst.eSet( 1, iy * qw + iw * - qy + iz * - qx - ix * - qz );
  dst.eSet( 2, iz * qw + iw * - qz + ix * - qy - iy * - qx );

  /* */

/*
  clone.quaternionApply2( q );
  let err = clone.distanceSqr( this );
  if( abs( err ) > 0.0001 )
  throw _.err( 'Vector :', 'Something wrong' );
*/

  /* */

  return dst;
}

dop = quaternionApply.operation = Object.create( null );
dop.input = 'vw vr';
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

function quaternionApply2( dst, q )
{

  _.assert( dst.length === 3 && q.length === 4, 'quaternionApply :', 'Expects vector and quaternion as arguments' );
  throw _.err( 'not tested' );
  let qvector = this.fromLongLrange( dst, 0, 3 );

  let cross1 = this.cross( qvector, dst );
  this.mul( cross1, 2 );

  let cross2 = this.cross( qvector, cross1 );
  this.mul( cross1, q.eGet( 3 ) );

  dst.eSet( 0, dst.eSet( 0 ) + cross1.eGet( 0 ) + cross2.eGet( 0 ) );
  dst.eSet( 1, dst.eGet( 1 ) + cross1.eGet( 1 ) + cross2.eGet( 1 ) );
  dst.eSet( 2, dst.eGet( 2 ) + cross1.eGet( 2 ) + cross2.eGet( 2 ) );

  return dst;
}

dop = quaternionApply2.operation = Object.create( null );
dop.input = 'vw vr';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function eulerApply( v, e )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  throw _.err( 'not implemented' )

}

dop = eulerApply.operation = Object.create( null );
dop.input = 'vw vr';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function reflect( v, normal )
{

  _.assert( arguments.length === 3, 'Expects exactly two arguments' );
  _.assert( _.vectorAdapterIs( v ) );
  _.assert( _.vectorAdapterIs( normal ) );

  debugger;
  throw _.err( 'not tested' );

  let result = this.mul( normal.clone() , 2*this.dot( v, normal ) );

  return result;
}

dop = reflect.operation = Object.create( null );
dop.input = 'vw|n vr vr';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 3;
dop.takingVectors = 3;
dop.takingVectorsOnly = true;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function matrixApplyTo( dst, srcMatrix )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.matrixIs( srcMatrix ) );
  debugger;
  return _.space.mul( dst, [ srcMatrix, dst ] );
}

dop = matrixApplyTo.operation = Object.create( null );
dop.input = 'vr mw';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function matrixHomogenousApply( dst, srcMatrix )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.matrixIs( srcMatrix ) );
  return srcMatrix.matrixHomogenousApply( dst );
}

dop = matrixHomogenousApply.operation = Object.create( null );
dop.input = 'vr mw';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function matrixDirectionsApply( v, m )
{
  _.assrt( arguments.length === 2 );
  m.matrixDirectionsApply( v );
  return v;
}

dop = matrixDirectionsApply.operation = Object.create( null );
dop.input = 'vr mw';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function swapVectors( v1, v2 )
{

  _.assert( arguments.length === 2 );
  _.assert( v1.length === v2.length );

  for( let i = 0 ; i < v1.length ; i++ )
  {
    let val = v1.eGet( i );
    v1.eSet( i, v2.eGet( i ) );
    v2.eSet( i, val );
  }

}

dop = swapVectors.operation = Object.create( null );
dop.input = 'vw vw';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = true;

//

function swapAtoms( v, i1, i2 )
{

  _.assert( arguments.length === 3 );
  _.assert( 0 <= i1 && i1 < v.length );
  _.assert( 0 <= i2 && i2 < v.length );
  _.assert( _.numberIs( i1 ) );
  _.assert( _.numberIs( i2 ) );

  let val = v.eGet( i1 );
  v.eSet( i1, v.eGet( i2 ) );
  v.eSet( i2, val );

  return v;
}

dop = swapAtoms.operation = Object.create( null );
dop.input = 'vw s s';
dop.atomWise = false;
dop.homogeneous = false;
dop.takingArguments = 3;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;

//

function formate( dst, srcs )
{
  let ape = srcs.length;
  let l = dst.length / ape;

  _.assert( _.arrayIs( srcs ) );
  _.assert( _.intIs( l ) );

  // debugger;

  for( let a = 0 ; a < ape ; a++ )
  {
    let src = srcs[ a ];

    if( _.numberIs( src ) )
    {
      for( let i = 0 ; i < l ; i++ )
      dst.eSet( i*ape+a , src );
    }
    else
    {
      src = _.vectorAdapter.from( src );
      _.assert( src.length === l );
      for( let i = 0 ; i < l ; i++ )
      dst.eSet( i*ape+a , src.eGet( i ) );
    }
  }

  // debugger;
  return dst;
}

dop = formate.operation = Object.create( null );
dop.input = 'vw !vw';
dop.takingArguments = 2;
dop.takingVectors = 1;
dop.takingVectorsOnly = false;
dop.returningSelf = true;
dop.returningNew = false;
dop.modifying = true;
dop.reducing = false;
dop.homogeneous = false;

// --
// atom-wise, modifying, taking single vector : self
// --

let inv = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _inv( dst, src, i )
  {
    dst.eSet( i, 1 / src.eGet( i ) );
  }
});

//

let invOrOne = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _invOrOne( dst, src, i )
  {
    if( src.eGet( i ) === 0 )
    dst.eSet( i, 1 );
    else
    dst.eSet( i, 1 / src.eGet( i ) );
  }
});

//

let absRoutine = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _abs( dst, src, i )
  {
    dst.eSet( i, Math.abs( src.eGet( i ) ) );
  }
});

//

let floorRoutine = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _floor( dst, src, i )
  {
    dst.eSet( i, Math.floor( src.eGet( i ) ) );
  }
});

//

let ceilRoutine = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _ceil( dst, src, i )
  {
    dst.eSet( i, Math.ceil( src.eGet( i ) ) );
  }
});

//

let roundRoutine = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _round( dst, src, i )
  {
    debugger;
    dst.eSet( i, Math.round( src.eGet( i ) ) );
  }
});

//

let ceilToPowerOfTwo = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onEach : function _ceil( dst, src, i )
  {
    dst.eSet( i, _.math.ceilToPowerOfTwo( src.eGet( i ) ) );
  }
});

//

let _normalizeM;
let normalize = meta._operationTakingDstSrcReturningSelfComponentWise_functor
({
  onVectorsBegin : function normalize( dst, src )
  {
    _normalizeM = this.mag( src );
    if( !_normalizeM )
    _normalizeM = 1;
    _normalizeM = 1 / _normalizeM;
  },
  onEach : function normalize( dst, src, i )
  {
    dst.eSet( i, src.eGet( i ) * _normalizeM );
  },
});

// --
// float / vector
// --

// /**
//  * @summary Add vectors `src` and `dst`. Saves result in vector `dst`.
//  * @param {Long|VectorAdapter} dst Destination vector.
//  * @param {Long|VectorAdapter} src Source vector.
//  * @example
//  * var a1 = [ 1, 2, 5, 9 ];
//  * var a2 = [ 1, 2, 3, 4 ];
//  * _.avector.add( a1, a2 );
//  * console.log( 'a1', a1 );
//  * console.log( 'a2', a2 );
//  * //a1 [ 2, 4, 8, 13 ]
//  * //a2 [ 1, 2, 3, 4 ]
//  *
//  * @function add
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let add = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 2, Infinity ],
//   input : 'vw +vr|+s',
//   homogenous : 1,
//   onEach : function add( dst, src, i )
//   {
//     let d = dst.eGet( i );
//     let s = src.eGet( i );
//
//     let r = d + s;
//
//     dst.eSet( i, r );
//   }
// });
//
// //
//
// /**
//  * @summary Subtracts vector `src` from vector `dst`. Saves result in vector `dst`.
//  * @param {Long|VectorAdapter} dst Destination vector.
//  * @param {Long|VectorAdapter} src Source vector.
//  * @example
//  * var a1 = [ 1, 2, 5, 9 ];
//  * var a2 = [ 1, 2, 3, 4 ];
//  * _.avector.sub( a1, a2 );
//  * console.log( 'a1', a1 );
//  * console.log( 'a2', a2 );
//  * //a1 [ 0, 0, 2, 5 ]
//  * //a2 [ 1, 2, 3, 4 ]
//  *
//  * @function sub
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let sub = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 2, Infinity ],
//   input : 'vw +vr|+s',
//   homogenous : 1,
//   onEach : function sub( dst, src, i )
//   {
//     let d = dst.eGet( i );
//     let s = src.eGet( i );
//
//     let r = d - s;
//
//     dst.eSet( i, r );
//   }
// });
//
// //
//
// /**
//  * @summary Multiplication of vectors `src` and `dst`. Saves result in vector `dst`.
//  * @param {Long|VectorAdapter} dst Destination vector.
//  * @param {Long|VectorAdapter} src Source vector.
//  * @example
//  * var a1 = [ 1, 2, 5, 9 ];
//  * var a2 = [ 1, 2, 3, 4 ];
//  * _.avector.mul( a1, a2 );
//  * console.log( 'a1', a1 );
//  * console.log( 'a2', a2 );
//  * //a1 [1, 4, 15, 36]
//  * //a2 [ 1, 2, 3, 4 ]
//  *
//  * @function mul
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let mul = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 2, Infinity ],
//   input : 'vw +vr|+s',
//   homogenous : 1,
//   onMakeIdentity : function( dst )
//   {
//     _.vectorAdapter.assignScalar( dst, 1 );
//   },
//   onEach : function mul( dst, src, i )
//   {
//     let d = dst.eGet( i );
//     let s = src.eGet( i );
//
//     let r = d * s;
//
//     dst.eSet( i, r );
//   }
// });
//
// //
//
// /**
//  * @summary Division of vectors `src` and `dst`. Saves result in vector `dst`.
//  * @param {Long|VectorAdapter} dst Destination vector.
//  * @param {Long|VectorAdapter} src Source vector.
//  * @example
//  * var a1 = [ 1, 4, 9, 16 ];
//  * var a2 = [ 1, 2, 3, 4 ];
//  * _.avector.div( a1, a2 );
//  * console.log( 'a1', a1 );
//  * console.log( 'a2', a2 );
//  * //a1 [1, 2, 3, 4]
//  * //a2 [ 1, 2, 3, 4 ]
//  *
//  * @function div
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let div = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 2, Infinity ],
//   input : 'vw +vr|+s',
//   homogenous : 1,
//   onMakeIdentity : function( dst )
//   {
//     debugger;
//     _.vectorAdapter.assignScalar( dst, 1 );
//   },
//   onEach : function div( dst, src, i )
//   {
//     debugger;
//     let d = dst.eGet( i );
//     let s = src.eGet( i );
//
//     let r = d / s;
//
//     dst.eSet( i, r );
//   }
// });
//
// //
//
// /**
//  * @summary Finds minimum values from vectors `src` and `dst`. Saves result in vector `dst`.
//  * @param {Long|VectorAdapter} dst Destination vector.
//  * @param {Long|VectorAdapter} src Source vector.
//  * @example
//  * var a1 = [ 1, 4, 9, 16 ];
//  * var a2 = [ 1, 2, 3, 4 ];
//  * _.avector.min( a1, a2 );
//  * console.log( 'a1', a1 );
//  * console.log( 'a2', a2 );
//  * //a1 [1, 2, 3, 4]
//  * //a2 [ 1, 2, 3, 4 ]
//  *
//  * @function min
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let min = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 2, Infinity ],
//   homogenous : 1,
//   input : 'vw +vr|+s',
//   onMakeIdentity : function( dst )
//   {
//     debugger;
//     _.vectorAdapter.assignScalar( dst, +Infinity );
//   },
//   onEach : function min( dst, src, i )
//   {
//     let d = dst.eGet( i );
//     let s = src.eGet( i );
//
//     let r = _min( d, s );
//
//     dst.eSet( i, r );
//   }
// });
//
// //
//
// /**
//  * @summary Finds maximal values from vectors `src` and `dst`. Saves result in vector `dst`.
//  * @param {Long|VectorAdapter} dst Destination vector.
//  * @param {Long|VectorAdapter} src Source vector.
//  * @example
//  * var a1 = [ 1, 4, 9, 16 ];
//  * var a2 = [ 1, 2, 3, 4 ];
//  * _.avector.max( a1, a2 );
//  * console.log( 'a1', a1 );
//  * console.log( 'a2', a2 );
//  * //a1 [ 1, 4, 9, 16 ]
//  * //a2 [ 1, 2, 3, 4 ]
//  *
//  * @function max
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let max = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 2, Infinity ],
//   homogenous : 1,
//   input : 'vw +vr|+s',
//   onMakeIdentity : function( dst )
//   {
//     debugger;
//     _.vectorAdapter.assignScalar( dst, -Infinity );
//   },
//   onEach : function max( dst, src, i )
//   {
//     let d = dst.eGet( i );
//     let s = src.eGet( i );
//
//     let r = _max( d, s );
//
//     dst.eSet( i, r );
//   }
// });
//
// //
//
// /**
//  * @summary Limits values of vector `dst` to values in orange [min, max].
//  * @param {Long|VectorAdapter} dst Vector.
//  * @example
//  * var a1 = [ 1, 2, 3, 4 ];
//  * _.avector.clamp( a1, 1, 2 );
//  * console.log( 'a1', a1 );
//  * //a1 [ 1, 2, 2, 2 ]
//  *
//  * @function clamp
//  * @memberof module:Tools/math/Vector.wTools.vectorAdapter
// */
//
// let clamp = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 3, 3 ],
//   input : 'vw vr|s vr|s',
//   onEach : function clamp( dst, min, max, i )
//   {
//     let vmin = min.eGet( i );
//     let vmax = max.eGet( i );
//     if( dst.eGet( i ) > vmax ) dst.eSet( i, vmax );
//     else if( dst.eGet( i ) < vmin ) dst.eSet( i, vmin );
//   }
// });
//
// //
//
// let randomInRange = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 3, 3 ],
//   input : 'vw vr|s vr|s',
//   onEach : function randomInRange( dst, min, max, i )
//   {
//     let vmin = min.eGet( i );
//     let vmax = max.eGet( i );
//     dst.eSet( i, vmin + Math.random()*( vmax-vmin ) );
//   }
// });
//
// //
//
// let mix = meta._operationReturningSelfTakingVariantsComponentWise_functor
// ({
//   takingArguments : [ 3, 3 ],
//   input : 'vw vr|s vr|s',
//   onEach : function mix( dst, src, progress, i )
//   {
//     debugger;
//     throw _.err( 'not tested' );
//     let v1 = dst.eGet( i );
//     let v2 = src.eGet( i );
//     let p = progress.eGet( i );
//     dst.eSet( i, v1*( 1-p ) + v2*( p ) );
//   }
// });

  // add,
  // sub,
  // mul,
  // div,
  // min,
  // max,

// --
// extremal reductor
// --

let reduceToClosest = meta._operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    debugger;
    _.assert( o.container.length, 'not tested' );
    _.assert( 0, 'not tested' );
    return abs( o.result.instance - o.element );
  },
  onIsGreater : function( a, b )
  {
    return a < b;
  },
  input : 'vr *vr',
  // takingArguments : 2,
  // takingVectors : 1,
  distanceOnBegin : +Infinity,
  valueName : 'distance',
  name : 'reduceToClosest',
});

//

let reduceToFurthest = meta._operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    debugger;
    _.assert( o.container.length, 'not tested' );
    _.assert( 0, 'not tested' );
    return abs( o.result.instance - o.element );
  },
  onIsGreater : function( a, b )
  {
    return a > b;
  },
  input : 'vr *vr',
  // takingArguments : 2,
  // takingVectors : 1,
  distanceOnBegin : -Infinity,
  valueName : 'distance',
  name : 'reduceToFurthest',
});

//

let reduceToMin = meta._operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    debugger;
    _.assert( o.container.length, 'not tested' );
    _.assert( 0, 'not tested' );
    return o.element;
  },
  onIsGreater : function( a, b )
  {
    return a < b;
  },
  input : 'vr *vr',
  distanceOnBegin : +Infinity,
  valueName : 'value',
  name : 'reduceToMin',
});

//

let reduceToMinAbs = meta._operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    _.assert( o.container.length, 'not tested' );
    return abs( o.element );
  },
  onIsGreater : function( a, b )
  {
    return a < b;
  },
  input : 'vr *vr',
  distanceOnBegin : -Infinity,
  valueName : 'value',
  name : 'reduceToMinAbs',
});

//

let reduceToMax = meta._operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    _.assert( o.container.length, 'not tested' );
    return o.element;
  },
  onIsGreater : function( a, b )
  {
    return a > b;
  },
  input : 'vr *vr',
  distanceOnBegin : -Infinity,
  valueName : 'value',
  name : 'reduceToMax',
});

//

let reduceToMaxAbs = meta._operationReduceToExtremal_functor
({
  onDistance : function( o )
  {
    _.assert( o.container.length, 'not tested' );
    return abs( o.element );
  },
  onIsGreater : function( a, b )
  {
    return a > b;
  },
  input : 'vr *vr',
  distanceOnBegin : -Infinity,
  valueName : 'value',
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

  _.assert( o.container.length, 'not tested' );

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

let distributionRangeSummary = meta._operationReduceToScalar_functor
({
  onAtom : _distributionRangeSummaryEach,
  onAtomsBegin : _distributionRangeSummaryBegin,
  onAtomsEnd : _distributionRangeSummaryEnd,
  returningNumber : false,
  returningPrimitive : false,
  interruptible : false,
  name : 'distributionRangeSummary',
});

_.assert( distributionRangeSummary.trivial.operation.reducing );

//

function reduceToMinValue()
{
  debugger;
  let result = this.reduceToMin.apply( this, arguments );
  return result.value;
}

_.assert( _.strIs( reduceToMin.trivial.operation.input.definition ) );
// debugger;
dop = reduceToMinValue.operation = Object.create( null );
dop.input = reduceToMin.trivial.operation.input.definition;
// dop.takingArguments = [ 1, Infinity ];
// dop.takingVectors = [ 1, Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningNumber = true;
dop.returningPrimitive = true;
dop.modifying = false;

//

function reduceToMaxValue()
{
  let result = this.reduceToMax.apply( this, arguments );
  return result.value;
}

dop = reduceToMaxValue.operation = Object.create( null );
dop.input = reduceToMax.trivial.operation.input.definition;
// dop.takingArguments = [ 1, Infinity ];
// dop.takingVectors = [ 1, Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningNumber = true;
dop.returningPrimitive = true;
dop.modifying = false;

//

function distributionRangeSummaryValue()
{
  _.assert( _.routineIs( this.distributionRangeSummary ) );
  let result = this.distributionRangeSummary.apply( this, arguments );
  return [ result.min.value, result.max.value ];
}

// debugger;
dop = distributionRangeSummaryValue.operation = Object.create( null );
dop.input = distributionRangeSummary.trivial.operation.input.definition;
// dop.takingArguments = [ 1, Infinity ];
// dop.takingVectors = [ 1, Infinity ];
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningNumber = false;
dop.modifying = false;

// meta.declareHomogeneousLogical2Routines();

// --
// zipping
// --

// function gt( dst, src )
// {
//   return _.vectorAdapter.isGreater.apply( this, arguments );
// }
//
// debugger;
// dop = gt.operation = Routines.isGreater.operation;
// _.assert( _.objectIs( dop ) );
//
// //
//
// function ge( dst, src )
// {
//   return _.vectorAdapter.isGreaterEqual.apply( this, arguments );
// }
//
// dop = ge.operation = Routines.isGreaterEqual.operation;
// _.assert( _.objectIs( dop ) );
//
// //
//
// function lt( dst, src )
// {
//   return _.vectorAdapter.isLess.apply( this, arguments );
// }
//
// dop = lt.operation = Routines.isLess.operation;
// _.assert( _.objectIs( dop ) );
//
// //
//
// function le( dst, src )
// {
//   return _.vectorAdapter.isLessEqual.apply( this, arguments );
// }
//
// dop = le.operation = Routines.isLessEqual.operation;
// _.assert( _.objectIs( dop ) );

//

function all( src, onEach )
{

  if( onEach === undefined || onEach === null )
  onEach = onEach0;

  let l = src.length;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( _.intIs( l ) );

  for( let i = 0 ; i < l ; i++ )
  {
    let r = onEach( src.eGet( i ), i, src );
    if( !r )
    return r;
  }

  return true;

  /* */

  function onEach0( e, k, src )
  {
    return e;
  }
}

dop = all.operation = Object.create( null );
dop.input = 'vw ?s';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
dop.takingVectors = [ 1, 1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = false;
dop.returningBoolean = true;
dop.reducing = true;
dop.modifying = false;

//

function any( src, onEach )
{

  if( onEach === undefined || onEach === null )
  onEach = onEach0;

  let l = src.length;

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( _.intIs( l ) );

  for( let i = 0 ; i < l ; i++ )
  {
    let r = onEach( src.eGet( i ), i, src );
    if( r )
    return r;
  }

  return false;

  function onEach0( e, k, src )
  {
    return e;
  }
}

dop = any.operation = Object.create( null );
dop.input = 'vw ?s';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
dop.takingVectors = [ 1, 1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = false;
dop.returningBoolean = true;
dop.reducing = true;
dop.modifying = false;

//

function none( src, onEach )
{

  if( onEach === undefined || onEach === null )
  onEach = onEach0;

  let l = src.length;

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( _.intIs( l ) );

  for( let i = 0 ; i < l ; i++ )
  {
    let r = onEach( src.eGet( i ), i, src );
    if( r )
    return !r;
  }

  return true;

  function onEach0( e, k, src )
  {
    return e;
  }
}

dop = none.operation = Object.create( null );
dop.input = 'vw ?s';
dop.atomWise = true;
dop.homogeneous = false;
dop.takingArguments = [ 1, 2 ];
dop.takingVectors = [ 1, 1 ];
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.returningLong = false;
dop.returningBoolean = true;
dop.reducing = true;
dop.modifying = false;

// --
// interruptible reductor with bool result
// --

function _equalAre( it )
{
  let length = it.src2.length;

  _.assert( arguments.length === 1 );
  _.assert( it.strictTyping !== undefined );
  _.assert( it.containing !== undefined );

  it.continue = false;

  if( !( it.src.length >= 0 ) )
  return false;

  if( !( it.src2.length >= 0 ) )
  return false;

  if( !it.strictContainer )
  {
    if( !_.vectorAdapterIs( it.src ) && _.longIs( it.src ) )
    it.src = this.fromLong( it.src );
    if( !_.vectorAdapterIs( it.src2 ) && _.longIs( it.src2 ) )
    it.src2 = this.fromLong( it.src2 );
  }
  else
  {
    if( !_.vectorAdapterIs( it.src ) )
    return false;
    if( !_.vectorAdapterIs( it.src2 ) )
    return false;
  }

  if( it.strictTyping )
  if( it.src._vectorBuffer.constructor !== it.src2._vectorBuffer.constructor )
  return false;

  if( !it.containing )
  if( it.src.length !== length )
  return false;

  if( !length )
  return true;

  for( let i = 0 ; i < length ; i++ )
  {
    if( !it.onNumbersAreEqual( it.src.eGet( i ), it.src2.eGet( i ) ) )
    return false;
  }

  return true;
}

_.routineExtend( _equalAre, _._equal );

dop = _equalAre.operation = Object.create( null );
dop.input = '!v';
dop.takingArguments = 1;
dop.takingVectors = 0;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function equalAre( src1, src2, opts )
{

  let it = this._equalAre.pre.call( this, this.equalAre, arguments );
  let result = this._equalAre( it );
  return result;

  // it = equalAre.lookContinue( equalAre, arguments );
  // let result = this._equalAre( it );
  // return result;

  // _entityEqualIteratorMake

}

_.routineExtend( equalAre, _._equal );

// _.assert( _.objectIs( equalAre.defaults ) );
// _.assert( _.routineIs( equalAre.body ) );
// _.assert( _.routineIs( equalAre.lookContinue ) );

dop = equalAre.operation = Object.create( null );
dop.input = 'vr vr ?!v';
dop.takingArguments = [ 2, 3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function identicalAre( src1, src2, iterator )
{
  // _.assert( !opts, 'not tested' );
  debugger;
  let it = this._equalAre.pre.call( this, this.identicalAre, arguments );
  let result = this._equalAre( it );
  return result;

  // debugger;
  // let it = identicalAre.lookContinue( identicalAre, arguments );
  // let result = this._equalAre( it );
  // return result;
  // _entityEqualIteratorMake
}

_.routineExtend( identicalAre, _.entityIdentical );

dop = identicalAre.operation = Object.create( null );
dop.input = 'vr vr ?!v';
dop.takingArguments = [ 2, 3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

function equivalentAre( src1, src2, iterator )
{
  // _.assert( !opts, 'not tested' );
  debugger;
  let it = this._equalAre.pre.call( this, this.equivalentAre, arguments );
  let result = this._equalAre( it );
  return result;

  // let it = equivalentAre.lookContinue( identicalAre, arguments );
  // let result = this._equalAre( it );
  // return result;
  // // _entityEqualIteratorMake
}

_.routineExtend( equivalentAre, _.entityIdentical );

dop = equivalentAre.operation = Object.create( null );
dop.input = 'vr vr ?!v';
dop.takingArguments = [ 2, 3 ];
dop.takingVectors = 2;
dop.takingVectorsOnly = false;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;
dop.reducing = true;
dop.homogeneous = true;

//

/* aaa : good coverage required */
/* Dmytro : covered */

function areParallel( src1, src2, accuracy )
{
  let length = src1.length;
  accuracy = ( accuracy !== undefined ) ? accuracy : this.accuracy;

  _.assert( _.numberIs( accuracy ) );
  _.assert( src1.length === src2.length, 'vector.areParallel :', 'src1 and src2 should have same length' );

  if( !length )
  return true;

  let ratio = 0;
  let s = 0;
  while( s < length )
  {

    let allZero1 = src1.eGet( s ) === 0;
    let allZero2 = src2.eGet( s ) === 0;

    if( allZero1 ^ allZero2 )
    return false;

    if( allZero1 )
    {
      s += 1;
      continue;
    }

    ratio = src1.eGet( s ) / src2.eGet( s );
    break; /* Dmytro : enough single ratio to check any other. Also, if it comment out, then needs set s to 0 */
    //break;

    s += 1;

  }

  while( s < length )
  {
    let r = src1.eGet( s ) / src2.eGet( s );

    if( abs( r - ratio ) > accuracy )
    return false;

    s += 1;
  }

  return true;
}

dop = areParallel.operation = Object.create( null );
dop.input = 'vr vr ?s';
dop.takingArguments = [ 2, 3 ];
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

meta._routinesDeclare();

// --
// helper
// --

function mag( v )
{

  _.assert( arguments.length === 1 );

  return this.reduceToMag( v );
}

dop = mag.operation = _.mapExtend( null , Routines.reduceToMag.operation );
dop.input = 'vr';
dop.takingArguments = [ 1, 1 ];
dop.takingVectors = [ 1, 1 ];

//

function magSqr( v )
{

  _.assert( arguments.length === 1 );

  return this.reduceToMagSqr( v );
}

dop = magSqr.operation = _.mapExtend( null , Routines.reduceToMagSqr.operation );
dop.input = 'vr';
dop.takingArguments = [ 1, 1 ];
dop.takingVectors = [ 1, 1 ];


// --
// statistics
// --

//

function dot( dst, src )
{
  let result = 0;
  let length = dst.length;

  _.assert( _.vectorAdapterIs( dst ) );
  _.assert( _.vectorAdapterIs( src ) );
  _.assert( dst.length === src.length, 'src and dst should have same length' );
  _.assert( arguments.length === 2 );

  for( let s = 0 ; s < length ; s++ )
  {
    result += dst.eGet( s ) * src.eGet( s );
  }

  return result;
}

dop = dot.operation = Object.create( null );
dop.input = 'vr vr';
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function distance( src1, src2 )
{
  let result = this.distanceSqr( src1, src2 );
  result = sqrt( result );
  return result;
}

dop = distance.operation = Object.create( null );
dop.input = 'vr vr';
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function distanceSqr( src1, src2 )
{
  let result = 0;
  let length = src1.length;

  _.assert( src1.length === src2.length, 'vector.distanceSqr :', 'src1 and src2 should have same length' );

  for( let s = 0 ; s < length ; s++ )
  {
    result += _sqr( src1.eGet( s ) - src2.eGet( s ) );
  }

  return result;
}

dop = distanceSqr.operation = Object.create( null );
dop.input = 'vr vr';
dop.takingArguments = 2;
dop.takingVectors = 2;
dop.takingVectorsOnly = true;
dop.returningSelf = false;
dop.returningNew = false;
dop.modifying = false;

//

function median( v )
{
  debugger;
  let result = this.distributionRangeSummary( v ).median;
  debugger;
  return result;
}

dop = median.operation = _.mapExtend( null , distributionRangeSummary.trivial.operation );
// dop.input = 'vr';

//

function momentCentral( v, degree, mean )
{
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  return this._momentCentral( v, degree, mean );
}

dop = momentCentral.operation = _.mapExtend( null , Routines._momentCentral.operation );
dop.input = 'vr s ?s';
dop.takingArguments = [ 2, 3 ];

//

function momentCentralConditional( v, degree, mean, filter )
{
  _.assert( arguments.length === 3 || arguments.length === 4 );

  if( _.routineIs( mean ) )
  {
    _.assert( filter === undefined );
    filter = mean;
    mean = null;
  }

  if( mean === undefined || mean === null )
  mean = _.avector.meanConditional( v, filter );

  return this._momentCentralConditional( v, degree, mean, filter );
}

dop = momentCentralConditional.operation = _.mapExtend( null , Routines._momentCentralConditional.operation );
dop.input = 'vr s ?s !v';
dop.takingArguments = [ 3, 4 ];

//

function distributionSummary( v )
{
  let result = Object.create( null );

  result.range = this.distributionRangeSummary( v );
  delete result.range.min.container;
  delete result.range.max.container;

  result.mean = this.mean( v );
  result.variance = this.variance( v, result.mean );
  result.standardDeviation = this.standardDeviation( v, result.mean );
  result.kurtosisExcess = this.kurtosisExcess( v, result.mean );
  result.skewness = this.skewness( v, result.mean );

  return result;
}

dop = distributionSummary.operation = _.mapExtend( null , Routines._momentCentral.operation );
// dop.input = 'vr';
// dop.takingArguments = [ 1, 1 ];

//

function variance( v, mean )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  let degree = 2;
  return this.momentCentral( v, degree, mean );
}

dop = variance.operation = _.mapExtend( null , momentCentral.operation );
dop.input = 'vr ?s';
dop.takingArguments = [ 1, 2 ];

//

function varianceConditional( v, mean, filter )
{
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( _.routineIs( mean ) )
  {
    _.assert( filter === undefined );
    filter = mean;
    mean = null;
  }

  let degree = 2;
  return this.momentCentralConditional( v, degree, mean, filter );
}

dop = varianceConditional.operation = _.mapExtend( null , momentCentralConditional.operation );
dop.input = 'vr ?s !v';
dop.takingArguments = [ 2, 3 ];

//

function standardDeviation()
{
  let result = this.variance.apply( this, arguments );
  return _sqrt( result );
}

dop = standardDeviation.operation = _.mapExtend( null , variance.operation );
dop.input = 'vr ?s';

//

function standardDeviationNormalized( v, mean )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  let result = this.variance( v, mean );

  return _sqrt( result ) / mean;
}

dop = standardDeviationNormalized.operation = _.mapExtend( null , variance.operation );
dop.input = 'vr ?s';

//

function kurtosis( v, mean )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  let variance = this.variance( v, mean );
  let result = this.momentCentral( v, 4, mean );

  return result / _pow( variance, 2 );
}

dop = kurtosis.operation = _.mapExtend( null , variance.operation );
dop.input = 'vr ?s';

//

/* kurtosis of normal distribution is three */

function kurtosisNormalized( v, mean )
{
  let result = this.kurtosis.apply( this, arguments );
  return result - 3;
}

dop = kurtosisNormalized.operation = _.mapExtend( null , variance.operation );
dop.input = 'vr ?s';

//

function skewness( v, mean )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( mean === undefined || mean === null )
  mean = _.avector.mean( v );

  let moment = this.moment( v, 3 );
  let std = this.std( v, mean );

  return moment / _pow( std, 3 );
}

dop = skewness.operation = _.mapExtend( null , variance.operation );
dop.input = 'vr ?s';

// --
// routines
// --

let _routinesMathematical =
{

  // basic

  assign,
  assignVector,

  clone,
  makeSimilar,

  slice,
  // slicedAdapter, /* zzz : deprecate */
  // slicedLong, /* zzz : deprecate */

  /* qqq : implement routine shrinkLong and cover */
  /* qqq : implement routine shrinkAdapter and cover */
  /* qqq : implement routine growLong and cover */
  /* qqq : implement routine growAdapter and cover */

  grow : growAdapter,
  growAdapter,
  growLong,

  shrink : shrinkAdapter,
  shrinkAdapter,
  shrinkLong,

  // resizedAdapter, /* zzz : deprecate */
  // resizedLong, /* zzz : deprecate */

  review, /* aaa : cover please */ /* Dmytro : covered */
  // subarray, /* zzz : deprecate */

  bufferConstructorOf,

  toLong,
  toStr : _toStr,
  _toStr,

  gather,

  map, /* aaa : implement perfect coverage */ /* Dmytro : implemented */
  filter, /* aaa : implement perfect coverage */ /* Dmytro : implemented */
  while : _while,

  // special

  sort,
  randomInRadius,

  crossWithPoints,
  _cross3,
  cross3,
  cross,

  quaternionApply,
  quaternionApply2,
  eulerApply,

  reflect,

  matrixApplyTo,
  matrixHomogenousApply,
  matrixDirectionsApply,

  swapVectors,
  swapAtoms,

  formate,


  // atom-wise, modifying, taking single vector : self

  /* meta._operationTakingDstSrcReturningSelfComponentWise_functor */

  inv,
  invOrOne,

  floor : floorRoutine,
  ceil : ceilRoutine,
  abs : absRoutine,
  round : roundRoutine,

  ceilToPowerOfTwo,

  normalize,

  // atom-wise, assigning, mixed : self /* zzz qqq : deprecate */

  /* meta._operationReturningSelfTakingVariantsComponentWise_functor */
  /* meta._operationReturningSelfTakingVariantsComponentWiseAct_functor */

  // addAssigning : add.assigning,
  // subAssigning : sub.assigning,
  // mulAssigning : mul.assigning,
  // divAssigning : div.assigning,
  //
  // minAssigning : min.assigning,
  // maxAssigning : max.assigning,
  // clampAssigning : clamp.assigning,
  // randomInRangeAssigning : randomInRange.assigning,
  // mixAssigning : mix.assigning,

  // atom-wise, copying, mixed : self /* zzz qqq : deprecate */

  // addCopying : add.copying,
  // subCopying : sub.copying,
  // mulCopying : mul.copying,
  // divCopying : div.copying,
  //
  // minCopying : min.copying,
  // maxCopying : max.copying,
  // clampCopying : clamp.copying,
  // randomInRangeCopying : randomInRange.copying,
  // mixCopying : mix.copying,

  // atom-wise, homogeneous, taking vectors
  // vectors only -> self

  // /*
  // declareHomogeneousTakingVectorsRoutines,
  // */

  // addVectors : Routines.addVectors,
  // subVectors : Routines.subVectors,
  // mulVectors : Routines.mulVectors,
  // divVectors : Routines.divVectors,
  //
  // assignVectors : Routines.assignVectors,
  // minVectors : Routines.minVectors,
  // maxVectors : Routines.maxVectors,
  //
  // // atom-wise, homogeneous, taking scalar
  // // 1 vector , 1 scalar -> self
  //
  // /*
  // declareHomogeneousTakingScalarRoutines,
  // */
  //
  // addScalar : Routines.addScalar,
  // subScalar : Routines.subScalar,
  // mulScalar : Routines.mulScalar,
  // divScalar : Routines.divScalar,
  //
  // assignScalar : Routines.assignScalar,
  // minScalar : Routines.minScalar,
  // maxScalar : Routines.maxScalar,

  // atom-wise

  /*
  _onAtomAtomwise_functor,
  _onVectorsAtomwise_functor,
  */


// atom-wise, homogeneous

  /*
  _routineHomogeneousDeclare,
  routinesHomogeneousDeclare,
  */

  add : Routines.add,
  sub : Routines.sub,
  mul : Routines.mul,
  div : Routines.div,

  min : Routines.min,
  max : Routines.max,

// atom-wise, heterogeneous

  /*
  _routinesHeterogeneousDeclare,
  routinesHeterogeneousDeclare,
  */

  addScaled : Routines.addScaled,
  subScaled : Routines.subScaled,
  mulScaled : Routines.mulScaled,
  divScaled : Routines.divScaled,

  clamp : Routines.clamp,
  randomInRange : Routines.randomInRange,
  mix : Routines.mix,

  // scalarReductor

/*

  _normalizeOperationArity,
  _normalizeOperationFunctions,

  _meta._operationReduceToScalar_functor,
  meta._operationReduceToScalar_functor,
  declareReducingRoutines,

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

  // allFiniteConditional : Routines.allFiniteConditional,
  // anyNanConditional : Routines.anyNanConditional,
  // allIntConditional : Routines.allIntConditional,
  // allZeroConditional : Routines.allZeroConditional,

  // extremal reductor

  /* meta._operationReduceToExtremal_functor*/

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

  reduceToMinValue,
  reduceToMaxValue,
  distributionRangeSummaryValue,

  // logical2 zipper

/*
  _declareHomogeneousLogical2Routine,
  _declareHomogeneousLogical2NotReducingRoutine,
  _declareHomogeneousLogical2ReducingRoutine,
  _declareHomogeneousLogical2ReducingAllRoutine,
  _declareHomogeneousLogical2ReducingAnyRoutine,
  _declareHomogeneousLogical2ReducingNoneRoutine,
  declareHomogeneousLogical2Routines,
*/

  gt : Routines.isGreater,
  ge : Routines.isGreaterEqual,
  ga : Routines.isGreaterAprox,
  gea : Routines.isGreaterEqualAprox,
  lt : Routines.isLess,
  le : Routines.isLessEqual,
  la : Routines.isLessAprox,
  lea : Routines.isLessEqualAprox,

  //

  isIdentical : Routines.isIdentical,
  isNotIdentical : Routines.isNotIdentical,
  isEquivalent : Routines.isEquivalent,
  // isEquivalent2 : Routines.isEquivalent2,
  isNotEquivalent : Routines.isNotEquivalent,
  isGreater : Routines.isGreater,
  isGreaterEqual : Routines.isGreaterEqual,
  isGreaterEqualAprox : Routines.isGreaterEqualAprox,
  isGreaterAprox : Routines.isGreaterAprox,
  isLess : Routines.isLess,
  isLessEqual : Routines.isLessEqual,
  isLessEqualAprox : Routines.isLessEqualAprox,
  isLessAprox : Routines.isLessAprox,

  isNumber : Routines.isNumber,
  isZero : Routines.isZero,
  isFinite : Routines.isFinite,
  isInfinite : Routines.isInfinite,
  isNan : Routines.isNan,
  isInt : Routines.isInt,
  isString : Routines.isString,

  // logical2 reductor

  all, /* qqq : implement perfect coverage */

  allIdentical : Routines.allIdentical,
  allNotIdentical : Routines.allNotIdentical,
  allEquivalent : Routines.allEquivalent,
  // allEquivalent2 : Routines.allEquivalent2,
  allNotEquivalent : Routines.allNotEquivalent,
  allGreater : Routines.allGreater,
  allGreaterEqual : Routines.allGreaterEqual,
  allGreaterEqualAprox : Routines.allGreaterEqualAprox,
  allGreaterAprox : Routines.allGreaterAprox,
  allLess : Routines.allLess,
  allLessEqual : Routines.allLessEqual,
  allLessEqualAprox : Routines.allLessEqualAprox,
  allLessAprox : Routines.allLessAprox,

  allNumber : Routines.allNumber,
  allZero : Routines.allZero,
  allFinite : Routines.allFinite,
  allInfinite : Routines.allInfinite,
  allNan : Routines.allNan,
  allInt : Routines.allInt,
  allString : Routines.allString,

  //

  any, /* qqq : implement perfect coverage */

  anyIdentical : Routines.anyIdentical,
  anyNotIdentical : Routines.anyNotIdentical,
  anyEquivalent : Routines.anyEquivalent,
  // anyEquivalent2 : Routines.anyEquivalent2,
  anyNotEquivalent : Routines.anyNotEquivalent,
  anyGreater : Routines.anyGreater,
  anyGreaterEqual : Routines.anyGreaterEqual,
  anyGreaterEqualAprox : Routines.anyGreaterEqualAprox,
  anyGreaterAprox : Routines.anyGreaterAprox,
  anyLess : Routines.anyLess,
  anyLessEqual : Routines.anyLessEqual,
  anyLessEqualAprox : Routines.anyLessEqualAprox,
  anyLessAprox : Routines.anyLessAprox,

  anyNumber : Routines.anyNumber,
  anyZero : Routines.anyZero,
  anyFinite : Routines.anyFinite,
  anyInfinite : Routines.anyInfinite,
  anyNan : Routines.anyNan,
  anyInt : Routines.anyInt,
  anyString : Routines.anyString,

  //

  none, /* qqq : implement perfect coverage */

  noneIdentical : Routines.noneIdentical,
  noneNotIdentical : Routines.noneNotIdentical,
  noneEquivalent : Routines.noneEquivalent,
  // noneEquivalent2 : Routines.noneEquivalent2,
  noneNotEquivalent : Routines.noneNotEquivalent,
  noneGreater : Routines.noneGreater,
  noneGreaterEqual : Routines.noneGreaterEqual,
  noneGreaterEqualAprox : Routines.noneGreaterEqualAprox,
  noneGreaterAprox : Routines.noneGreaterAprox,
  noneLess : Routines.noneLess,
  noneLessEqual : Routines.noneLessEqual,
  noneLessEqualAprox : Routines.noneLessEqualAprox,
  noneLessAprox : Routines.noneLessAprox,

  noneNumber : Routines.noneNumber,
  noneZero : Routines.noneZero,
  noneFinite : Routines.noneFinite,
  noneInfinite : Routines.noneInfinite,
  noneNan : Routines.noneNan,
  noneInt : Routines.noneInt,
  noneString : Routines.noneString,

  // logical1 singler

/*
  _declareLogic1SinglerRoutine,
  _declareLogic1ReducingSinglerRoutine,
  _declareLogic1ReducingSinglerAllRoutine,
  _declareLogic1ReducingSinglerAnyRoutine,
  _declareLogic1ReducingSinglerNoneRoutine,
  declareLogic1Routines,
*/

  // interruptible reductor with bool result

  _equalAre,
  equalAre,
  identicalAre,
  equivalentAre,

  areParallel,

  // helper

  mag,
  magSqr,

  // statistics

  dot,
  distance,
  distanceSqr,

  median,

  momentCentral,
  momentCentralConditional,

  distributionSummary,

  variance,
  varianceConditional,

  std : standardDeviation,
  standardDeviation,
  coefficientOfVariation : standardDeviationNormalized,
  standardDeviationNormalized,

  kurtosis,
  kurtosisNormalized,
  kurtosisExcess : kurtosisNormalized,

  skewness,

}

//

for( let r in Routines )
_.assert( _.routineIs( _routinesMathematical[ r ] ), `routine::${r} was not declared explicitly in the proto map as it should` );

//

let Forbidden =
{
  randomInRange : 'randomInRange',
}

// --
// after
// --

_.assert( _.routineIs( _routinesMathematical.assign ) );
_.assert( _.objectIs( _routinesMathematical.assign.operation ) );
_.assert( _.arrayIs( _routinesMathematical.assign.operation.takingArguments ) );

for( let r in _routinesMathematical )
meta._routinePostForm( _routinesMathematical[ r ], r );

// --
// declare
// --

let Extension =
{

  _routinesMathematical,

}

_.mapExtend( Extension, _routinesMathematical );
_.mapExtend( _.vectorAdapter, Extension );

//

_.vectorAdapter._meta._routinesLongWrap_functor();

//

_.assert( _.mapOwnKey( _.avector, 'withDefaultLong' ) );
_.assert( _.objectIs( _.avector.withDefaultLong ) );
_.assert( _.objectIs( _.avector.withDefaultLong.Array ) );
_.assert( _.objectIs( _.avector.withDefaultLong.F32x ) );
_.assert( Object.getPrototypeOf( _.avector ) === wTools );
_.assert( _.objectIs( _.vectorAdapter._routinesMathematical ) );
_.assert( !_.avector.isValid );
_.assert( _.routineIs( _.avector.allFinite ) );

//

_.assert( _.routineIs( _.vectorAdapter.reduceToMean ) );
_.assert( !_.vectorAdapter.isValid );
_.assert( _.routineIs( _.vectorAdapter.allFinite ) );
_.assert( _.routineIs( _.vectorAdapter.reduceToMaxValue ) );
_.assert( _.routineIs( _.vectorAdapter.floor ) );
_.assert( _.routineIs( _.vectorAdapter.ceil ) );
_.assert( _.routineIs( _.vectorAdapter.abs ) );
_.assert( _.routineIs( _.vectorAdapter.round ) );
_.assert( _.routineIs( _.vectorAdapter.allIdentical ) );
_.assert( _.routineIs( _.vectorAdapter.isZero ) );
_.assert( _.longIdentical( _.vectorAdapter.allIdentical.operation.takingArguments, [ 2, 2 ] ) );
_.assert( _.vectorAdapter.accuracy >= 0 );
_.assert( _.vectorAdapter.accuracySqr >= 0 );
_.assert( _.numberIs( _.vectorAdapter.accuracy ) );
_.assert( _.numberIs( _.vectorAdapter.accuracySqr ) );
_.assert( _.routineIs( _routinesMathematical.reduceToMaxValue ) );

})();
