(function _AdapterClass_s_() {

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

let accuracy = _.accuracy;
let accuracySqr = _.accuracySqr;

let Parent = null;
let Self = _.VectorAdapter;
let meta = _.vectorAdapter._meta;

// --
// etc
// --

/**
 * Routine to() converts vector to instance of another class. If destination class is VectorAdapter, then routine
 * returns original vector.
 *
 * @param { Function } cls - Constructor of the class. The valid constructors are: Array, _.Matrix, _.VectorAdapter.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * var got = src.to( Array );
 * console.log( got );
 * // log [ 3, 4, 5 ]
 *
 * @returns { Array|Matrix|VectorAdapter } - Returns vector as instance of destination class.
 * @function to
 * @throws { Error } If arguments.length is not equal to one.
 * @throws { Error } If {-cls-} is not Array, _.Matrix, _.VectorAdapter.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function to( cls )
{
  let self = this;
  let result;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.constructorLikeArray( cls ) )
  {
    result = new cls( self.length );
    for( let i = 0 ; i < result.length ; i++ )
    result[ i ] = self.eGet( i );
    return result;
  }
  else if( _.constructorIsVector( cls ) )
  {
    return this;
  }
  else if( _.constructorIsMatrix( cls ) )
  {
    return _.Matrix.makeCol( this )
  }

  _.assert( 0, 'unknown class to convert to', _.strType( cls ) );
}

//

/**
 * Routine eGet() ( from "element get" ) returns value of vector element with an index.
 *
 * @param { Number } index - Index of element.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * var got = src.eGet( 1 );
 * console.log( got );
 * // log 4
 *
 * @returns { Number } - Returns element of vector.
 * @function eGet
 * @throws { Error } If arguments.length is not equal to one.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function eGet( index )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.vectorAdapter.eGet( self, index );
}

//

/**
 * Routine eSet() ( from "element set" ) returns value of vector element with an index.
 *
 * @param { Number } index - Index of element.
 * @param { Number } val - Value to set.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * src.eSet( 1, 0 );
 * console.log( src.toStr() );
 * // log "3.000, 0.000, 5.000"
 *
 * @returns { Undefined } - Returns not a value, sets element of vector.
 * @function eSet
 * @throws { Error } If arguments.length is not equal to two.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function eSet( index, val )
{
  let self = this;
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return this.vectorAdapter.eSet( self, index, val );
}

// //
//
// function assign()
// {
//   let self = this;
//   return this.vectorAdapter.assign( self, ... arguments );
// }

//

/**
 * Routine copy() copies the values from source vector.
 * The adapter and vector should have equal lengths.
 *
 * @param { VectorAdapter } src - Source vector.
 *
 * @example
 * var src = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * src.copy( [ 0, 1, 1 ] );
 * console.log( src.toStr() );
 * // log "0.000, 1.000, 1.000"
 *
 * @returns { VectorAdapter } - Returns adapter filled by content of source vector.
 * @function copy
 * @throws { Error } If arguments.length is not equal to one.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function copy( src )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.vectorAdapter.assign( self, src );
}

//

// function clone()
// {
//   let self = this;
//   _.assert( arguments.length === 0, 'Expects no arguments' );
//   _.assert( _.vectorAdapterIs( self ) );
//   return this.vectorAdapter.clone( self );
// }

// //
//
// function makeSimilar( length )
// {
//   let self = this;
//   _.assert( arguments.length === 0 || arguments.length === 1 );
//   return this.vectorAdapter.makeSimilar( self, length );
// }

// //
//
// function slice( b, e )
// {
//   let self = this;
//
//   _.assert( arguments.length <= 2 );
//   _.assert( _.vectorAdapterIs( self ) );
//
//   return this.vectorAdapter.slice( self, b, e );
// }
//
// //
//
// function slicedLong( b, e )
// {
//   let self = this;
//
//   _.assert( arguments.length <= 2 );
//   _.assert( _.vectorAdapterIs( self ) );
//
//   return this.vectorAdapter.slicedLong( self, b, e );
// }
//
// //
//
// function slicedAdapter( b, e )
// {
//   let self = this;
//
//   _.assert( arguments.length <= 2 );
//   _.assert( _.vectorAdapterIs( self ) );
//
//   return this.vectorAdapter.slicedAdapter( self, b, e );
// }
//
// //
//
// function resizedLong( first, last, val )
// {
//   let self = this;
//   _.assert( arguments.length <= 3 );
//   let result = this.vectorAdapter.resizedLong( self, first, last, val );
//   return result;
// }
//
// //
//
// function resizedAdapter( first, last, val )
// {
//   let self = this;
//   _.assert( arguments.length <= 3 );
//   let result = this.vectorAdapter.resizedAdapter( self, first, last, val );
//   return result;
// }
//
// //
//
// function subarray( first, last )
// {
//   let self = this;
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   return this.vectorAdapter.subarray( self, first, last );
// }

// //
//
// function toStr( o )
// {
//   let self = this;
//
//   _.assert( arguments.length === 0 || arguments.length === 1 );
//   _.assert( _.mapIs( o ) || o === undefined );
//   _.assert( _.vectorAdapterIs( self ) );
//
//   return this.vectorAdapter._toStr( self, o );
// }
//
// //
//
// function equalWith( src2, it )
// {
//   let src1 = this;
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   return this.vectorAdapter.equalAre( src2, src1, it );
// }
//
// equalWith.takingArguments = 2;
// equalWith.takingVectors = 2;
// equalWith.takingVectorsOnly = true;
// equalWith.returningSelf = false;
// equalWith.returningNew = false;
// equalWith.modifying = false;

//

/**
 * Routine identicalWith() check that vectors are identical.
 *
 * @param { VectorAdapter } src2 - Source vector.
 * @param { Map } it - Options map.
 *
 * @example
 * var src1 = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * var src2 = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * var got = src1.identicalWith( src2 );
 * console.log( got );
 * // log true
 *
 * @returns { Boolean } - Returns whether the vectors are identical.
 * @function identicalWith
 * @throws { Error } If arguments.length is less then one or more then two.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function identicalWith( src2, it )
{
  let src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( 0, 'not tested' );
  return this.vectorAdapter.identicalAre( src2, src1, it );
}

identicalWith.takingArguments = 2;
identicalWith.takingVectors = 2;
identicalWith.takingVectorsOnly = true;
identicalWith.returningSelf = false;
identicalWith.returningNew = false;
identicalWith.modifying = false;

//

/**
 * Routine equivalentWith() check that vectors are equivalent.
 *
 * @param { VectorAdapter } src2 - Source vector.
 * @param { Map } it - Options map.
 *
 * @example
 * var src1 = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * var src2 = _.vectorAdapter.fromLong( new U8x( [ 3, 4.0000001, 5 ] ) );
 * var got = src1.equivalentWith( src2 );
 * console.log( got );
 * // log true
 *
 * @returns { Boolean } - Returns whether the vectors are equivalent.
 * @function equivalentWith
 * @throws { Error } If arguments.length is less then one or more then two.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function equivalentWith( src2, it )
{
  let src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( 0, 'not tested' );
  return this.vectorAdapter.equivalentAre( src2, src1, it );
}

equivalentWith.takingArguments = [ 2, 3 ];
equivalentWith.takingVectors = 2;
equivalentWith.takingVectorsOnly = false;
equivalentWith.returningSelf = false;
equivalentWith.returningNew = false;
equivalentWith.modifying = false;

// //
//
// function sameWith( src2 )
// {
//   let src1 = this;
//   _.assert( 0, 'not implemented' );
//   debugger; /* zzz */
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   if( src1._vectorBuffer !== src2._vectorBuffer )
//   return false;
//   if( src1.offset !== src2.offset )
//   return false;
//   if( src1.length !== src2.length )
//   return false;
//   debugger;
//   return true;
// }
//
// sameWith.takingArguments = [ 2, 3 ];
// sameWith.takingVectors = 2;
// sameWith.takingVectorsOnly = false;
// sameWith.returningSelf = false;
// sameWith.returningNew = false;
// sameWith.modifying = false;

//

/**
 * Routine hasShape() check that vectors have identical length.
 *
 * @param { VectorAdapter|Matrix } src - Source vector.
 *
 * @example
 * var src1 = _.vectorAdapter.fromLong( new U8x( [ 3, 4, 5 ] ) );
 * var src2 = _.vectorAdapter.fromLong( [ 0, 0, 0 ] );
 * var got = src1.hasShape( src2 );
 * console.log( got );
 * // log true
 *
 * @returns { Boolean } - Returns whether the vectors have identical length.
 * @function hasShape
 * @throws { Error } If arguments.length is less then one or more then two.
 * @memberof "namespace:wTools.vectorAdapter"
 */

function hasShape( src )
{
  if( _.matrixIs( src ) )
  return src.dims.length === 2 && src.dims[ 0 ] === self.length && src.dims[ 1 ] === 1;
  return this.length === src.length;
}

hasShape.takingArguments = 2;
hasShape.takingVectors = 2;
hasShape.takingVectorsOnly = true;
hasShape.returningSelf = false;
hasShape.returningNew = false;
hasShape.modifying = false;

// --
// declare
// --

let Proto =
{

  to,

  eGet,
  eSet,

  // assign,
  copy,

  // makeSimilar,

  // slice,
  // slicedLong,
  // slicedAdapter,
  //
  // resizedLong,
  // resizedAdapter,
  //
  // subarray,

  // toStr,

  // equalWith,
  identicalWith,
  equivalentWith,
  // sameWith,

  hasShape,

}

_.mapExtend( Self.prototype, Proto );

// --
// declare
// --

meta._adapterClassDeclare();

_.assert( _.routineIs( Self.prototype.mag ) );
_.assert( _.routineIs( Self.prototype.magSqr ) );
_.assert( _.routineIs( Self.prototype.toLong ) );
_.assert( _.routineIs( Self.prototype.toStr ) );
_.assert( _.routineIs( Self.prototype.abs ) );
_.assert( _.routineIs( Self.prototype.makeSimilar ) );
_.assert( _.routineIs( Self.prototype.assign ) );
_.assert( _.routineIs( Self.prototype.slice ) );
_.assert( _.routineIs( Self.prototype.allZero ) );

_.assert( _.routineIs( _.vectorAdapter.toLong ) );
_.assert( _.routineIs( _.vectorAdapter.toStr ) );

})();
