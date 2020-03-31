var _ = require( 'wmathvector' );

var srcVector1 = [ 1, 2, 3 ];
var srcVector2 = [ 4, 5, 6 ];
var dstVector = _.avector.add( null, srcVector1, srcVector2 );

console.log( srcVector1 );
/* log : [ 1, 2, 3 ] */
console.log( srcVector2 );
/* log : [ 4, 5, 6 ] */
console.log( dstVector );
/* log : [ 5, 7, 9 ] */
console.log( dstVector === srcVector1 );
/* log : false */
