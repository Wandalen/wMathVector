( function _VectorAdapter_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

  require( '../l3_vector/Include.s' );

}

//

var _ = _global_.wTools.withDefaultLong.Fx;
var Space = _.Matrix;
var vad = _.vectorAdapter;
var vec = _.vectorAdapter.fromLong;
var avector = _.avector;
var sqrt = _.math.sqrt;

var Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// from
// --

function fromLongReview( test )
{

  test.case = 'basic';
  var exp = [ 1, 3, 5, 7 ];
  var v = _.vectorAdapter.fromLong([ 1, 3, 5, 7 ]);
  test.equivalent( v, exp );
  var exp = [ 3, 5 ];
  var v2 = v.review([ 1, 2 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 1, 3 ];
  var v2 = v.review([ 0, 1 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 5, 7 ];
  var v2 = v.review([ 2, 3 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );

}

//

function fromLongWithStrideReview( test )
{

  test.case = 'basic';
  var exp = [ 1, 3, 5, 7 ];
  var v = _.vectorAdapter.fromLongWithStride( [ 1, 2, 3, 4, 5, 6, 7, 8 ], 2 );
  test.equivalent( v, exp );
  var exp = [ 3, 5 ];
  var v2 = v.review([ 1, 2 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 1, 3 ];
  var v2 = v.review([ 0, 1 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 5, 7 ];
  var v2 = v.review([ 2, 3 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );

}

//

function fromLongLrangeReview( test )
{

  test.case = 'basic';
  var exp = [ 1, 3, 5, 7 ];
  var v = _.vectorAdapter.fromLongLrange( [ 0, 1, 3, 5, 7, 0 ], [ 1, 4 ] );
  test.equivalent( v, exp );
  var exp = [ 3, 5 ];
  var v2 = v.review([ 1, 2 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 1, 3 ];
  var v2 = v.review([ 0, 1 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 5, 7 ];
  var v2 = v.review([ 2, 3 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );

}

//

function fromLongLrangeAndStrideReview( test )
{

  test.case = 'basic';
  var exp = [ 1, 3, 5, 7 ];
  var v = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 4 ], 2 );
  test.equivalent( v, exp );
  var exp = [ 3, 5 ];
  var v2 = v.review([ 1, 2 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 1, 3 ];
  var v2 = v.review([ 0, 1 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );
  var exp = [ 5, 7 ];
  var v2 = v.review([ 2, 3 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer === v._vectorBuffer );

}

//

function fromNumberReview( test )
{

  test.case = 'basic';
  var exp = [ 3, 3, 3, 3 ];
  var v = _.vectorAdapter.fromNumber( 3, 4 );
  test.equivalent( v, exp );
  var exp = [ 3, 3 ];
  var v2 = v.review([ 1, 2 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer !== v._vectorBuffer );
  var exp = [ 3, 3 ];
  var v2 = v.review([ 0, 1 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer !== v._vectorBuffer );
  var exp = [ 3, 3 ];
  var v2 = v.review([ 2, 3 ]);
  test.equivalent( v2, exp );
  test.is( !!v2._vectorBuffer );
  test.is( v2._vectorBuffer !== v._vectorBuffer );

}

// --
// iterator
// --

function map( test )
{

  /* */

  test.case = 'dst = src';

  function onElement1( src )
  {
    return - 5 < src && src < 0 ; /* numbers in range */
  }
  var src = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
  var got = _.vectorAdapter.map( src, onElement1 );

  var exp = _.vectorAdapter.from( [ true, true, true ] );
  test.identical( got, exp );
  test.is( got === src );

  /* */

  test.case = 'dst = null';

  function onElement1( src )
  {
    return - 5 < src && src < 0 ; /* numbers in range */
  }
  var src = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
  var got = _.vectorAdapter.map( null, src, onElement1 );

  var exp = _.vectorAdapter.make( [ 1, 1, 1 ] );
  test.identical( got, exp );

  var exp = _.vectorAdapter.from( [ -1, -1.5, -2 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'Check if a number is > 0 - empty';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a number is > 0 - true';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ 0, 1, 0, 2, 1000, 307 ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ true, true, true, true, true, true ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a number is > 0 - false some';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ 0, - 1, 0, 2, 1000, '307' ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ true, false, true, true, true, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a number is > 0 - false none';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ - 1, - 2, - 1000, '307', [ 3 ] ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ false, false, false, false, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a string starts with h - true';

  function stringLengthThree( src )
  {
    return _.strIs( src ) && src.charAt( 0 ) === 'h' ; /* str starts with H */
  }
  var src = _.vectorAdapter.from( [ 'hi!', 'how', 'has', 'he', 'handled', 'his', 'huge', 'hair' ] );
  var got = _.vectorAdapter.map( src, stringLengthThree );

  var expectedStr = _.vectorAdapter.from( [ true, true, true, true, true, true, true, true ] );
  test.identical( got, expectedStr );

  /* */

  test.case = 'Check if a string starts with h - false';

  function stringLengthThree( src )
  {
    return _.strIs( src ) && src.charAt( 0 ) === 'h' ; /* str starts with H */
  }
  var src = _.vectorAdapter.from( [ 'Hello, ', 'how', 'are', 'you', '?' ] );
  var got = _.vectorAdapter.map( src, stringLengthThree );

  var exp = _.vectorAdapter.from( [ false, true, false, false, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check an array´s length - true';

  function arrayLength( src )
  {
    return _.arrayIs( src ) && src.length === 4 ; /* arrays of length 4 */
  }
  var src = _.vectorAdapter.from( [ ['hi!', 'how', 'are', 'you' ], [ 0, 1, 2, 3 ] ] );
  var got = _.vectorAdapter.map( src, arrayLength );

  var expectedArr = _.vectorAdapter.from( [ true, true ] );
  test.identical( got, expectedArr );

  /* */

  test.case = 'Check an array´s length - false';

  function arrayLength( src )
  {
    return _.arrayIs( src ) && src.length === 4 ; /* arrays of length 4 */
  }
  var src = _.vectorAdapter.from( [ [ 'Hello, ', 'how', 'are', 'you', '?' ], [ 0, 1, 2 ] ] );
  var got = _.vectorAdapter.map( src, arrayLength );

  var exp =  _.vectorAdapter.from( [ false, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'single argument';

  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst );
  test.is( got === dst );

  /* */

  test.case = 'dst and undefined';

  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst, undefined );
  test.is( got === dst );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'Only one argument';

  test.shouldThrowErrorSync( () => _.vectorAdapter.map( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 2 ));

  /* */

  test.case = 'Wrong second argument';

  // test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  /* */

  test.case = 'Wrong first argument';

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( Int8Array.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

//

function filter( test )
{

  /* */

  test.case = 'dst = null';

  function onElement1( src )
  {
    return src + 10;
  }
  var src = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
  var got = _.vectorAdapter.filter( null, src, onElement1 );
  var exp = _.vectorAdapter.make( [ 9, 8.5, 8 ] );
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ -1, -1.5, -2 ] )
  test.equivalent( src, exp );

  /* */

}

//

function _while( test )
{

  /* */

  test.case = 'dst = null';
  function onElement1( src )
  {
    return src < 2 ? src : undefined;
  }
  var src = _.vectorAdapter.from([ 0, 1, 2, 3 ]);
  var got = _.vectorAdapter.while( null, src, onElement1 );
  var exp = _.vectorAdapter.make( [ 0, 1 ] );
  test.identical( got, exp );
  var exp = _.vectorAdapter.from([ 0, 1, 2, 3 ]);
  test.equivalent( src, exp );

  /* */

  test.case = 'dst, src';
  function onElement2( src )
  {
    return src + 10;
  }
  var dst = _.vectorAdapter.from([ 0, 1, 2, 3 ]);
  var got = _.vectorAdapter.while( dst, onElement2 );
  var exp = _.vectorAdapter.from([ 10, 11, 12, 13 ]);
  test.identical( got, exp );
  var exp = _.vectorAdapter.from([ 10, 11, 12, 13 ]);
  test.equivalent( dst, exp );

  /* */

}

//

function all( test )
{

  /* */

  test.case = 'basic false';

  function onElement1( src )
  {
    return src < 13;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.all( src, onElement1 );
  var exp = false;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'basic true';

  function onElement2( src )
  {
    return src < 130;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.all( src, onElement2 );
  var exp = true;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'Only one argument'; //

  test.shouldThrowErrorSync( () => _.vectorAdapter.all( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 2 ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ) )); /* qqq : add such test case */

  test.case = 'Wrong second argument'; //

  // test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), undefined )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  test.case = 'Wrong first argument'; //

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( I8x.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

//

function any( test )
{

  /* */

  test.case = 'basic false';

  function onElement1( src )
  {
    return src < 0;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.any( src, onElement1 );
  var exp = false;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'basic true';

  function onElement2( src )
  {
    return src < 13;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.any( src, onElement2 );
  var exp = true;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'Only one argument'; //

  test.shouldThrowErrorSync( () => _.vectorAdapter.any( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( 2 ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ) )); /* qqq : add such test case */

  test.case = 'Wrong second argument'; //

  // test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), undefined )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  test.case = 'Wrong first argument'; //

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( I8x.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

//

function none( test )
{

  /* */

  test.case = 'basic false';

  function onElement1( src )
  {
    return src < 13;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.none( src, onElement1 );
  var exp = false;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'basic true';

  function onElement2( src )
  {
    return src < 0;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.none( src, onElement2 );
  var exp = true;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'Only one argument'; //

  test.shouldThrowErrorSync( () => _.vectorAdapter.none( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( 2 ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ) )); /* qqq : add such test case */

  test.case = 'Wrong second argument'; //

  // test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), undefined )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  test.case = 'Wrong first argument'; //

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( I8x.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

// --
// etc
// --

function distributionRangeSummaryValue( test )
{

  test.case = 'basic';
  var a = vad.from( new I32x([ 1, 2, 3 ]) );
  var b = vad.from( new I32x([ 3, 4, 5 ]) );
  var exp = [ 1, 5 ];
  var got = vad.distributionRangeSummaryValue( a, b );
  test.identical( got, exp );

}

//

function entityEqual( test )
{

  /* - */

  test.case = 'src1:vad-a-arr src2:vad-a-arr - identical';
  var vad1 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var vad2 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var got = _.equivalent( vad1, vad2 );
  test.identical( got, true );
  test.et( vad1, vad2 );
  var got = _.identical( vad1, vad2 );
  test.identical( got, true );
  test.il( vad1, vad2 );

  /* */

  test.case = 'src1:vad-a-arr src2:vad-a-arr - identical';
  var vad1 = _.avector.make( [ true, true, true ] );
  var vad2 = _.avector.make( [ true, true, true ] );
  var got = _.equivalent( vad1, vad2 );
  test.identical( got, true );
  test.et( vad1, vad2 );
  var got = _.identical( vad1, vad2 );
  test.identical( got, true );
  test.il( vad1, vad2 );

  /* - */

  test.case = 'src1:vad-a-arr src2:vad-a-arr - not equivalent';
  var vad1 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var vad2 = _.vectorAdapter.from([ 1, 3, 6 ]);
  var got = _.equivalent( vad1, vad2 );
  test.identical( got, false );
  test.ne( vad1, vad2 );
  var got = _.identical( vad1, vad2 );
  test.identical( got, false );
  test.ni( vad1, vad2 );

  /* - */

  test.case = 'src1:vad-a-arr src2:vad-ls-arr';
  var vad1 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var vad2 = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 3 ], 2 );
  var got = _.equivalent( vad1, vad2 );
  test.identical( got, true );
  test.et( vad1, vad2 );
  var got = _.identical( vad1, vad2 );
  test.identical( got, true );
  test.il( vad1, vad2 );

  /* - */

  test.case = 'src1:vad-arr src2:long-arr';
  var long = [ 1, 3, 5 ];
  var vad = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 3 ], 2 );
  var got = _.equivalent( vad, long );
  test.identical( got, true );
  test.et( vad, long );
  var got = _.identical( vad, long );
  test.identical( got, false );
  test.ni( vad, long );

  /* */

  test.case = 'src1:long-arr src2:vad-arr';
  var long = [ 1, 3, 5 ];
  var vad = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 3 ], 2 );
  var got = _.equivalent( long, vad );
  test.identical( got, true );
  test.et( long, vad );
  var got = _.identical( long, vad );
  test.identical( got, false );
  test.ni( long, vad );

  /* - */

  test.case = 'src1:vad-f32 src2:long-i16';
  var long = new I16x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new F32x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  var got = _.equivalent( vad, long );
  test.identical( got, true );
  test.et( vad, long );
  var got = _.identical( vad, long );
  test.identical( got, false );
  test.ni( vad, long );

  /* */

  test.case = 'src1:long-i16 src2:vad-f32';
  var long = new I16x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new F32x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  var got = _.equivalent( long, vad );
  test.identical( got, true );
  test.et( long, vad );
  var got = _.identical( long, vad );
  test.identical( got, false );
  test.ni( long, vad );

  /* - */

  test.case = 'src1:vad-i16 src2:long-f32';
  var long = new F32x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new I16x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  var got = _.equivalent( vad, long );
  test.identical( got, true );
  test.et( vad, long );
  var got = _.identical( vad, long );
  test.identical( got, false );
  test.ni( vad, long );

  /* */

  test.case = 'src1:long-f32 src2:vad-i16';
  var long = new F32x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new I16x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  var got = _.equivalent( long, vad );
  test.identical( got, true );
  test.et( long, vad );
  var got = _.identical( long, vad );
  test.identical( got, false );
  test.ni( long, vad );

  /* - */

}

//

function review( test )
{

  /* */

  test.case = 'fromNumber';

  var exp = vad.from( vad.long.longMake([ 1, 1, 1, 1 ]) );
  var vad1 = vad.fromNumber( 1, 4 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 1, 1 ]) );
  var vad1 = vad.fromNumber( 1, 4 );
  var got = vad.review( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer !== got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromNumber( 1, 4 );
    var got = vad.review( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromNumber( 1, 4 );
    var got = vad.review( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLong';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var got = vad.review( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
    var got = vad.review( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
    var got = vad.review( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLongLrange';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
  var got = vad.review( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
    var got = vad.review( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
    var got = vad.review( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLongLrangeAndStride';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
  var got = vad.review( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
    var got = vad.review( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
    var got = vad.review( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLongWithStride';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
  var got = vad.review( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
    var got = vad.review( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
    var got = vad.review( vad1, [ 2, 8 ], 6 );
  });

  /* */

}

//

function isEquivalent( test )
{

  test.case = 'basic';
  var accuracy = 0.1;
  var a = _.vectorAdapter.from([ 1 ]);
  var b = _.vectorAdapter.from([ 1+accuracy ]);
  var got = _.vectorAdapter.isEquivalent( null, a, b, accuracy );
  var exp = _.vectorAdapter.from([ true ]);
  test.identical( got, exp );

}

//

function allEquivalent( test )
{

  test.case = 'basic';
  var accuracy = 0.1;
  var a = _.vectorAdapter.from([ 1 ]);
  var b = _.vectorAdapter.from([ 1+accuracy ]);
  debugger;
  var got = _.vectorAdapter.allEquivalent( a, b, accuracy );
  debugger;
  var exp = true;
  test.identical( got, exp );

}

// --
// proto
// --

var Self =
{

  name : 'Tools.Math.Vector.Adapter',
  silencing : 1,

  context :
  {
  },

  tests :
  {

    // from

    fromLongReview,
    fromLongWithStrideReview,
    fromLongLrangeReview,
    fromLongLrangeAndStrideReview,
    fromNumberReview,

    // iterator

    map,
    filter,
    while : _while,
    all,
    any,
    none,

    // etc

    distributionRangeSummaryValue,
    entityEqual,
    review,

    isEquivalent,
    allEquivalent,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
