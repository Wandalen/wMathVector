if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1: ', v1 );
/* log "v1: VectorAdapterFromLong { _vectorBuffer: [ 1, 2, 3 ] }" */
console.log( 'v1.toStr(): ', v1.toStr() );
/* log "v1 to string: 1.000, 2.000, 3.000" */

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.length: ', v1.length )
/* log "v1.length:  3" */
console.log( 'a1.length: ', a1.length )
/* log "a1.length:  3" */

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.eGet( 2 ): ', v1.eGet( 2 ) );
/* log "v1.eGet( 2 ):  3" */

//

var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
v1.eSet( 0, 5 );
console.log( 'v1.toStr(): ',  v1.toStr() );
/* log "v1.toStr():  5.000 2.000 3.000" */

//

var a1 = [ -1, -1, -1 ];
var v1 = _.vectorAdapter.from( a1 )
_.vectorAdapter.abs( v1 );
console.log( 'v1.toStr(): ',  v1.toStr() );
/* log "v1.toStr():  1.000 1.000 1.000" */
console.log( 'a1: ', a1 );
/* log "a1:  [ 1, 1, 1 ]" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
var result = _.vectorAdapter.add( v1, v2 );
console.log( 'result.toStr(): ', result.toStr() );
/* log "result.toStr():  2.000 2.000 2.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var a3 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
var v3 = _.vectorAdapter.from( a3 );
var result = _.vectorAdapter.add( v1, v2, v3 );
console.log( 'result.toStr(): ', result.toStr() );
/* log "result.toStr():  3.000 3.000 3.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
_.vectorAdapter.add( v2, v1 );
console.log( 'v2.toStr(): ', v2.toStr() );
/* log "v2.toStr():  2.000 2.000 2.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
var result = _.vectorAdapter.add( null, v1, v2 );
console.log( 'result: ', result.toStr() );
/* log "result.toStr():  2.000 2.000 2.000" */
console.log( 'v1.toStr(): ', v1.toStr() );
/* log "v1.toStr():  1.000 1.000 1.000" */
console.log( 'v2.toStr(): ', v2.toStr() );
/* log "v2.toStr():  1.000 1.000 1.000" */

//

var a1 = [ 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
_.vectorAdapter.add( v1, 3 );
console.log( 'v1.toStr(): ', v1.toStr() );
/* log "v1.toStr():  4.000 4.000" */

//

var a1 = [ 1, 1, 1 ];
var a2 = [ 1, 1, 1 ];
_.avector.add( a1, a2 );
console.log( 'a1: ', a1 );
/* log  "a1:  [ 2, 2, 2 ]" */

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
  console.log( "ERROR message \n",err );
}
/* log error message:
 = Message of error#2
    Assertion fails

 = Beautified calls stack
    at Object.fromNumber (/home/user/wMathVector/proto/dwtools/amath/l3_vector/l3_from/Number.s:87:7)
    at Object.fromMaybeNumber (/home/user/wMathVector/proto/dwtools/amath/l3_vector/l3_from/Number.s:137:21)
    at Object._vectorizeSrcs (/home/user/wMathVector/proto/dwtools/amath/l3_vector/l3/RoutineMeta.s:615:46)
    at Object._vectorsCallBegin (/home/user/wMathVector/proto/dwtools/amath/l3_vector/l3/RoutineMeta.s:654:8)
    at Object.homogenousUninterruptibleVectors [as add] (/home/user/wMathVector/proto/dwtools/amath/l3_vector/l3/RoutineMeta.s:1780:10)
    at Object.<anonymous> (/home/user/wMathVector/sample/Basics.js:119:19)
    at Module._compile (internal/modules/cjs/loader.js:959:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:995:10)
    at Module.load (internal/modules/cjs/loader.js:815:32)
    at Function.Module._load (internal/modules/cjs/loader.js:727:14)
    at Function.Module.runMain (internal/modules/cjs/loader.js:1047:10)
    at internal/main/run_main_module.js:17:11

 = Throws stack
    thrown at Object.fromNumber @ /home/user/wMathVector/proto/dwtools/amath/l3_vector/l3_from/Number.s:87:7
*/
