let _ = require( 'wmathvector' );

var vector1 = _.vectorAdapter.fromNumber( 1, 3 );
var vector2 = _.vectorAdapter.from([ 4, 5, 6 ]);

console.log( 'vector1 :', vector1 );
/* log : vector1 :  VectorAdapter.x3.F32x :: 1.000, 1.000, 1.000 */
console.log( 'vector2 :', vector2 );
/* log : vector1 :  VectorAdapter.x3.Array :: 4.000, 5.000, 6.000 */

_.vectorAdapter.add( vector2, vector1 );

console.log( 'vector1 :', vector1 );
/* log : vector1 :  VectorAdapter.x3.F32x :: 1.000, 1.000, 1.000 */
console.log( 'vector2 :', vector2 );
/* log : vector2 :  VectorAdapter.x3.Array :: 5.000, 6.000, 7.000 */
