if( typeof module !== 'undefined' )
require( 'wmathvector' );

let _ = wTools;

/* add 2 avectors */

var a1 = [ 1, 2, 5, 9 ];
var a2 = [ 1, 2, 3, 4 ];
_.avector.add( a1, a2 );
console.log( 'add 2 avectors' );
console.log( 'a1', a1 );
/* log : "a1 [ 2, 4, 8, 13 ]" */
console.log( 'a2', a2 );
/* log : "a2 [ 1, 2, 3, 4 ]" */

/* add 2 vectorAdapters made from arrays */

var a1 = [ 1, 2, 5, 9 ];
var a2 = [ 1, 2, 3, 4 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
_.vectorAdapter.add( v1, v2 );
console.log( 'add 2 vectors made from arrays' );
console.log( 'a1', a1 );
/* log : "a1 [ 2, 4, 8, 13 ]" */
console.log( 'a2', a2 );
/* log : "a2 [ 1, 2, 3, 4 ]" */

/* add 2 vectorAdapters made from single array */

var a = [ 0, 1, 2, 5, 9, 0, 0, 1, 2, 3, 4, 0 ];
var v1 = _.vectorAdapter.fromLongLrange( a, 1, 4 );
var v2 = _.vectorAdapter.fromLongLrange( a, 7, 4 );
v1.add( v2 );
console.log( 'add 2 vectors made from single array' );
console.log( 'v1', v1 );
/* log : "v1 VectorAdapter.x4.Array :: 2.000 4.000 8.000 13.00" */
console.log( 'v2', v2 );
/* log : "v2 VectorAdapter.x4.Array :: 1.000 2.000 3.000 4.000" */
console.log( 'a', a );
/* log : "a [ 0, 2, 4, 8, 13, 0, 0, 1, 2, 3, 4, 0 ]" */

