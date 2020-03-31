if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

var vector1 = [ 1, 2, 3 ];
var vector2 = [ 4, 5, 6 ];

_.avector.add( vector1, vector2 );

console.log( vector1 );
/* log : [ 5, 7, 9 ] */
console.log( vector2 );
/* log : [ 4, 5, 6 ] */
