(function _Namespaces_s_() {

'use strict';

/**
 *@summary Collection of functions for vector math
  @namespaces "wTools.avector","wTools.vectorAdapter"
  @module Tools/math/Vector
*/

let _ = _global_.wTools;

_.vectorAdapter = _.vad = _.vectorAdapter || _.vad || Object.create( null );
_.avector = _.vector = _.avector || _.vector || Object.create( null );

// --
// declare
// --

// let AdapterExtension =
// {
//   vectorAdapter : _.vectorAdapter,
// }

Object.setPrototypeOf( _.vectorAdapter, wTools );
// _.mapExtend( _.vectorAdapter, AdapterExtension );

_.longDescriptorProducer.applyTo( _.vectorAdapter, 'Fx' );
_.assert( Object.getPrototypeOf( _.vectorAdapter.withDefaultLongType.Array ) === _.vectorAdapter );

_.assert( _.objectIs( _.withDefaultLongType.Fx ) );
_.assert( _.vectorAdapter.longType === undefined );
_.vectorAdapter.longType = _.withDefaultLongType.Fx;
_.assert( _.objectIs( _.vectorAdapter.longType ) );
_.assert( _.routineIs( _.vectorAdapter.longType.longFrom ) );
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
_.assert( Object.getPrototypeOf( _.avector.withDefaultLongType.Array ) === _.avector );

_.assert( _.mapOwnKey( _.avector, 'withDefaultLongType' ) );
_.assert( _.objectIs( _.avector.withDefaultLongType ) );
_.assert( _.objectIs( _.avector.withDefaultLongType.Array ) );
_.assert( _.objectIs( _.avector.withDefaultLongType.F32x ) );
_.assert( Object.getPrototypeOf( _.avector ) === wTools );

//

})();
