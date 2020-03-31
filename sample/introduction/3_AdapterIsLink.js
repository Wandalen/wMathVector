if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

var array = [ 1, 2, 3 ];
var vector1 = _.vectorAdapter.from( array );

_.avector.mul( array, 2 );

console.log( vector1.toStr() );
/* log : "2.000, 4.000, 6.000" */

