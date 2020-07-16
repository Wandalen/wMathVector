let _ = require( 'wmathvector' );

var array1 = [ 1, 2, 3 ];
var adapter1 = _.vectorAdapter.from( array1 );

_.avector.mul( array1, 2 );
_.vectorAdapter.mul( adapter1, 2 );
adapter1.mul( 2 );

console.log( 'adapter1 :', adapter1 );
/* log : adapter1 :  VectorAdapter.x3.Array :: 8.000, 16.000, 24.000 */
