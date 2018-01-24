if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

/* add 2 avectors */

var a1 = [ 1, 2, 3 ];
var a2 = [ 1, 2, 3 ];
var a3 = [ 1, 2, 3 ];
var avector = wTools.avector.add( a1, a2, a3 );
console.log( 'avector: ', avector );
console.log( 'a1:', a1 );

/* add 2 avectors and scalar */

var a1 = [ 0, 0, 0 ];
var a2 = [ 0, 0, 0 ];
var a3 =  5;
var a4 =  7;
var avector = wTools.avector.add( a1, a2, a3, a4 );
console.log( 'avector: ', avector );
console.log( 'a1:', a1 );

/* saving add result to new avector */

var a1 = [ 0, 0, 0 ];
var a2 = [ 0, 0, 0 ];
var a3 =  5;
var a4 =  7;
var vector = wTools.avector.add( null, a1, a2, a3, a4 );
console.log( 'avector: ', avector );
console.log( 'a1:', a1 );

/* using vector wrapper and single avector as container */

var a = [ 0, 0, 1, 1, 2, 2 ];

var v1Offset = 0;
var v1Length = 3;
var v1 = wTools.vector.fromSubArray( a, v1Offset, v1Length );

var v2Offset = v1Length;
var v2Length = 3;
var v2 = wTools.vector.fromSubArray( a, v2Offset, v2Length );

wTools.vector.add( v1, v2 );

console.log( 'v1: ', v1 );
console.log( 'v2: ', v2 );
console.log( 'a: ', a );

/* vector wrapper from avector */

var avector = [ 1, 2, 3 ];
var vector = wTools.vector.from( avector );
console.log( vector )

/* setting and getting data from container through vector wrapper */

var avector = [ 1, 2, 3 ];
var vector = wTools.vector.from( avector );
vector.eSet( 0, 5 );
console.log( vector.eGet( 0 ) )
