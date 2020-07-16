if( typeof module !== 'undefined' )
require( 'wmathvector' );

let _ = wTools;

/* add 2 avectors */

var a1 = [ 1, 2, 3 ];
var a2 = [ 1, 2, 3 ];
var a3 = [ 1, 2, 3 ];
var avector = _.avector.add( a1, a2, a3 );
console.log( 'avector:', avector );
/* log : "avector: [ 3, 6, 9 ]" */
console.log( 'a1:', a1 );
/* log : "a1: [ 3, 6, 9 ]" */

/* add 2 avectors and scalar */

var a1 = [ 0, 0, 0 ];
var a2 = [ 0, 0, 0 ];
var a3 =  5;
var a4 =  7;
var avector = _.avector.add( a1, a2, a3, a4 );
console.log( 'avector:', avector );
/* log : "avector:  [ 12, 12, 12 ]" */
console.log( 'a1:', a1 );
/* log : "a1: [ 12, 12, 12 ]" */

/* saving add result to new avector */

var a1 = [ 0, 0, 0 ];
var a2 = [ 0, 0, 0 ];
var a3 =  5;
var a4 =  7;
var vector = _.avector.add( null, a1, a2, a3, a4 );
console.log( 'avector:', avector );
/* log : "avector:  [ 12, 12, 12 ]" */
console.log( 'a1:', a1 );
/* log : "a1: [ 0, 0, 0 ]" */

/* using vector wrapper and single avector as container */

var a = [ 0, 0, 1, 1, 2, 2 ];

var v1Offset = 0;
var v1Length = 3;
var v1 = _.vectorAdapter.fromLongLrange( a, v1Offset, v1Length );

var v2Offset = v1Length;
var v2Length = 3;
var v2 = _.vectorAdapter.fromLongLrange( a, v2Offset, v2Length );

_.avector.add( v1, v2 );

console.log( 'v1:', v1 );
/* log :
"v1:  VectorAdapterFromLongShrinked {
  _vectorBuffer: [ 1, 2, 3, 1, 2, 2 ],
  length: 3,
  offset: 0
}" */
console.log( 'v2:', v2 );
/* log :
"v2:  VectorAdapterFromLongShrinked {
  _vectorBuffer: [ 1, 2, 3, 1, 2, 2 ],
  length: 3,
  offset: 3
}" */
console.log( 'a:', a );
/* log : "a:  [ 1, 2, 3, 1, 2, 2 ]" */
/* qqq : review all samples and update actual output */

/* vector wrapper from avector */

var avector = [ 1, 2, 3 ];
var vector = _.vectorAdapter.from( avector );
console.log( vector )
/* log : "VectorAdapterFromLong { _vectorBuffer: [ 1, 2, 3 ] }" */

/* setting and getting data from container through vector wrapper */

var avector = [ 1, 2, 3 ];
var vector = _.vectorAdapter.from( avector );
vector.eSet( 0, 5 );
console.log( vector.eGet( 0 ) );
/* log : 5 */
