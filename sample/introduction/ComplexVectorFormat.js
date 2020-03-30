if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

var vector1 = _.vectorAdapter.fromNumber( 1, 3 );
var vector2 = _.vectorAdapter.from([ 4, 5, 6 ]);

console.log( vector1.toStr() );
/* log : [ 1, 1, 1 ] */
console.log( vector2.toStr() );
/* log : [ 4, 5, 6 ] */

_.vectorAdapter.add( vector2, vector1 );

console.log( vector1.toStr() );
/* log : [ 1, 1, 1 ] */
console.log( vector2.toStr() );
/* log : [ 5, 6, 7 ] */

