let _ = require( 'wmathvector' );

var array = [ 1, 2, 3 ];
var buffer = new F32x([ 1, 2, 3 ]);
var vad = _.vad.from([ 1, 2, 3 ]);

console.log( 'arrayIs( array ) :', _.arrayIs( array ) );
/* log : arrayIs( array ) : true */
console.log( 'arrayIs( buffer ) :', _.arrayIs( buffer ) );
/* log : arrayIs( buffer ) : false */
console.log( 'arrayIs( vad ) :', _.arrayIs( vad ) );
/* log : arrayIs( vad ) : false */
console.log( '' )

console.log( 'longIs( array ) :', _.longIs( array ) );
/* log : longIs( array ) : true */
console.log( 'longIs( buffer ) :', _.longIs( buffer ) );
/* log : longIs( buffer ) : true */
console.log( 'longIs( vad ) :', _.longIs( vad ) );
/* log : longIs( vad ) : false */
console.log( '' )

console.log( 'vectorIs( array ) :', _.vectorIs( array ) );
/* log : vectorIs( array ) : true */
console.log( 'vectorIs( buffer ) :', _.vectorIs( buffer ) );
/* log : vectorIs( buffer ) : true */
console.log( 'vectorIs( vad ) :', _.vectorIs( vad ) );
/* log : vectorIs( vad ) : true */
console.log( '' )
