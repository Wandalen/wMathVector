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

function comparator( test )
{

  test.case = 'trivial';

  let v1 = vad.from([ 1, 2, 3 ]);
  let v2 = vad.from([ 1, 2, 4 ]);

  let diff = _.entityDiff( v1, v2 );
  let expected =
`
at /2
- src1 :
  1.000 2.000 3.000
- src2 :
  1.000 2.000 4.000
- difference :
  1.000 2.000 *
`

  console.log( diff );

  test.identical.apply( test, _.strLinesStrip( diff, expected ) );
  test.notIdentical( v1, v2 );

}

//

function vectorAdapterIs( test )
{
  /* Dmytro : the first part of routine in module wTools */

  test.case = 'src - vectorAdapter, routine from';
  var src = vad.from( [ 1, 2, 3 ] );
  test.is( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLong';
  var src = vad.fromLong( [ 1, 2, 3 ] );
  test.is( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLongWithStride';
  var src = vad.fromLongWithStride( [ 1, -1, 2, -1, 3 ], 2 );
  test.is( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLongLrange';
  var src = vad.fromLongLrange( [ -1, 1, 2, 3, -1 ], 1, 3 );
  test.is( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLongLrangeAndStride';
  var src = vad.fromLongLrangeAndStride( [ -1, 1, -1, 2, -1, 3, -1 ], 1, 3, 2 );
  test.is( _.vectorAdapterIs( src ) );
}

//

function constructorIsVector( test )
{
  /* Dmytro : the first part of routine in module wTools */

  test.case = 'src - vectorAdapter constructor, routine from';
  var src = vad.from( [ 1, 2, 3 ] );
  test.is( _.constructorIsVector( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLong';
  var src = vad.fromLong( [ 1, 2, 3 ] );
  test.is( _.constructorIsVector( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLongWithStride';
  var src = vad.fromLongWithStride( [ 1, -1, 2, -1, 3 ], 2 );
  test.is( _.constructorIsVector( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLongLrange';
  var src = vad.fromLongLrange( [ -1, 1, 2, 3, -1 ], 1, 3 );
  test.is( _.constructorIsVector( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLongLrangeAndStride';
  var src = vad.fromLongLrangeAndStride( [ -1, 1, -1, 2, -1, 3, -1 ], 1, 3, 2 );
  test.is( _.constructorIsVector( src.constructor ) );
}

//

function to( test )
{

  test.case = 'vector to array'; /* */

  var v = vad.from([ 1, 2, 3 ]);
  var got = v.to( [].constructor );
  var expected = [ 1, 2, 3 ];
  test.identical( got, expected );

  test.case = 'vector to vector'; /* */

  var v = vad.from([ 1, 2, 3 ]);
  var got = v.to( vad.fromLong( [] ).constructor );
  test.is( got === v );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to() );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( [], 1 ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( 1 ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( null ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( '1' ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( [], 1 ) );

}

//

function toLong( test )
{

  test.case = 'trivial'; /* */

  var v = vad.from([ 1, 2, 3 ]);
  var got = v.toLong();
  var expected = [ 1, 2, 3 ];
  test.identical( got, expected );
  test.is( v._vectorBuffer === got );

  test.case = 'trivial with fromLongLrangeAndStride'; /* */

  var v = vad.fromLongLrangeAndStride( [ 1, 2, 3, 4, 5 ], 0, 5, 1 );
  var got = v.toLong();
  var expected = [ 1, 2, 3, 4, 5 ];
  test.identical( got, expected );
  test.is( v._vectorBuffer === got );

  test.case = 'with custom offset'; /* */

  var v = vad.fromLongLrange( [ 1, 2, 3, 4, 5 ], 1 );
  var got = v.toLong();
  var expected = [ 2, 3, 4, 5 ];
  test.identical( got, expected );
  test.is( v._vectorBuffer !== got );

  test.case = 'with custom length'; /* */

  var v = vad.fromLongLrange( [ 1, 2, 3, 4, 5 ], 0, 4 );
  var got = v.toLong();
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( v._vectorBuffer !== got );

  test.case = 'with fromLongLrangeAndStride'; /* */

  var v = vad.fromLongLrangeAndStride( [ 1, 2, 3, 4, 5 ], 1, 2, 2 );
  var got = v.toLong();
  var expected = [ 2, 4 ];
  test.identical( got, expected );
  test.is( v._vectorBuffer !== got );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( 0 ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( undefined ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( null ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( _.vectorAdapter.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( '123' ) );
  test.shouldThrowErrorSync( () => vad.from([ 1, 2, 3 ]).to( function( a, b, c ){} ) );

}

//

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

//

function reviewSrcIsSimpleVector( test )
{
  test.case = 'src - empty vector, crange - 0';
  var src = [];
  var got = vad.review( src, 0 );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - 0';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, 0 );
  var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange > 0 && crange < src.length - 1';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, 2 );
  var exp = vad.from( [ 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - src.length';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, 6 );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

  test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
  var src = [];
  var got = vad.review( src, [ 0, -1 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, [ 0, 5 ] );
  var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] - 0, crange < src.length';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, [ 0, 3 ] );
  var exp = vad.from( [ 0, 1, 2, 3 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > 0, crange < src.length';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, [ 1, 3 ] );
  var exp = vad.from( [ 1, 2, 3 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, [ 6, 5 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > crange[ 1 ]';
  var src = [ 0, 1, 2, 3, 4, 5 ];
  var got = vad.review( src, [ 3, 2 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.avector.review() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.avector.review( [] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.avector.review( [], 0, 0 ) );

  test.case = 'crange - number, crange < 0';
  test.shouldThrowErrorSync( () => _.avector.review( [ 1, 2 ], -1 ) );

  test.case = 'crange - number, crange > src.length - 1';
  test.shouldThrowErrorSync( () => _.avector.review( [ 1, 2 ], 5 ) );

  test.case = 'crange[ 0 ] < 0';
  test.shouldThrowErrorSync( () => _.avector.review( [ 1, 2 ], [ -1, 1 ] ) );

  test.case = 'crange[ 1 ] > src.length - 1';
  test.shouldThrowErrorSync( () => _.avector.review( [ 1, 2 ], [ 0, 4 ] ) );

  test.case = 'crange[ 1 ] - crange[ 0 ] < -1';
  test.shouldThrowErrorSync( () => _.avector.review( [ 1, 2 ], [ 0, 4 ] ) );

  test.case = 'crange[ 1 ] - src.length';
  test.shouldThrowErrorSync( () => _.avector.review( [ 1, 2 ], [ 1, 2 ] ) );
}

//

function reviewSrcIsAdapterRoutineFrom( test )
{
  test.case = 'src - empty vector, crange - 0';
  var src = vad.from( [] );
  var got = vad.review( src, 0 );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange - 0';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, 0 );
  var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange > 0 && crange < src.length - 1';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, 2 );
  var exp = vad.from( [ 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - src.length';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, 6 );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

  test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
  var src = vad.from( [] );
  var got = vad.review( src, [ 0, -1 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, [ 0, 5 ] );
  var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange[ 0 ] - 0, crange < src.length';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, [ 0, 3 ] );
  var exp = vad.from( [ 0, 1, 2, 3 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > 0, crange < src.length';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, [ 1, 3 ] );
  var exp = vad.from( [ 1, 2, 3 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, [ 6, 5 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > crange[ 1 ]';
  var src = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
  var got = vad.review( src, [ 3, 2 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );
}

// --
// iterator
// --

function map( test )
{
  test.case = 'single argument';
  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst );
  test.is( got === dst );

  test.case = 'dst and undefined';
  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst, undefined );
  test.is( got === dst );

  test.case = 'dst and null';
  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst, null );
  test.is( got === dst );

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

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map() );

  test.case = 'Only one argument';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( NaN ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( undefined ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 'string' ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 2 ) );

  /* */

  test.case = 'Wrong second argument';

  // test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* aaa : add such test case */ /* Dmytro : added */
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

//

function sort( test )
{

  // 13.00 13.00 10.00 10.00 10.00 2.00 10.00 15.00 2.00 14.00 10.00 6.00 6.000 15.00 4.00 8.00

  var samples =
  [

    [ 0 ],

    [ 0, 1 ],
    [ 1, 0 ],

    [ 1, 0, 2 ],
    [ 2, 0, 1 ],
    [ 0, 1, 2 ],
    [ 0, 2, 1 ],
    [ 2, 1, 0 ],
    [ 1, 2, 0 ],

    [ 0, 1, 1 ],
    [ 1, 0, 1 ],
    [ 1, 1, 0 ],

    [ 0, 0, 1, 1 ],
    [ 0, 1, 1, 0 ],
    [ 1, 1, 0, 0 ],
    [ 1, 0, 1, 0 ],
    [ 0, 1, 0, 1 ],

  ];

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample1 = samples[ s ].slice();
    var sample2 = samples[ s ].slice();
    _.vectorAdapter.sort( _.vectorAdapter.fromLong( sample1 ) );
    sample2.sort();
    test.identical( sample1, sample2 );
  }

}

sort.timeOut = 15000;

//

function cross3( test ) 
{
  test.open( 'src1 and src2 - vectorAdapter instances' );

  test.case = 'dst - only zeros, src1 and src2 - only zeros';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - only zeros';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - different elements, src1 - only zeros, src2 - different elements';
  var dst = vad.from( [ 1, -1, 3 ] );
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 5, 4, 3 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 - different elements, src2 - only zeros';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ 10, -5, 4 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same positive number';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same positive number';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same negative number';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same negative number';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different positive values';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = vad.from( [ 1, 2, 3 ] );
  var src2 = vad.from( [ 4, 5, 6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different positive values';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ 1, 2, 3 ] );
  var src2 = vad.from( [ 4, 5, 6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different negative values';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = vad.from( [ -1, -2, -3 ] );
  var src2 = vad.from( [ -4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different negative values';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ -1, -2, -3 ] );
  var src2 = vad.from( [ -4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different values';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = vad.from( [ -1, 2, 3 ] );
  var src2 = vad.from( [ 4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different values';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = vad.from( [ -1, 2, 3 ] );
  var src2 = vad.from( [ 4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'src1 and src2 - vectorAdapter instances' );

  /* - */

  test.open( 'src1 and src2 - simple vectors' );

  test.case = 'dst - only zeros, src1 and src2 - only zeros';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - only zeros';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - different elements, src1 - only zeros, src2 - different elements';
  var dst = vad.from( [ 1, -1, 3 ] );
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 5, 4, 3 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 - different elements, src2 - only zeros';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ 10, -5, 4 ];
  var src2 = [ 0, 0, 0 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same positive number';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same positive number';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same negative number';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same negative number';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different positive values';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = [ 1, 2, 3 ];
  var src2 = [ 4, 5, 6 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different positive values';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ 1, 2, 3 ];
  var src2 = [ 4, 5, 6 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different negative values';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = [ -1, -2, -3 ];
  var src2 = [ -4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different negative values';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ -1, -2, -3 ];
  var src2 = [ -4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different values';
  var dst = vad.from( [ 0, 0, 0 ] );
  var src1 = [ -1, 2, 3 ];
  var src2 = [ 4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different values';
  var dst = vad.from( [ 1, -5, 's' ] );
  var src1 = [ -1, 2, 3 ];
  var src2 = [ 4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'src1 and src2 - simple vectors' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3() );

  test.case = 'not enouth arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3 ], [ 3, 2, 1 ] ) );

  test.case = 'wrong length of dst';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3, 4 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( null, [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( { a : 1, b : 2, c : 3 }, [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.case = 'wrong length of src1';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 1, 2, 3 ] ) );

  test.case = 'wrong type of src1';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], undefined, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], 3, [ 1, 2, 3 ] ) );

  test.case = 'wrong length of src2';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], [] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ) );

  test.case = 'wrong type of src2';
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], true ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], 'str' ) );
}

//

function swapVectors( test )
{

  test.case = 'swapVectors vectors'; /* */

  var v1 = vad.from([ 1, 2, 3 ]);
  var v2 = vad.from([ 10, 20, 30 ]);
  var v1Expected = vad.from([ 10, 20, 30 ]);
  var v2Expected = vad.from([ 1, 2, 3 ]);

  var r = vad.swapVectors( v1, v2 );

  test.is( r === undefined );
  test.identical( v1, v1Expected );
  test.identical( v2, v2Expected );

  test.case = 'swapVectors arrays'; /* */

  var v1 = [ 1, 2, 3 ];
  var v2 = [ 10, 20, 30 ];
  var v1Expected = [ 10, 20, 30 ];
  var v2Expected = [ 1, 2, 3 ];

  var r = avector.swapVectors( v1, v2 );

  test.is( r === undefined );
  test.identical( v1, v1Expected );
  test.identical( v2, v2Expected );

  test.case = 'swapVectors empty arrays'; /* */

  var v1 = [];
  var v2 = [];
  var v1Expected = [];
  var v2Expected = [];

  var r = avector.swapVectors( v1, v2 );

  test.is( r === undefined );
  test.identical( v1, v1Expected );
  test.identical( v2, v2Expected );

  test.case = 'swapAtoms vectors'; /* */

  var v1 = vad.from([ 1, 2, 3 ]);
  var v1Expected = vad.from([ 3, 2, 1 ]);
  var r = vad.swapAtoms( v1, 0, 2 );

  test.is( r === v1 );
  test.identical( v1, v1Expected );

  test.case = 'swapAtoms arrays'; /* */

  var v1 = [ 1, 2, 3 ];
  var v1Expected = [ 3, 2, 1 ];
  var r = avector.swapAtoms( v1, 0, 2 );

  test.is( r === v1 );
  test.identical( v1, v1Expected );

  test.case = 'swapAtoms array with single atom'; /* */

  var v1 = [ 1 ];
  var v1Expected = [ 1 ];
  var r = avector.swapAtoms( v1, 0, 0 );

  test.is( r === v1 );
  test.identical( v1, v1Expected );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => vad.swapVectors() );
  test.shouldThrowErrorSync( () => vad.swapVectors( vad.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => vad.swapVectors( vad.from([ 1, 2, 3 ]), vad.from([ 1, 2, 3 ]), vad.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => vad.swapVectors( vad.from([ 1, 2, 3 ]), vad.from([ 1, 2 ]) ) );
  test.shouldThrowErrorSync( () => vad.swapVectors( vad.from([ 1, 2, 3 ]), [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => vad.swapVectors( [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.shouldThrowErrorSync( () => vad.swapAtoms() );
  test.shouldThrowErrorSync( () => vad.swapAtoms( vad.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => vad.swapAtoms( vad.from([ 1, 2, 3 ]), 0 ) );
  test.shouldThrowErrorSync( () => vad.swapAtoms( vad.from([ 1, 2, 3 ]), 0, +3 ) );
  test.shouldThrowErrorSync( () => vad.swapAtoms( vad.from([ 1, 2, 3 ]), 0, -1 ) );
  test.shouldThrowErrorSync( () => vad.swapAtoms( vad.from([ 1, 2, 3 ]), '0', '1' ) );
  test.shouldThrowErrorSync( () => vad.swapAtoms( vad.from([ 1, 2, 3 ]), [ 0 ], [ 1 ] ) );

}

swapVectors.timeOut = 15000;

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

//

function areParallelDefaultAccuracy( test ) 
{
  let e = _.accuracy || 10 ** -7;

  /* - */

  test.open( 'without deviation' );

  test.case = 'empty vectors, equivalent, zeros';
  var src1 = vad.from( [] );
  var src2 = vad.from( [] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0 ] );
  var src2 = vad.from( [ 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ 5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5 ] );
  var src2 = vad.from( [ -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ -5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zeros';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 10, -100, 20 ] );
  var src2 = vad.from( [ 50, -500, 100 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ -5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = vad.from( [ 5, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'without deviation' );

  /* - */

  test.open( 'with deviation' );

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0 ] );
  var src2 = vad.from( [ 0 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ 5 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5 ] );
  var src2 = vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0 + e * 10, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5 + e * 10, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ -5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500 + e * 10, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500  + 0.05, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 10, -100, 20 ] );
  var src2 = vad.from( [ 50, -500, 100  + 0.05 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = vad.from( [ 0 + e * 10, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ 5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = vad.from( [ -5 + e * 10, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ -5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5 + e * 10, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5 + e * 100, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = vad.from( [ 5 + e * 100, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.close( 'with deviation' );

  /* - */ 

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( [ 1 ] ) );

  test.case = 'wrong type of src1';
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( 'wrong', [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( null, [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( undefined, [ 1 ], 0.1 ) );

  test.case = 'wrong type of src2';
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( [ 1 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( [ 1 ], {} ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( [ 1 ], new Set( [] ), 0.1 ) );

  test.case = 'wrong type of accuracy';
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( [ 1, 2 ], [ 1, 2 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.areParallel( [ 1, 2 ], [ 1, 2 ], null ) );
}

//

function areParallelNotDefaultAccuracy( test )
{
  let e = _.accuracy || 10 ** -7;

  /* - */

  test.open( 'without deviation' );

  test.case = 'empty vectors, equivalent, zeros';
  var src1 = vad.from( [] );
  var src2 = vad.from( [] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0 ] );
  var src2 = vad.from( [ 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5 ] );
  var src2 = vad.from( [ -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ -5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zeros';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 10, -100, 20 ] );
  var src2 = vad.from( [ 50, -500, 100 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ -5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = vad.from( [ 5, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'without deviation' );

  /* - */

  test.open( 'with deviation' );

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0 ] );
  var src2 = vad.from( [ 0 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ 5 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5 ] );
  var src2 = vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = vad.from( [ 5 ] );
  var src2 = vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0 + e * 10, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5 + e * 10, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ -5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500 + e * 10, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero';
  var src1 = vad.from( [ 10, -100, 0 ] );
  var src2 = vad.from( [ 50, -500  + e * 10, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 10, -100, 20 ] );
  var src2 = vad.from( [ 50, -500, 100  + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = vad.from( [ 0 + e * 10, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ 5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = vad.from( [ -5 + e * 10, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = vad.from( [ -5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5 + e * 10, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = vad.from( [ 5 + e * 10, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2, 20 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = vad.from( [ 5 + e * 10, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'with deviation' );
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

    comparator,
    vectorAdapterIs, /* Dmytro : the first part of routine in module wTools */
    constructorIsVector, /* Dmytro : the first part of routine in module wTools */

    to,
    toLong,

    // from

    fromLongReview,
    fromLongWithStrideReview,
    fromLongLrangeReview,
    fromLongLrangeAndStrideReview,
    fromNumberReview,

    reviewSrcIsSimpleVector,
    reviewSrcIsAdapterRoutineFrom,

    // iterator

    map,
    filter,
    while : _while,

    all,
    any,
    none,

    sort,

    cross3,

    swapVectors,

    // etc

    distributionRangeSummaryValue,
    entityEqual,

    // isEquivalent,
    // allEquivalent,

    //

    areParallelDefaultAccuracy,
    areParallelNotDefaultAccuracy,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
