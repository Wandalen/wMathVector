(function _Namespaces_s_() {

'use strict';

/**
 *@summary Collection of functions for vector math
  @namespaces "wTools.avector","wTools.vectorAdapter"
  @module Tools/math/Vector
*/

const _ = _global_.wTools;

_.vectorAdapter = _.vad = _.vectorAdapter || _.vad || Object.create( null );
_.avector = _.vector = _.avector || _.vector || Object.create( null );

// --
// declare
// --

let AdapterExtension =
{
  // vectorAdapter : _.vectorAdapter,

  NamespaceName : 'vectorAdapter',
  NamespaceQname : 'wTools/vectorAdapter',
  TypeName : 'VectorAdapter',
  SecondTypeName : 'VectorAdapter',
  InstanceConstructor : null,
  IsFixedLength : true,
  tools : _,

}

Object.setPrototypeOf( _.vectorAdapter, wTools );
_.props.extend( _.vectorAdapter, AdapterExtension );

_.vectorAdapter.long = Object.create( _.long );
_.vectorAdapter.long.namespaces = Object.create( _.long.namespaces );
_.vectorAdapter.long.toolsNamespacesByType = Object.create( _.long.toolsNamespacesByType );
_.vectorAdapter.long.toolsNamespacesByName = Object.create( _.long.toolsNamespacesByName );
_.vectorAdapter.long.toolsNamespaces = _.vectorAdapter.long.toolsNamespacesByName;
_.vectorAdapter.long.tools = _.vectorAdapter;
_.vectorAdapter.withLong = _.vectorAdapter.long.toolsNamespacesByType;

_.long._namespaceRegister( _.vectorAdapter, 'defaultVad' );

_.vectorAdapter.defaultLong = _.vectorAdapter.withLong.F32x.defaultLong;
_.defaultVad = _.vectorAdapter;

_.assert( _.defaultVad === _.vectorAdapter );
_.assert( _.vectorAdapter.long.tools === _.vectorAdapter );
_.assert( _.vectorAdapter.withLong.Array.tools.defaultVad === _.vectorAdapter );

_.assert( _.object.isBasic( _.withLong.Fx ) );
_.assert( _.vectorAdapter.longType === undefined );
_.vectorAdapter.longType = _.withLong.Fx;
_.assert( _.object.isBasic( _.vectorAdapter.longType ) );
_.assert( _.routineIs( _.vectorAdapter.longType.longFrom ) );
_.assert( _.numberDefined( _.accuracy ) );
_.assert( _.numberDefined( _.accuracySqr ) );
_.assert( _.numberDefined( _.accuracySqrt ) );


//

let AvectorExtension =
{
  NamespaceName : 'avector',
  NamespaceQname : 'wTools/avector',
  TypeName : 'Vector',
  SecondTypeName : 'Vector',
  InstanceConstructor : null,
  IsFixedLength : true,
  tools : _,
}

Object.setPrototypeOf( _.avector, wTools );
_.props.extend( _.avector, AvectorExtension );

_.avector.long = Object.create( _.long );
_.avector.long.namespaces = Object.create( _.long.namespaces );
_.avector.long.toolsNamespacesByType = Object.create( _.long.toolsNamespacesByType );
_.avector.long.toolsNamespacesByName = Object.create( _.long.toolsNamespacesByName );
_.avector.long.toolsNamespaces = _.avector.long.toolsNamespacesByName;
_.avector.long.tools = _.avector;
_.avector.withLong = _.avector.long.toolsNamespacesByType;

_.long._namespaceRegister( _.avector, 'defaultVector' );

_.avector.defaultLong = _.avector.withLong.F32x.defaultLong;
_.defaultVector = _.avector;

_.assert( _.defaultVector === _.avector );
_.assert( _.avector.long.tools === _.avector );
_.assert( _.avector.withLong.Array.tools.defaultVector === _.avector );

_.assert( _.mapOnlyOwnKey( _.avector, 'withLong' ) );
_.assert( _.object.isBasic( _.avector.withLong ) );
_.assert( _.object.isBasic( _.avector.withLong.Array ) );
_.assert( _.object.isBasic( _.avector.withLong.F32x ) );
_.assert( Object.getPrototypeOf( _.avector ) === wTools );

//

})();
