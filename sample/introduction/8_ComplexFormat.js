var _ = require( 'wmathvector' );

var vector1 = _.vectorAdapter.fromNumber( 1, 3 );
var vector2 = _.vectorAdapter.from([ 4, 5, 6 ]);

console.log( 'vector1 : ', vector1.toStr() );
/* log : vector1 : 1.000, 1.000, 1.000 */
console.log( 'vector2 : ', vector2.toStr() );
/* log : vector1 : 4.000, 5.000, 6.000 */

_.vectorAdapter.add( vector2, vector1 );

console.log( 'vector1 : ', vector1.toStr() );
/* log : vector1 : 1.000, 1.000, 1.000 */
console.log( 'vector2 : ', vector2.toStr() );
/* log : vector2 : 5.000, 6.000, 7.000 */
