( function _VectorLong_test_s_( ) {

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
// test
// --

function assign( test )
{

  test.case = 'assign scalar';

  var src = [ 1, 2, 3 ];
  var got = _.avector.assign( src, 0 );
  var expected = [ 0, 0, 0 ];
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'assign scalar to null vector';

  var src = [];
  var got = _.avector.assign( src, 1 );
  var expected = [];
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'assign avector';

  var src = [ 1, 2, 3 ];
  var got = _.avector.assign( src, [ 4, 5, 6 ] );
  var expected = [ 4, 5, 6 ];
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'assign multiple scalars';

  var src = [ 1, 2, 3 ];
  var got = _.avector.assign( src, 4, 5, 6 );
  var expected = [ 4, 5, 6 ];
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'null avector';

  var src = [];
  var got = _.avector.assign( src );
  var expected = [];
  test.identical( expected, got );
  test.is( got === src );

  /* */

  test.case = 'assign scalar by method';

  var src = vad.fromLong([ 1, 2, 3 ]);
  var got = src.assign( 0 );
  var expected = vad.fromLong([ 0, 0, 0 ]);
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'assign scalar to null vector';

  var src = vad.fromLong([]);
  var got = src.assign( 1 );
  var expected = vad.fromLong([]);
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'assign avector';

  var src = vad.fromLong([ 1, 2, 3 ]);
  var got = src.assign([ 4, 5, 6 ] );
  var expected = vad.fromLong([ 4, 5, 6 ]);
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'assign multiple scalars';

  var src = vad.fromLong([ 1, 2, 3 ]);
  var got = src.assign([ 4, 5, 6 ]);
  var expected = vad.fromLong([ 4, 5, 6 ]);
  test.identical( expected, got );
  test.is( got === src );

  test.case = 'null avector';

  var src = vad.fromLong([]);
  var got = src.assign();
  var expected = vad.fromLong([]);
  test.identical( expected, got );
  test.is( got === src );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector.assign() );
  test.shouldThrowErrorSync( () => _.avector.assign( [], 1, 1 ) );
  test.shouldThrowErrorSync( () => _.avector.assign( [ 0 ], 1, 1 ) );
  test.shouldThrowErrorSync( () => _.avector.assign( [ 0 ], '1' ) );
  test.shouldThrowErrorSync( () => _.avector.assign( [ 0 ], [ 1, 1 ] ) );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange - 0';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = new makeLong( [] );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }

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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.from( new makeLong( [] ) );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLong( new makeLong( [] ) );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLong( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLongWithStride( new makeLong( [] ), 2 );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLongWithStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 6 );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLongLrange( new makeLong( [] ), 0, 0 );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 8 );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 1, 8 );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 6 );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLongLrange( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 8 );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 2, 4, 6, 8, 10 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 8, 2 );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 2, 4, 6 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 1, 6, 2 );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 3, 5, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromLongLrangeAndStride( new makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromNumber( vad.from( new makeLong( [] ) ), 0 );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }

  /* */

  test.case = 'src - empty vector, crange - 0';
  var src = vad.fromNumber( 5, 0 );
  var got = _.avector.review( src, 0 );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - 0';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, 0 );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange > 0 && crange < src.length - 1';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, 2 );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - src.length';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, 6 );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

  test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
  var src = vad.fromNumber( 5, 0 );
  var got = _.avector.review( src, [ 0, -1 ] );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, [ 0, 5 ] );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] - 0, crange < src.length';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, [ 0, 3 ] );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > 0, crange < src.length';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, [ 1, 3 ] );
  var exp = _.longDescriptor.from( [ 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, [ 6, 5 ] );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > crange[ 1 ]';
  var src = vad.fromNumber( 5, 6 );
  var got = _.avector.review( src, [ 3, 2 ] );
  var exp = _.longDescriptor.from( [] );
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
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [] ) ), 0 );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromMaybeNumber( vad.from( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp =new makeLong( [] ); 
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange - 0';
    var src = vad.fromMaybeNumber( new makeLong( [] ), 0 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - 0';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, 0 );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange > 0 && crange < src.length - 1';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, 2 );
    var exp = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange - src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, 6 );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
    var src = vad.fromMaybeNumber( new makeLong( [] ), 0 );
    var got = _.avector.review( src, [ 0, -1 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, [ 0, 5 ] );
    var exp = new makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] - 0, crange < src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, [ 0, 3 ] );
    var exp = new makeLong( [ 0, 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > 0, crange < src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, [ 1, 3 ] );
    var exp = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, [ 6, 5 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'crange[ 0 ] > crange[ 1 ]';
    var src = vad.fromMaybeNumber( new makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.avector.review( src, [ 3, 2 ] );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
  }

  /* */

  test.case = 'src - empty vector, crange - 0';
  var src = vad.fromMaybeNumber( 5, 0 );
  var got = _.avector.review( src, 0 );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - 0';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, 0 );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange > 0 && crange < src.length - 1';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, 2 );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange - src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, 6 );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

  test.case = 'src - empty vector, crange[ 0 ] and crange[ 1 ] - -1';
  var src = vad.fromMaybeNumber( 5, 0 );
  var got = _.avector.review( src, [ 0, -1 ] );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] - 0, crange[ 1 ] - src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, [ 0, 5 ] );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] - 0, crange < src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, [ 0, 3 ] );
  var exp = _.longDescriptor.from( [ 5, 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > 0, crange < src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, [ 1, 3 ] );
  var exp = _.longDescriptor.from( [ 5, 5, 5 ] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] and crange[ 1 ] - src.length';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, [ 6, 5 ] );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'crange[ 0 ] > crange[ 1 ]';
  var src = vad.fromMaybeNumber( 5, 6 );
  var got = _.avector.review( src, [ 3, 2 ] );
  var exp = _.longDescriptor.from( [] );
  test.identical( got, exp );
  test.is( got !== src );
}

//

function mapDstIsNullSimpleVector( test )
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
    var dst = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.avector.map( dst );
    var exp = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.avector.map( dst, undefined );
    var exp = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.avector.map( dst, null );
    var exp = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, null );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'dst - null' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.avector.map() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [] ), _.avector.make( [] ), ( e ) => e, 'extra' ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.avector.map( { 1 : 0 }, _.avector.make( [ 1 ] ), ( e ) => e ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [ 1 ] ), { 1 : 0 }, ( e ) => e ) );

  test.case = 'wrong type of onEach';
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [ 1, 2 ] ), _.avector.make( [ 1, 2 ] ), [] ) );
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [ 1 ] ), _.avector.make( [ 2 ] ), 'wrong' ) );

  test.case = 'different length of dst and src';
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [ 1, 2 ] ), _.avector.make( [] ), ( e ) => e ) );
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [ 1 ] ), _.avector.make( [ 1, 2 ] ), ( e ) => e ) );

  test.case = 'only dst, dst - null';
  test.shouldThrowErrorSync( () => _.avector.map( null ) );

  test.case = 'two arguments, onEach not undefined' ;
  test.shouldThrowErrorSync( () => _.avector.map( null, _.avector.make( [ 1, 2 ] ) ) );
  test.shouldThrowErrorSync( () => _.avector.map( _.avector.make( [ 2, 1 ] ), _.avector.make( [ 1, 2 ] ) ) );
}

//

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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, null );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );
  }
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, null );
    var exp = _.longDescriptor.from( 3 );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 3 );
    test.identical( got, exp );
    test.is( got !== src );
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
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.map( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.map( dst, src, null );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'from vectorAdapter' );

    /* - */

    test.open( 'from number' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, null );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 5 );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'from number' );
  }
}

//

function mapOnlyDstSimpleVector( test )
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
    test.open( 'src - instance of avector' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( src, undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, null );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.close( 'src - instance of avector' );

    /* - */

    test.open( 'src - simple vector' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = new makeLong( [] );
    var got = _.avector.map( src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( src, null );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = new makeLong( [] );
    var got = _.avector.map( src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = new makeLong( [] );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = new makeLong( [] );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = new makeLong( [] );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = new makeLong( [] );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    test.close( 'src - simple vector' );
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
    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, null );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
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
    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( src, null );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( src, ( e ) => e );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function mapDstIsVectorSimpleVector( test )
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
    test.open( 'routine make' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, null );
    var exp = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.avector.make( new makeLong( [ -2, -4, -6, -8, -10 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.close( 'routine make' );

    /* - */

    test.open( 'simple vector' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.map( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( dst, src, null );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.close( 'simple vector' );
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, null );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );
  }
}

//

function mapDstIsVectorRoutineFromLongLrangeAndStride( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, null );
    var exp = new makeLong( [ -1, -3, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -6, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ -1, -3, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );
  }
}

//

function mapDstIsVectorRoutineFromNumberWithVectorAdapter( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [] ) ), 0 );
    var got = _.avector.map( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.avector.map( dst, src, null );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [] ) ), 0 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [] ) ), 0 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [] ) ), 0 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [] ) ), 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [] ) ), 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( new makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );
  }
}

//

function mapDstIsVectorRoutineFromNumberWithNumber( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, null );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e ) => e );
    var exp = new makeLong( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -8, -9, -10, -11, -12 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [ -1, -2, -3, -4, -5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );
  }
}

//

function filterDstIsNullSimpleVector( test )
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
    var dst = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.avector.filter( dst );
    var exp = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.avector.filter( dst, undefined );
    var exp = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    var got = _.avector.filter( dst, null );
    var exp = _.avector.make( new makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, null );
    var exp = _.longDescriptor.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 0 );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'dst - null' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.avector.filter() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.avector.filter( _.avector.make( [] ), _.avector.make( [] ), ( e ) => e, 'extra' ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.avector.filter( { 1 : 0 }, _.avector.make( [ 1 ] ), ( e ) => e ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.avector.filter( _.avector.make( [ 1 ] ), { 1 : 0 }, ( e ) => e ) );

  test.case = 'wrong type of onEach';
  test.shouldThrowErrorSync( () => _.avector.filter( _.avector.make( [ 1, 2 ] ), _.avector.make( [ 1, 2 ] ), [] ) );
  test.shouldThrowErrorSync( () => _.avector.filter( _.avector.make( [ 1 ] ), _.avector.make( [ 2 ] ), 'wrong' ) );

  test.case = 'only dst, dst - null';
  test.shouldThrowErrorSync( () => _.avector.filter( null ) );

  test.case = 'two arguments, onEach not undefined' ;
  test.shouldThrowErrorSync( () => _.avector.filter( null, _.avector.make( [ 1, 2 ] ) ) );
  test.shouldThrowErrorSync( () => _.avector.filter( _.avector.make( [ 2, 1 ] ), _.avector.make( [ 1, 2 ] ) ) );

  test.case = 'dst === src, onEach returns undefined';
  test.shouldThrowErrorSync( () => _.avector.filter( [ 1, 2, 3 ], ( e ) => undefined ) );
}

//

function filterDstIsNullRoutineFromLong( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, null );
    var exp = _.longDescriptor.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 0 );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function filterDstIsNullRoutineFromLongLrangeAndStride( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, null );
    var exp = _.longDescriptor.from( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 0 );
    test.identical( got, exp );
    test.is( got !== src );
  }
}

//

function filterDstIsNullRoutineFromNumber( test )
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
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.filter( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.filter( dst, src, null );
    var exp = _.longDescriptor.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [] ), 0 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 0 );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'from vectorAdapter' );

    /* - */

    test.open( 'from number' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.filter( dst, src, undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.filter( dst, src, null );
    var exp = _.longDescriptor.from( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.longDescriptor.from( 0 );
    test.identical( got, exp );
    test.is( got !== src );

    test.close( 'from number' );
  }
}

//

function filterOnlyDstSimpleVector( test )
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
    test.open( 'src - instance of avector' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( src, undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, null );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () => 
    {
      var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
      var got = _.avector.filter( src, ( e, k, s, d ) => undefined ); 
    });

    test.close( 'src - instance of avector' );

    /* - */

    test.open( 'src - simple vector' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = new makeLong( [] );
    var got = _.avector.filter( src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach - null';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( src, null );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = new makeLong( [] );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = new makeLong( [] );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = new makeLong( [] );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = new makeLong( [] );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = new makeLong( [] );
    var got = _.avector.filter( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got === src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () => 
    {
      var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
      var got = _.avector.filter( src, ( e, k, s, d ) => undefined ); 
    });

    test.close( 'src - simple vector' );
  }
}

//

function filterOnlyDstRoutineFromLong( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, null );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () => 
    {
      var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
      var got = _.avector.filter( src, ( e, k, s, d ) => undefined );
    });
  }
}

//

function filterOnlyDstRoutineFromLongLrangeAndStride( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( src, null );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( src, ( e ) => e );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( src, ( e, k, s, d ) => d.length );
    var exp = new makeLong( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () => 
    {
      var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
      var got = _.avector.filter( src, ( e, k, s, d ) => undefined );
    });
  }
}

//

function filterDstIsVectorSimpleVector( test )
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
    test.open( 'routine make' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, null );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = _.avector.make( new makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.avector.make( new makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.avector.make( new makeLong( [ -2, -4, -6, -8, -10 ] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.avector.make( new makeLong( [] ) );
    var src = _.avector.make( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.avector.make( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.avector.make( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.avector.make( new makeLong( [] ) );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.close( 'routine make' );

    /* - */

    test.open( 'simple vector' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.filter( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( dst, src, null );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = new makeLong( [] );
    var src = new makeLong( [] );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = new makeLong( [ -1, -2, -3, -4, -5 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.close( 'simple vector' );
  }
}

//

function filterDstIsVectorRoutineFromLong( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, null );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( new makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );
  }
}

//

function filterDstIsVectorRoutineFromLongLrangeAndStride( test )
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
    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, null );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e ) => e );
    var exp = new makeLong( [ 1, 3, 5 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k ) => k );
    var exp = new makeLong( [ 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s ) => s.length );
    var exp = new makeLong( [ 3, 3, 3 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = new makeLong( [ -2, -6, -10 ] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [] ), 0, 0, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( new makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.avector.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = new makeLong( [] );
    test.identical( got, exp );
    test.is( got !== src );
    test.is( got !== dst );
  }
}

//

function cross3( test )
{
  test.open( 'src1 and src2 - simple vectors' );

  test.case = 'dst - only zeros, src1 and src2 - only zeros';
  var dst = [ 0, 0, 0 ];
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - only zeros';
  var dst = [ 1, -5, 's' ];
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - different elements, src1 - only zeros, src2 - different elements';
  var dst = [ 1, -1, 3 ];
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 5, 4, 3 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 - different elements, src2 - only zeros';
  var dst = [ 1, -5, 's' ];
  var src1 = [ 10, -5, 4 ];
  var src2 = [ 0, 0, 0 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same positive number';
  var dst = [ 0, 0, 0 ];
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same positive number';
  var dst = [ 1, -5, 's' ];
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same negative number';
  var dst = [ 0, 0, 0 ];
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same negative number';
  var dst = [ 1, -5, 's' ];
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different positive values';
  var dst = [ 0, 0, 0 ];
  var src1 = [ 1, 2, 3 ];
  var src2 = [ 4, 5, 6 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different positive values';
  var dst = [ 1, -5, 's' ];
  var src1 = [ 1, 2, 3 ];
  var src2 = [ 4, 5, 6 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different negative values';
  var dst = [ 0, 0, 0 ];
  var src1 = [ -1, -2, -3 ];
  var src2 = [ -4, -5, -6 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different negative values';
  var dst = [ 1, -5, 's' ];
  var src1 = [ -1, -2, -3 ];
  var src2 = [ -4, -5, -6 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different values';
  var dst = [ 0, 0, 0 ];
  var src1 = [ -1, 2, 3 ];
  var src2 = [ 4, -5, -6 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different values';
  var dst = [ 1, -5, 's' ];
  var src1 = [ -1, 2, 3 ];
  var src2 = [ 4, -5, -6 ];
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'src1 and src2 - simple vectors' );

  /* - */

  test.open( 'src1 and src2 - vectorAdapter instances' );

  test.case = 'dst - only zeros, src1 and src2 - only zeros';
  var dst = [ 0, 0, 0 ];
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - only zeros';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - different elements, src1 - only zeros, src2 - different elements';
  var dst = [ 1, -1, 3 ];
  var src1 = vad.from( [ 0, 0, 0 ] );
  var src2 = vad.from( [ 5, 4, 3 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 - different elements, src2 - only zeros';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ 10, -5, 4 ] );
  var src2 = vad.from( [ 0, 0, 0 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same positive number';
  var dst = [ 0, 0, 0 ];
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same positive number';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ 5, 5, 5 ] );
  var src2 = vad.from( [ 5, 5, 5 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same negative number';
  var dst = [ 0, 0, 0 ];
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same negative number';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ -5, -5, -5 ] );
  var src2 = vad.from( [ -5, -5, -5 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 0, 0, 0 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different positive values';
  var dst = [ 0, 0, 0 ];
  var src1 = vad.from( [ 1, 2, 3 ] );
  var src2 = vad.from( [ 4, 5, 6 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different positive values';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ 1, 2, 3 ] );
  var src2 = vad.from( [ 4, 5, 6 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different negative values';
  var dst = [ 0, 0, 0 ];
  var src1 = vad.from( [ -1, -2, -3 ] );
  var src2 = vad.from( [ -4, -5, -6 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different negative values';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ -1, -2, -3 ] );
  var src2 = vad.from( [ -4, -5, -6 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ -3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different values';
  var dst = [ 0, 0, 0 ];
  var src1 = vad.from( [ -1, 2, 3 ] );
  var src2 = vad.from( [ 4, -5, -6 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different values';
  var dst = [ 1, -5, 's' ];
  var src1 = vad.from( [ -1, 2, 3 ] );
  var src2 = vad.from( [ 4, -5, -6 ] );
  var got = _.avector.cross3( dst, src1, src2 );
  var exp = [ 3, 6, -3 ];
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'src1 and src2 - vectorAdapter instances' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.avector.cross3() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3 ], [ 3, 2, 1 ] ) );

  test.case = 'wrong length of dst';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3, 4 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.avector.cross3( null, [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( { a : 1, b : 2, c : 3 }, [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.case = 'wrong length of src1';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 1, 2, 3 ] ) );

  test.case = 'wrong type of src1';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], undefined, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], 3, [ 1, 2, 3 ] ) );

  test.case = 'wrong length of src2';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], [] ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ) );

  test.case = 'wrong type of src2';
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], true ) );
  test.shouldThrowErrorSync( () => _.avector.cross3( [ 1, 2, 3 ], [ 1, 2, 3 ], 'str' ) );
}

//

function cross( test )
{
  test.case = 'trivial, make new'; /* */
  var a = [ 1, 2, 3 ];
  var b = [ 4, 5, 6 ];
  var expected = [ -3, +6, -3 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'zero, make new'; /* */
  var a = [ 0, 0, 0 ];
  var b = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'same, make new'; /* */
  var a = [ 1, 1, 1 ];
  var b = [ 1, 1, 1 ];
  var expected = [ 0, 0, 0 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'perpendicular1, make new'; /* */
  var a = [ 1, 0, 0 ];
  var b = [ 0, 0, 1 ];
  var expected = [ 0, -1, 0 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'perpendicular2, make new'; /* */
  var a = [ 0, 0, 1 ];
  var b = [ 1, 0, 0 ];
  var expected = [ 0, +1, 0 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'perpendicular3, make new'; /* */
  var a = [ 1, 0, 0 ];
  var b = [ 0, 1, 0 ];
  var expected = [ 0, 0, +1 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'perpendicular4, make new'; /* */
  var a = [ 0, 1, 0 ];
  var b = [ 1, 0, 0 ];
  var expected = [ 0, 0, -1 ];
  var got = _.avector.cross( null, a, b );
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'trivial'; ///
  var a = [ 1, 2, 3 ];
  var b = [ 4, 5, 6 ];
  var expected = [ -3, +6, -3 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'zero'; /* */
  var a = [ 0, 0, 0 ];
  var b = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'same'; /* */
  var a = [ 1, 1, 1 ];
  var b = [ 1, 1, 1 ];
  var expected = [ 0, 0, 0 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular1'; /* */
  var a = [ 1, 0, 0 ];
  var b = [ 0, 0, 1 ];
  var expected = [ 0, -1, 0 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular2'; /* */
  var a = [ 0, 0, 1 ];
  var b = [ 1, 0, 0 ];
  var expected = [ 0, +1, 0 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular3'; /* */
  var a = [ 1, 0, 0 ];
  var b = [ 0, 1, 0 ];
  var expected = [ 0, 0, +1 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular4'; /* */
  var a = [ 0, 1, 0 ];
  var b = [ 1, 0, 0 ];
  var expected = [ 0, 0, -1 ];
  var got = _.avector.cross( a, b );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'trivial'; ///
  var a = [ 1, 2, 3 ];
  var b = [ 4, 5, 6 ];
  var c = [ 7, 8, 9 ];
  var expected = [ 78, 6, -66 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'zero'; /* */
  var a = [ 0, 0, 0 ];
  var b = [ 0, 0, 0 ];
  var c = [ 7, 8, 9 ];
  var expected = [ 0, 0, 0 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'same'; /* */
  var a = [ 1, 1, 1 ];
  var b = [ 1, 1, 1 ];
  var c = [ 7, 8, 9 ];
  var expected = [ 0, 0, 0 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular1'; /* */
  var a = [ 1, 0, 0 ];
  var b = [ 0, 0, 1 ];
  var c = [ 7, 8, 9 ];
  var expected = [ -9, 0, 7 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular2'; /* */
  var a = [ 0, 0, 1 ];
  var b = [ 1, 0, 0 ];
  var c = [ 7, 8, 9 ];
  var expected = [ 9, 0, -7 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular3'; /* */
  var a = [ 1, 0, 0 ];
  var b = [ 0, 1, 0 ];
  var c = [ 7, 8, 9 ];
  var expected = [ -8, 7, 0 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'perpendicular4'; /* */
  var a = [ 0, 1, 0 ];
  var b = [ 1, 0, 0 ];
  var c = [ 7, 8, 9 ];
  var expected = [ 8, -7, 0 ];
  var got = _.avector.cross( a, b, c );
  test.identical( got, expected );
  test.is( got === a );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; ///
  test.shouldThrowErrorSync( () => _.avector.cross( 1 ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( undefined, [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ], [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ], [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [], function(){} ) );
}

cross.timeOut = 15000;

//

function abs( test )
{
  test.case = 'trivial';

  var expected = [ 1, 2, 3 ];
  var dst = [ -1, -2, -3 ];
  var got = _.avector.abs( dst );

  test.identical( got, expected );
  test.is( dst === got );
}

//

function add( test )
{
  test.case = 'vector vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.add( null, ins1, ins2 );
  test.identical( got, [ 4, 6, 8 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'vector vector vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.add( null, ins1, ins2, ins3 );
  test.identical( got, [ 14, 26, 38 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var got = _.avector.add( null, ins1, ins2 );
  test.identical( got, [ 11, 12, 13 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.add( null, ins1, ins2, ins3 );
  test.identical( got, [ 21, 32, 43 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var got = _.avector.add( null, ins1, ins2 );
  test.identical( got, [ 11, 12, 13 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.add( null, ins1, ins2, ins3 );
  test.identical( got, [ 21, 32, 43 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'scalar scalar, new dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var got = _.avector.add( null, ins1, ins2 );
  test.identical( got, 11 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar scalar scalar, new dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;
  var got = _.avector.add( null, ins1, ins2, ins3 );
  test.identical( got, 111 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector vector, first argument is dst'; ///
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.add( ins1, ins2 );
  test.identical( got, [ 4, 6, 8 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'vector vector vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.add( ins1, ins2, ins3 );
  test.identical( got, [ 14, 26, 38 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var got = _.avector.add( ins1, ins2 );
  test.identical( got, [ 11, 12, 13 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'vector scalar vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.add( ins1, ins2, ins3 );
  test.identical( got, [ 21, 32, 43 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var got = _.avector.add( ins1, ins2 );
  test.identical( got, [ 11, 12, 13 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'vector scalar vector, first argument is dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.add( ins1, ins2, ins3 );
  test.identical( got, [ 21, 32, 43 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'scalar scalar, first argument is dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var got = _.avector.add( ins1, ins2 );
  test.identical( got, 11 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  test.case = 'scalar scalar scalar, first argument is dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;
  var got = _.avector.add( ins1, ins2, ins3 );
  test.identical( got, 111 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.avector.add( [ 1, 2, 3 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.add( [ 1, 2, 3 ], [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.add( '1', [ 3, 4, 5 ], null ) );

  test.shouldThrowErrorSync( () => _.avector.add( [ 0, 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.add( [ 0, 0 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.add( [ 0 ], [ 1, 1, 1 ] ) );
}

add.timeOut = 15000;

//

function sub( test )
{
  test.case = 'trivial'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.sub( ins1, ins2 );
  test.identical( got, [ -2, -2, -2 ] );
  test.identical( ins1, [ -2, -2, -2 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got == ins1 );

  test.case = 'vector vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.sub( null, ins1, ins2 );
  test.identical( got, [ -2, -2, -2 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'vector vector vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.sub( null, ins1, ins2, ins3 );
  test.identical( got, [ -12, -22, -32 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var got = _.avector.sub( null, ins1, ins2 );
  test.identical( got, [ -9, -8, -7 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.sub( null, ins1, ins2, ins3 );
  test.identical( got, [ -19, -28, -37 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var got = _.avector.sub( null, ins1, ins2 );
  test.identical( got, [ 9, 8, 7 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.sub( null, ins1, ins2, ins3 );
  test.identical( got, [ -1, -12, -23 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'scalar scalar, new dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var got = _.avector.sub( null, ins1, ins2 );
  test.identical( got, -9 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar scalar scalar, new dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;
  var got = _.avector.sub( null, ins1, ins2, ins3 );
  test.identical( got, -109 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector vector, first argument is dst'; ///
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.sub( ins1, ins2 );
  test.identical( got, [ -2, -2, -2 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'vector vector vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.sub( ins1, ins2, ins3 );
  test.identical( got, [ -12, -22, -32 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var got = _.avector.sub( ins1, ins2 );
  test.identical( got, [ -9, -8, -7 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'vector scalar vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.sub( ins1, ins2, ins3 );
  test.identical( got, [ -19, -28, -37 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var got = _.avector.sub( ins1, ins2 );
  test.identical( got, [ 9, 8, 7 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'vector scalar vector, first argument is dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.sub( ins1, ins2, ins3 );
  test.identical( got, [ -1, -12, -23 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'scalar scalar, first argument is dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var got = _.avector.sub( ins1, ins2 );
  test.identical( got, -9 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  test.case = 'scalar scalar scalar, first argument is dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;
  var got = _.avector.sub( ins1, ins2, ins3 );
  test.identical( got, -109 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.avector.sub( [ 1, 2, 3 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 1, 2, 3 ], [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.sub( '1', [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 0, 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 0, 0 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 0 ], [ 1, 1, 1 ] ) );
}

sub.timeOut = 15000;

//

function mul( test )
{
  test.case = 'vector vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.mul( null, ins1, ins2 );
  test.identical( got, [ 3, 8, 15 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'vector vector vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.mul( null, ins1, ins2, ins3 );
  test.identical( got, [ 30, 160, 450 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var got = _.avector.mul( null, ins1, ins2 );
  test.identical( got, [ 10, 20, 30 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.mul( null, ins1, ins2, ins3 );
  test.identical( got, [ 100, 400, 900 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var got = _.avector.mul( null, ins1, ins2 );
  test.identical( got, [ 10, 20, 30 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.mul( null, ins1, ins2, ins3 );
  test.identical( got, [ 100, 400, 900 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'scalar scalar, new dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var got = _.avector.mul( null, ins1, ins2 );
  test.identical( got, 10 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar scalar scalar, new dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;
  var got = _.avector.mul( null, ins1, ins2, ins3 );
  test.identical( got, 1000 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector vector, first argument is dst'; ///
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var got = _.avector.mul( ins1, ins2 );
  test.identical( got, [ 3, 8, 15 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'vector vector vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.mul( ins1, ins2, ins3 );
  test.identical( got, [ 30, 160, 450 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var got = _.avector.mul( ins1, ins2 );
  test.identical( got, [ 10, 20, 30 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'vector scalar vector, first argument is dst'; /* */
  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.mul( ins1, ins2, ins3 );
  test.identical( got, [ 100, 400, 900 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var got = _.avector.mul( ins1, ins2 );
  test.identical( got, [ 10, 20, 30 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'vector scalar vector, first argument is dst'; /* */
  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];
  var got = _.avector.mul( ins1, ins2, ins3 );
  test.identical( got, [ 100, 400, 900 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'scalar scalar, first argument is dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var got = _.avector.mul( ins1, ins2 );
  test.identical( got, 10 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  test.case = 'scalar scalar scalar, first argument is dst'; /* */
  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;
  var got = _.avector.mul( ins1, ins2, ins3 );
  test.identical( got, 1000 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.avector.mul( [ 1, 2, 3 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 1, 2, 3 ], [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.mul( '1', [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 0, 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 0, 0 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 0 ], [ 1, 1, 1 ] ) );
}

mul.timeOut = 15000;

//

function div( test )
{
  test.case = 'vector vector, new dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];

  var got = _.avector.div( null, ins1, ins2 );

  test.equivalent( got, [ 1/3, 2/4, 3/5 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'vector vector vector, new dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];

  var got = _.avector.div( null, ins1, ins2, ins3 );

  test.equivalent( got, [ 1/3/10, 2/4/20, 3/5/30 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;

  var got = _.avector.div( null, ins1, ins2 );

  test.equivalent( got, [ 1/10, 2/10, 3/10 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];

  var got = _.avector.div( null, ins1, ins2, ins3 );

  test.equivalent( got, [ 1/10/10, 2/10/20, 3/10/30 ] );
  test.identical( ins1, [ 1, 2, 3 ] );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar vector, new dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];

  var got = _.avector.div( null, ins1, ins2 );

  test.equivalent( got, [ 10/1, 10/2, 10/3 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'vector scalar vector, new dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];

  var got = _.avector.div( null, ins1, ins2, ins3 );

  test.equivalent( got, [ 10/1/10, 10/2/20, 10/3/30 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );
  test.is( got !== ins1 );

  test.case = 'scalar scalar, new dst'; /* */

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.div( null, ins1, ins2 );
  test.equivalent( got, 1/10 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  test.case = 'scalar scalar scalar, new dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.div( null, ins1, ins2, ins3 );

  test.equivalent( got, 1/10/100 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );
  test.is( got !== ins1 );

  /* -- */

  test.case = 'vector vector, first argument is dst';

  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];

  var got = _.avector.div( ins1, ins2 );

  test.equivalent( got, [ 1/3, 2/4, 3/5 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'vector vector vector, first argument is dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = [ 3, 4, 5 ];
  var ins3 = [ 10, 20, 30 ];

  var got = _.avector.div( ins1, ins2, ins3 );

  test.equivalent( got, [ 1/3/10, 2/4/20, 3/5/30 ] );
  test.identical( ins2, [ 3, 4, 5 ] );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;

  var got = _.avector.div( ins1, ins2 );

  test.equivalent( got, [ 1/10, 2/10, 3/10 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = [ 1, 2, 3 ];
  var ins2 = 10;
  var ins3 = [ 10, 20, 30 ];

  var got = _.avector.div( ins1, ins2, ins3 );

  test.equivalent( got, [ 1/10/10, 2/10/20, 3/10/30 ] );
  test.identical( ins2, 10 );
  test.is( got === ins1 );

  test.case = 'scalar vector, first argument is dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];

  var got = _.avector.div( ins1, ins2 );

  test.equivalent( got, [ 10/1, 10/2, 10/3 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1, 2, 3 ];
  var ins3 = [ 10, 20, 30 ];

  var got = _.avector.div( ins1, ins2, ins3 );

  test.equivalent( got, [ 10/1/10, 10/2/20, 10/3/30 ] );
  test.identical( ins1, 10 );
  test.identical( ins2, [ 1, 2, 3 ] );

  test.case = 'scalar scalar, first argument is dst'; /* */

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.div( ins1, ins2 );

  test.equivalent( got, 1/10 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  test.case = 'scalar scalar scalar, first argument is dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.div( ins1, ins2, ins3 );

  test.equivalent( got, 1/10/100 );
  test.identical( ins1, 1 );
  test.identical( ins2, 10 );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.avector.div( [ 1, 2, 3 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 1, 2, 3 ], [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.div( '1', [ 3, 4, 5 ], null ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 0, 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 0, 0 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 0 ], [ 1, 1, 1 ] ) );
}

div.timeOut = 15000;

//

function heterogeneousScaledRoutines( test )
{
  test.case = 'addScaled null, vector, vector, vector'; /* */

  var expected = [ 31, 42, 33 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.addScaled( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec([ 31, 42, 33 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.addScaled( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'addScaled scalar, vector, vector, vector'; /* */

  var expected = [ 14 ];
  var dst = [ 9 ];
  var src0 = 2;
  var src1 = 3;
  var src2 = 4;
  var got = _.avector.addScaled( dst, src0, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'addScaled vector, vector, vector, vector'; /* */

  var expected = [ 31, 42, 33 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.addScaled( dst, dst.slice(), src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 31, 42, 33 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.addScaled( dst, dst.slice(), src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  /* */

  test.case = 'addScaled vector, vector, vector'; /* */

  var expected = [ 31, 42, 33 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.addScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 31, 42, 33 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.addScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'addScaled scalar, vector, vector'; /* */

  var expected = [ 130, 140, 130 ];
  var dst = [ 1, 2, 3 ];
  var dst = 100;
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.addScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec([ 130, 140, 130 ]);
  var dst = vec([ 1, 2, 3 ]);
  var dst = 100;
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.addScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'subScaled vector, vector, vector'; /* */

  var expected = [ -29, -38, -27 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.subScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ -29, -38, -27 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.subScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'mulScaled vector, vector, vector'; /* */

  var expected = [ 30, 80, 90 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.mulScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 30, 80, 90 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.mulScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'divScaled vector, vector, vector'; /* */

  var expected = [ 1/30, 2/40, 3/30 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = [ 10, 20, 30 ];
  var got = _.avector.divScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 1/30, 2/40, 3/30 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = vec([ 10, 20, 30 ]);
  var got = _.vectorAdapter.divScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'addScaled vector, vector, scaler'; /* */

  var expected = [ 31, 22, 13 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = 10;
  var got = _.avector.addScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = [ 1, 2, 3 ];
  var got = _.avector.addScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 31, 22, 13 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = 10;
  var got = _.vectorAdapter.addScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = vec([ 1, 2, 3 ]);
  var got = _.vectorAdapter.addScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'subScaled vector, vector, scaler'; /* */

  var expected = [ -29, -18, -7 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = 10;
  var got = _.avector.subScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = [ 1, 2, 3 ];
  var got = _.avector.subScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ -29, -18, -7 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = 10;
  var got = _.vectorAdapter.subScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = vec([ 1, 2, 3 ]);
  var got = _.vectorAdapter.subScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'mulScaled vector, vector, scaler'; /* */

  var expected = [ 30, 40, 30 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = 10;
  var got = _.avector.mulScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = [ 1, 2, 3 ];
  var got = _.avector.mulScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 30, 40, 30 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = 10;
  var got = _.vectorAdapter.mulScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = vec([ 1, 2, 3 ]);
  var got = _.vectorAdapter.mulScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'divScaled vector, vector, scaler'; /* */

  var expected = [ 1/30, 2/20, 3/10 ];
  var dst = [ 1, 2, 3 ];
  var src1 = [ 3, 2, 1 ];
  var src2 = 10;
  var got = _.avector.divScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = [ 1, 2, 3 ];
  var got = _.avector.divScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 1/30, 2/20, 3/10 ]);
  var dst = vec([ 1, 2, 3 ]);
  var src1 = vec([ 3, 2, 1 ]);
  var src2 = 10;
  var got = _.vectorAdapter.divScaled( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );
  var dst = vec([ 1, 2, 3 ]);
  var got = _.vectorAdapter.divScaled( dst, src2, src1 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'empty vector'; /* */

  function checkEmpty( rname )
  {
    var op = _.vectorAdapter[ rname ].operation;

    var dst = [];
    var args = _.dup( [], op.takingArguments[ 0 ]-1 );
    args.unshift( dst );
    var got = _.avector[ rname ].apply( _, args );
    test.is( got === dst );
    test.identical( got , [] );

    var dst = vec([]);
    var args = _.dup( vec([]), op.takingArguments[ 0 ]-1 );
    args.unshift( dst );
    var got = _.vectorAdapter[ rname ].apply( _, args );
    test.is( got === dst );
    test.identical( got , vec([]) );

  }

  checkEmpty( 'addScaled' );
  checkEmpty( 'subScaled' );
  checkEmpty( 'mulScaled' );
  checkEmpty( 'subScaled' );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  function shouldThrowErrorOfAnyKind( rname )
  {

    test.case = 'bad arguments for ' + rname;

    test.shouldThrowErrorSync( () => _.avector[ rname ]() );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3 ], [ 5, 5 ] ) );
    // test.shouldThrowErrorSync( () => _.avector[ rname ]( 1, [ 3, 3 ], [ 5, 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], '1' ) );

    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined, [ 1, 2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined, [ 1, 2 ], [ 3, 4 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined, [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ) );

    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]() );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), vec([ 5 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3 ]), vec([ 5, 5 ]) ) );

    // test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( 1, vec([ 3, 3 ]), vec([ 5, 5 ]) ) );

    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), undefined ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), '1' ) );

    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined, vec([ 1, 2 ]) ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined, vec([ 1, 2 ]), vec([ 3, 4 ]) ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined, vec([ 1, 2 ]), vec([ 3, 4 ]), vec([ 5, 6 ]) ) );

    test.shouldThrowErrorSync( () => _.vectorAdapter.addScaled( 1, vec([ 1 ]), vec([ 1 ]), vec([ 1 ]) ) );

  }

  shouldThrowErrorOfAnyKind( 'addScaled' );
  shouldThrowErrorOfAnyKind( 'subScaled' );
  shouldThrowErrorOfAnyKind( 'mulScaled' );
  shouldThrowErrorOfAnyKind( 'subScaled' );
  // shouldThrowErrorOfAnyKind( 'clamp' );
}

heterogeneousScaledRoutines.timeOut = 15000;

//

function clamp( test )
{
  test.case = 'clamp vectors, 4 arguments'; /* */

  var expected = [ 30, 20, 20, 20, 15, 15 ];
  var dst = [ 10, 20, 10, 30, 30, 15 ];
  var src1 = [ 30, 20, 20, 20, 10, 10 ];
  var src2 = [ 40, 20, 20, 20, 15, 15 ];
  var got = _.avector.clamp( dst, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 30, 20, 20, 20, 15, 15 ]);
  var dst = vec([ 10, 20, 10, 30, 30, 15 ]);
  var src1 = vec([ 30, 20, 20, 20, 10, 10 ]);
  var src2 = vec([ 40, 20, 20, 20, 15, 15 ]);
  var got = _.vectorAdapter.clamp( dst, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'clamp vectors, 3 arguments and null'; /* */

  var expected = [ 30, 20, 20, 20, 15, 15 ];
  var dst = [ 10, 20, 10, 30, 30, 15 ];
  var src1 = [ 30, 20, 20, 20, 10, 10 ];
  var src2 = [ 40, 20, 20, 20, 15, 15 ];
  var got = _.avector.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec([ 30, 20, 20, 20, 15, 15 ]);
  var dst = vec([ 10, 20, 10, 30, 30, 15 ]);
  var src1 = vec([ 30, 20, 20, 20, 10, 10 ]);
  var src2 = vec([ 40, 20, 20, 20, 15, 15 ]);
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'clamp vectors, 3 arguments'; /* */

  var expected = [ 30, 20, 20, 20, 15, 15 ];
  var dst = [ 10, 20, 10, 30, 30, 15 ];
  var src1 = [ 30, 20, 20, 20, 10, 10 ];
  var src2 = [ 40, 20, 20, 20, 15, 15 ];
  var got = _.avector.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 30, 20, 20, 20, 15, 15 ]);
  var dst = vec([ 10, 20, 10, 30, 30, 15 ]);
  var src1 = vec([ 30, 20, 20, 20, 10, 10 ]);
  var src2 = vec([ 40, 20, 20, 20, 15, 15 ]);
  var got = _.vectorAdapter.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'clamp vector and scaler, 4 arguments'; /* */

  var expected = [ 20, 20, 20, 20, 20, 15 ];
  var dst = [ 10, 20, 10, 20, 20, 15 ];
  var src1 = [ 20, 20, 20, 20, 10, 10 ];
  var src2 = 20;
  var got = _.avector.clamp( dst, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 20, 20, 20, 20, 20, 15 ]);
  var dst = vec([ 10, 20, 10, 20, 20, 15 ]);
  var src1 = vec([ 20, 20, 20, 20, 10, 10 ]);
  var src2 = 20;
  var got = _.vectorAdapter.clamp( dst, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = [ 15, 20, 15, 20, 15, 15 ];
  var dst = [ 10, 20, 10, 30, 30, 15 ];
  var src1 = 15;
  var src2 = [ 40, 20, 20, 20, 15, 15 ];
  var got = _.avector.clamp( dst, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 15, 20, 15, 20, 15, 15 ]);
  var dst = vec([ 10, 20, 10, 30, 30, 15 ]);
  var src1 = 15;
  var src2 = vec([ 40, 20, 20, 20, 15, 15 ]);
  var got = _.vectorAdapter.clamp( dst, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'clamp vector and scaler, 3 arguments and null'; /* */

  var expected = [ 20, 20, 20, 20, 20, 15 ];
  var dst = [ 10, 20, 10, 20, 20, 15 ];
  var src1 = [ 20, 20, 20, 20, 10, 10 ];
  var src2 = 20;
  var got = _.avector.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec([ 20, 20, 20, 20, 20, 15 ]);
  var dst = vec([ 10, 20, 10, 20, 20, 15 ]);
  var src1 = vec([ 20, 20, 20, 20, 10, 10 ]);
  var src2 = 20;
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = [ 15, 20, 15, 20, 15, 15 ];
  var dst = [ 10, 20, 10, 30, 30, 15 ];
  var src1 = 15;
  var src2 = [ 40, 20, 20, 20, 15, 15 ];
  var got = _.avector.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec([ 15, 20, 15, 20, 15, 15 ]);
  var dst = vec([ 10, 20, 10, 30, 30, 15 ]);
  var src1 = 15;
  var src2 = vec([ 40, 20, 20, 20, 15, 15 ]);
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec([ 17, 20, 17, 17, 10, 25 ]);
  var dst = 17;
  var src1 = vec([ 15, 20, 15, 10, 10, 25 ]);
  var src2 = vec([ 40, 20, 20, 20, 10, 25 ]);
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'clamp vector and scaler, 3 arguments'; /* */

  var expected = [ 20, 20, 20, 20, 20, 15 ];
  var dst = [ 10, 20, 10, 20, 20, 15 ];
  var src1 = [ 20, 20, 20, 20, 10, 10 ];
  var src2 = 20;
  var got = _.avector.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 20, 20, 20, 20, 20, 15 ]);
  var dst = vec([ 10, 20, 10, 20, 20, 15 ]);
  var src1 = vec([ 20, 20, 20, 20, 10, 10 ]);
  var src2 = 20;
  var got = _.vectorAdapter.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = [ 15, 20, 15, 20, 15, 15 ];
  var dst = [ 10, 20, 10, 30, 30, 15 ];
  var src1 = 15;
  var src2 = [ 40, 20, 20, 20, 15, 15 ];
  var got = _.avector.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 15, 20, 15, 20, 15, 15 ]);
  var dst = vec([ 10, 20, 10, 30, 30, 15 ]);
  var src1 = 15;
  var src2 = vec([ 40, 20, 20, 20, 15, 15 ]);
  var got = _.vectorAdapter.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec([ 17, 20, 17, 17, 10, 25 ]);
  var dst = 17;
  var src1 = vec([ 15, 20, 15, 10, 10, 25 ]);
  var src2 = vec([ 40, 20, 20, 20, 10, 25 ]);
  var got = _.vectorAdapter.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = '3 arguments, all scalar'; /* */
  var expected = 16;
  var dst = 15;
  var src1 = 16
  var src2 = 40;
  var got = _.avector.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = 16;
  var dst = 15;
  var src1 = 16
  var src2 = 40;
  var got = _.vectorAdapter.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'null + 3 arguments, all scalar'; /* */
  var expected = 16;
  var dst = 15;
  var src1 = 16
  var src2 = 40;
  var got = _.avector.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = 16;
  var dst = 15;
  var src1 = 16
  var src2 = 40;
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = '3 arguments, 2 scalar 1 vector'; /* */
  var expected = [ 16 ];
  var dst = [ 15 ];
  var src1 = 16
  var src2 = 40;
  var got = _.avector.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  var expected = vec( [ 16 ] );
  var dst = vec( [ 15 ] );
  var src1 = 16
  var src2 = 40;
  var got = _.vectorAdapter.clamp( dst, src1, src2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'null + 3 arguments, 2 scalar 1 vector'; /* */
  var expected = [ 16 ];
  var dst = [ 15 ];
  var src1 = 16
  var src2 = 40;
  var got = _.avector.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = vec( [ 16 ] );
  var dst = vec( [ 15 ] );
  var src1 = 16
  var src2 = 40;
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'null + 3 scalar arguments;' /* */
  var expected = 16;
  var dst = 15;
  var src1 = 16
  var src2 = 40;
  var got = _.avector.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  var expected = 16;
  var dst = 15;
  var src1 = 16
  var src2 = 40;
  var got = _.vectorAdapter.clamp( null, dst, src1, src2 );
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'empty vectors, 3 arguments'; /* */

  var op = _.vectorAdapter.clamp.operation;

  var args = _.dup( [], op.takingArguments[ 0 ] );
  var got = _.avector.clamp.apply( _, args );
  test.is( got === args[ 0 ] );
  test.identical( got , [] );

  var args = _.dup( vec([]), op.takingArguments[ 0 ] );
  var got = _.vectorAdapter.clamp.apply( _, args );
  test.is( got === args[ 0 ] );
  test.identical( got , vec([]) );

  test.case = 'empty vectors, 4 arguments'; /* */

  var op = _.vectorAdapter.clamp.operation;

  var dst = [];
  var args = _.dup( [], op.takingArguments[ 0 ] );
  args.unshift( dst );
  var got = _.avector.clamp.apply( _, args );
  test.is( got === dst );
  test.identical( got , [] );

  var dst = vec([]);
  var args = _.dup( vec([]), op.takingArguments[ 0 ] );
  args.unshift( dst );
  var got = _.vectorAdapter.clamp.apply( _, args );
  test.is( got === dst );
  test.identical( got , vec([]) );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.avector.clamp() );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1, 2 ], [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1, 2 ], [ 3, 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1, 2 ], [ 3 ], [ 5, 5 ] ) );
  // test.shouldThrowErrorSync( () => _.avector.clamp( 1, [ 3, 3 ], [ 5, 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1, 2 ], [ 3, 4 ], undefined ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1, 2 ], [ 3, 4 ], '1' ) );

  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp() );
  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( vec([ 1, 2 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( vec([ 1, 2 ]), vec([ 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( vec([ 1, 2 ]), vec([ 3, 4 ]), vec([ 5 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( vec([ 1, 2 ]), vec([ 3 ]), vec([ 5, 5 ]) ) );

  // test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( 1, vec([ 3, 3 ]), vec([ 5, 5 ]) ) );

  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( vec([ 1, 2 ]), vec([ 3, 4 ]), undefined ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.clamp( vec([ 1, 2 ]), vec([ 3, 4 ]), '1' ) );
}

clamp.timeOut = 15000;

//

function randomInRange( test )
{
  // test.case = '2 scalar argument'; /* */

  // var src1 = 0;
  // var src2 = 1;
  // var got = _.avector.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1, src2 ], got ) );

  test.case = 'null + 2 scalar argument'; /* */

  var src1 = 0;
  var src2 = 1;
  var got = _.avector.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1, src2 ], got ) );

  // test.case = '2 vectors argument'; /* */

  // var src1 = [ 0 ];
  // var src2 = [ 1 ];
  // var got = _.avector.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1[ 0 ], src2[ 0 ] ], got[ 0 ] ) );
  // test.is( src1 === got )

  // var src1 = vec( [ 0 ] );
  // var src2 = vec( [ 1 ] );
  // var got = _.vectorAdapter.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1.eGet( 0 ), src2.eGet( 0 ) ], got.eGet( 0 ) ) );
  // test.is( src1 === got )

  test.case = 'null + 2 vectors argument'; /* */

  var src1 = [ 0 ];
  var src2 = [ 1 ];
  var got = _.avector.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1[ 0 ], src2[ 0 ] ], got[ 0 ] ) );
  test.is( src1 !== got )

  var src1 = vec( [ 0 ] );
  var src2 = vec( [ 1 ] );
  var got = _.vectorAdapter.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1.eGet( 0 ), src2.eGet( 0 ) ], got.eGet( 0 ) ) );
  test.is( src1 !== got )

  // test.case = 'vector and scalar'; /* */

  // var src1 = [ 0 ];
  // var src2 = 1;
  // var got = _.avector.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1[ 0 ], src2 ], got[ 0 ] ) );
  // test.is( src1 === got )

  // var src1 = vec( [ 0 ] );
  // var src2 = 1;
  // var got = _.vectorAdapter.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1.eGet( 0 ), src2 ], got.eGet( 0 ) ) );
  // test.is( src1 === got )

  // test.case = 'scalar and vector'; /* */

  // var src1 = 0;
  // var src2 = [ 1 ];
  // var got = _.avector.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1, src2[ 0 ] ], got[ 0 ]) );
  // test.is( _.numberIs( src1 ) )

  // var src1 = 0;
  // var src2 = vec( [ 1 ] );
  // var got = _.vectorAdapter.randomInRange( src1, src2 );
  // test.is( _.rangeInInclusive( [ src1, src2.eGet( 0 ) ], got.eGet( 0 ) ) );
  // test.is( _.numberIs( src1 ) )

  test.case = 'null + vector and scalar'; /* */

  var src1 = [ 0 ];
  var src2 = 1;
  var got = _.avector.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1[ 0 ], src2 ], got[ 0 ] ) );
  test.is( src1 !== got )

  var src1 = vec( [ 0 ] );
  var src2 = 1;
  var got = _.vectorAdapter.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1.eGet( 0 ), src2 ], got.eGet( 0 ) ) );
  test.is( src1 !== got )

  test.case = 'null + scalar and vector'; /* */

  var src1 = 0;
  var src2 = [ 1 ];
  var got = _.avector.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1, src2[ 0 ] ], got[ 0 ] ) );
  test.is( _.numberIs( src1 ) )

  var src1 = 0;
  var src2 = vec( [ 1 ] );
  var got = _.vectorAdapter.randomInRange( null, src1, src2 );
  test.is( _.rangeInInclusive( [ src1, src2.eGet( 0 ) ], got.eGet( 0 )) );
  test.is( _.numberIs( src1 ) )

  // test.case = 'scalar scalar scalar'; /* */

  // var src1 = 0;
  // var src2 = 2;
  // var src3 = 3;
  // var got = _.avector.randomInRange( src1, src2, src3 );
  // test.is( _.rangeInInclusive( [ src2, src3 ], got ) );
  // test.identical( src1, 0 );

  // var src1 = 0;
  // var src2 = 2;
  // var src3 = 3;
  // var got = _.vectorAdapter.randomInRange( src1, src2, src3 );
  // test.is( _.rangeInInclusive( [ src2, src3 ], got ) );
  // test.identical( src1, 0 );

  test.case = 'vector scalar scalar'; /* */

  var src1 = [ 0 ];
  var src2 = 2;
  var src3 = 3;
  var got = _.avector.randomInRange( src1, src2, src3 );
  test.is( _.rangeInInclusive( [ src2, src3 ], got[ 0 ] ) );
  test.is( src1 === got );

  var src1 = vec([ 0 ]);
  var src2 = 2;
  var src3 = 3;
  var got = _.vectorAdapter.randomInRange( src1, src2, src3 );
  test.is( _.rangeInInclusive( [ src2, src3 ], got.eGet( 0 ) ) );
  test.is( src1 === got );

  test.case = 'vector scalar vector'; /* */

  var src1 = [ 0 ];
  var src2 = 2;
  var src3 = [ 3 ];
  var got = _.avector.randomInRange( src1, src2, src3 );
  test.is( _.rangeInInclusive( [ src2, src3[ 0 ] ], got[ 0 ] ) );
  test.is( src1 === got );

  var src1 = vec( [ 0 ] );
  var src2 = 2;
  var src3 = vec( [ 3 ] );
  var got = _.vectorAdapter.randomInRange( src1, src2, src3 );
  test.is( _.rangeInInclusive( [ src2, src3.eGet( 0 ) ], got.eGet( 0 ) ) );
  test.is( src1 === got );

  test.case = 'vector vector vector'; /* */

  var src1 = [ 0 ];
  var src2 = [ 2 ];
  var src3 = [ 3 ];
  var got = _.avector.randomInRange( src1, src2, src3 );
  test.is( _.rangeInInclusive( [ src2[ 0 ], src3[ 0 ] ], got[ 0 ] ) );
  test.is( src1 === got );

  var src1 = vec( [ 0 ] );
  var src2 = vec( [ 2 ] );
  var src3 = vec( [ 3 ] );
  var got = _.vectorAdapter.randomInRange( src1, src2, src3 );
  test.is( _.rangeInInclusive( [ src2.eGet( 0 ), src3.eGet( 0 ) ], got.eGet( 0 ) ) );
  test.is( src1 === got );


  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.avector.randomInRange() );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( null, [ 1 ], [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( [ 1, 2 ], [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( [ 1, 2 ], [ 3, 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( [ 1, 2 ], [ 3 ], [ 5, 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( [ 1, 2 ], [ 3, 4 ], undefined ) );
  test.shouldThrowErrorSync( () => _.avector.randomInRange( [ 1, 2 ], [ 3, 4 ], '1' ) );

  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange() );
  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( null, vec([ 1 ]), vec([ 1 ]), vec([ 1 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( vec([ 1, 2 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( vec([ 1, 2 ]), vec([ 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( vec([ 1, 2 ]), vec([ 3, 4 ]), vec([ 5 ]) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( vec([ 1, 2 ]), vec([ 3 ]), vec([ 5, 5 ]) ) );

  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( vec([ 1, 2 ]), vec([ 3, 4 ]), undefined ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.randomInRange( vec([ 1, 2 ]), vec([ 3, 4 ]), '1' ) );
}

randomInRange.timeOut = 15000;

//

function mix( test )
{
  // var got = _.avector.mix( null, [ 1, 2 ], [ 3, 4 ] );
  // var dst = [ 9 ];
  // var got = _.avector.mix( dst, 1, 3, 0.5 );

  /* 3 arguments */

  test.case = 'all arrays, 3 arguments';

  var src = [ 1, 2, 3 ];
  var got = _.avector.mix( src, [ 3, 4, 5 ], [ 0.1, 0.2, 0.3 ] );
  var expected = [ 1.2 , 2.4 , 3.6 ];

  test.equivalent( got, expected );
  test.is( src === got );

  test.case = 'mixed, 3 arguments';

  var src = [ 1, 2, 3 ];
  var got = _.avector.mix( src, 5, 0.1 );
  var expected = [ 1.4 , 2.3 , 3.2 ];

  test.equivalent( got, expected );
  test.is( src === got );

  var src = [ 1, 2, 3 ]
  var got = _.avector.mix( 5, src, 0.1 );
  var expected = [ 4.6 , 4.7 , 4.8 ];

  test.equivalent( got, expected );
  test.is( src !== got );

  test.case = 'many elements in progress, 3 arguments';

  var got = _.avector.mix( 1, 3, [ -1, 0, 0.3, 0.7, 1, 2 ] );
  var expected = [ -1 , 1 , 1.6 , 2.4 , 3 , 5 ];
  test.equivalent( got, expected );

  test.case = 'only scalars, 3 arguments';

  var got = _.avector.mix( 1, 3, 0.5 );
  var expected = 2;
  test.equivalent( got, expected );

  /* 4 arguments with null */

  test.case = 'all arrays, 4 arguments, dst null';

  var src = [ 1, 2, 3 ];
  var got = _.avector.mix( null, src, [ 3, 4, 5 ], [ 0.1, 0.2, 0.3 ] );
  var expected = [ 1.2 , 2.4 , 3.6 ];

  test.equivalent( got, expected );
  test.is( src !== got );

  test.case = 'mixed, 4 arguments, dst null';

  var src = [ 1, 2, 3 ];
  var got = _.avector.mix( null, src, 5, 0.1 );
  var expected = [ 1.4 , 2.3 , 3.2 ];

  test.equivalent( got, expected );
  test.is( src !== got );

  var src = [ 1, 2, 3 ]
  var got = _.avector.mix( null, 5, src, 0.1 );
  var expected = [ 4.6 , 4.7 , 4.8 ];

  test.equivalent( got, expected );
  test.is( src !== got );

  test.case = 'many elements in progress, 4 arguments, dst null';

  var got = _.avector.mix( null, 1, 3, [ -1, 0, 0.3, 0.7, 1, 2 ] );
  var expected = [ -1 , 1 , 1.6 , 2.4 , 3 , 5 ];
  test.equivalent( got, expected );

  test.case = 'only scalars, 4 arguments, dst null';

  var got = _.avector.mix( null, 1, 3, 0.5 );
  var expected = 2;
  test.equivalent( got, expected );

  /* 4 arguments with provided container */

  test.case = 'all arrays, 4 arguments, dst null';

  var dst = [ -1, -1, -1 ];
  var src = [ 1, 2, 3 ];
  var got = _.avector.mix( dst, src, [ 3, 4, 5 ], [ 0.1, 0.2, 0.3 ] );
  var expected = [ 1.2 , 2.4 , 3.6 ];

  test.equivalent( got, expected );
  test.is( src !== got );
  test.is( dst === got );

  test.case = 'mixed, 4 arguments, dst null';

  var dst = [ -1, -1, -1 ];
  var src = [ 1, 2, 3 ];
  var got = _.avector.mix( dst, src, 5, 0.1 );
  var expected = [ 1.4 , 2.3 , 3.2 ];

  test.equivalent( got, expected );
  test.is( src !== got );
  test.is( dst === got );

  var dst = [ -1, -1, -1 ];
  var src = [ 1, 2, 3 ]
  var got = _.avector.mix( dst, 5, src, 0.1 );
  var expected = [ 4.6 , 4.7 , 4.8 ];

  test.equivalent( got, expected );
  test.is( src !== got );
  test.is( dst === got );

  test.case = 'many elements in progress, 4 arguments, dst null';

  var dst = [ -1, -1, -1, -1, -1, -1 ];
  var got = _.avector.mix( dst, 1, 3, [ -1, 0, 0.3, 0.7, 1, 2 ] );
  var expected = [ -1 , 1 , 1.6 , 2.4 , 3 , 5 ];
  test.equivalent( got, expected );
  test.is( dst === got );

  test.case = 'only scalars, 3 arguments';

  var got = _.avector.mix( 1, 3, 0.5 );
  var expected = 2;
  test.equivalent( got, expected );

  test.case = '3 scalars and dst long';

  var dst = [ 9 ];
  var got = _.avector.mix( dst, 1, 3, 0.5 );
  var expected = [ 2 ];
  test.equivalent( got, expected );
  test.is( dst === got );

  test.case = '3 scalars and dst null';

  var got = _.avector.mix( null, 1, 3, 0.5 );
  var expected = [ 2 ];
  test.equivalent( got, expected );

  test.case = 'all scalars, but last';

  var dst = [ 1, 2 ];
  var got = _.avector.mix( dst, [ 3, 4 ], [ 5, 6 ], 1 );
  var expected = [ 5, 6 ];
  test.equivalent( got, expected );
  test.is( dst === got );

  /* throwing error */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector.mix( -1, 1, 3, 0.5 ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1, 2 ], [ 3 ], 0.5 ) );
  test.shouldThrowErrorSync( () => _.avector.mix() );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1, 2 ], [ 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( null, [ 1, 2 ], [ 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( '0', [ 3, 4 ], [ 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( undefined, [ 3, 4 ], [ 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( undefined, [ 3, 4 ], [ 3, 4 ], [ 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( false, [ 3, 4 ], [ 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( true, [ 3, 4 ], [ 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1, 2 ], '0', [ 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1, 2 ], [ 3, 4 ], '0' ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 4, 4 ], [ 3, 4 ] ) );
}

mix.timeOut = 15000;

//

function polynomApply( test )
{
  test.case = 'trivial';

  var expected = 7;
  var got = _.avector.polynomApply( [ 1, 1, 1 ], 2 );
  test.identical( got, expected );

  test.case = 'trivial'; /* */

  var expected = 36;
  var got = _.avector.polynomApply( [ 0, 1, 2 ], 4 );
  test.identical( got, expected );

  test.case = 'trivial'; /* */

  var expected = 6;
  var got = _.avector.polynomApply( [ 2, 1, 0 ], 4 );
  test.identical( got, expected );

  test.case = 'trivial'; /* */

  var expected = 262;
  var got = _.avector.polynomApply( [ 2, 1, 0, 4 ], 4 );
  test.identical( got, expected );
}

//

function mean( test )
{
  test.case = 'simple even'; /* */

  var expected = 2.5;
  var got = _.avector.mean([ 1, 2, 3, 4 ]);
  test.equivalent( got, expected );

  test.case = 'simple odd'; /* */

  var expected = 2;
  var got = _.avector.mean([ 1, 2, 3 ]);
  test.equivalent( got, expected );

  test.case = 'empty'; /* */

  var expected = 0;
  var got = _.avector.mean([]);
  test.equivalent( got, expected );

  test.case = 'simple even, filtering'; /* */

  var expected = 2;
  var got = _.avector.meanConditional( [ 1, 2, 3, 4 ], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'simple odd, filtering'; /* */

  var expected = 2;
  var got = _.avector.meanConditional( [ 1, 2, 3 ], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'empty, filtering'; /* */

  var expected = 0;
  var got = _.avector.meanConditional( [], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';
  test.shouldThrowErrorSync( () => _.mean() );
  test.shouldThrowErrorSync( () => _.mean( 'x' ) );
  test.shouldThrowErrorSync( () => _.mean( 1 ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ], 'x' ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ], [ 1 ] ) );

  test.shouldThrowErrorSync( () => _.meanConditional() );
  test.shouldThrowErrorSync( () => _.meanConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( 'x', () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( 1, () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ], 'x', () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ], 1, () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ], [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ], [ 1 ], () => true ) );

}

mean.timeOut = 15000;

//

function moment( test )
{
  test.case = 'first even'; /* */

  var expected = 2.5;
  var got = _.avector.moment( [ 1, 2, 3, 4 ], 1 );
  test.equivalent( got, expected );

  test.case = 'first odd'; /* */

  var expected = 2;
  var got = _.avector.moment( [ 1, 2, 3 ], 1 );
  test.equivalent( got, expected );

  test.case = 'first empty'; /* */

  var expected = 0;
  var got = _.avector.moment( [], 1 );
  test.equivalent( got, expected );

  test.case = 'second even'; /* */

  var expected = 30 / 4;
  var got = _.avector.moment( [ 1, 2, 3, 4 ], 2 );
  test.equivalent( got, expected );

  test.case = 'second odd'; /* */

  var expected = 14 / 3;
  var got = _.avector.moment( [ 1, 2, 3 ], 2 );
  test.equivalent( got, expected );

  test.case = 'second empty'; /* */

  var expected = 0;
  var got = _.avector.moment( [], 2 );
  test.equivalent( got, expected );

  test.case = 'simple even, filtering'; /* */

  var expected = 5;
  var got = _.avector.momentConditional( [ 1, 2, 3, 4 ], 2, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'simple odd, filtering'; /* */

  var expected = 5;
  var got = _.avector.momentConditional( [ 1, 2, 3 ], 2, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'empty, filtering'; /* */

  var expected = 0;
  var got = _.avector.momentConditional( [], 2, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';
  test.shouldThrowErrorSync( () => _.moment() );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.moment( 1 ) );
  test.shouldThrowErrorSync( () => _.moment( 'x', 1 ) );
  test.shouldThrowErrorSync( () => _.moment( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ], 'x' ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ], [ 1 ] ) );

  test.shouldThrowErrorSync( () => _.momentConditional() );
  test.shouldThrowErrorSync( () => _.momentConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 1, () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 'x', 1, () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 1, 1, () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ], 'x', () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 1, [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ], [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ], [ 1 ], () => true ) );
}

moment.timeOut = 15000;

//

function reduceToMean( test )
{
  test.case = 'simple even'; /* */

  var expected = 2.5;
  var got = _.avector.reduceToMean([ 1, 2, 3, 4 ]);
  test.equivalent( got, expected );

  test.case = 'simple odd'; /* */

  var expected = 2;
  var got = _.avector.reduceToMean([ 1, 2, 3 ]);
  test.equivalent( got, expected );

  test.case = 'several vectors'; /* */

  var expected = 3;
  var got = _.avector.reduceToMean( [ 1, 2, 3 ], [ 4, 5 ] );
  test.equivalent( got, expected );

  test.case = 'empty'; /* */

  var expected = NaN;
  var got = _.avector.reduceToMean([]);
  test.equivalent( got, expected );

  test.case = 'simple even, filtering'; /* */

  var expected = 2;
  var got = _.avector.reduceToMeanConditional( [ 1, 2, 3, 4 ], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'simple odd, filtering'; /* */

  var expected = 2;
  var got = _.avector.reduceToMeanConditional( [ 1, 2, 3 ], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'several vectors, filtering'; /* */

  var expected = 3;
  var got = _.avector.reduceToMeanConditional( [ 1, 2, 3 ], [ 4, 5 ], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'empty, filtering'; /* */

  var expected = NaN;
  var got = _.avector.reduceToMeanConditional( [], ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';
  test.shouldThrowErrorSync( () => _.avector.reduceToMean() );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( 'x' ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( 1 ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( [ 1 ], 'x' ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( [ 1 ], 1 ) );

  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional() );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( 'x', () => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( 1, () => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( [ 1 ], 'x', () => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( [ 1 ], 1, () => true ) );

}

reduceToMean.timeOut = 15000;

//

function distributionRangeSummary( test )
{
  var empty = [];
  var a = [ 1, 2, 3, 4, 5 ];
  var b = [ 55, 22, 33, 99, 2, 22, 3, 33, 4, 99, 5, 44 ];
  var filter = ( e, o ) => !(e % 2);

  test.case = 'distributionRangeSummary single element'; /* */

  var ar = [ 1 ];
  var expected =
  {
    min : { value : 1, index : 0, container : vec( ar ) },
    max : { value : 1, index : 0, container : vec( ar ) },
    median : 1,
  };

  var got = _.avector.distributionRangeSummary( ar );
  test.identical( got, expected );

  test.case = 'reduceToMax single element'; /* */

  var ar = [ 1 ];
  var expected = { value : 1, index : 0, container : vec( ar ) };
  var got = _.avector.reduceToMax( ar );
  test.identical( got, expected );

  var ar = [ 1 ];
  var expected = { value : 1, index : 0, container : vec( ar ) };
  var got = vad.reduceToMax( vec( ar ) );
  test.identical( got, expected );

  test.case = 'trivial'; /* */

  var expected =
  {
    min : { value : 1, index : 0, container : vec( a ) },
    max : { value : 5, index : 4, container : vec( a ) },
    median : 3,
  };

  var got = _.avector.distributionRangeSummary( a );
  test.identical( got, expected );

  test.case = 'simplest case with filtering'; /* */

  var expected =
  {
    min : { value : 2, index : 1, container : vec( a ) },
    max : { value : 4, index : 3, container : vec( a ) },
    median : 3,
  };

  var got = _.avector.distributionRangeSummaryConditional( a, filter );
  test.identical( got, expected );

  test.case = 'several vectors'; /* */

  var expected =
  {
    min : { value : 1, index : 0, container : vec( a ) },
    max : { value : 99, index : 3, container : vec( b ) },
    median : 50,
  };

  var got = _.avector.distributionRangeSummary( a, b );
  test.identical( got, expected );

  test.case = 'several vectors with filtering'; /* */

  var expected =
  {
    min : { value : 2, index : 1, container : vec( a ) },
    max : { value : 44, index : 11, container : vec( b ) },
    median : 23,
  };

  var got = _.avector.distributionRangeSummaryConditional( a, b, filter );
  test.identical( got, expected );

  test.case = 'empty array'; /* */

  var expected =
  {
    min : { value : NaN, index : -1, container : null },
    max : { value : NaN, index : -1, container : null },
    median : NaN,
  };
  var got = _.avector.distributionRangeSummary( empty );
  test.identical( got, expected )

  test.case = 'empty array with filtering'; /* */

  var expected =
  {
    min : { value : NaN, index : -1, container : null },
    max : { value : NaN, index : -1, container : null },
    median : NaN,
  };
  var got = _.avector.distributionRangeSummaryConditional( empty, filter );
  test.identical( got, expected )

  // test.case = 'no array'; /* */
  //
  // var expected =
  // {
  //   min : { value : NaN, index : -1, container : null },
  //   max : { value : NaN, index : -1, container : null },
  // };
  // var got = _.avector.distributionRangeSummary();
  // test.identical( got, expected )
  //
  // test.case = 'no array with filtering'; /* */
  //
  // var expected =
  // {
  //   min : { value : NaN, index : -1, container : null },
  //   max : { value : NaN, index : -1, container : null },
  // };
  // var got = _.avector.distributionRangeSummaryConditional( filter );
  // test.identical( got, expected )

  test.case = 'bad arguments'; /* */

  if( Config.debug )
  {

    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary() );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( 1 ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( '1' ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( [ 1 ], 1 ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( [ 1 ], undefined ) );

    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional() );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1, 2, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1, 2, 3 ], null ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1, 2, 3 ], () => true ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( 1, filter ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1 ], 1, filter ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1 ], undefined, filter ) );

  }
}

distributionRangeSummary.timeOut = 15000;

// --
//
// --

function _isIdentical( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, f, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );

  var expected = array( f, f, t );
  var got = _.avector[ r ]( 3, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with null dst'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, f, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar, with null dst'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), 3 );
  test.identical( got, expected );
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, 3, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar, with null dst'; /* */
  var expected = t;
  var got = _.avector[ r ]( null, 3, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( null, 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with dst'; /* */
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'vector and scalar, with dst'; /* */
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), 3 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, array( 1, 2, 3 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'scalar and scalar, with vector dst'; /* */
  var expected = array( t, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, 3 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, 4 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'empty vectors'; /* */
  var expected = array();
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  test.case = 'different types of containers'; /* */

  var expected = [ t, t, t ];
  var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1, 2, 3 ) );
  test.identical( got, expected );
  var expected = array( t, t, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3 ] );
  test.identical( got, expected );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 3, 3, 3 ) );
}

//

function isIdentical( test )
{

  this._isIdentical( test, 'isIdentical', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isIdentical( test, 'isIdentical', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isIdentical( test, 'isIdentical', true, function()
  {
    return _.longMake( U32x, arguments );
  });

}

//

function isNotIdentical( test )
{

  this._isIdentical( test, 'isNotIdentical', false, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isIdentical( test, 'isNotIdentical', false, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isIdentical( test, 'isNotIdentical', false, function()
  {
    return _.longMake( U32x, arguments );
  });

}

//

function isEquivalent( test )
{

  this._isIdentical( test, 'isEquivalent', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isIdentical( test, 'isEquivalent', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isIdentical( test, 'isEquivalent', true, function()
  {
    return _.longMake( U32x, arguments );
  });

}

//

function isNotEquivalent( test )
{

  this._isIdentical( test, 'isNotEquivalent', false, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isIdentical( test, 'isNotEquivalent', false, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isIdentical( test, 'isNotEquivalent', false, function()
  {
    return _.longMake( U32x, arguments );
  });

}

// //
//
// function _isEquivalent( test, r, t, Array, array )
// {
//   var f = !t;
//   var e = _.accuracy * 0.5;
//
//   /* */
//
//   test.case = 'trivial'; /* */
//   var expected = array( f, f, t );
//   var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
//   test.identical( got, expected );
//   var expected = array( t, f, f );
//   var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 1, 9 ) );
//   test.identical( got, expected );
//
//   if( Array !== U32x )
//   {
//
//     test.case = 'very close, positive elements'; /* */
//     var expected = array( t, t, t, t, t, t );
//     var got = _.avector[ r ]( array( 0+e, 1+e, 1001+e, 0-e, 1-e, 1001-e ), array( -0, +1, +1001, -0, +1, +1001 ) );
//     test.identical( got, expected );
//
//     test.case = 'very close, negative elements'; /* */
//     var expected = array( t, t, t, t, t, t );
//     var got = _.avector[ r ]( array( -0+e, -1+e, -1001+e, -0-e, -1-e, -1001-e ), array( +0, -1, -1001, +0, -1, -1001 ) );
//     test.identical( got, expected );
//
//   }
//
//   test.case = 'very close, scalars'; /* */
//   var expected = t;
//   var got = _.avector[ r ]( 1+e, 1 );
//   test.identical( got, expected );
//   var expected = t;
//   var got = _.avector[ r ]( 1-e, 1 );
//   test.identical( got, expected );
//   var expected = t;
//   var got = _.avector[ r ]( 1, 1+e );
//   test.identical( got, expected );
//   var expected = t;
//   var got = _.avector[ r ]( 1, 1-e );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'trivial, with null dst'; /* */
//   var expected = array( f, f, t );
//   var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 3, 4, 3+e ) );
//   test.identical( got, expected );
//   var expected = array( t, f, f );
//   var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 1+e, 1, 9 ) );
//   test.identical( got, expected );
//
//   test.case = 'vector and scalar, with null dst'; /* */
//   var expected = array( f, f, t );
//   var got = _.avector[ r ]( null, array( 1, 2, 3 ), 3+e );
//   test.identical( got, expected );
//   var expected = array( f, f, t );
//   var got = _.avector[ r ]( null, 3, array( 1, 2, 3+e ) );
//   test.identical( got, expected );
//
//   test.case = 'scalar and scalar, with null dst'; /* */
//   var expected = t;
//   var got = _.avector[ r ]( null, 3+e, 3 );
//   test.identical( got, expected );
//   var expected = f;
//   var got = _.avector[ r ]( null, 3, 4-e );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'trivial, with dst'; /* */
//   var expected = array( f, f, t );
//   var dst = array( -1, -1, -1 );
//   var got = _.avector[ r ]( dst, array( 1, 2, 3+e ), array( 3, 4, 3 ) );
//   test.identical( got, expected );
//   test.is( got === dst );
//   var expected = array( t, f, f );
//   var dst = array( -1, -1, -1 );
//   var got = _.avector[ r ]( dst, array( 1+e, 2, 3 ), array( 1, 1, 9 ) );
//   test.identical( got, expected );
//   test.is( got === dst );
//
//   test.case = 'vector and scalar, with dst'; /* */
//   var expected = array( f, f, t );
//   var dst = array( -1, -1, -1 );
//   var got = _.avector[ r ]( dst, array( 1, 2, 3 ), 3+e );
//   test.identical( got, expected );
//   test.is( got === dst );
//   var expected = array( f, f, t );
//   var dst = array( -1, -1, -1 );
//   var got = _.avector[ r ]( dst, 3, array( 1, 2, 3+e ) );
//   test.identical( got, expected );
//   test.is( got === dst );
//
//   test.case = 'scalar and scalar, with scalar dst'; /* */
//   var expected = t;
//   var dst = 0;
//   var got = _.avector[ r ]( dst, 3, 3+e );
//   test.identical( got, expected );
//   test.is( got !== dst );
//   var expected = f;
//   var dst = t;
//   var got = _.avector[ r ]( dst, 3, 4-e );
//   test.identical( got, expected );
//   test.is( got !== dst );
//
//   test.case = 'scalar and scalar, with vector dst'; /* */
//   var expected = array( t, t, t );
//   var dst = array( -1, -1, -1 );
//   var got = _.avector[ r ]( dst, 3, 3+e );
//   test.identical( got, expected );
//   test.is( got === dst );
//   var expected = array( f, f, f );
//   var dst = array( -1, -1, -1 );
//   var got = _.avector[ r ]( dst, 3, 4-e );
//   test.identical( got, expected );
//   test.is( got === dst );
//
//   test.case = 'different types of containers'; /* */
//
//   var expected = [ t, t, t ] ;
//   var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1+e, 2, 3 ) );
//   test.identical( got, expected );
//   var expected = array( t, t, t );
//   var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3+e ] );
//   test.identical( got, expected );
//
// }
//
// //
//
// function isEquivalent2( test )
// {
//
//   this._isEquivalent( test, 'isEquivalent', true, Array, function()
//   {
//     return _.longMake( Array, arguments );
//   });
//
//   this._isEquivalent( test, 'isEquivalent', true, F32x, function()
//   {
//     return _.longMake( F32x, arguments );
//   });
//
//   this._isEquivalent( test, 'isEquivalent', true, U32x, function()
//   {
//     return _.longMake( U32x, arguments );
//   });
//
// }

//

function _isGreater( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = array( f, f, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( f, t, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( f, f, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );

  var expected = array( t, f, f );
  var got = _.avector[ r ]( 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 4, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with null dst'; /* */
  var expected = array( f, f, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( f, t, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar, with null dst'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  var expected = array( t, f, f );
  var got = _.avector[ r ]( null, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar, with null dst'; /* */
  var expected = t;
  var got = _.avector[ r ]( null, 4, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( null, 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with dst'; /* */
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 3, 4, 2 ) );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, t, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'vector and scalar, with dst'; /* */
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'scalar and scalar, with vector dst'; /* */
  var expected = array( t, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 4, 3 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, 4 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'different types of containers'; /* */

  var expected = [ f, f, t ];
  var got = _.avector[ r ]( [ 1, 2, 4 ], array( 1, 2, 3 ) );
  test.identical( got, expected );
  var expected = array( f, f, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 4 ] );
  test.identical( got, expected );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 0, 4, 3 ) );
}

//

function isGreater( test )
{

  this._isGreater( test, 'isGreater', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isGreater( test, 'isGreater', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isGreater( test, 'isGreater', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  this._isGreater( test, 'gt', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isGreater( test, 'gt', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isGreater( test, 'gt', true, function()
  {
    return _.longMake( U32x, arguments );
  });

}

//

function isLessEqual( test )
{

  this._isGreater( test, 'isLessEqual', false, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isGreater( test, 'isLessEqual', false, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isGreater( test, 'isLessEqual', false, function()
  {
    return _.longMake( U32x, arguments );
  });

  this._isGreater( test, 'le', false, function()
  {
    return _.longMake( Array, arguments );
  });

  this._isGreater( test, 'le', false, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._isGreater( test, 'le', false, function()
  {
    return _.longMake( U32x, arguments );
  });

}

//

function isLessEqualAprox( test )
{
  this._isGreater( test, 'isLessEqualAprox', false, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isGreater( test, 'isLessEqualAprox', false, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isGreater( test, 'isLessEqualAprox', false, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

  this._isLessAprox( test, 'isLessEqualAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLessAprox( test, 'isLessEqualAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLessAprox( test, 'isLessEqualAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

//

function isLessAprox( test )
{
  this._isLessAprox( test, 'isLessAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLessAprox( test, 'isLessAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLessAprox( test, 'isLessAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

//

function _isLess( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = array( t, t, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( t, t, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );

  var expected = array( f, f, t );
  var got = _.avector[ r ]( 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 4, 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with null dst'; /* */
  var expected = array( t, t, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar, with null dst'; /* */
  var expected = array( t, f, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar, with null dst'; /* */
  var expected = f;
  var got = _.avector[ r ]( null, 4, 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( null, 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with dst'; /* */
  var expected = array( t, t, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 3, 4, 2 ) );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'vector and scalar, with dst'; /* */
  var expected = array( t, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'scalar and scalar, with vector dst'; /* */
  var expected = array( f, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 4, 3 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, 4 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 0, 3, 4 ) );

}

//

function _isLessAprox( test, r, t, array )
{
  var f = !t;

  var e = _.accuracy * 0.5;

  /* */

  test.case = ' trivial'; /* */
  var expected = array( t, t, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3 + e, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, f, t );
  var got = _.avector[ r ]( array( 1 + e, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( t, t, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 + e );
  test.identical( got, expected );

  var expected = array( f, t, t );
  var got = _.avector[ r ]( 2, array( 1, 2, 3 - e ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 4, 3 + e );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3 - e,  4 );
  test.identical( got, expected );

  /* */

  test.case = ' trivial'; /* */
  var expected = array( t, t, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( t, t, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );

  var expected = array( f, t, t );
  var got = _.avector[ r ]( 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 4, 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with null dst'; /* */
  var expected = array( t, t, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, f, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar, with null dst'; /* */
  var expected = array( t, t, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  var expected = array( f, t, t );
  var got = _.avector[ r ]( null, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar, with null dst'; /* */
  var expected = f;
  var got = _.avector[ r ]( null, 4, 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( null, 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with dst'; /* */
  var expected = array( t, t, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 3, 4, 2 ) );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'vector and scalar, with dst'; /* */
  var expected = array( t, t, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'scalar and scalar, with vector dst'; /* */
  var expected = array( f, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 4, 3 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, 4 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 0, 3, 4 ) );
}

//

function _isGreaterAprox( test, r, t, array )
{
  var f = !t;

  var e = _.accuracy * 0.5;

  /* */

  test.case = ' trivial'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 + e ) );
  test.identical( got, expected );
  var expected = array( t, t, f );
  var got = _.avector[ r ]( array( 1 + e, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 + e ), 3 );
  test.identical( got, expected );

  var expected = array( t, t, f );
  var got = _.avector[ r ]( 2 + e, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 4, 3 + e );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3 + e, 4 );
  test.identical( got, expected );

  /* */

  test.case = ' trivial'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, t, f );
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );

  var expected = array( t, t, f );
  var got = _.avector[ r ]( 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 4, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with null dst'; /* */
  var expected = array( f, f, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = array( t, t, f );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar, with null dst'; /* */
  var expected = array( f, t, t );
  var got = _.avector[ r ]( null, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  var expected = array( t, t, f );
  var got = _.avector[ r ]( null, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar, with null dst'; /* */
  var expected = t;
  var got = _.avector[ r ]( null, 4, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( null, 3, 4 );
  test.identical( got, expected );

  /* */

  test.case = 'trivial, with dst'; /* */
  var expected = array( f, f, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 3, 4, 2 ) );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, t, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), array( 1, 1, 9 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'vector and scalar, with dst'; /* */
  var expected = array( f, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, array( 1, 2, 3 ), 2 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( t, t, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 2, array( 1, 2, 3 ) );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'scalar and scalar, with vector dst'; /* */
  var expected = array( t, t, t );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 4, 3 );
  test.identical( got, expected );
  test.is( got === dst );
  var expected = array( f, f, f );
  var dst = array( -1, -1, -1 );
  var got = _.avector[ r ]( dst, 3, 4 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 0, 3, 4 ) );
}

//

function isLess( test )
{

  this._isLess( test, 'isLess', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLess( test, 'isLess', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLess( test, 'isLess', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

  this._isLess( test, 'lt', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLess( test, 'lt', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLess( test, 'lt', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

}

//

function isGreaterEqual( test )
{

  this._isLess( test, 'isGreaterEqual', false, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLess( test, 'isGreaterEqual', false, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLess( test, 'isGreaterEqual', false, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

  this._isLess( test, 'ge', false, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLess( test, 'ge', false, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLess( test, 'ge', false, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

}

//

function isGreaterEqualAprox( test )
{
  this._isLess( test, 'isGreaterEqualAprox', false, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isLess( test, 'isGreaterEqualAprox', false, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isLess( test, 'isGreaterEqualAprox', false, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

  this._isGreaterAprox( test, 'isGreaterEqualAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isGreaterAprox( test, 'isGreaterEqualAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isGreaterAprox( test, 'isGreaterEqualAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

//

function isGreaterAprox( test )
{
  this._isGreaterAprox( test, 'isGreaterAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._isGreaterAprox( test, 'isGreaterAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._isGreaterAprox( test, 'isGreaterAprox', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

//

/* aaa : ask how to improve */
/* Dmytro : improved, moved routines in right position */

function isZero( test )
{
  test.open( 'Array constructor' );

  _isZero( test, 'isZero', true, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _isZero( test, 'isZero', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _isZero( test, 'isZero', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _isZero( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = 'vector'; /* */
    var expected = array( t, t, t );
    var src = array( 0, 0, 0 );
    var got = _.avector[ r ]( src );
    test.identical( got, expected );
    test.is( got !== src );

    var expected = array( f, f, t );
    var src = array( 1, 2, 0 );
    var got = _.avector[ r ]( src );
    test.identical( got, expected );
    test.is( got !== src );

    var expected = array( t, f, f );
    var src = array( 0, 2, 3 );
    var got = _.avector[ r ]( src );
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'scalar'; /* */
    var expected = f;
    var src = 3;
    var got = _.avector[ r ]( src );
    test.identical( got, expected );

    var expected = t;
    var src = 0;
    var got = _.avector[ r ]( src );
    test.identical( got, expected );

    /* */

    test.case = 'empty vector'; /* */
    var expected = array();
    var src = array();
    var got = _.avector[ r ]( src );
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'vector with null'; /* */
    var expected = array( t, t, t );
    var src = array( 0, 0, 0 );
    var got = _.avector[ r ]( null, src );
    test.identical( got, expected );
    test.is( got !== src );

    var expected = array( f, f, t );
    var src = array( 1, 2, 0 );
    var got = _.avector[ r ]( null, src );
    test.identical( got, expected );
    test.is( got !== src );

    var expected = array( t, f, f );
    var src = array( 0, 2, 3 );
    var got = _.avector[ r ]( null, src );
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'scalar with null'; /* */
    var expected = f;
    var src = 3;
    var got = _.avector[ r ]( null, src );
    test.identical( got, expected );

    var expected = t;
    var src = 0;
    var got = _.avector[ r ]( null, src );
    test.identical( got, expected );

    /* */

    test.case = 'empty vector with null'; /* */
    var expected = array();
    var src = array();
    var got = _.avector[ r ]( null, src );
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'vector with dst'; /* */

    var expected = array( t, t, t );
    var src = array( 0, 0, 0 );
    var dst = array( -1, -1, -1 );
    var got = _.avector[ r ]( dst, src );
    test.identical( got, expected );
    test.is( got !== src );

    var expected = array( f, f, t );
    var src = array( 1, 2, 0 );
    var dst = array( -1, -1, -1 );
    var got = _.avector[ r ]( dst, src );
    test.identical( got, expected );
    test.is( got !== src );

    var expected = array( t, f, f );
    var src = array( 0, 2, 3 );
    var dst = array( -1, -1, -1 );
    var got = _.avector[ r ]( dst, src );
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'scalar with dst'; /* */

    var expected = array( f );
    var src = 3;
    var dst = array( -1 );
    var got = _.avector[ r ]( dst, src );
    test.identical( got, expected );

    var expected = array( t );
    var src = 0;
    var dst = array( -1 );
    var got = _.avector[ r ]( dst, src );
    test.identical( got, expected );

    /* */

    test.case = 'empty vector with dst'; /* */
    var expected = array();
    var src = array();
    var dst = array();
    var got = _.avector[ r ]( dst, src );
    test.identical( got, expected );
    test.is( got !== src );

    if( Config.debug )
    test.shouldThrowErrorSync( () => _.avector[ r ]( -1, 3 ) );
  }
}

isZero.timeOut = 15000;

//

function logical2ArgsZipperWithBadArguments( test, r, t, array )
{
  var f = !t;

  /* */

  for( r in _.vectorAdapter )
  {
    if( !_.routineIs( _.vectorAdapter[ r ] ) )
    continue;

    var op = _.vectorAdapter[ r ].operation;

    if( !op )
    continue;

    if( op.reducing )
    continue;

    // if( !op.returningBoolean )
    // continue;

    if( !_.longIdentical( op.takingArguments, [ 2, 3 ] ) )
    continue;

    forRoutine( r );
  }

  function forRoutine( r )
  {

    test.case = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1, 2, 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( null, [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( {}, [ 1, 5 ], [ 1, 2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1, 5 ], { 1 : 1, 2 : 2 } ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1, 1 ], [ 1, 5 ], { 1 : 1, 2 : 2 } ) );

  }

}

logical2ArgsZipperWithBadArguments.timeOut = 30000;

//

function _allIdentical( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, array( 3, 3, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  test.case = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1, 2, 3 ) );
  test.identical( got, expected );

}

//

function allIdentical( test )
{

  this._allIdentical( test, 'allIdentical', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._allIdentical( test, 'allIdentical', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._allIdentical( test, 'allIdentical', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

}

allIdentical.timeOut = 15000;


//

function _anyIdentical( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 6 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 4, 6 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), 4 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, array( 1, 3, 5 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  test.case = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1, 2, 3 ) );
  test.identical( got, expected );

}

//

function anyIdentical( test )
{

  this._anyIdentical( test, 'anyIdentical', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._anyIdentical( test, 'anyIdentical', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._anyIdentical( test, 'anyIdentical', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });

}

anyIdentical.timeOut = 15000;

//

function _noneIdentical( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 6 ), array( 3, 2, 3 ) );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 4, 5, 6 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), 4 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, array( 1, 3, 5 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 3, 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  test.case = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 4, 5, 6 ], array( 1, 2, 3 ) );
  test.identical( got, expected );

}

//

function _allNotIdentical( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 4, 5, 6 ) );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), 4 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, array( 3, 3, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = f;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  var expected = f;
  var got = _.avector[ r ]( [ 4, 5, 6 ], array( 1, 2, 3 ) );
  test.identical( got, expected );

}

//

function allNotIdentical( test )
{
  this._allNotIdentical( test, 'allNotIdentical', false, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._allNotIdentical( test, 'allNotIdentical', false, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._allNotIdentical( test, 'allNotIdentical', false, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

allNotIdentical.timeOut = 15000;

//

function allEquivalent( test )
{
  /* - */

  test.open( 'Array constructor' );

  _allEquivalent( test, 'allEquivalent', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _allEquivalent( test, 'allEquivalent', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x' );

  _allEquivalent( test, 'allEquivalent', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x' );

  /* - */

  function _allEquivalent( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial';
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1 + e, 2 + e, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements';
      var expected = t;
      var got = _.avector[ r ]( array( 0+e, 1+e, 1001+e, 0-e, 1-e, 1001-e ), array( -0, +1, +1001, -0, +1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements';
      var expected = t;
      var got = _.avector[ r ]( array( -0+e, -1+e, -1001+e, -0-e, -1-e, -1001-e ), array( +0, -1, -1001, +0, -1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars';
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors';
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers';
    var expected = t;
    var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1+e, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3+e ] );
    test.identical( got, expected );
  }
}

allEquivalent.timeOut = 15000;

//

function allEquivalent2( test )
{
  this._allIdentical( test, 'allEquivalent', true, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._allIdentical( test, 'allEquivalent', true, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._allIdentical( test, 'allEquivalent', true, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

allEquivalent2.timeOut = 15000;

//

function allNotEquivalent( test )
{
  this._allNotIdentical( test, 'allNotEquivalent', false, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._allNotIdentical( test, 'allNotEquivalent', false, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._allNotIdentical( test, 'allNotEquivalent', false, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

allNotEquivalent.timeOut = 15000;

//

function allGreater( test )
{
  _allGreater( test, 'allGreater', true, function()
  {
    return _.longMake( Array, arguments );
  });

  _allGreater( test, 'allGreater', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  _allGreater( test, 'allGreater', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  /* - */

  function _allGreater( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = ' trivial'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );
    var expected = t;
    var got = _.avector[ r ]( array( 2, 2, 9 ), array( 1, 1, 8 ) );
    test.identical( got, expected );

    test.case = 'vector and scalar'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 2, array( 1, 1, 1 ) );
    test.identical( got, expected );

    test.case = 'scalar and scalar'; /* */
    var expected = t;
    var got = _.avector[ r ]( 4, 3 );
    test.identical( got, expected );
    var expected = f;
    var got = _.avector[ r ]( 3, 4 );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */

    var expected = f;
    var got = _.avector[ r ]( [ 1, 2, 4 ], array( 1, 2, 3 ) );
    test.identical( got, expected );
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 4 ] );
    test.identical( got, expected );

    test.case = 'bad arguments'; /* */

    if( Config.debug )
    {
      test.shouldThrowErrorSync( () => _.avector[ r ]() );
      test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
    }
  }
}

allGreater.timeOut = 150000;

//

function allGreaterEqualAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _allGreaterEqualAprox( test, 'allGreaterEqualAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _allGreaterEqualAprox( test, 'allGreaterEqualAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _allGreaterEqualAprox( test, 'allGreaterEqualAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _allGreaterEqualAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 0, 1, 2 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1 + e, 2 + e, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0+e, 1+e, 1001+e, 0-e, 1-e, 1001-e ), array( -0, +1, +1001, -0, +1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( -0+e, -1+e, -1001+e, -0-e, -1-e, -1001-e ), array( +0, -1, -1001, +0, -1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1+e, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3+e ] );
    test.identical( got, expected );
  }
}

allGreaterEqualAprox.timeOut = 150000;

//

function allGreaterAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _allGreaterAprox( test, 'allGreaterAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _allGreaterAprox( test, 'allGreaterAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _allGreaterAprox( test, 'allGreaterAprox', true, F32x, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _allGreaterAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1 + e, 2 + e, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0+e, 1+e, 1001+e, 0-e, 1-e, 1001-e ), array( -0, +1, +1001, -0, +1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( -0+e, -1+e, -1001+e, -0-e, -1-e, -1001-e ), array( +0, -1, -1001, +0, -1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors';
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers';
    var expected = t;
    var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1+e, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3+e ] );
    test.identical( got, expected );
  }
}

allGreaterAprox.timeOut = 150000;

//

function allLessEqualAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _allLessEqualAprox( test, 'allLessEqualAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _allLessEqualAprox( test, 'allLessEqualAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _allLessEqualAprox( test, 'allLessEqualAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _allLessEqualAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 2, 3, 4 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1 + e, 2 + e, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0+e, 1+e, 1001+e, 0-e, 1-e, 1001-e ), array( -0, +1, +1001, -0, +1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( -0+e, -1+e, -1001+e, -0-e, -1-e, -1001-e ), array( +0, -1, -1001, +0, -1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1+e, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3+e ] );
    test.identical( got, expected );
  }
}

allLessEqualAprox.timeOut = 150000;

//

function allLessAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _allLessAprox( test, 'allLessAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _allLessAprox( test, 'allLessAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _allLessAprox( test, 'allLessAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _allLessAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1 + e, 2 + e, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0+e, 1+e, 1001+e, 0-e, 1-e, 1001-e ), array( -0, +1, +1001, -0, +1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( -0+e, -1+e, -1001+e, -0-e, -1-e, -1001-e ), array( +0, -1, -1001, +0, -1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 1, 2, 3 ], array( 1+e, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 3+e ] );
    test.identical( got, expected );
  }
}

allLessAprox.timeOut = 150000;

//

function allZero( test )
{
  /* - */

  test.open( 'Array constructor' );

  _allZero( test, 'allZero', true, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _allZero( test, 'allZero', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _allZero( test, 'allZero', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _allZero( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = 'vector';
    var expected = t;
    var got = _.avector[ r ]( array( 0, 0, 0 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 0 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 0, 2, 3 ) );
    test.identical( got, expected );

    /* */

    test.case = 'scalar';
    var expected = f;
    var got = _.avector[ r ]( 3 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 0 );
    test.identical( got, expected );

    /* */

    test.case = 'empty vector';
    var expected = t;
    var got = _.avector[ r ]( array() );
    test.identical( got, expected );

    /* */

    test.case = 'not';
    test.identical( _.avector[ r ]([ 1, 2, 3 ]), false );
    test.identical( _.avector[ r ]([ 0, 0, 1 ]), false );
    test.identical( _.avector[ r ]([ 0, 3, NaN ]), false );
    test.identical( _.avector[ r ]([ 0, NaN, 3 ]), false );
    test.identical( _.avector[ r ]([ 0, 3, -Infinity ]), false );
    test.identical( _.avector[ r ]([ 0, +Infinity, 3 ]), false );
    test.identical( _.avector[ r ]([ 1.1, 0, 1 ]), false );
    test.identical( _.avector[ r ]([ 1, 0, 1.1 ]), false );
  }
}

allZero.timeOut = 15000;
//

function allFinite( test )
{

  test.identical( _.avector.allFinite([ 1, 2, 3 ]), true );
  test.identical( _.avector.allFinite([ 0, 0, 0 ]), true );
  test.identical( _.avector.allFinite([ 0, 0, 1 ]), true );

  test.identical( _.avector.allFinite([ 1, 3, NaN ]), false );
  test.identical( _.avector.allFinite([ 1, NaN, 3 ]), false );
  test.identical( _.avector.allFinite([ 1, 3, -Infinity ]), false );
  test.identical( _.avector.allFinite([ 1, +Infinity, 3 ]), false );

  test.identical( _.avector.allFinite([ 1.1, 0, 1 ]), true );
  test.identical( _.avector.allFinite([ 1, 0, 1.1 ]), true );

}

//

function allInt( test )
{

  test.identical( _.avector.allInt([ 1, 2, 3 ]), true );
  test.identical( _.avector.allInt([ 0, 0, 0 ]), true );
  test.identical( _.avector.allInt([ 0, 0, 1 ]), true );

  test.identical( _.avector.allInt([ 1, 3, NaN ]), false );
  test.identical( _.avector.allInt([ 1, NaN, 3 ]), false );
  test.identical( _.avector.allInt([ 1, 3, -Infinity ]), true );
  test.identical( _.avector.allInt([ 1, +Infinity, 3 ]), true );

  test.identical( _.avector.allInt([ 1.1, 0, 1 ]), false );
  test.identical( _.avector.allInt([ 1, 0, 1.1 ]), false );

}

//

function _anyNotIdentical( test, r, t, array )
{
  var f = !t;

  /* */

  test.case = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 4 ) );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 ) );
  test.identical( got, expected );

  test.case = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( 3, array( 3, 3, 3 ) );
  test.identical( got, expected );

  test.case = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3, 3 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 3, 4 );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = f;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  var expected = f;
  var got = _.avector[ r ]( [ 4, 5, 6 ], array( 1, 2, 3 ) );
  test.identical( got, expected );

}

//

function anyNotIdentical( test )
{
  this._anyNotIdentical( test, 'anyNotIdentical', false, function()
  {
    return _.longMake( Array, arguments );
  });

  this._anyNotIdentical( test, 'anyNotIdentical', false, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._anyNotIdentical( test, 'anyNotIdentical', false, function()
  {
    return _.longMake( U32x, arguments );
  });
}

anyNotIdentical.timeOut = 15000;

//

function anyEquivalent( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyEquivalent( test, 'anyEquivalent', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyEquivalent( test, 'anyEquivalent', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyEquivalent( test, 'anyEquivalent', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyEquivalent( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
    test.identical( got, expected );
  }
}

anyEquivalent.timeOut = 15000;

// //
//
// function anyEquivalent2( test )
// {
//   this._anyIdentical( test, 'anyEquivalent', true, function()
//   {
//     return _.longMake( Array, arguments );
//   });
//
//   this._anyIdentical( test, 'anyEquivalent', true, function()
//   {
//     return _.longMake( F32x, arguments );
//   });
//
//   this._anyIdentical( test, 'anyEquivalent', true, function()
//   {
//     return _.longMake( U32x, arguments );
//   });
// }
//
// anyEquivalent2.timeOut = 15000;

//

function anyNotEquivalent( test )
{
  this._anyNotIdentical( test, 'anyNotEquivalent', false, function()
  {
    return _.longMake( Array, arguments );
  });

  this._anyNotIdentical( test, 'anyNotEquivalent', false, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._anyNotIdentical( test, 'anyNotEquivalent', false, function()
  {
    return _.longMake( U32x, arguments );
  });
}

anyNotEquivalent.timeOut = 15000;

//

function anyGreater( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyGreater( test, 'anyGreater', true, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyGreater( test, 'anyGreater', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyGreater( test, 'anyGreater', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyGreater( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = ' trivial'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 1, 9 ), array( 1, 1, 8 ) );
    test.identical( got, expected );

    test.case = 'vector and scalar'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 4 ), 3 );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 2, array( 3, 3, 3 ) );
    test.identical( got, expected );

    test.case = 'scalar and scalar'; /* */
    var expected = t;
    var got = _.avector[ r ]( 4, 3 );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 3, 4 );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 1, 2, 4 ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 4 ] );
    test.identical( got, expected );

    test.case = 'bad arguments'; /* */

    /* - */

    if( Config.debug )
    {
      test.shouldThrowErrorSync( () => _.avector[ r ]() );
      test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
    }
  }
}

anyGreater.timeOut = 15000;

//

function anyGreaterEqualAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyGreaterEqualAprox( test, 'anyGreaterEqualAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyGreaterEqualAprox( test, 'anyGreaterEqualAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyGreaterEqualAprox( test, 'anyGreaterEqualAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyGreaterEqualAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 1, 3, 4 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
    test.identical( got, expected );
  }
}

anyGreaterEqualAprox.timeOut = 15000;

//

function anyGreaterAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyGreaterAprox( test, 'anyGreaterAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyGreaterAprox( test, 'anyGreaterAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyGreaterAprox( test, 'anyGreaterAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyGreaterAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
    test.identical( got, expected );
  }
}

anyGreaterAprox.timeOut = 15000;

//

function anyLessEqualAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyLessEqualAprox( test, 'anyLessEqualAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyLessEqualAprox( test, 'anyLessEqualAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyLessEqualAprox( test, 'anyLessEqualAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyLessEqualAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 1, 4, 3 ) );
    test.identical( got, expected );

    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
    test.identical( got, expected );
  }
}

anyLessEqualAprox.timeOut = 15000;

//

function anyLessAprox( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyLessAprox( test, 'anyLessAprox', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyLessAprox( test, 'anyLessAprox', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyLessAprox( test, 'anyLessAprox', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyLessAprox( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = t
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = t;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = t;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
    test.identical( got, expected );
  }
}

anyGreaterAprox.timeOut = 15000;

//

function anyZero( test )
{
  /* - */

  test.open( 'Array constructor' );

  _anyZero( test, 'anyZero', true, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _anyZero( test, 'anyZero', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _anyZero( test, 'anyZero', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _anyZero( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = 'vector';
    var expected = t;
    var got = _.avector[ r ]( array( 0, 0, 0 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 0 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 0, 2, 3 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ) );
    test.identical( got, expected );

    /* */

    test.case = 'scalar';
    var expected = f;
    var got = _.avector[ r ]( 3 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 0 );
    test.identical( got, expected );

    /* */

    test.case = 'empty vector';
    var expected = t;
    var got = _.avector[ r ]( array() );
    test.identical( got, expected );

    /* */

    test.case = 'not';
    test.identical( _.avector[ r ]([ 1, 2, 3 ]), false );
    test.identical( _.avector[ r ]([ 3, 4, 1 ]), false );
    test.identical( _.avector[ r ]([ 1, 3, NaN ]), false );
    test.identical( _.avector[ r ]([ 1, NaN, 3 ]), false );
    test.identical( _.avector[ r ]([ 1, 3, -Infinity ]), false );
    test.identical( _.avector[ r ]([ 1, +Infinity, 3 ]), false );
    test.identical( _.avector[ r ]([ 1.1, 0.001, 1 ]), false );
    test.identical( _.avector[ r ]([ 1, 0.001, 1.1 ]), false );
  }
}

anyZero.timeOut = 15000;

//

function anyNan( test )
{

  test.identical( _.avector.anyNan([ 1, 2, 3 ]), false );
  test.identical( _.avector.anyNan([ 0, 0, 0 ]), false );
  test.identical( _.avector.anyNan([ 0, 0, 1 ]), false );

  test.identical( _.avector.anyNan([ 1, 3, NaN ]), true );
  test.identical( _.avector.anyNan([ 1, NaN, 3 ]), true );
  test.identical( _.avector.anyNan([ 1, 3, -Infinity ]), false );
  test.identical( _.avector.anyNan([ 1, +Infinity, 3 ]), false );

  test.identical( _.avector.anyNan([ 1.1, 0, 1 ]), false );
  test.identical( _.avector.anyNan([ 1, 0, 1.1 ]), false );

}

//

function noneIdentical( test )
{
  this._noneIdentical( test, 'noneIdentical', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._noneIdentical( test, 'noneIdentical', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._noneIdentical( test, 'noneIdentical', true, function()
  {
    return _.longMake( U32x, arguments );
  });
}

noneIdentical.timeOut = 15000;

//

function noneNotIdentical( test )
{
  this._allIdentical( test, 'noneNotIdentical', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._allIdentical( test, 'noneNotIdentical', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._allIdentical( test, 'noneNotIdentical', true, function()
  {
    return _.longMake( U32x, arguments );
  });
}

noneNotIdentical.timeOut = 15000;

//

function _noneGreaterAprox( test, r, t, Array, array )
{
  var f = !t;
  var e = _.accuracy * 0.5;

  /* */

  test.case = 'trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
  test.identical( got, expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 4, 5, 6 ) );
  test.identical( got, expected );

  if( Array !== U32x )
  {

    test.case = 'very close, positive elements'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
    test.identical( got, expected );

    test.case = 'very close, negative elements'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
    test.identical( got, expected );

  }

  test.case = 'very close, scalars'; /* */
  var expected = f;
  var got = _.avector[ r ]( 1+e, 1 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 1-e, 1 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 1, 1+e );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 1, 1-e );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  test.case = 'different types of containers'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1, 2, 3 ), [ 4, 5, 6 ] );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
  test.identical( got, expected );


}

//

function _noneLessAprox( test, r, t, Array, array )
{
  var f = !t;
  var e = _.accuracy * 0.5;

  /* */

  test.case = 'trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), array( 4, 5, 6 ) );
  test.identical( got, expected );

  if( Array !== U32x )
  {

    test.case = 'very close, positive elements'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
    test.identical( got, expected );

    test.case = 'very close, negative elements'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
    test.identical( got, expected );

  }

  test.case = 'very close, scalars'; /* */
  var expected = f;
  var got = _.avector[ r ]( 1+e, 1 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 1-e, 1 );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 1, 1+e );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( 1, 1-e );
  test.identical( got, expected );

  test.case = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(), array() );
  test.identical( got, expected );

  test.case = 'different types of containers'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3 ), [ 4, 5, 6 ] );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
  test.identical( got, expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
  test.identical( got, expected );


}

//

function noneEquivalent( test )
{
  /* - */

  test.open( 'Array constructor' );

  _noneEquivalent( test, 'noneEquivalent', true, Array, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _noneEquivalent( test, 'noneEquivalent', true, U32x, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _noneEquivalent( test, 'noneEquivalent', true, F32x, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _noneEquivalent( test, r, t, Array, array )
  {
    var f = !t;
    var e = _.accuracy * 0.5;

    /* */

    test.case = 'trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 5 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 1, 2, 3 + e ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 4, 5, 6 ) );
    test.identical( got, expected );

    if( Array !== U32x )
    {
      test.case = 'very close, positive elements'; /* */
      var expected = f;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, 1001-e ), array( 0, 1, 1001, 0, 1, +1001 ) );
      test.identical( got, expected );

      test.case = 'very close, negative elements'; /* */
      var expected = f;
      var got = _.avector[ r ]( array( 0, 1, 1001, 0, 1, -1001-e ), array( 0, 1, 1001, 0, 1, -1001 ) );
      test.identical( got, expected );
    }

    test.case = 'very close, scalars'; /* */
    var expected = f;
    var got = _.avector[ r ]( 1+e, 1 );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 1-e, 1 );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 1, 1+e );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 1, 1-e );
    test.identical( got, expected );

    test.case = 'empty vectors'; /* */
    var expected = t;
    var got = _.avector[ r ]( array(), array() );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 4, 5, 6 ] );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( [ 0, 1, 3+e ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 3+e ), [ 0, 1, 3 ] );
    test.identical( got, expected );
  }
}

noneEquivalent.timeOut = 15000;

// //
//
// function noneEquivalent2( test )
// {
//   this._noneIdentical( test, 'noneIdentical', true, function()
//   {
//     return _.longMake( Array, arguments );
//   });
//
//   this._noneIdentical( test, 'noneIdentical', true, function()
//   {
//     return _.longMake( F32x, arguments );
//   });
//
//   this._noneIdentical( test, 'noneIdentical', true, function()
//   {
//     return _.longMake( U32x, arguments );
//   });
// }
//
// noneEquivalent2.timeOut = 15000;

//

function noneNotEquivalent( test )
{
  this._allIdentical( test, 'noneNotEquivalent', true, function()
  {
    return _.longMake( Array, arguments );
  });

  this._allIdentical( test, 'noneNotEquivalent', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  this._allIdentical( test, 'noneNotEquivalent', true, function()
  {
    return _.longMake( U32x, arguments );
  });
}

noneNotEquivalent.timeOut = 15000;

//

function noneGreater( test )
{
  /* - */

  test.open( 'Array constructor' );

  _noneGreater( test, 'noneGreater', true, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _noneGreater( test, 'noneGreater', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _noneGreater( test, 'noneGreater', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );


  /* - */

  function _noneGreater( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = ' trivial'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), array( 3, 4, 3 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 2, 2, 9 ), array( 1, 1, 8 ) );
    test.identical( got, expected );

    test.case = 'vector and scalar'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), 3 );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 2, array( 1, 1, 1 ) );
    test.identical( got, expected );

    test.case = 'scalar and scalar'; /* */
    var expected = f;
    var got = _.avector[ r ]( 4, 3 );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( 3, 4 );
    test.identical( got, expected );

    test.case = 'different types of containers'; /* */
    var expected = f;
    var got = _.avector[ r ]( [ 1, 2, 4 ], array( 1, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ), [ 1, 2, 4 ] );
    test.identical( got, expected );

    /* - */

    if( Config.debug )
    {
      test.case = 'bad arguments';
      test.shouldThrowErrorSync( () => _.avector[ r ]() );
      test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
      test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );
    }
  }
}

noneGreater.timeOut = 15000;

//

function noneGreaterAprox( test )
{
  this._noneGreaterAprox( test, 'noneGreaterAprox', true, Array, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._noneGreaterAprox( test, 'noneGreaterAprox', true, F32x, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._noneGreaterAprox( test, 'noneGreaterAprox', true, U32x, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

noneGreaterAprox.timeOut = 150000;

//

function noneGreaterEqualAprox( test )
{
  this._noneGreaterAprox( test, 'noneGreaterEqualAprox', true, Array, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._noneGreaterAprox( test, 'noneGreaterEqualAprox', true, F32x, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._noneGreaterAprox( test, 'noneGreaterEqualAprox', true, U32x, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

noneGreaterEqualAprox.timeOut = 150000;

//

function noneLessAprox( test )
{
  this._noneLessAprox( test, 'noneLessAprox', true, Array, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._noneLessAprox( test, 'noneLessAprox', true, F32x, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._noneLessAprox( test, 'noneLessAprox', true, U32x, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

noneLessAprox.timeOut = 150000;

//

function noneLessEqualAprox( test )
{
  this._noneLessAprox( test, 'noneLessEqualAprox', true, Array, function()
  {
    return _.longMake/*longMakeUndefined*/( Array, arguments );
  });

  this._noneLessAprox( test, 'noneLessEqualAprox', true, F32x, function()
  {
    return _.longMake/*longMakeUndefined*/( F32x, arguments );
  });

  this._noneLessAprox( test, 'noneLessEqualAprox', true, U32x, function()
  {
    return _.longMake/*longMakeUndefined*/( U32x, arguments );
  });
}

noneLessEqualAprox.timeOut = 150000;

//

function noneZero( test )
{
  /* - */

  test.open( 'Array constructor' );

  _noneZero( test, 'noneZero', true, function()
  {
    return _.longMake( Array, arguments );
  });

  test.close( 'Array constructor' );

  /* - */

  test.open( 'U32x constructor' );

  _noneZero( test, 'noneZero', true, function()
  {
    return _.longMake( U32x, arguments );
  });

  test.close( 'U32x constructor' );

  /* - */

  test.open( 'F32x constructor' );

  _noneZero( test, 'noneZero', true, function()
  {
    return _.longMake( F32x, arguments );
  });

  test.close( 'F32x constructor' );

  /* - */

  function _noneZero( test, r, t, array )
  {
    var f = !t;

    /* */

    test.case = 'vector';
    var expected = f;
    var got = _.avector[ r ]( array( 0, 0, 0 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 1, 2, 0 ) );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( array( 0, 2, 3 ) );
    test.identical( got, expected );

    var expected = t;
    var got = _.avector[ r ]( array( 1, 2, 3 ) );
    test.identical( got, expected );

    /* */

    test.case = 'scalar';
    var expected = t;
    var got = _.avector[ r ]( 3 );
    test.identical( got, expected );

    var expected = f;
    var got = _.avector[ r ]( 0 );
    test.identical( got, expected );

    /* */

    test.case = 'empty vector';
    var expected = t;
    var got = _.avector[ r ]( array() );
    test.identical( got, expected );

    /* */

    test.case = 'not';
    test.identical( _.avector[ r ]([ 1, 0, 3 ]), false );
    test.identical( _.avector[ r ]([ 0, 0, 1 ]), false );
    test.identical( _.avector[ r ]([ 0, 3, NaN ]), false );
    test.identical( _.avector[ r ]([ 0, NaN, 3 ]), false );
    test.identical( _.avector[ r ]([ 0, 3, -Infinity ]), false );
    test.identical( _.avector[ r ]([ 0, +Infinity, 3 ]), false );
    test.identical( _.avector[ r ]([ 1.1, 0, 1 ]), false );
    test.identical( _.avector[ r ]([ 1, 0, 1.1 ]), false );
  }
}

noneZero.timeOut = 15000;

//

function logical2ArgsReducerWithBadArguments( test, r, t, array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.case = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( null, [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1, 2, 3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1, 5 ], { 1 : 1, 2 : 2 } ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1, 5 ], undefined ) );

  }

  /*
  allIdentical : Routines.allIdentical,
  allNotIdentical : Routines.allNotIdentical,
  allEquivalent : Routines.allEquivalent,
  allNotEquivalent : Routines.allNotEquivalent,
  allGreater : Routines.allGreater,
  allGreaterEqual : Routines.allGreaterEqual,
  allLess : Routines.allLess,
  allLessEqual : Routines.allLessEqual,

  anyIdentical : Routines.anyIdentical,
  anyNotIdentical : Routines.anyNotIdentical,
  anyEquivalent : Routines.anyEquivalent,
  anyNotEquivalent : Routines.anyNotEquivalent,
  anyGreater : Routines.anyGreater,
  anyGreaterEqual : Routines.anyGreaterEqual,
  anyLess : Routines.anyLess,
  anyLessEqual : Routines.anyLessEqual,

  noneIdentical : Routines.noneIdentical,
  noneNotIdentical : Routines.noneNotIdentical,
  noneEquivalent : Routines.noneEquivalent,
  noneNotEquivalent : Routines.noneNotEquivalent,
  noneGreater : Routines.noneGreater,
  noneGreaterEqual : Routines.noneGreaterEqual,
  noneLess : Routines.noneLess,
  noneLessEqual : Routines.noneLessEqual,
  */

  for( r in _.vectorAdapter )
  {
    if( !_.routineIs( _.vectorAdapter[ r ] ) )
    continue;

    var op = _.vectorAdapter[ r ].operation;

    if( !op )
    continue;

    if( !op.reducing )
    continue;

    if( !op.returningBoolean )
    continue;

    if( !_.longIdentical( op.takingArguments, [ 2, 2 ] ) )
    continue;

    forRoutine( r );
  }

}

logical2ArgsReducerWithBadArguments.timeOut = 30000;

//

function logical1ArgsSinglerWithBadArguments( test, r, t, array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.case = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1' ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10, 10, 3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, 10, 3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1 ], [ 1 ], [ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, [ 1 ], [ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, 10, [ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, [ 1 ], 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1, 2, 3 ) );

  }

  /*
  */

  for( r in _.vectorAdapter )
  {

    if( !_.routineIs( _.vectorAdapter[ r ] ) )
    continue;

    var op = _.vectorAdapter[ r ].operation;

    if( !op )
    continue;

    if( op.reducing )
    continue;

    if( !op.returningBoolean )
    continue;

    if( !_.longIdentical( op.takingArguments, [ 1, 2 ] ) )
    continue;

    forRoutine( r );

  }

}

logical1ArgsSinglerWithBadArguments.timeOut = 25000;

//

function logical1ArgsReducerWithBadArguments( test, r, t, array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.case = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1' ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10, 10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1 ], [ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, 10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, [ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined, 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1', 3, 4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ], [ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 4 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4, 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3, 3 ], [ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( null, [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ], [ 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null, 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1, 2, 3 ) );

  }

  /*
  */

  for( r in _.vectorAdapter )
  {

    if( !_.routineIs( _.vectorAdapter[ r ] ) )
    continue;

    var op = _.vectorAdapter[ r ].operation;

    if( !op )
    continue;

    if( !op.reducing )
    continue;

    if( !op.returningBoolean )
    continue;

    if( !_.longIdentical( op.takingArguments, [ 1, 1 ] ) )
    continue;

    forRoutine( r );

  }

}

logical1ArgsReducerWithBadArguments.timeOut = 30000;

//

function areParallelDefaultAccuracy( test )
{
  let e = _.accuracy || 10 ** -7;

  /* - */

  test.open( 'without deviation' );

  test.case = 'empty vectors, equivalent, zeros';
  var src1 = [];
  var src2 = [];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = [ 0 ];
  var src2 = [ 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = [ 5 ];
  var src2 = [ 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = [ -5 ];
  var src2 = [ -5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = [ 5 ];
  var src2 = [ -5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ -5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500, 1 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zeros';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = [ 10, -100, 20 ];
  var src2 = [ 50, -500, 100 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0, 0, 0 ];
  var src2 = [ 0, 0, 0, 0, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ 5, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5, -5, -5 ];
  var src2 = [ -5, -5, -5, -5, -5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ -5, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5, -25, 50, -500, 1 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5, -25, 50, -500, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = [ 1, -5, 10, -100, 20 ];
  var src2 = [ 5, -25, 50, -500, 100 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'without deviation' );

  /* - */

  test.open( 'with deviation' );

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = [ 0 ];
  var src2 = [ 0 + e * 10 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = [ 5 ];
  var src2 = [ 5 + e * 10 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = [ -5 ];
  var src2 = [ -5 + e * 10 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = [ 5 ];
  var src2 = [ -5 + e * 10 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0 + e * 10, 0, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5 + e * 10, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5 + e * 10, -5, -5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ -5 + e * 10, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500 + e * 10, 1 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500  + 0.05, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = [ 10, -100, 20 ];
  var src2 = [ 50, -500, 100  + 0.05 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0, 0, 0 ];
  var src2 = [ 0 + e * 10, 0, 0, 0, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ 5 + e * 10, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5, -5, -5 ];
  var src2 = [ -5 + e * 10, -5, -5, -5, -5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ -5 + e * 10, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5 + e * 10, -25, 50, -500, 1 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5 + e * 100, -25, 50, -500, 0 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = [ 1, -5, 10, -100, 20 ];
  var src2 = [ 5 + e * 100, -25, 50, -500, 100 ];
  var got = _.avector.areParallel( src1, src2 );
  var exp = false;
  test.identical( got, exp );

  test.close( 'with deviation' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.avector.areParallel() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.avector.areParallel( [ 1 ] ) );

  test.case = 'wrong type of src1';
  test.shouldThrowErrorSync( () => _.avector.areParallel( 'wrong', [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.areParallel( null, [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.areParallel( undefined, [ 1 ], 0.1 ) );

  test.case = 'wrong type of src2';
  test.shouldThrowErrorSync( () => _.avector.areParallel( [ 1 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.avector.areParallel( [ 1 ], {} ) );
  test.shouldThrowErrorSync( () => _.avector.areParallel( [ 1 ], new Set( [] ), 0.1 ) );

  test.case = 'wrong type of accuracy';
  test.shouldThrowErrorSync( () => _.avector.areParallel( [ 1, 2 ], [ 1, 2 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.avector.areParallel( [ 1, 2 ], [ 1, 2 ], null ) );
}

//

function areParallelNotDefaultAccuracy( test )
{
  let e = _.accuracy || 10 ** -7;

  /* - */

  test.open( 'without deviation' );

  test.case = 'empty vectors, equivalent, zeros';
  var src1 = [];
  var src2 = [];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = [ 0 ];
  var src2 = [ 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = [ 5 ];
  var src2 = [ 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = [ -5 ];
  var src2 = [ -5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = [ 5 ];
  var src2 = [ -5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ -5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500, 1 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zeros';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = [ 10, -100, 20 ];
  var src2 = [ 50, -500, 100 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0, 0, 0 ];
  var src2 = [ 0, 0, 0, 0, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ 5, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5, -5, -5 ];
  var src2 = [ -5, -5, -5, -5, -5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ -5, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5, -25, 50, -500, 1 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5, -25, 50, -500, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = [ 1, -5, 10, -100, 20 ];
  var src2 = [ 5, -25, 50, -500, 100 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'without deviation' );

  /* - */

  test.open( 'with deviation' );

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = [ 0 ];
  var src2 = [ 0 + e * 10 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = [ 5 ];
  var src2 = [ 5 + e * 10 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = [ -5 ];
  var src2 = [ -5 + e * 10 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = [ 5 ];
  var src2 = [ -5 + e * 10 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0 + e * 10, 0, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5 + e * 10, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5 + e * 10, -5, -5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = [ 5, 5, 5 ];
  var src2 = [ -5 + e * 10, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500 + e * 10, 1 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero';
  var src1 = [ 10, -100, 0 ];
  var src2 = [ 50, -500  + e * 10, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = [ 10, -100, 20 ];
  var src2 = [ 50, -500, 100  + e * 10 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = [ 0, 0, 0, 0, 0 ];
  var src2 = [ 0 + e * 10, 0, 0, 0, 0 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ 5 + e * 10, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = [ -5, -5, -5, -5, -5 ];
  var src2 = [ -5 + e * 10, -5, -5, -5, -5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = [ 5, 5, 5, 5, 5 ];
  var src2 = [ -5 + e * 10, 5, 5, 5, 5 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5 + e * 10, -25, 50, -500, 1 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = [ 1, -5, 10, -100, 0 ];
  var src2 = [ 5 + e * 10, -25, 50, -500, 0 ];
  var got = _.avector.areParallel( src1, src2, 20 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = [ 1, -5, 10, -100, 20 ];
  var src2 = [ 5 + e * 10, -25, 50, -500, 100 ];
  var got = _.avector.areParallel( src1, src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'with deviation' );
}

//

function mag( test )
{
  test.case = 'basic';
  var a = [ 0, 0, 2 ];
  var exp = 2;
  var got = _.avector.mag( a );
  test.identical( got, exp );
}

//

function dot( test )
{
  var a = [ 1, 2, 3, 4 ];
  var b = [ 6, 7, 8, 9 ];

  var or1 = [ 3, 1, 5 ];
  var or2 = [ -1, 3, 0 ];

  test.case = 'anrarrays'; /* */
  var expected = 80;
  var got = _.avector.dot( a, b );
  test.identical( got, expected )

  test.case = 'orthogonal anrarrays'; /* */
  var expected = 0;
  var got = _.avector.dot( or1, or2 );
  test.identical( got, expected )

  test.case = 'empty anarrays'; /* */
  var expected = 0;
  var got = _.avector.dot( [], [] );
  test.identical( got, expected )

  test.case = 'empty vectors'; /* */
  var expected = 0;
  var got = _.avector.dot( vec([]), vec([]) );
  test.identical( got, expected )

  test.case = 'subarray vectors'; /* */
  var av = _.vectorAdapter.fromLongLrange( a, 1, 3 );
  var bv = _.vectorAdapter.fromLongLrange( b, 1, 3 );
  var expected = 74;
  var got = _.avector.dot( av, bv );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */
  test.shouldThrowErrorSync( () => _.avector.dot( 1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ], [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ], [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [], function(){} ) );
}

dot.timeOut = 15000;

//

function median( test )
{

  test.case = 'simple even'; /* */

  var expected = 5;
  var got = _.avector.median([ 1, 2, 3, 9 ]);
  test.equivalent( got, expected );

  test.case = 'simple odd'; /* */

  var expected = 5;
  var got = _.avector.median([ 1, 2, 9 ]);
  test.equivalent( got, expected );

  test.case = 'empty'; /* */

  var expected = NaN;
  var got = _.avector.median([]);
  test.equivalent( got, expected );

}

median.timeOut = 15000;

//

function momentCentral( test )
{
  test.case = 'first even'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [ 1, 2, 3, 4 ], 1, 2.5 );
  test.equivalent( got, expected );

  test.case = 'first odd'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [ 1, 2, 3 ], 1, 2 );
  test.equivalent( got, expected );

  test.case = 'first empty'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [], 1, 0 );
  test.equivalent( got, expected );

  test.case = 'second even'; /* */
  var expected = 5 / 4;
  var got = _.avector.momentCentral( [ 1, 2, 3, 4 ], 2, 2.5 );
  test.equivalent( got, expected );

  test.case = 'second odd'; /* */
  var expected = 2 / 3;
  var got = _.avector.momentCentral( [ 1, 2, 3 ], 2, 2 );
  test.equivalent( got, expected );

  test.case = 'second empty'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [], 2, 0 );
  test.equivalent( got, expected );

  test.case = 'first even'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [ 1, 2, 3, 4 ], 1 );
  test.equivalent( got, expected );

  test.case = 'first odd'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [ 1, 2, 3 ], 1 );
  test.equivalent( got, expected );

  test.case = 'first empty'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [], 1 );
  test.equivalent( got, expected );

  test.case = 'second even'; /* */
  var expected = 5 / 4;
  var got = _.avector.momentCentral( [ 1, 2, 3, 4 ], 2 );
  test.equivalent( got, expected );

  test.case = 'second odd'; /* */
  var expected = 2 / 3;
  var got = _.avector.momentCentral( [ 1, 2, 3 ], 2 );
  test.equivalent( got, expected );

  test.case = 'second empty'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [], 2 );
  test.equivalent( got, expected );

  test.case = 'first even, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [ 1, 2, 3, 4 ], 1, null );
  test.equivalent( got, expected );

  test.case = 'first odd, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [ 1, 2, 3 ], 1, null );
  test.equivalent( got, expected );

  test.case = 'first empty, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [], 1, null );
  test.equivalent( got, expected );

  test.case = 'second even, with mean : null'; /* */
  var expected = 5 / 4;
  var got = _.avector.momentCentral( [ 1, 2, 3, 4 ], 2, null );
  test.equivalent( got, expected );

  test.case = 'second odd, with mean : null'; /* */
  var expected = 2 / 3;
  var got = _.avector.momentCentral( [ 1, 2, 3 ], 2, null );
  test.equivalent( got, expected );

  test.case = 'second empty, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentral( [], 2, null );
  test.equivalent( got, expected );

  test.case = 'first even, filtering'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3, 4 ], 1, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'first odd, filtering'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3 ], 1, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'first empty, filtering'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [], 1, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'second even, filtering'; /* */
  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3, 4 ], 2, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'second odd, filtering'; /* */
  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3 ], 2, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'second empty, filtering'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [], 2, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'first even, filtering, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3, 4 ], 1, null, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'first odd, filtering, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3 ], 1, null, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'first empty, filtering, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [], 1, null, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'second even, filtering, with mean : null'; /* */
  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3, 4 ], 2, null, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'second odd, filtering, with mean : null'; /* */
  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1, 2, 3 ], 2, null, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  test.case = 'second empty, filtering, with mean : null'; /* */
  var expected = 0;
  var got = _.avector.momentCentralConditional( [], 2, null, ( e, op ) => e % 2 );
  test.equivalent( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */
  test.shouldThrowErrorSync( () => _.momentCentral() );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ], '1' ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.momentCentral( 1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( 'x', 1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ], 'x' ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ], [ 1 ] ) );

  test.shouldThrowErrorSync( () => _.momentCentralConditional() );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ], '1', () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ], [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 1, () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 'x', 1, () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 1, 1, () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ], 'x', () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 1, [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ], [ 1 ], () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ], [ 1 ], () => true ) );
}

momentCentral.timeOut = 15000;

//

function distributionSummaryExperiment( test )
{

  var summary = _.avector.distributionSummary([ 1, 2, 3, 4, 9 ]);
  logger.log( 'summary', summary );

  test.identical( 1, 1 );
}

distributionSummaryExperiment.experimental = 1;

// //
//
// function subarray( test )
// {
//
//   test.case = 'trivial'; /* */
//
//   var v = vec([ 1, 2, 3 ]);
//   test.identical( v.subarray( 0, 2 ), vec([ 1, 2 ]) );
//   test.identical( v.subarray( 1, 3 ), vec([ 2, 3 ]) );
//
//   test.case = 'subarray from vector with stride'; /* */
//
//   var v = vad.fromLongLrangeAndStride( [ -1, 1, -2, 2, -2, 3 ], 1, 3, 2 );
//   test.identical( v.subarray( 0, 2 ), vec([ 1, 2 ]) );
//   test.identical( v.subarray( 1, 3 ), vec([ 2, 3 ]) );
//
//   test.case = 'get empty subarray'; /* */
//
//   var v = vad.fromLongLrangeAndStride( [ -1, 1, -2, 2, -2, 3 ], 1, 3, 2 );
//   test.identical( v.subarray( 0, 0 ), vec([]) );
//   test.identical( v.subarray( 2, 2 ), vec([]) );
//   test.identical( v.subarray( 3, 3 ), vec([]) );
//   test.identical( v.subarray( 10, 3 ), vec([]) );
//   test.identical( v.subarray( 10, 0 ), vec([]) );
//   test.identical( v.subarray( 10, 10 ), vec([]) );
//   test.identical( v.subarray( 10, 11 ), vec([]) );
//   test.identical( v.subarray( -2, -2 ), vec([]) );
//   test.identical( v.subarray( -2, -1 ), vec([]) );
//
//   test.case = 'missing argument'; /* */
//
//   test.identical( v.subarray( undefined, 2 ), vec([ 1, 2 ]) );
//   test.identical( v.subarray( 1 ), vec([ 2, 3 ]) );
//
//   test.case = 'bad arguments'; /* */
//
//   var v = vec([ 1, 2, 3 ]);
//   test.shouldThrowErrorSync( () => v.subarray() );
//   var v = vec([ 1, 2, 3 ]);
//   test.shouldThrowErrorSync( () => v.subarray( 10, 10, 10 ) );
//
//   // var v = vad.fromLongLrangeAndStride( [ -1, 1, -2, 2, -2, 3 ], 1, 3, 2 );
//   // test.shouldThrowErrorSync( () => v.subarray( -1, 1 ) );
//   //
//   // var v = vec([ 1, 2, 3 ]);
//   // test.shouldThrowErrorSync( () => v.subarray( -1, 1 ) );
//   //
//   // var v = vad.fromLongLrangeAndStride( [ -1, 1, -2, 2, -2, 3 ], 1, 3, 2 );
//   // test.shouldThrowErrorSync( () => v.subarray( 10, 10 ) );
//   //
//   // var v = vec([ 1, 2, 3 ]);
//   // test.shouldThrowErrorSync( () => v.subarray( 10, 10 ) );
//
// }
//
// subarray.timeOut = 15000;
//
// //
//
// function homogeneousWithScalar( test )
// {
//
//   test.case = 'assignScalar'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   _.avector.assignScalar( dst, 5 );
//   test.identical( dst, [ 5, 5, 5 ] );
//
//   var dst = vec([ 1, 2, 3 ]);
//   _.vectorAdapter.assignScalar( dst, 5 );
//   test.identical( dst, vec([ 5, 5, 5 ]) );
//
//   var dst = [];
//   _.avector.assignScalar( dst, 5 );
//   test.identical( dst, [] );
//
//   test.case = 'addScalar'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   _.avector.addScalar( dst, 5 );
//   test.identical( dst, [ 6, 7, 8 ] );
//
//   var dst = vec([ 1, 2, 3 ]);
//   _.vectorAdapter.addScalar( dst, 5 );
//   test.identical( dst, vec([ 6, 7, 8 ]) );
//
//   var dst = [];
//   _.avector.addScalar( dst, 5 );
//   test.identical( dst, [] );
//
//   test.case = 'subScalar'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   _.avector.subScalar( dst, 5 );
//   test.identical( dst, [ -4, -3, -2 ] );
//
//   var dst = vec([ 1, 2, 3 ]);
//   _.vectorAdapter.subScalar( dst, 5 );
//   test.identical( dst, vec([ -4, -3, -2 ]) );
//
//   var dst = [];
//   _.avector.subScalar( dst, 5 );
//   test.identical( dst, [] );
//
//   test.case = 'mulScalar'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   _.avector.mulScalar( dst, 5 );
//   test.identical( dst, [ 5, 10, 15 ] );
//
//   var dst = vec([ 1, 2, 3 ]);
//   _.vectorAdapter.mulScalar( dst, 5 );
//   test.identical( dst, vec([ 5, 10, 15 ]) );
//
//   var dst = [];
//   _.avector.mulScalar( dst, 5 );
//   test.identical( dst, [] );
//
//   test.case = 'divScalar'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   _.avector.divScalar( dst, 5 );
//   test.identical( dst, [ 1/5, 2/5, 3/5 ] );
//
//   var dst = vec([ 1, 2, 3 ]);
//   _.vectorAdapter.divScalar( dst, 5 );
//   test.identical( dst, vec([ 1/5, 2/5, 3/5 ]) );
//
//   var dst = [];
//   _.avector.divScalar( dst, 5 );
//   test.identical( dst, [] );
//
//   test.case = 'bad arguments'; /* */
//
//   if( !Config.debug )
//   return;
//
//   shouldThrowErrorOfAnyKind( 'assignScalar' );
//   shouldThrowErrorOfAnyKind( 'addScalar' );
//   shouldThrowErrorOfAnyKind( 'subScalar' );
//   shouldThrowErrorOfAnyKind( 'mulScalar' );
//   shouldThrowErrorOfAnyKind( 'divScalar' );
//
//   function shouldThrowErrorOfAnyKind( name )
//   {
//
//     test.shouldThrowErrorSync( () => _.avector[ name ]() );
//     test.shouldThrowErrorSync( () => _.avector[ name ]( 1 ) );
//     // test.shouldThrowErrorSync( () => _.avector[ name ]( 1, 3 ) );
//     test.shouldThrowErrorSync( () => _.avector[ name ]( '1', '3' ) );
//     test.shouldThrowErrorSync( () => _.avector[ name ]( [], [] ) );
//     test.shouldThrowErrorSync( () => _.avector[ name ]( [], 1, 3 ) );
//     test.shouldThrowErrorSync( () => _.avector[ name ]( [], 1, undefined ) );
//     test.shouldThrowErrorSync( () => _.avector[ name ]( [], undefined ) );
//
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]() );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( 1 ) );
//     // test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( 1, 3 ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( '1', '3' ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( [], [] ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( [], 1, 3 ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( [], 1, undefined ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ name ]( [], undefined ) );
//
//   }
//
// }
//
// homogeneousWithScalar.timeOut = 15000;
//
// //
//
// function homogeneousOnlyVectors( test )
// {
//
//   test.case = 'addVectors anarrays'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   _.avector.addVectors( dst, src1 );
//   test.identical( dst, [ 4, 4, 4 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   var src2 = [ 11, 12, 13 ];
//   _.avector.addVectors( dst, src1, src2 );
//   test.identical( dst, [ 15, 16, 17 ] );
//
//   test.case = 'addVectors vectors'; /* */
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   _.avector.addVectors( dst, src1 );
//   test.identical( dst, vec([ 4, 4, 4 ]) );
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   var src2 = vec([ 11, 12, 13 ]);
//   _.avector.addVectors( dst, src1, src2 );
//   test.identical( dst, vec([ 15, 16, 17 ]) );
//
//   test.case = 'addVectors anarrays'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   _.avector.addVectors( dst, src1 );
//   test.identical( dst, [ 4, 4, 4 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   var src2 = [ 11, 12, 13 ];
//   _.avector.addVectors( dst, src1, src2 );
//   test.identical( dst, [ 15, 16, 17 ] );
//
//   test.case = 'subVectors anarrays'; /* */
//
//   var dst = ([ 1, 2, 3 ]);
//   var src1 = ([ 3, 2, 1 ]);
//   _.avector.subVectors( dst, src1 );
//   test.identical( dst, ([ -2, 0, +2 ]) );
//
//   var dst = ([ 1, 2, 3 ]);
//   var src1 = ([ 3, 2, 1 ]);
//   var src2 = ([ 11, 12, 13 ]);
//   _.avector.subVectors( dst, src1, src2 );
//   test.identical( dst, ([ -13, -12, -11 ]) );
//
//   test.case = 'subVectors vectors'; /* */
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   _.avector.subVectors( dst, src1 );
//   test.identical( dst, vec([ -2, 0, +2 ]) );
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   var src2 = vec([ 11, 12, 13 ]);
//   _.avector.subVectors( dst, src1, src2 );
//   test.identical( dst, vec([ -13, -12, -11 ]) );
//
//   test.case = 'mulVectors vectors'; /* */
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   _.avector.mulVectors( dst, src1 );
//   test.identical( dst, vec([ 3, 4, 3 ]) );
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   var src2 = vec([ 11, 12, 13 ]);
//   _.avector.mulVectors( dst, src1, src2 );
//   test.identical( dst, vec([ 33, 48, 39 ]) );
//
//   test.case = 'mulVectors anarrays'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   _.avector.mulVectors( dst, src1 );
//   test.identical( dst, [ 3, 4, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   var src2 = [ 11, 12, 13 ];
//   _.avector.mulVectors( dst, src1, src2 );
//   test.identical( dst, [ 33, 48, 39 ] );
//
//   test.case = 'divVectors vectors'; /* */
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   _.avector.divVectors( dst, src1 );
//   test.identical( dst, vec([ 1/3, 1, 3 ]) );
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   var src2 = vec([ 11, 12, 13 ]);
//   _.avector.divVectors( dst, src1, src2 );
//   test.identical( dst, vec([ 1/3/11, 1/12, 3/13 ]) );
//
//   test.case = 'divVectors anarrays'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   _.avector.divVectors( dst, src1 );
//   test.identical( dst, [ 1/3, 1, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   var src2 = [ 11, 12, 13 ];
//   _.avector.divVectors( dst, src1, src2 );
//   test.identical( dst, [ 1/3/11, 1/12, 3/13 ] );
//
//   test.case = 'minVectors vectors'; /* */
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   _.avector.minVectors( dst, src1 );
//   test.identical( dst, vec([ 1, 2, 1 ]) );
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   var src2 = vec([ 11, 0, 13 ]);
//   _.avector.minVectors( dst, src1, src2 );
//   test.identical( dst, vec([ 1, 0, 1 ]) );
//
//   test.case = 'minVectors anarrays'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   _.avector.minVectors( dst, src1 );
//   test.identical( dst, [ 1, 2, 1 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   var src2 = [ 11, 0, 13 ];
//   _.avector.minVectors( dst, src1, src2 );
//   test.identical( dst, [ 1, 0, 1 ] );
//
//   test.case = 'maxVectors vectors'; /* */
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   _.avector.maxVectors( dst, src1 );
//   test.identical( dst, vec([ 3, 2, 3 ]) );
//
//   var dst = vec([ 1, 2, 3 ]);
//   var src1 = vec([ 3, 2, 1 ]);
//   var src2 = vec([ 11, 0, 13 ]);
//   _.avector.maxVectors( dst, src1, src2 );
//   test.identical( dst, vec([ 11, 2, 13 ]) );
//
//   test.case = 'maxVectors anarrays'; /* */
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   _.avector.maxVectors( dst, src1 );
//   test.identical( dst, [ 3, 2, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var src1 = [ 3, 2, 1 ];
//   var src2 = [ 11, 0, 13 ];
//   _.avector.maxVectors( dst, src1, src2 );
//   test.identical( dst, [ 11, 2, 13 ] );
//
//   test.case = 'empty vector'; /* */
//
//   function checkEmptyVector( rname )
//   {
//
//     var dst = [];
//     var got = _.avector[ rname ]( dst, [], [] );
//     test.is( got === dst );
//     test.identical( got , [] );
//
//     var dst = vec([]);
//     var got = _.vectorAdapter[ rname ]( dst, vec([]), vec([]) );
//     test.is( got === dst );
//     test.identical( got , vec([]) );
//
//   }
//
//   checkEmptyVector( 'assignVectors' );
//   checkEmptyVector( 'addVectors' );
//   checkEmptyVector( 'subVectors' );
//   checkEmptyVector( 'mulVectors' );
//   checkEmptyVector( 'subVectors' );
//   checkEmptyVector( 'minVectors' );
//   checkEmptyVector( 'maxVectors' );
//
//   test.case = 'bad arguments'; /* */
//
//   if( !Config.debug )
//   return;
//
//   function shouldThrowErrorOfAnyKind( rname )
//   {
//
//     test.shouldThrowErrorSync( () => _.avector[ rname ]() );
//     test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ] ) );
//     test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3 ] ) );
//     test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], [ 5 ] ) );
//     test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], 1 ) );
//     test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], undefined ) );
//     test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], '1' ) );
//
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]() );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]) ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3 ]) ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), vec([ 5 ]) ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), 1 ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), undefined ) );
//     test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), '1' ) );
//
//   }
//
//   shouldThrowErrorOfAnyKind( 'assignVectors' );
//   shouldThrowErrorOfAnyKind( 'addVectors' );
//   shouldThrowErrorOfAnyKind( 'subVectors' );
//   shouldThrowErrorOfAnyKind( 'mulVectors' );
//   shouldThrowErrorOfAnyKind( 'subVectors' );
//   shouldThrowErrorOfAnyKind( 'minVectors' );
//   shouldThrowErrorOfAnyKind( 'maxVectors' );
//
// }
//
// homogeneousOnlyVectors.timeOut = 15000;

// --
// proto
// --

var Self =
{

  name : 'Tools.Math.Vector.Long',
  silencing : 1,

  context :
  {

    _isIdentical,
    // _isEquivalent,
    _isGreater,
    _isLess,

    _isLessAprox,
    _isGreaterAprox,

    _allIdentical,
    _allNotIdentical,

    _anyIdentical,
    _anyNotIdentical,

    _noneIdentical,
    _noneGreaterAprox,
    _noneLessAprox,

  },

  tests :
  {

    /* aaa : move out routines which should be in VectorAdapter.test.s. ask how */
    /* Dmytro : all routines with vectorAdapter moved to VectorAdapter.test.s */

    /* aaa : sort routines order*/
    /* Dmytro : sorted */

    assign,

    reviewSrcIsSimpleVector,
    reviewSrcIsAdapterRoutineFrom,
    reviewSrcIsAdapterRoutineFromLong,
    reviewSrcIsAdapterRoutineFromLongWithStride,
    reviewSrcIsAdapterRoutineFromLongLrange,
    reviewSrcIsAdapterRoutineFromLongLrangeAndStride,
    reviewSrcIsAdapterRoutineFromNumber,
    reviewSrcIsAdapterRoutineFromMaybeNumber,

    //

    mapDstIsNullSimpleVector,
    mapDstIsNullRoutineFromLong,
    mapDstIsNullRoutineFromLongLrangeAndStride,
    mapDstIsNullRoutineFromNumber,
    mapOnlyDstSimpleVector,
    mapOnlyDstRoutineFromLong,
    mapOnlyDstRoutineFromLongLrangeAndStride,
    mapDstIsVectorSimpleVector,
    mapDstIsVectorRoutineFromLong,
    mapDstIsVectorRoutineFromLongLrangeAndStride,
    mapDstIsVectorRoutineFromNumberWithVectorAdapter,
    mapDstIsVectorRoutineFromNumberWithNumber,

    filterDstIsNullSimpleVector,
    filterDstIsNullRoutineFromLong,
    filterDstIsNullRoutineFromLongLrangeAndStride,
    filterDstIsNullRoutineFromNumber,
    filterOnlyDstSimpleVector,
    filterOnlyDstRoutineFromLong,
    filterOnlyDstRoutineFromLongLrangeAndStride,
    filterDstIsVectorSimpleVector,
    filterDstIsVectorRoutineFromLong,
    filterDstIsVectorRoutineFromLongLrangeAndStride,

    cross3,
    cross,

    abs,

    //

    add,
    sub,
    mul,
    div,

    heterogeneousScaledRoutines,

    clamp,
    randomInRange,
    mix,

    polynomApply,

    //

    mean,
    moment,
    reduceToMean,
    distributionRangeSummary,

    //

    isIdentical,
    isNotIdentical,
    isEquivalent,
    isNotEquivalent,
    // isEquivalent2,
    isGreater,
    isLessEqual,
    isLessEqualAprox,
    isLess,
    isLessAprox,
    isGreaterEqual,
    isGreaterEqualAprox,
    isGreaterAprox,

    isZero,

    logical2ArgsZipperWithBadArguments,

    /* */

    allIdentical,
    allNotIdentical,
    allEquivalent,
    // allEquivalent2,
    allNotEquivalent,
    allGreater,
    allGreaterEqualAprox,
    allGreaterAprox,
    allLessEqualAprox,
    allLessAprox,

    allZero, /* aaa : group all* routines */ /* Dmytro : grouped */
    allFinite,
    allInt,

    //

    anyIdentical,
    anyNotIdentical,
    anyEquivalent,
    // anyEquivalent2,
    anyNotEquivalent,
    anyGreater,
    anyGreaterEqualAprox,
    anyGreaterAprox,
    anyLessEqualAprox,
    anyLessAprox,

    anyZero, /* aaa : group any* routines */ /* Dmytro : grouped */
    anyNan,

    //

    noneIdentical,
    noneNotIdentical,
    noneEquivalent,
    // noneEquivalent2,
    noneNotEquivalent,
    noneGreater,
    noneGreaterAprox,
    noneGreaterEqualAprox,
    noneLessAprox,
    noneLessEqualAprox,

    noneZero, /* aaa : group none* routines */ /* Dmytro : grouped */

    //

    logical2ArgsReducerWithBadArguments,

    logical1ArgsSinglerWithBadArguments,

    logical1ArgsReducerWithBadArguments,

    //

    areParallelDefaultAccuracy,
    areParallelNotDefaultAccuracy,

    //

    mag,

    //

    dot,

    median,
    momentCentral,

    distributionSummaryExperiment,

    // deprecated

    // subarray,
    // homogeneousWithScalar,
    // homogeneousOnlyVectors,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
