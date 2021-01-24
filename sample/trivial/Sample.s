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
