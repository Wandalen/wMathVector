if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

//

var a1 = [ 1, 2, 3 ];
var v1 = wTools.vector.from( a1 );
console.log( 'v1: ', v1 );
console.log( 'v1.toStr(): ', v1.toStr() );

/* v1:  VectorFromArray { _vectorBuffer: [ 1, 2, 3 ] } */

//

var a1 = [ 1, 2, 3 ];
var v1 = wTools.vector.from( a1 );
console.log( 'v1.length: ', v1.length )
console.log( 'a1.length: ', a1.length )

/*
  v1.length:  3
  a1.length:  3
*/

//

var a1 = [ 1, 2, 3 ];
var v1 = wTools.vector.from( a1 );
console.log( 'v1: ', v1 );
console.log( 'v1.toStr(): ',  v1.toStr() );

/* v1.toStr():  1.000 2.000 3.000 */

//

var a1 = [ 1, 2, 3 ];
var v1 = wTools.vector.from( a1 );
console.log( 'v1.eGet( 2 ): ', v1.eGet( 2 ) );

/* v1.eGet( 2 ):  3 */

//

var a1 = [ 1, 2, 3 ];
var v1 = wTools.vector.from( a1 );
v1.eSet( 0, 5 );
console.log( 'v1.toStr(): ',  v1.toStr() );

/* v1.toStr():  5.000 2.000 3.000 */

//

var a1 = [ -1, -1, -1 ];
var v1 = wTools.vector.from( a1 )
wTools.vector.abs( v1 );
console.log( 'v1.toStr(): ',  v1.toStr() );
console.log( 'a1: ', a1 );

/*
  v1.toStr():  1.000 1.000 1.000
  a1:  [ 1, 1, 1 ]
*/

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = wTools.vector.from( a1 );
var v2 = wTools.vector.from( a2 );
var result = wTools.vector.add( v1, v2 );
console.log( 'result.toStr(): ', result.toStr() );

/*
  result.toStr():  2.000 2.000 2.000
*/

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var a3 = [ 1, 1, 1 ];
var v1 = wTools.vector.from( a1 );
var v2 = wTools.vector.from( a2 );
var v3 = wTools.vector.from( a3 );
var result = wTools.vector.add( v1, v2, v3 );
console.log( 'result.toStr(): ', result.toStr() );

/*
  result.toStr():  3.000 3.000 3.000
*/

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = wTools.vector.from( a1 );
var v2 = wTools.vector.from( a2 );
wTools.vector.add( v2, v1 );
console.log( 'v2.toStr(): ', v2.toStr() );

/* v2.toStr():  2.000 2.000 2.000 */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = wTools.vector.from( a1 );
var v2 = wTools.vector.from( a2 );
var result = wTools.vector.add( null, v1, v2 );
console.log( 'result: ', result.toStr() );
console.log( 'v1.toStr(): ', v1.toStr() );
console.log( 'v2.toStr(): ', v2.toStr() );

/*
  result.toStr():  2.000 2.000 2.000
  v1.toStr():  1.000 1.000 1.000
  v2.toStr():  1.000 1.000 1.000
*/

//

var a1 = [ 1, 1 ];
var v1 = wTools.vector.from( a1 );
wTools.vector.add( v1, 3 );
console.log( 'v1.toStr(): ', v1.toStr() );

/*
  v1.toStr():  4.000 4.000
*/

//

var a1 = [ 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = wTools.vector.from( a1 );
var v2 = wTools.vector.from( a2 );
try
{
  wTools.vector.add( v1, v2 );
}
catch( err )
{
  console.log( err );
}

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
wTools.avector.add( a1, a2 );
console.log( 'a1: ', a1 );

/*
  a1:  [ 2, 2, 2 ]
*/
