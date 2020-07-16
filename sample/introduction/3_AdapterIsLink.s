let _ = require( 'wmathvector' );

var array = [ 1, 2, 3 ];
var vector1 = _.vectorAdapter.from( array );

_.avector.mul( array, 2 );

console.log( 'vector1 :', vector1 );
/* log : vector1 :  VectorAdapter.x3.Array :: 2.000, 4.000, 6.000 */
