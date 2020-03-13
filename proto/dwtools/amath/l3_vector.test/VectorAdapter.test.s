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

function reviewSrcIsSimpleVector( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = new makeLong( [] );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = new makeLong( [] );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => vad.review() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => vad.review( [] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => vad.review( [], 0, 0 ) );

  test.case = 'crange - number, crange < 0';
  test.shouldThrowErrorSync( () => vad.review( [ 1, 2 ], -1 ) );

  test.case = 'crange - number, crange > src.length - 1';
  test.shouldThrowErrorSync( () => vad.review( [ 1, 2 ], 5 ) );

  test.case = 'crange[ 0 ] < 0';
  test.shouldThrowErrorSync( () => vad.review( [ 1, 2 ], [ -1, 1 ] ) );

  test.case = 'crange[ 1 ] > src.length - 1';
  test.shouldThrowErrorSync( () => vad.review( [ 1, 2 ], [ 0, 4 ] ) );

  test.case = 'crange[ 1 ] - crange[ 0 ] < -1';
  test.shouldThrowErrorSync( () => vad.review( [ 1, 2 ], [ 0, 4 ] ) );

  test.case = 'crange[ 1 ] - src.length';
  test.shouldThrowErrorSync( () => vad.review( [ 1, 2 ], [ 1, 2 ] ) );
}

//

function reviewSrcIsAdapterRoutineFrom( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.from( new makeLong( [] ) );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.from( new makeLong( [] ) );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLong( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromLong( new makeLong( [] ) );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLong( new makeLong( [] ) );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLongWithStride( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromLongWithStride( new makeLong( [] ), 2 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLongWithStride( new makeLong( [] ), 2 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLongLrange( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromLongLrange( new makeLong( [] ), 0, 0 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 6 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLongLrange( new makeLong( [] ), 0, 0 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 8 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 1, 8 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 6  );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 8 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLongLrangeAndStride( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 1 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 8, 2 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 1, 6, 2 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 3, 5, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2  );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromNumber( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromNumber( vad.from( new makeLong( [] ) ), 0 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromNumber( vad.from( new makeLong( [] ) ), 0 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }

    /* */

    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromNumber( 5, 0 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 5, 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromNumber( 5, 0 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 5, 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromNumber( 5, 6 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
}

//

function reviewSrcIsAdapterRoutineFromMaybeNumber( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [] ) ), 0 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [] ) ), 0 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] )
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromMaybeNumber( new makeLong( [] ), 0 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, 0 );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, 2 );
    var exp = vad.from( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, 6 );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromMaybeNumber( new makeLong( [] ), 0 );
    var got = vad.review( src, [ 0, -1 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, [ 0, 5 ] );
    var exp = vad.from( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, [ 0, 3 ] );
    var exp = vad.from( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, [ 1, 3 ] );
    var exp = vad.from( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, [ 6, 5 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = vad.review( src, [ 3, 2 ] );
    var exp = vad.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }

  /* */

  test.case = 'src - empty vector, crange - 0';
  var src = vad.fromMaybeNumber( 5, 0 );
  var got = vad.review( src, 0 );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange - 0';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, 0 );
  var exp = vad.from( [ 5, 5, 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange > 0 && crange < src.length - 1';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, 2 );
  var exp = vad.from( [ 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, 6 );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

  test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
  var src = vad.fromMaybeNumber( 5, 0 );
  var got = vad.review( src, [ 0, -1 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, [ 0, 5 ] );
  var exp = vad.from( [ 5, 5, 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'crange[ 0 ] - 0, crange < src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, [ 0, 3 ] );
  var exp = vad.from( [ 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > 0, crange < src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, [ 1, 3 ] );
  var exp = vad.from( [ 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, [ 6, 5 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > crange[ 1 ]';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = vad.review( src, [ 3, 2 ] );
  var exp = vad.from( [] );
  test.identical( got, exp );
  test.is( got !== src );
}

// --
// iterator
// --

function mapDstIsNullRoutineFromLong( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'dst - vectorAdapter';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.map( dst );
    var exp = _.vectorAdapter.from( [ 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.map( dst, undefined );
    var exp = _.vectorAdapter.from( [ 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.map( dst, null );
    var exp = _.vectorAdapter.from( [ 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'dst - null' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [] ), _.vectorAdapter.from( [] ), ( e ) => e, 'extra' ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( [ 1, 2 ], _.vectorAdapter.from( [ 1, 2 ] ), ( e ) => e ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( { 1 : 0 }, _.vectorAdapter.from( [ 1 ] ), ( e ) => e ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 1, 2 ] ), [ 1, 2 ], ( e ) => e ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 1 ] ), { 1 : 0 }, ( e ) => e ) );

  test.case = 'wrong type of onEach';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 1, 2 ] ), _.vectorAdapter.from( [ 1, 2 ] ), [] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 1 ] ), _.vectorAdapter.from( [ 2 ] ), 'wrong' ) );

  test.case = 'different length of dst and src';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 1, 2 ] ), _.vectorAdapter.from( [] ), ( e ) => e ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 1 ] ), _.vectorAdapter.from( [ 1, 2 ] ), ( e ) => e ) );

  test.case = 'only dst, dst - null';
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null ) );

  test.case = 'two arguments, onEach not undefined' ;
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null, _.vectorAdapter.from( [ 1, 2 ] ) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 1 ] ), _.vectorAdapter.from( [ 1, 2 ] ) ) );
}

//

function mapDstIsNullRoutineFromLongLrangeAndStride( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'dst - vectorAdapter';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst );
    var exp = _.vectorAdapter.from( [ 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, undefined );
    var exp = _.vectorAdapter.from( [ 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, null );
    var exp = _.vectorAdapter.from( [ 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 1 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'dst - null' );
  }
}

//

function mapDstIsNullRoutineFromNumber( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( vad.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'from vectorAdapter' );

    /* - */

    test.open( 'from number' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 10, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'from number' );
  }
}

//

function mapOnlyDstRoutineFromLong( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'call by namespace' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, null );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = src.map( undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( null );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.close( 'call by instance' );
  }
}

//

function mapOnlyDstRoutineFromLongLrangeAndStride( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'call by namespace' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, null );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = src.map( undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( null );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.close( 'call by instance' );
  }
}

//

function mapDstIsVectorRoutineFromLong( test )
{
  var list = 
  [
    _.arrayMake,
    I16x,
    F32x
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( `long - ${ list[ i ].name }` );
    testRun( list[ i ] );
    test.close( `long - ${ list[ i ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'call by namespace' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = dst.map( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, null );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.close( 'call by instance' );
  }
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

    // 

    reviewSrcIsSimpleVector,
    reviewSrcIsAdapterRoutineFrom,
    reviewSrcIsAdapterRoutineFromLong,
    reviewSrcIsAdapterRoutineFromLongWithStride,
    reviewSrcIsAdapterRoutineFromLongLrange,
    reviewSrcIsAdapterRoutineFromLongLrangeAndStride,
    reviewSrcIsAdapterRoutineFromNumber,
    reviewSrcIsAdapterRoutineFromMaybeNumber,

    // iterator

    mapDstIsNullRoutineFromLong,
    mapDstIsNullRoutineFromLongLrangeAndStride,
    mapDstIsNullRoutineFromNumber,
    mapOnlyDstRoutineFromLong,
    mapOnlyDstRoutineFromLongLrangeAndStride,
    mapDstIsVectorRoutineFromLong,

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
