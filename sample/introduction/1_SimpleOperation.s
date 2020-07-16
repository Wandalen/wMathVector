let _ = require( 'wmathvector' );

var vector1 = [ 1, 2, 3 ];
var vector2 = [ 4, 5, 6 ];

_.avector.add( vector1, vector2 );

console.log( 'vector1 :', vector1 );
/* log : vector1 [ 5, 7, 9 ] */
console.log( 'vector2 :', vector2 );
/* log : vector2 : [ 4, 5, 6 ] */
