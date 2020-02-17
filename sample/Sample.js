if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

/* add 2 avectors */

var a1 = [ 1,2,5,9 ];
var a2 = [ 1,2,3,4 ];
_.avector.add( a1,a2 );
console.log( 'add 2 avectors' );
console.log( 'a1',a1 );
console.log( 'a2',a2 );
/*
a1 [ 2, 4, 8, 13 ]
a2 [ 1, 2, 3, 4 ]
*/

/* add 2 vectors made from arrays */

var a1 = [ 1,2,5,9 ];
var a2 = [ 1,2,3,4 ];
var v1 = _.vector.from( a1 );
var v2 = _.vector.from( a2 );
_.vector.add( v1,v2 );
console.log( 'add 2 vectors made from arrays' );
console.log( 'a1',a1 );
console.log( 'a2',a2 );
/*
a1 [ 2, 4, 8, 13 ]
a2 [ 1, 2, 3, 4 ]
*/

/* add 2 vectors made from single array */

var a = [ 0,1,2,5,9,0,0,1,2,3,4,0 ];
var v1 = _.vector.fromSubArray( a,1,4 );
var v2 = _.vector.fromSubArray( a,7,4 );
_.vector.add( v1,v2 );
console.log( 'add 2 vectors made from single array' );
console.log( 'v1',v1.toStr() );
console.log( 'v2',v2.toStr() );
console.log( 'a',a );

/*
v1 2.000 4.000 8.000 13.00
v2 1.000 2.000 3.000 4.000
a [ 0, 2, 4, 8, 13, 0, 0, 1, 2, 3, 4, 0 ]
*/
