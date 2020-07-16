if( typeof module !== 'undefined' )
require( 'wmathvector' );

let _ = wTools;

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1:', v1 );
/* log : "v1:  VectorAdapter.x3.Array :: 1.000 2.000 3.000" */
console.log( 'v1:', v1 );
/* log : "v1:  VectorAdapter.x3.Array :: 1.000 2.000 3.000" */

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.length:', v1.length )
/* log : "v1.length:  3" */
console.log( 'a1.length:', a1.length )
/* log : "a1.length:  3" */

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.eGet( 2 ):', v1.eGet( 2 ) );
/* log : "v1.eGet( 2 ):  3" */

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
v1.eSet( 0, 5 );
console.log( 'v1:',  v1 );
/* log : "v1:  VectorAdapter.x3.Array :: 5.000 2.000 3.000" */

//

var a1 = [ -1, -1, -1 ];
var v1 = _.vectorAdapter.from( a1 )
_.vectorAdapter.abs( v1 );
console.log( 'v1:',  v1 );
/* log : "v1:  VectorAdapter.x3.Array :: 1.000 1.000 1.000" */
console.log( 'a1:', a1 );
/* log : "a1:  [ 1, 1, 1 ]" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
var result = _.vectorAdapter.add( v1, v2 );
console.log( 'result:', result );
/* log : "result:  VectorAdapter.x3.Array :: 2.000 2.000 2.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var a3 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
var v3 = _.vectorAdapter.from( a3 );
var result = _.vectorAdapter.add( v1, v2, v3 );
console.log( 'result:', result );
/* log : "result:  VectorAdapter.x3.Array :: 3.000 3.000 3.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
_.vectorAdapter.add( v2, v1 );
console.log( 'v2:', v2 );
/* log : "v2:  VectorAdapter.x3.Array :: 2.000 2.000 2.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
var result = _.vectorAdapter.add( null, v1, v2 );
console.log( 'result:', result );
/* log : "result:  2.000 2.000 2.000" */
console.log( 'v1:', v1 );
/* log : "v1:  VectorAdapter.x3.Array :: 1.000 1.000 1.000" */
console.log( 'v2:', v2 );
/* log : "v2:  VectorAdapter.x3.Array :: 1.000 1.000 1.000" */

//

var a1 = [ 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
_.vectorAdapter.add( v1, 3 );
console.log( 'v1:', v1 );
/* log : "v1:  VectorAdapter.x2.Array :: 4.000 4.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
_.avector.add( a1, a2 );
console.log( 'a1:', a1 );
/* log :  "a1:  [ 2, 2, 2 ]" */

//

var a1 = [ 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
try
{
  _.vectorAdapter.add( v1, v2 );
}
catch( err )
{
  console.error( err );
}

/* log :
  = Message of error#2
    Inconsistant length 3 <> 2

 = Beautified calls stack
    at Object.fromNumber (/wMathVector/proto/wtools/amath/l3_vector/l3_from/Number.s:89:7)
    at Object.fromMaybeNumber (/wMathVector/proto/wtools/amath/l3_vector/l3_from/Number.s:140:21)
    at Object._vectorizeSrcs (/wMathVector/proto/wtools/amath/l3_vector/l3/RoutineMeta.s:651:46)
    at Object._vectorsCallBegin (/wMathVector/proto/wtools/amath/l3_vector/l3/RoutineMeta.s:690:8)
    at Object.homogenousUninterruptibleVectors [as add] (/wMathVector/proto/wtools/amath/l3_vector/l3/RoutineMeta.s:1816:10)
    at Object.<anonymous> (/wMathVector/sample/Basics.js:119:19)
    at Module._compile (internal/modules/cjs/loader.js:1138:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:1158:10)
    at Module.load (internal/modules/cjs/loader.js:986:32)
    at Function.Module._load (internal/modules/cjs/loader.js:879:14)
    at Function.executeUserEntryPoint [as runMain] (internal/modules/run_main.js:71:12)
    at internal/main/run_main_module.js:17:47

 = Throws stack
    thrown at Object.fromNumber @ /wMathVector/proto/wtools/amath/l3_vector/l3_from/Number.s:89:7


 end of ERROR message.

*/
