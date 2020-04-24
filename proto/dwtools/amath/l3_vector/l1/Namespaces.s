(function _Namespaces_s_() {

'use strict';

/**
 *@summary Collection of functions for vector math
  @namespaces "wTools.avector","wTools.vectorAdapter"
  @module Tools/math/Vector
*/

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = _.longSlice;
let _sqrt = Math.sqrt;
let _abs = Math.abs;
let _sqr = _.math.sqr;

_.vectorAdapter = _.vectorAdapter || Object.create( null );
_.avector = _.avector || Object.create( null );

// --
// class
// --

function VectorAdapter()
{
  throw _.err( 'should not be called' )
};

VectorAdapter.prototype = Object.create( null );
VectorAdapter.prototype._vectorBuffer = null;
_.VectorAdapter = VectorAdapter;

// --
// declare
// --

let AdapterClassExtension =
{
  vectorAdapter : _.vectorAdapter,
}

_.mapExtend( _.VectorAdapter, AdapterClassExtension );
_.mapExtend( _.VectorAdapter.prototype, AdapterClassExtension );

//

let AdapterExtension =
{
  vectorAdapter : _.vectorAdapter,
}

Object.setPrototypeOf( _.vectorAdapter, wTools );
_.mapExtend( _.vectorAdapter, AdapterExtension );

_.longDescriptorProducer.applyTo( _.vectorAdapter, 'Fx' );
_.assert( Object.getPrototypeOf( _.vectorAdapter.withDefaultLong.Array ) === _.vectorAdapter );

_.assert( _.objectIs( _.withDefaultLong.Fx ) );
_.assert( _.vectorAdapter.long === undefined );
_.vectorAdapter.long = _.withDefaultLong.Fx;
_.assert( _.objectIs( _.vectorAdapter.long ) );
_.assert( _.routineIs( _.vectorAdapter.long.longFrom ) );
_.assert( _.numberDefined( _.accuracy ) );
_.assert( _.numberDefined( _.accuracySqr ) );
_.assert( _.numberDefined( _.accuracySqrt ) );

//

let AvectorExtension =
{
}

Object.setPrototypeOf( _.avector, wTools );
_.mapExtend( _.avector, AvectorExtension );

_.longDescriptorProducer.applyTo( _.avector, 'Fx' );
_.assert( Object.getPrototypeOf( _.avector.withDefaultLong.Array ) === _.avector );

_.assert( _.mapOwnKey( _.avector, 'withDefaultLong' ) );
_.assert( _.objectIs( _.avector.withDefaultLong ) );
_.assert( _.objectIs( _.avector.withDefaultLong.Array ) );
_.assert( _.objectIs( _.avector.withDefaultLong.F32x ) );
_.assert( Object.getPrototypeOf( _.avector ) === wTools );

//

})();
