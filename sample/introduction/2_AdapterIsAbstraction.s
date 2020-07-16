let _ = require( 'wmathvector' );

var array1 = [ 1, 2, 3 ];
var array2 = [ 4, 5, 6 ];
var vector1 = _.vectorAdapter.from( array1 );
var vector2 = _.vectorAdapter.from( array2 );

console.log( 'vector1 :', vector1 );
/* log : vector1 :  VectorAdapter.x3.Array :: 1.000 2.000 3.000 */
console.log( 'vector2 :', vector2 );
/* log : vector2 :  VectorAdapter.x3.Array :: 4.000 5.000 6.000 */

_.vectorAdapter.add( vector1, vector2 );

console.log( 'vector1 :', vector1 );
/* log : vector1 :  VectorAdapter.x3.Array :: 5.000 7.000 9.000 */
console.log( 'vector2 :', vector2 );
/* log : vector2 :  VectorAdapter.x3.Array :: 4.000 5.000 6.000 */

console.log( 'array1 :', array1 );
/* log : array1 : [ 5, 7, 9 ] */
console.log( 'array2 :', array2 );
/* log : array2 : [ 4, 5, 6 ] */
