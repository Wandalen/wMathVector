if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

var array1 = [ 1, 2, 3 ];
var array2 = [ 4, 5, 6 ];
var vector1 = _.vectorAdapter.from( array1 );
var vector2 = _.vectorAdapter.from( array2 );

console.log( vector1.toStr() );
/* log : "1.000, 2.000, 3.000" */
console.log( vector2.toStr() );
/* log : "4.000, 5.000, 6.000" */

_.vectorAdapter.add( vector1, vector2 );

console.log( vector1.toStr() );
/* log : "5.000, 7.000, 9.000" */
console.log( vector2.toStr() );
/* log : "4.000, 5.000, 6.000" */

console.log( array1 );
/* log : [ 5, 7, 9 ] */
console.log( array2 );
/* log : [ 4, 5, 6 ] */

