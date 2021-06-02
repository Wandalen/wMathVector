( function _VectorAdapter_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

  require( '../l3_vector/Include.s' );

}

//

const Parent = wTester;
const _ = _global_.wTools.withLong.Fx;

// --
// from
// --

function fromWithLong( test )
{
  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {
    test.open( `different type of long, ${ a.format }` );

    test.case = 'from empty long';
    var src = a.longMake( [] );
    var got = _.vad.from( src );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.case = 'from filled long';
    var src = a.longMake([ 1, 2, 3 ]);
    var got = _.vad.from( src );
    var expected = [ 1, 2, 3 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `different type of long, ${ a.format }` );
  }

  /* */

  test.case = 'from empty vectorAdapter';
  var src = _.vad.make( 0 );
  var got = _.vad.from( src );
  test.identical( got.length, 0 );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'from filled vectorAdapter';
  var longSrc = [ 1, 2, 3 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.from( src );
  var expected = [ 1, 2, 3 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.from() );

  test.case = 'wrong type of src';
  let onError = ( err, arg ) => test.identical( _.strCount( err.message, /\s+Can't make VectorAdapter from/ ), 1 );
  test.shouldThrowErrorSync( () => _.vad.from( false ), onError );
  test.shouldThrowErrorSync( () => _.vad.from( 5 ), onError );
}

//

function fromLong( test )
{
  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {
    test.open( `different type of long, ${ a.format }` );

    test.case = 'from empty long';
    var src = a.longMake( [] );
    var got = _.vad.fromLong( src );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.case = 'from filled long';
    var src = a.longMake([ 1, 2, 3 ]);
    var got = _.vad.fromLong( src );
    var expected = [ 1, 2, 3 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `different type of long, ${ a.format }` );
  }

  /* */

  test.case = 'from empty vectorAdapter';
  var src = _.vad.make( 0 );
  var got = _.vad.fromLong( src );
  test.identical( got.length, 0 );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'from filled vectorAdapter';
  var longSrc = [ 1, 2, 3 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLong( src );
  var expected = [ 1, 2, 3 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.fromLong() );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.fromLong( false ) );
  test.shouldThrowErrorSync( () => _.vad.fromLong( 5 ) );

}

//

function fromLongLrange( test )
{

  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {
    test.open( `from empty ${ a.format }` );

    test.case = 'offset is undefined, length is undefined';
    var src = a.longMake( [] );
    var got = _.vad.fromLongLrange( src );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length is undefined';
    var src = a.longMake( [] );
    var got = _.vad.fromLongLrange( src, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 0';
    var src = a.longMake( [] );
    var got = _.vad.fromLongLrange( src, 0, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `from empty ${ a.format }` );

    /* */

    test.open( `from filled ${ a.format }` );

    test.case = 'offset is undefined, length is undefined';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src );
    var expected = [ 1, 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length is undefined';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 0 );
    var expected = [ 1, 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 0, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 0, 1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 5';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 0, 5 );
    var expected = [ 1, 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length is undefined';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 1 );
    var expected = [ 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 1, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 1';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 1, 1 );
    var expected = [ 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 4';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 1, 4 );
    var expected = [ 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 2, length = 2';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 2, 2 );
    var expected = [ 3, -4 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 4, length is undefined';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 4 );
    var expected = [ -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 4, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 4, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 4, length = 1';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 4, 1 );
    var expected = [ -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 5, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, 5, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `from filled ${ a.format }` );

    /* */

    test.case = `from empty ${ a.format }, offset and length passed as range, offset = 0, length = 0`;
    var src = a.longMake( [] );
    var got = _.vad.fromLongLrange( src, [ 0, 0 ] );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.open( `from filled ${ a.format }, offset and length passed as range` );

    test.case = 'offset = 0, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 0, 0 ] );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 0, 1 ] );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 5';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 0, 5 ] );
    var expected = [ 1, 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 1, 0 ] );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 1';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 1, 1 ] );
    var expected = [ 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 4';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 1, 4 ] );
    var expected = [ 2, 3, -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 2, length = 2';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 2, 2 ] );
    var expected = [ 3, -4 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 4, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 4, 0 ] );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 4, length = 1';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 4, 1 ] );
    var expected = [ -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 5, length = 0';
    var src = a.longMake([ 1, 2, 3, -4, -5 ]);
    var got = _.vad.fromLongLrange( src, [ 5, 0 ] );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `from filled ${ a.format }, offset and length passed as range` );
  }

  /* */

  test.open( 'from empty vectorAdapter' );

  test.case = 'offset is undefined, length is undefined';
  var longSrc = [];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length is undefined';
  var longSrc = [];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 0 );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length = 0';
  var longSrc = [];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 0, 0 );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.close( 'from empty vectorAdapter' );

  /* */

  test.open( 'from filled vectorAdapter' );

  test.case = 'offset is undefined, length is undefined';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src );
  var expected = [ 1, 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length is undefined';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 0 );
  var expected = [ 1, 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 0, 0 );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length = 1';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 0, 1 );
  var expected = [ 1 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length = 5';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 0, 5 );
  var expected = [ 1, 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length is undefined';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 1 );
  var expected = [ 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 1, 0 );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length = 1';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 1, 1 );
  var expected = [ 2 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length = 4';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 1, 4 );
  var expected = [ 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 2, length = 2';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 2, 2 );
  var expected = [ 3, -4 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 4, length is undefined';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 4 );
  var expected = [ -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 4, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 4, 0 );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 4, length = 1';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 4, 1 );
  var expected = [ -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 5, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, 4, 0 );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.close( 'from filled vectorAdapter' );

  /* */

  test.case = 'from empty vectorAdapter, offset and length passed as range, offset = 0, length = 0';
  var src = _.vad.make( 0 );
  var got = _.vad.fromLongLrange( src, [ 0, 0 ] );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  /* */

  test.open( 'from filled vectorAdapter, offset and length passed as range' );

  test.case = 'offset = 0, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 0, 0 ] );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length = 1';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 0, 1 ] );
  var expected = [ 1 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 0, length = 5';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 0, 5 ] );
  var expected = [ 1, 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 1, 0 ] );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length = 1';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 1, 1 ] );
  var expected = [ 2 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 1, length = 5';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 1, 4 ] );
  var expected = [ 2, 3, -4, -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 2, length = 2';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 2, 2 ] );
  var expected = [ 3, -4 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 4, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 4, 0 ] );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 4, length = 1';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 4, 1 ] );
  var expected = [ -5 ];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.case = 'offset = 5, length = 0';
  var longSrc = [ 1, 2, 3, -4, -5 ];
  var src = _.vad.make( longSrc.length );
  for( let i = 0 ; i < longSrc.length ; i++ )
  src.eSet( i, longSrc[ i ] );
  var got = _.vad.fromLongLrange( src, [ 5, 0 ] );
  var expected = [];
  for( let i = 0 ; i < expected.length ; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.identical( got.length, expected.length );
  test.true( got._vectorBuffer === src._vectorBuffer );

  test.close( 'from filled vectorAdapter, offset and length passed as range' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange() );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( null, 0, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( 5, 0, 1 ) );

  test.case = 'wrong type of offset|range';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2 ], [ 1, 2, 3 ], 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2 ], false, 1 ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2 ], [ 0, 1 ], [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2 ], 0, false ) );

  test.case = 'negative offset';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], -1, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], [ -1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], [ -1, 2 ], 1 ) );

  test.case = 'negative length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], 1, -1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], [ 1, -2 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], [ 1, -2 ], 1 ) );

  test.case = 'offset+length > srcLong.length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], 0, 5 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], 2, 3 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrange( [ 1, 2, 3, 4 ], 4, 1 ) );

}

//

function fromLongLrangeAndStride( test )
{
  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {

    test.open( `one-element ${ a.format }` );

    test.case = 'offset = 0, length = 0, stride = 0';
    var src = a.longMake([ 1 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 0, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = 1';
    var src = a.longMake([ 1 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 1, 1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = -1';
    var src = a.longMake([ 1 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 1, -1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `one-element ${ a.format }` );

    /* */

    test.open( `two-element ${ a.format }` );

    test.case = 'offset = 0, length = 0, stride = 0';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 0, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = 1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 0, 1 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = 2';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 0, 2 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
      test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = 1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 1, 1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = 2';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 1, 2 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 2, stride = 1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 2, 1 );
    var expected = [ 1, 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 1, stride = -1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 1, -1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0, stride = 0';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 0, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0, stride = 1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 0, 1 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0, stride = 2';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 0, 2 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0, stride = -2';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 0, 2 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
      test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 1, stride = 1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 1 );
    var expected = [ 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 1, stride = 2';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 2 );
    var expected = [ 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 1, stride = -1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, -1 );
    var expected = [ 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 2, stride = -1';
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, -1 );
    var expected = [ 2, 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `two-element ${ a.format }` );

    /* */

    test.open( `filled ${ a.format }, offset = 0, length = 2, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 2, 0 );
    var expected = [ 0, 0 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 2, 1 );
    var expected = [ 0, 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 2, 2 );
    var expected = [ 0, 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 7';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 2, 7 );
    var expected = [ 0, 7 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 0, length = 2, positive stride` );

    /* */

    test.open( `filled ${ a.format }, offset = 0, length = 3, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 3, 0 );
    var expected = [ 0, 0, 0 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 3, 1 );
    var expected = [ 0, 1, 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 3, 2 );
    var expected = [ 0, 2, -4 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 3';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 3, 3 );
    var expected = [ 0, 3, -6 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 0, length = 3, positive stride` );

    test.open( `filled ${ a.format }, offset = 0, length = 8, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 8, 0 );
    var expected = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 0, 8, 1 );
    var expected = [ 0, 1, 2, 3, -4, -5, -6, 7 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );


    test.close( `filled ${ a.format }, offset = 0, length = 8, positive stride` );

    /* */

    test.case = 'offset = 1, length = 0, stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 0, 0 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 1, length = 0, stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 0, -1 );
    var expected = [];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.open( `filled ${ a.format }, offset = 1, length = 1, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 0 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 2 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 3';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 3 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 8';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, 8 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 1, length = 1, positive stride` );

    /* */

    test.open( `filled ${ a.format }, offset = 1, length = 1, negative stride` );

    test.case = 'stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, -1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = -2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 1, -2 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 1, length = 1, negative stride` );

    /* */

    test.open( `filled ${ a.format }, offset = 1, length = 2, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, 0 );
    var expected = [ 1, 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, 1 );
    var expected = [ 1, 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, 2 );
    var expected = [ 1, 3 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 3';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, 3 );
    var expected = [ 1, -4 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 6';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, 6 );
    var expected = [ 1, 7 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 1, length = 2, positive stride` );

    /* */

    test.case = 'offset = 1, length = 2, stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 2, -1 );
    var expected = [ 1, 0 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.open( `filled ${ a.format }, offset = 1, length = 3, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 3, 0 );
    var expected = [ 1, 1, 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 3, 1 );
    var expected = [ 1, 2, 3 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 3, 2 );
    var expected = [ 1, 3, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 1, length = 3, positive stride` );

    /* */

    test.open( `filled ${ a.format }, offset = 1, length = 7, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 7, 0 );
    var expected = [ 1, 1, 1, 1, 1, 1, 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 1, 7, 1 );
    var expected = [ 1, 2, 3, -4, -5, -6, 7 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 1, length = 7, positive stride` );

    /* */

    test.open( `filled ${ a.format }, offset = 4, length = 2, positive stride` );

    test.case = 'stride = 0';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 4, 2, 0 );
    var expected = [ -4, -4 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 4, 2, 1 );
    var expected = [ -4, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 4, 2, 2 );
    var expected = [ -4, -6 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 4, length = 2, positive stride` );

    test.open( `filled ${ a.format }, offset = 4, length = 2, negative stride` );

    test.case = 'stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 4, 2, -1 );
    var expected = [ -4, 3 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = -2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 4, 2, -2 );
    var expected = [ -4, 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 4, length = 2, negative stride` );

    /* */

    test.open( `filled ${ a.format }, offset = 7, length = 3, negative stride` );

    test.case = 'stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 7, 3, -1 );
    var expected = [ 7, -6, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'stride = -2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 7, 3, -2 );
    var expected = [ 7, -5, 3 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( `filled ${ a.format }, offset = 7, length = 3, negative stride` );

    /* */

    test.case = 'offset = src.length - 1, length = src.length, stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, 7, 8, -1 );
    var expected = [ 7, -6, -5, -4, 3, 2, 1, 0 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.open( 'offset and length passed as range' );

    test.case = 'offset = 3, length = 2, stride = 2';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, [ 3, 2 ], 2 );
    var expected = [ 3, -5 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 3, length = 3, stride = -1';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, [ 3, 3 ], -1 );
    var expected = [ 3, 2, 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = 'offset = 0, length = 3, stride = 3';
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongLrangeAndStride( src, [ 0, 3 ], 3 );
    var expected = [ 0, 3, -6 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.close( 'offset and length passed as range' );

  }

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride() );

  test.case = 'wrong arguments.length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], [ 1, 1 ], 1, 1 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( null, 0, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( 5, 0, 1 ) );

  test.case = 'wrong type of offset|range';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2 ], [ 1, 2, 3 ], 1, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2 ], false, 1, 1 ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2 ], [ 0, 1 ], [ 0, 1 ], 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2 ], 0, false, 1 ) );

  test.case = 'negative offset';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4 ], -1, 1, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4 ], [ -1, 2 ], 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4 ], [ -1, 2 ], 1 ) );

  test.case = 'negative length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4 ], 1, -1, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4 ], [ 1, -2 ], 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4 ], [ 1, -2 ], 1 ) );

  test.case = 'offset + ( length - 1 ) * stride >= 0';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 0, 2, -1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 1, 2, -2 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 2, 3, -2 ) );

  test.case = 'offset + ( length - 1 ) * stride < srcLong.length';
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 0, 2, 3 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 0, 3, 2 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongLrangeAndStride( [ 1, 2, 3 ], 1, 2, 2 ) );

}

//

function fromLongWithStride( test )
{
  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {

    test.case = `one-element ${ a.format }, stride = 1`;
    var src = a.longMake([ 1 ]);
    var got = _.vad.fromLongWithStride( src, 1 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.case = `two-element ${ a.format }, stride = 1`;
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongWithStride( src, 1 );
    var expected = [ 1, 2 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = `two-element ${ a.format }, stride = 2`;
    var src = a.longMake([ 1, 2 ]);
    var got = _.vad.fromLongWithStride( src, 2 );
    var expected = [ 1 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    /* */

    test.case = `filled ${ a.format }, stride = 1`;
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongWithStride( src, 1 );
    var expected = [ 0, 1, 2, 3, -4, -5, -6, 7 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = `filled ${ a.format }, stride = 2`;
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongWithStride( src, 2 );
    var expected = [ 0, 2, -4, -6 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = `filled ${ a.format }, stride = 3`;
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongWithStride( src, 3 );
    var expected = [ 0, 3, -6 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = `filled ${ a.format }, stride = 6`;
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongWithStride( src, 6 );
    var expected = [ 0, -6 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = `filled ${ a.format }, stride = 7`;
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongWithStride( src, 7 );
    var expected = [ 0, 7 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

    test.case = `filled ${ a.format }, stride = 10`;
    var src = a.longMake([ 0, 1, 2, 3, -4, -5, -6, 7 ]);
    var got = _.vad.fromLongWithStride( src, 10 );
    var expected = [ 0 ];
    for( let i = 0 ; i < expected.length ; i++ )
    test.identical( got.eGet( i ), expected[ i ] );
    test.identical( got.length, expected.length );
    test.true( got._vectorBuffer === src );

  }

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride() );

  test.case = 'wrong arguments.length';
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2, 3 ], 1, 1 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( null, 1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( 5, 1 ) );

  test.case = 'wrong type of stride';
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2 ], [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2 ], null ) );

  test.case = 'negative stride';
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2, 3, 4 ], -1 ) );
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2, 3, 4 ], -2 ) );

  test.case = 'zero stride';
  test.shouldThrowErrorSync( () => _.vad.fromLongWithStride( [ 1, 2, 3, 4 ], 0 ) );

}

//

function updateLrange( test )
{
  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {
    test.open( `trivial ${ a.format }` );

    var src = a.longMake( [ 1, 2, 3 ] );
    var got = _.vad.fromLongLrange( src );

    test.case = 'single';
    _.vad.updateLrange( got, 0, 1 );
    test.identical( got.offset, 0 );
    test.identical( got.length, 1 );
    var expected = [ 1 ];
    test.equivalent( got.toLong(), expected );

    test.case = 'several';
    _.vad.updateLrange( got, 0, 2 );
    test.identical( got.offset, 0 );
    test.identical( got.length, 2 );
    var expected = [ 1, 2 ];
    test.equivalent( got.toLong(), expected );

    test.case = 'all';
    _.vad.updateLrange( got, 0, src.length );
    test.identical( got.offset, 0 );
    test.identical( got.length, src.length );
    var expected = src;
    test.equivalent( got.toLong(), expected );

    if( Config.debug )
    {
      test.shouldThrowErrorSync( () => _.vad.updateLrange( got, 1, src.length ) );
      test.shouldThrowErrorSync( () => _.vad.updateLrange( got, 1, src.length ) );
    }

    test.close( `trivial ${ a.format }` );

  }
}

// --
// is
// --

function vectorAdapterIs( test )
{

  test.case = '_.vectorAdapterIs( vad )';
  var vad = _.vad.from([ 1, 2, 3 ]);
  var got = _.vectorAdapterIs( vad );
  var exp = true;
  test.identical( got, exp );

  test.case = '_.vectorAdapterIs( number )';
  var got = _.vectorAdapterIs( 1 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'src - vectorAdapter, routine from';
  var src = _.vad.from( [ 1, 2, 3 ] );
  test.true( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLong';
  var src = _.vad.fromLong( [ 1, 2, 3 ] );
  test.true( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLongWithStride';
  var src = _.vad.fromLongWithStride( [ 1, -1, 2, -1, 3 ], 2 );
  test.true( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLongLrange';
  var src = _.vad.fromLongLrange( [ -1, 1, 2, 3, -1 ], 1, 3 );
  test.true( _.vectorAdapterIs( src ) );

  test.case = 'src - vectorAdapter, routine fromLongLrangeAndStride';
  var src = _.vad.fromLongLrangeAndStride( [ -1, 1, -1, 2, -1, 3, -1 ], 1, 3, 2 );
  test.true( _.vectorAdapterIs( src ) );

}

//

function vectorIs( test )
{

  test.case = '_.vectorIs( vad )';
  var vad = _.vad.from([ 1, 2, 3 ]);
  var got = _.vectorIs( vad );
  var exp = true;
  test.identical( got, exp );

  test.case = '_.vectorIs( number )';
  var got = _.vectorIs( 1 );
  var exp = false;
  test.identical( got, exp );

}

//

/* qqq : wrote similar test in module::wTools, emulating vad */
function longIs( test )
{

  test.case = 'vad';
  var got = _.longIs( _.vad.from([ 1, 2, 3 ]) );
  var exp = false;
  test.identical( got, exp );

  test.case = 'number';
  var got = _.longIs( 1 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'array';
  var got = _.longIs([ 1, 2, 3 ]);
  var exp = true;
  test.identical( got, exp );

}

//

function constructorIsVad( test )
{

  test.case = 'src - vectorAdapter constructor, routine from';
  var src = _.vad.from( [ 1, 2, 3 ] );
  test.true( _.constructorIsVad( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLong';
  var src = _.vad.fromLong( [ 1, 2, 3 ] );
  test.true( _.constructorIsVad( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLongWithStride';
  var src = _.vad.fromLongWithStride( [ 1, -1, 2, -1, 3 ], 2 );
  test.true( _.constructorIsVad( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLongLrange';
  var src = _.vad.fromLongLrange( [ -1, 1, 2, 3, -1 ], 1, 3 );
  test.true( _.constructorIsVad( src.constructor ) );

  test.case = 'src - vectorAdapter constructor, routine fromLongLrangeAndStride';
  var src = _.vad.fromLongLrangeAndStride( [ -1, 1, -1, 2, -1, 3, -1 ], 1, 3, 2 );
  test.true( _.constructorIsVad( src.constructor ) );

}

// --
// tests
// --

function assign( test )
{
  _.vectorAdapter.contextsForTesting({ onEach : act1 });

  function act1( a )
  {
    test.open( `dst - vectorAdapter from ${a.format}` );

    test.case = 'dst - empty, without src';
    var dst = _.vectorAdapter.fromLong( a.longMake([]) );
    var got = dst.assign();
    var exp = _.vectorAdapter.fromLong( a.longMake([]) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several elements, src - arguments';
    var dst = _.vectorAdapter.fromLong( a.longMake([ 0, -1, 2 ]) );
    var got = dst.assign( -1, -2, 0 );
    var exp = _.vectorAdapter.fromLong( a.longMake( [ -1, -2, 0 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    /* */

    test.case = 'dst - empty, src - number';
    var dst = _.vectorAdapter.fromLong( a.longMake([]) );
    var src = 5;
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong( a.longMake([]) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several elements, src - number';
    var dst = _.vectorAdapter.fromLong( a.longMake([ 0, -1, 2 ]) );
    var src = 5;
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong( a.longMake([ 5, 5, 5 ]) );
    test.identical( got, exp );
    test.true( got === dst );

    test.close( `dst - vectorAdapter from ${a.format}` );
  }

  /* - */

  _.vectorAdapter.contextsForTesting({ onEach : act2 });

  function act2( a )
  {
    test.open( `src - vectorAdapter, ${a.format} ${a.form}` );

    test.case = 'dst - empty, src - empty';
    var dst = _.vectorAdapter.fromLong([]);
    var src = a.vadMake([]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([]);
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several arguments, src.length === dst.length';
    var dst = _.vectorAdapter.fromLong([ 0, -1, 2 ]);
    var src = a.vadMake([ 3, -2, -4 ]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([ 3, -2, -4 ]);
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several arguments, src.length < dst.length';
    var dst = _.vectorAdapter.fromLong([ 0, -1, 2, 3, 3 ]);
    var src = a.vadMake([ 3, -2, -4 ]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([ 3, -2, -4, 0, 0 ]);
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several arguments, src.length > dst.length';
    var dst = _.vectorAdapter.fromLong([ 0, -1, 2 ]);
    var src = a.vadMake([ 3, -2, -4, 3, 5 ]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([ 3, -2, -4 ]);
    test.identical( got, exp );
    test.true( got === dst );

    test.close( `src - vectorAdapter, ${a.format} ${a.form}` );

    /* - */

    test.open( `src - long, ${a.format}` );

    test.case = 'dst - empty, src - empty';
    var dst = _.vectorAdapter.fromLong([]);
    var src = a.longMake([]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([]);
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several arguments, src.length === dst.length';
    var dst = _.vectorAdapter.fromLong([ 0, -1, 2 ]);
    var src = a.longMake([ 3, -2, -4 ]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([ 3, -2, -4 ]);
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several arguments, src.length < dst.length';
    var dst = _.vectorAdapter.fromLong([ 0, -1, 2, 3, 3 ]);
    var src = a.longMake([ 3, -2, -4 ]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([ 3, -2, -4, 0, 0 ]);
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - several arguments, src.length > dst.length';
    var dst = _.vectorAdapter.fromLong([ 0, -1, 2 ]);
    var src = a.longMake([ 3, -2, -4, 3, 5 ]);
    var got = dst.assign( src );
    var exp = _.vectorAdapter.fromLong([ 3, -2, -4 ]);
    test.identical( got, exp );
    test.true( got === dst );

    test.close( `src - long, ${a.format}` );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'not empty dst assigns no arguments';
  var dst = _.vectorAdapter.fromLong([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => dst.assign() );

  test.case = 'not enough arguments';
  var dst = _.vectorAdapter.fromLong([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => dst.assign( 0, 0 ) );

  test.case = 'wrong type of src';
  var dst = _.vectorAdapter.fromLong([ 1, 2, 3 ]);
  test.shouldThrowErrorSync( () => dst.assign( { a : 1, b : 2, c : 3 } ) );
}

//

function assignScalar( test )
{

  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {

    test.case = `${a.format} ${a.form} - routine`;
    var v1 = a.vadMake([ 2, 3, 4 ]);
    var got = _.vectorAdapter.assignScalar( v1, 1 );
    var exp = a.vadMake([ 1, 1, 1 ]);
    test.identical( got, exp );
    test.true( got === v1 );

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.vectorAdapter.assignScalar( null, 1 ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter.assignScalar( a.vadMake([ 1, 2 ]), null ) );

  }

}

function addVectorScalar( test )
{

  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {

    test.case = `${a.format} ${a.form} - routine`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = a.vadMake([ 2, 3, 4 ]);
    var got = _.vectorAdapter.addVectorScalar( v1, v2, 0 );
    var exp = a.vadMake([ 2, 3, 4 ]);
    test.identical( got, exp );
    test.true( got === v1 );

    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = a.vadMake([ 2, 3, 4 ]);
    var got = _.vectorAdapter.addVectorScalar( v1, v2, 1 );
    var exp = a.vadMake([ 3, 4, 5 ]);
    test.identical( got, exp );
    test.true( got === v1 );

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.vectorAdapter.addVectorScalar( null, a.vadMake([ 1 ]), 1 ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter.addVectorScalar( a.vadMake([ 1, 2 ]), a.vadMake([ 1 ]), 1 ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter.addVectorScalar( a.vadMake([ 1, 2 ]), a.vadMake([ 1, 2 ]), null ) );

  }

}

//

function growAdapter( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.case = 'src - empty vectorAdapter, without cinterval and val';
    var src = _.vad.fromLong( a.longMake( [] ) );
    var got = _.vad.growAdapter( src );
    var exp = _.vad.fromLong( a.longMake( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* - */

    test.open( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - empty` );

    test.case = 'cinterval - [ 0, 0 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 0, 0 ] );
    var exp = a.vadMake( [ 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 2 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 0, 2 ] );
    var exp = a.vadMake( [ 0, 0, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, -2 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 0, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 2 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 2, 2 ] );
    var exp = a.vadMake( [ 0, 0, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 4 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 2, 4 ] );
    var exp = a.vadMake( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, -2 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 2, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -2 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ -2, -2 ] );
    var exp = a.vadMake( [ 0, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, 0 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ -2, 0 ] );
    var exp = a.vadMake( [ 0, 0, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -4 ], no val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ -2, -4 ] );
    var exp = a.vadMake( [ 0, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - empty` );

    /* - */

    test.open( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - empty` );

    test.case = 'cinterval - [ 0, 0 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 0, 0 ], 7 );
    var exp = a.vadMake( [ 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 2 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 0, 2 ], 7 );
    var exp = a.vadMake( [ 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, -2 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 0, -2 ], 7 );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 2 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 2, 2 ], 7 );
    var exp = a.vadMake( [ 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 4 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 2, 4 ], 7 );
    var exp = a.vadMake( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, -2 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ 2, -2 ], 7 );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -2 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ -2, -2 ], 7 );
    var exp = a.vadMake( [ 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, 0 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ -2, 0 ], 7 );
    var exp = a.vadMake( [ 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -4 ], with val';
    var src = a.vadMake( [] );
    var got = _.vad.growAdapter( src, [ -2, -4 ], 7 );
    var exp = a.vadMake( [ 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - empty` );

    /* - */

    test.case = 'src - filled vectorAdapter, without cinterval and val';
    var src = _.vad.fromLong( a.vadMake( [ 1, -2, 3, -5 ] ) );
    var got = _.vad.growAdapter( src );
    var exp = _.vad.fromLong( a.vadMake( [ 1, -2, 3, -5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* - */

    test.open( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - filled` );

    test.case = 'cinterval - [ 0, 0 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 0, 0 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 2 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 0, 2 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, -2 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 0, -2 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 2 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 2, 2 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 4 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 2, 4 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, -2 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 2, -2 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -2 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ -2, -2 ] );
    var exp = a.vadMake( [ 0, 0, 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, 0 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ -2, 4 ] );
    var exp = a.vadMake( [ 0, 0, 1, -2, 3, -5, 0 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -4 ], no val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ -2, -4 ] );
    var exp = a.vadMake( [ 0, 0, 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - filled` );

    /* - */

    test.open( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - filled` );

    test.case = 'cinterval - [ 0, 0 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 0, 0 ], 7 );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 2 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 0, 2 ], 7 );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, -2 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 0, -2 ], 7 );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 2 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 2, 2 ], 7 );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 4 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 2, 4 ], 7 );
    var exp = a.vadMake( [ 1, -2, 3, -5, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, -2 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ 2, -2 ], 7 );
    var exp = a.vadMake( [ 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -2 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ -2, -2 ], 7 );
    var exp = a.vadMake( [ 7, 7, 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, 0 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ -2, 4 ], 7 );
    var exp = a.vadMake( [ 7, 7, 1, -2, 3, -5, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -4 ], with val';
    var src = a.vadMake( [ 1, -2, 3, -5 ] );
    var got = _.vad.growAdapter( src, [ -2, -4 ], 7 );
    var exp = a.vadMake( [ 7, 7, 1, -2, 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( `different type of vectorAdapter, ${ a.format } ${ a.form }, src - filled` );

  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.growAdapter() );

  test.case = 'wrong src';
  test.shouldThrowErrorSync( () => _.vad.growAdapter( 5, [ 1, 2 ] ) );

  test.case = 'extra arguments';
  var src = _.vad.fromLong( [ 1, 2, 3 ] )
  test.shouldThrowErrorSync( () => src.growAdapter( [ 1, 4 ], 2, 3 ) );

}

//

function growLong( test )
{

  test.case = 'src - filled vectorAdapter, cinterval - [ -2, 0 ], with val';
  var src = _.vad.fromLong( [ 1, -2, 3, -5 ] );
  var got = _.vad.growLong( src, [ -2, 4 ], 7 );
  var exp = [ 7, 7, 1, -2, 3, -5, 7 ];
  test.identical( got, exp );
  test.true( got !== src );

}

//

function onlyAdapter_( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `different type of vectorAdapter, ${ a.format }, src - empty` );

    test.case = 'without cinterval';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    /* - */

    test.case = 'cinterval - [ 0, 0 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ 0, 0 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 2 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ 0, 2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, -2 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ 0, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 2 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ 2, 2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 4 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ 2, 4 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, -2 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ 2, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -2 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ -2, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, 0 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ -2, 0 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -2, -4 ]';
    var src = a.vadMake( [] );
    var got = _.vad.onlyAdapter_( src, [ -2, -4 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( `different type of vectorAdapter, ${ a.format }, src - empty` );

    /* - */

    test.open( `different type of vectorAdapter, ${ a.format }, src - filled vector` );

    test.case = 'without cinterval';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src );
    var exp = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, -4 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, -4 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, -2 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, -1 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, -2 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, 0 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, 0 ] );
    var exp = a.vadMake( [ 1 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, 2 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, 2 ] );
    var exp = a.vadMake( [ 1, -2, 3 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, 4 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, 4 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ -4, 7 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ -4, 7 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 0 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 0, 0 ] );
    var exp = a.vadMake( [ 1 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 2 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 0, 2 ] );
    var exp = a.vadMake( [ 1, -2, 3 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 4 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 0, 4 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 0, 7 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 0, 7 ] );
    var exp = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 2 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 2, 2 ] );
    var exp = a.vadMake( [ 3 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 3 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 2, 3 ] );
    var exp = a.vadMake( [ 3, -5 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 4 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 2, 4 ] );
    var exp = a.vadMake( [ 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 7 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 2, 7 ] );
    var exp = a.vadMake( [ 3, -5, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 4, 4 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 4, 4 ] );
    var exp = a.vadMake( [ 8 ] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 5, 7 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 5, 7 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 7, 7 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 7, 7 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 7, 9 ]';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 7, 9 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 9, 7 ], wrong range direction';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 9, 7 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 9, 4 ], wrong range direction';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 9, 4 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 9, 0 ], wrong range direction';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 9, 0 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 9, -4 ], wrong range direction';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 9, -4 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, 0 ], wrong range direction';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 2, 0 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - [ 2, -4 ], wrong range direction';
    var src = a.vadMake( [ 1, -2, 3, -5, 8 ] );
    var got = _.vad.onlyAdapter_( src, [ 2, -4 ] );
    var exp = a.vadMake( [] );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( `different type of vectorAdapter, ${ a.format }, src - filled vector` );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.onlyAdapter_() );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.onlyAdapter_( 2, _.vad.from( [ 1, 4 ] ) ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.vad.onlyAdapter_( _.vad.from( [ 1, 2, 3 ] ), [ 1, 4 ], 2 ) );

}

//

function onlyLong_( test )
{

  test.case = 'src - filled vectorAdapter, cinterval - [ 2, 4 ]';
  var src = _.vad.fromLong( [ 1, -2, 3, -5, 8 ] );
  var got = _.vad.onlyLong_( src, [ 2, 4 ] );
  var exp = [ 3, -5, 8 ];
  test.identical( got, exp );
  test.true( got !== src );

}

// --
// exporter
// --

function to( test )
{

  /* */

  test.case = 'vector to array';

  var v = _.vad.from([ 1, 2, 3 ]);
  var got = v.to( [].constructor );
  var expected = [ 1, 2, 3 ];
  test.identical( got, expected );

  /* */

  test.case = 'vector to vector';

  var v = _.vad.from([ 1, 2, 3 ]);
  var got = v.to( _.vad.fromLong( [] ).constructor );
  test.true( got === v );

  /* */

  test.case = 'bad arguments';

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to() );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( [], 1 ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( 1 ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( null ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( '1' ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( [], 1 ) );

}

//

function toLong( test )
{

  /* */

  test.case = 'trivial';
  var v = _.vad.from([ 1, 2, 3 ]);
  var got = v.toLong();
  var expected = [ 1, 2, 3 ];
  test.identical( got, expected );
  test.true( v._vectorBuffer === got );

  /* */

  test.case = 'trivial with fromLongLrangeAndStride';
  var v = _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4, 5 ], 0, 5, 1 );
  var got = v.toLong();
  var expected = [ 1, 2, 3, 4, 5 ];
  test.identical( got, expected );
  test.true( v._vectorBuffer === got );

  /* */

  test.case = 'with custom offset';
  var v = _.vad.fromLongLrange( [ 1, 2, 3, 4, 5 ], 1 );
  var got = v.toLong();
  var expected = [ 2, 3, 4, 5 ];
  test.identical( got, expected );
  test.true( v._vectorBuffer !== got );

  /* */

  test.case = 'with custom length';
  var v = _.vad.fromLongLrange( [ 1, 2, 3, 4, 5 ], 0, 4 );
  var got = v.toLong();
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.true( v._vectorBuffer !== got );

  /* */

  test.case = 'with fromLongLrangeAndStride';
  var v = _.vad.fromLongLrangeAndStride( [ 1, 2, 3, 4, 5 ], 1, 2, 2 );
  var got = v.toLong();
  var expected = [ 2, 4 ];
  test.identical( got, expected );
  test.true( v._vectorBuffer !== got );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( 0 ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( undefined ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( null ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( _.vectorAdapter.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( '123' ) );
  test.shouldThrowErrorSync( () => _.vad.from([ 1, 2, 3 ]).to( function( a, b, c ){} ) );

}

//

function toStr( test )
{

  _.vectorAdapter.contextsForTesting
  ({
    onEach : arrayAct,
    varyingFormat : 'Array',
  });

  _.vectorAdapter.contextsForTesting
  ({
    onEach : i16xAct,
    varyingFormat : 'I16x',
  });

  function arrayAct( a )
  {

    /* */

    test.case = `${a.format} ${a.form} empty`;
    var vad1 = a.vadMake([]);
    var exp = 'VectorAdapter.x0.Array :: ';
    var got = vad1.toStr();
    test.identical( got, exp );
    var got = _.vad.toStr( vad1 );
    test.identical( got, exp );
    var got = _.vector.toStr( vad1 );
    test.identical( got, exp );
    var exp = '[]';
    var got = _.vector.toStr( a.longMake([]) );
    test.identical( got, exp );

    /* */

    test.case = `${a.format} ${a.form} non empty`;
    var vad1 = a.vadMake([ 1, 2, 3 ]);
    var exp = 'VectorAdapter.x3.Array :: 1.000 2.000 3.000';
    var got = vad1.toStr();
    test.identical( got, exp );
    var got = _.vad.toStr( vad1 );
    test.identical( got, exp );
    var got = _.vector.toStr( vad1 );
    test.identical( got, exp );
    var exp = '[ 1, 2, 3 ]';
    var got = _.vector.toStr( a.longMake([ 1, 2, 3 ]) );
    test.identical( got, exp );

    /* */

  }

  function i16xAct( a )
  {

    /* */

    test.case = `${a.format} ${a.form} empty`;
    var vad1 = a.vadMake([]);
    var exp = 'VectorAdapter.x0.I16x :: ';
    var got = vad1.toStr();
    test.identical( got, exp );
    var got = _.vad.toStr( vad1 );
    test.identical( got, exp );
    var got = _.vector.toStr( vad1 );
    test.identical( got, exp );
    var exp = '( new Int16Array([  ]) )';
    var got = _.vector.toStr( a.longMake([]) );
    test.identical( got, exp );

    /* */

    test.case = `${a.format} ${a.form} non empty`;
    var vad1 = a.vadMake([ 1, 2, 3 ]);
    var exp = 'VectorAdapter.x3.I16x :: 1.000 2.000 3.000';
    var got = vad1.toStr();
    test.identical( got, exp );
    var got = _.vad.toStr( vad1 );
    test.identical( got, exp );
    var got = _.vector.toStr( vad1 );
    test.identical( got, exp );
    var exp = '( new Int16Array([ 1, 2, 3 ]) )';
    var got = _.vector.toStr( a.longMake([ 1, 2, 3 ]) );
    test.identical( got, exp );

    /* */

  }

}

//

function toStrStandard( test )
{

  test.case = 'String( vad ) - empty';
  var vad = _.vad.from([]);
  var got = String( vad );
  var exp = 'VectorAdapter.x0.Array :: ';
  test.identical( got, exp );

  test.case = 'String( vad )';
  var vad = _.vad.from([ 1, 2, 3 ]);
  var got = String( vad );
  var exp = 'VectorAdapter.x3.Array :: 1.000 2.000 3.000';
  test.identical( got, exp );

  test.case = 'Object.prototype.toString';
  var vad = _.vad.from([ 1, 2, 3 ]);
  var got = Object.prototype.toString.call( vad );
  var exp = '[object VectorAdapter]';
  test.identical( got, exp );

}

// --
// compare
// --

function entityDiff( test )
{

  test.case = 'trivial';

  let v1 = _.vad.from([ 1, 2, 3 ]);
  let v2 = _.vad.from([ 1, 2, 4 ]);

  let diff = _.entityDiff( v1, v2 );
  let expected =
`
- src1 :
  VectorAdapter.x3.Array :: 1.000 2.000 3.000
- src2 :
  VectorAdapter.x3.Array :: 1.000 2.000 4.000
- difference :
  VectorAdapter.x3.Array :: 1.000 2.000 *
`

  console.log( diff );

  test.identical.apply( test, _.str.lines.strip( diff, expected ) );
  test.notIdentical( v1, v2 );

}

//

function compare( test )
{

  /* */

  test.case = 'src1:vad nonempty src2:vad empty - not equivalent';
  var src1 = _.vectorAdapter.fromLong([ 1, 2, 3 ]);
  var src2 = _.vectorAdapter.fromLong([]);
  test.identical( _.equivalent( src1, src2 ), false );
  test.identical( _.equivalent( src2, src1 ), false );
  test.identical( _.identical( src1, src2 ), false );
  test.identical( _.identical( src2, src1 ), false );
  test.neq( src1, src2 );
  test.neq( src2, src1 );
  test.nil( src1, src2 );
  test.nil( src2, src1 );

  /* */

  test.case = 'src1:vad src2:int - not equivalent';
  var src1 = _.vectorAdapter.fromLong( new I32x([ 1, 3, 5 ]) );
  var src2 = 1;
  test.identical( _.equivalent( src1, src2 ), false );
  test.identical( _.equivalent( src2, src1 ), false );
  test.identical( _.identical( src1, src2 ), false );
  test.identical( _.identical( src2, src1 ), false );
  test.neq( src1, src2 );
  test.neq( src2, src1 );
  test.nil( src1, src2 );
  test.nil( src2, src1 );

  /* */

  test.case = 'src1:vad-linterval-stride-i32 src2:vad-i32 - identical';
  var src1 = _.vectorAdapter.fromLongLrangeAndStride( new I32x([ 0, 1, 2, 3, 4, 5, 6 ]), [ 1, 3 ], 2 );
  var src2 = _.vectorAdapter.fromLong( new I32x([ 1, 3, 5 ]) );
  test.identical( _.equivalent( src1, src2 ), true );
  test.identical( _.equivalent( src2, src1 ), true );
  test.identical( _.identical( src1, src2 ), true );
  test.identical( _.identical( src2, src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  /* - */

  test.case = 'src1:vad-a-f32 src2:vad-a-f64 - not equivalent';
  var src1 = _.vectorAdapter.from( new F32x([ 1, 3, 5 ]) );
  var src2 = _.vectorAdapter.from( new F64x([ 1, 3, 5 ]) );
  test.identical( _.equivalent( src1, src2 ), true );
  test.identical( _.equivalent( src2, src1 ), true );
  debugger;
  _global_.debugger = 1;
  test.identical( _.identical( src1, src2 ), false );
  debugger;
  test.identical( _.identical( src2, src1 ), false );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.nil( src1, src2 );
  test.nil( src2, src1 );

  /* - */

  test.case = 'src1:vad-a-arr src2:vad-a-arr - identical';
  var src1 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var src2 = _.vectorAdapter.from([ 1, 3, 5 ]);
  test.identical( _.equivalent( src1, src2 ), true );
  test.identical( _.equivalent( src2, src1 ), true );
  test.identical( _.identical( src1, src2 ), true );
  test.identical( _.identical( src2, src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  /* */

  test.case = 'src1:vad-a-arr src2:vad-a-arr - identical';
  var src1 = _.avector.make( [ true, true, true ] );
  var src2 = _.avector.make( [ true, true, true ] );
  test.identical( _.equivalent( src1, src2 ), true );
  test.identical( _.equivalent( src2, src1 ), true );
  test.identical( _.identical( src1, src2 ), true );
  test.identical( _.identical( src2, src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  /* - */

  test.case = 'src1:vad-a-arr src2:vad-a-arr - not equivalent';
  var src1 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var src2 = _.vectorAdapter.from([ 1, 3, 6 ]);
  test.identical( _.equivalent( src1, src2 ), false );
  test.identical( _.equivalent( src2, src1 ), false );
  test.identical( _.identical( src1, src2 ), false );
  test.identical( _.identical( src2, src1 ), false );
  test.neq( src1, src2 );
  test.neq( src2, src1 );
  test.nil( src1, src2 );
  test.nil( src2, src1 );

  /* - */

  test.case = 'src1:vad-a-arr src2:vad-ls-arr';
  var src1 = _.vectorAdapter.from([ 1, 3, 5 ]);
  var src2 = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 3 ], 2 );
  test.identical( _.equivalent( src1, src2 ), true );
  test.identical( _.equivalent( src2, src1 ), true );
  test.identical( _.identical( src1, src2 ), true );
  test.identical( _.identical( src2, src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  /* - */

  test.case = 'src1:vad-arr src2:long-arr';
  var long = [ 1, 3, 5 ];
  var vad = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 3 ], 2 );
  test.identical( _.equivalent( vad, long ), true );
  test.identical( _.equivalent( long, vad ), true );
  test.identical( _.identical( vad, long ), false );
  test.identical( _.identical( long, vad ), false );
  test.equivalent( vad, long );
  test.equivalent( long, vad );
  test.nil( vad, long );
  test.nil( long, vad );

  /* */

  test.case = 'src1:long-arr src2:vad-arr';
  var long = [ 1, 3, 5 ];
  var vad = _.vectorAdapter.fromLongLrangeAndStride( [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ], [ 1, 3 ], 2 );
  test.identical( _.equivalent( vad, long ), true );
  test.identical( _.equivalent( long, vad ), true );
  test.identical( _.identical( vad, long ), false );
  test.identical( _.identical( long, vad ), false );
  test.equivalent( vad, long );
  test.equivalent( long, vad );
  test.nil( vad, long );
  test.nil( long, vad );

  /* - */

  test.case = 'src1:vad-f32 src2:long-i16';
  var long = new I16x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new F32x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  test.identical( _.equivalent( vad, long ), true );
  test.identical( _.equivalent( long, vad ), true );
  test.identical( _.identical( vad, long ), false );
  test.identical( _.identical( long, vad ), false );
  test.equivalent( vad, long );
  test.equivalent( long, vad );
  test.nil( vad, long );
  test.nil( long, vad );

  /* */

  test.case = 'src1:long-i16 src2:vad-f32';
  var long = new I16x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new F32x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  test.identical( _.equivalent( vad, long ), true );
  test.identical( _.equivalent( long, vad ), true );
  test.identical( _.identical( vad, long ), false );
  test.identical( _.identical( long, vad ), false );
  test.equivalent( vad, long );
  test.equivalent( long, vad );
  test.nil( vad, long );
  test.nil( long, vad );

  /* - */

  test.case = 'src1:vad-i16 src2:long-f32';
  var long = new F32x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new I16x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  test.identical( _.equivalent( vad, long ), true );
  test.identical( _.equivalent( long, vad ), true );
  test.identical( _.identical( vad, long ), false );
  test.identical( _.identical( long, vad ), false );
  test.equivalent( vad, long );
  test.equivalent( long, vad );
  test.nil( vad, long );
  test.nil( long, vad );

  /* */

  test.case = 'src1:long-f32 src2:vad-i16';
  var long = new F32x([ 1, 3, 5 ]);
  var vad = _.vectorAdapter.fromLongLrangeAndStride( new I16x([ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]), [ 1, 3 ], 2 );
  test.identical( _.equivalent( vad, long ), true );
  test.identical( _.equivalent( long, vad ), true );
  test.identical( _.identical( vad, long ), false );
  test.identical( _.identical( long, vad ), false );
  test.equivalent( vad, long );
  test.equivalent( long, vad );
  test.nil( vad, long );
  test.nil( long, vad );

  /* - */

}

// --
// operation
// --

// function experiment1( test )
// {
//
//   test.case = 'basic';
//   var dst = null;
//   var src = _.vad.from([ 1, 2, 3 ]);
//   debugger;
//   var got = _.vad.experiment1( dst, src );
//   debugger;
//   var exp = [ 1, 4, 9 ];
//   test.identical( got, exp );
//
//   // // debugger;
//   // // _.vad.experiment1( null, _.vad.from([ 1, 2, 3 ]), _.vad.from([ 3, 4, 5 ]) );
//   //
//   // test.case = 'throwing';
//   // test.shouldThrowErrorSync( () => _.vad.experiment1( null, _.vad.from([ 1, 2, 3 ]), _.vad.from([ 3, 4, 5 ]) ) );
//
// }

//

function add( test )
{

  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {

    test.case = `${a.format} ${a.form} - routine`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = a.vadMake([ 2, 3, 4 ]);
    var got = _.vectorAdapter.add( v1, v2 );
    var exp = a.vadMake([ 3, 5, 7 ]);
    test.identical( got, exp );
    test.true( got === v1 );

    test.case = `${a.format} ${a.form} - method`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = a.vadMake([ 2, 3, 4 ]);
    var got = v1.add( v2 );
    var exp = a.vadMake([ 3, 5, 7 ]);
    test.identical( got, exp );
    test.true( got === v1 );

    test.case = `${a.format} ${a.form} - F32x`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = new F32x([ 2, 3, 4 ]);
    var got = _.vectorAdapter.add( v1, v2 );
    var exp = a.vadMake([ 3, 5, 7 ]);
    test.identical( got, exp );
    test.true( got === v1 );

    test.case = `${a.format} ${a.form} - F32x - method`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = new F32x([ 2, 3, 4 ]);
    var got = v1.add( v2 );
    var exp = a.vadMake([ 3, 5, 7 ]);
    test.identical( got, exp );
    test.true( got === v1 );

  }

}

//

function subScaled( test )
{

  _.vectorAdapter.contextsForTesting({ onEach : act });

  function act( a )
  {

    test.case = `${a.format} ${a.form} routine`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = a.vadMake([ 3, 4, 5 ]);
    var scaler = 1 / 3;
    var got = _.vectorAdapter.subScaled( v1, v2, scaler );
    var exp = a.vadMake([ 0, 2 - 4/3, 3-5/3 ]);
    test.equivalent( got, exp );
    test.true( got === v1 );

    test.case = `${a.format} ${a.form} method`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = a.vadMake([ 3, 4, 5 ]);
    var scaler = 1 / 3;
    var got = v1.subScaled( v2, scaler );
    var exp = a.vadMake([ 0, 2 - 4/3, 3-5/3 ]);
    test.equivalent( got, exp );
    test.true( got === v1 );

    test.case = `${a.format} ${a.form} F32x routine`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = new F32x([ 3, 4, 5 ]);
    var scaler = 1 / 3;
    var got = _.vectorAdapter.subScaled( v1, v2, scaler );
    var exp = a.vadMake([ 0, 2 - 4/3, 3-5/3 ]);
    test.equivalent( got, exp );
    test.true( got === v1 );

    test.case = `${a.format} ${a.form} F32x method`;
    var v1 = a.vadMake([ 1, 2, 3 ]);
    var v2 = new F32x([ 3, 4, 5 ]);
    var scaler = 1 / 3;
    var got = v1.subScaled( v2, scaler );
    var exp = a.vadMake([ 0, 2 - 4/3, 3-5/3 ]);
    test.equivalent( got, exp );
    test.true( got === v1 );

    var v1 = a.vadMake([ 10, 20, 30 ]);
    var v2 = a.vadMake([ 1, 2, 3 ]);
    var got = _.vectorAdapter.subScaled( v1, v2, 2 );
    test.true( got === v1 );
    var exp = a.vadMake([ 8, 16, 24 ]);
    test.equivalent( got, exp );

  }

}

subScaled.accuracy = _.vectorAdapter.accuracy*10;

// --
// review
// --

function reviewSrcIsSimpleVector( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = makeLong( [] );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - 0';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got.toStr(), exp.toStr() );
    test.true( got !== src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = makeLong( [] );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = makeLong( [ 0, 1, 2, 3, 4, 5 ] );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vad.review() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.vad.review( [] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.vad.review( [], 0, 0 ) );

  test.case = 'cinterval - number, cinterval < 0';
  test.shouldThrowErrorSync( () => _.vad.review( [ 1, 2 ], -1 ) );

  test.case = 'cinterval - number, cinterval > src.length - 1';
  test.shouldThrowErrorSync( () => _.vad.review( [ 1, 2 ], 5 ) );

  test.case = 'cinterval[ 0 ] < 0';
  test.shouldThrowErrorSync( () => _.vad.review( [ 1, 2 ], [ -1, 1 ] ) );

  test.case = 'cinterval[ 1 ] > src.length - 1';
  test.shouldThrowErrorSync( () => _.vad.review( [ 1, 2 ], [ 0, 4 ] ) );

  test.case = 'cinterval[ 1 ] - cinterval[ 0 ] < -1';
  test.shouldThrowErrorSync( () => _.vad.review( [ 1, 2 ], [ 0, 4 ] ) );

  test.case = 'cinterval[ 1 ] - src.length';
  test.shouldThrowErrorSync( () => _.vad.review( [ 1, 2 ], [ 1, 2 ] ) );
}

//

function reviewSrcIsAdapterRoutineFrom( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.from( makeLong( [] ) );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.from( makeLong( [] ) );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromLong( makeLong( [] ) );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromLong( makeLong( [] ) );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromLong( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLongWithStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromLongWithStride( makeLong( [] ), 2 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 2, 4, 6, 8, 10 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 4, 6, 8, 10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromLongWithStride( makeLong( [] ), 2 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 2, 4, 6, 8, 10 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromLongWithStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLongLrange( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromLongLrange( makeLong( [] ), 0, 0 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 6 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromLongLrange( makeLong( [] ), 0, 0 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 6 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 0, 8 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 1, 8 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 6  );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromLongLrange( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ] ), 2, 8 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 1 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 2, 4, 6, 8, 10 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 4, 6, 8, 10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 6, 2 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 2, 4, 6, 8, 10 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 0, 8, 2 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 1, 6, 2 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 3, 5, 7 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2  );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromLongLrangeAndStride( makeLong( [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ] ), 2, 6, 2 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }
}

//

function reviewSrcIsAdapterRoutineFromNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [] ) ), 0 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [] ) ), 0 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }

    /* */

    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromNumber( 5, 0 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromNumber( 5, 0 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( _.long.default.make( [ 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromNumber( 5, 6 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
}

//

function reviewSrcIsAdapterRoutineFromMaybeNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [] ) ), 0 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [] ) ), 0 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromMaybeNumber( _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) ), 6 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) )
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval - 0';
    var src = _.vad.fromMaybeNumber( makeLong( [] ), 0 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval - 0';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, 0 );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval > 0 && cinterval < src.length - 1';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, 2 );
    var exp = _.vad.from( makeLong( [ 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval - src.length';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, 6 );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
    var src = _.vad.fromMaybeNumber( makeLong( [] ), 0 );
    var got = _.vad.review( src, [ 0, -1 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, [ 0, 5 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, [ 0, 3 ] );
    var exp = _.vad.from( makeLong( [ 0, 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, [ 1, 3 ] );
    var exp = _.vad.from( makeLong( [ 1, 2, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, [ 6, 5 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
    var src = _.vad.fromMaybeNumber( makeLong( [ 0, 1, 2, 3, 4, 5 ] ), 6 );
    var got = _.vad.review( src, [ 3, 2 ] );
    var exp = _.vad.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
  }

  /* */

  test.case = 'src - empty vector, cinterval - 0';
  var src = _.vad.fromMaybeNumber( 5, 0 );
  var got = _.vad.review( src, 0 );
  var exp = _.vad.from( _.long.default.make( [] ) );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'cinterval - 0';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, 0 );
  var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5, 5, 5 ] ) );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'cinterval > 0 && cinterval < src.length - 1';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, 2 );
  var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5 ] ) );
  test.identical( got, exp );
  test.true( got !== src );

  test.case = 'cinterval - src.length';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, 6 );
  var exp = _.vad.from( _.long.default.make( [] ) );
  test.identical( got, exp );
  test.true( got !== src );

  /* */

  test.case = 'src - empty vector, cinterval[ 0 ] and cinterval[ 1 ] - -1';
  var src = _.vad.fromMaybeNumber( 5, 0 );
  var got = _.vad.review( src, [ 0, -1 ] );
  var exp = _.vad.from( _.long.default.make( [] ) );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'cinterval[ 0 ] - 0, cinterval[ 1 ] - src.length';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, [ 0, 5 ] );
  var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5, 5, 5 ] ) );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'cinterval[ 0 ] - 0, cinterval < src.length';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, [ 0, 3 ] );
  var exp = _.vad.from( _.long.default.make( [ 5, 5, 5, 5 ] ) );
  test.identical( got, exp );
  test.true( got !== src );

  test.case = 'cinterval[ 0 ] > 0, cinterval < src.length';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, [ 1, 3 ] );
  var exp = _.vad.from( _.long.default.make( [ 5, 5, 5 ] ) );
  test.identical( got, exp );
  test.true( got !== src );

  test.case = 'cinterval[ 0 ] and cinterval[ 1 ] - src.length';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, [ 6, 5 ] );
  var exp = _.vad.from( _.long.default.make( [] ) );
  test.identical( got, exp );
  test.true( got !== src );

  test.case = 'cinterval[ 0 ] > cinterval[ 1 ]';
  var src = _.vad.fromMaybeNumber( 5, 6 );
  var got = _.vad.review( src, [ 3, 2 ] );
  var exp = _.vad.from( _.long.default.make( [] ) );
  test.identical( got, exp );
  test.true( got !== src );
}

// --
// iterator
// --

function mapDstIsNullRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLong( makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.map( dst );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.map( dst, undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.vectorAdapter.fromLong( makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.map( dst, null );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

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
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, null );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 1 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'dst - null' );
  }
}

//

function mapDstIsNullRoutineFromNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'from vectorAdapter' );

    /* - */

    test.open( 'from number' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 7, 7, 7, 7, 7 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 10, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 0, 0, 0, 0 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'from number' );
  }
}

//

function mapOnlyDstRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.map( undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.close( 'call by instance' );
  }
}

//

function mapOnlyDstRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.map( undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.map( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.close( 'call by instance' );
  }
}

//

function mapDstIsVectorRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -2, -3, -4, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -4, -6, -8, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -2, -3, -4, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.map( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -2, -3, -4, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -4, -6, -8, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -2, -3, -4, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by instance' );
  }
}

//

function mapDstIsVectorRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -3, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -6, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -3, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.map( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.map( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -3, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -6, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [ -1, -3, -5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by instance' );
  }
}

//

function mapDstIsVectorRoutineFromNumberWithVectorAdapter( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.open( 'call by namespace, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by namespace, src - from vectorAdapter' );

    /* - */

    test.open( 'call by instance, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.map( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.map( src, null );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by instance, src - from vectorAdapter' );
  }
}

//

function mapDstIsVectorRoutineFromNumberWithNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.open( 'call by namespace, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.map( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, null );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -8, -9, -10, -11, -12 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.map( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by namespace, src - from vectorAdapter' );

    /* - */

    test.open( 'call by instance, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.map( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.map( src, null );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.map( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.map( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.map( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.map( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -8, -9, -10, -11, -12 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.map( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [ -1, -2, -3, -4, -5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.close( 'call by instance, src - from vectorAdapter' );
  }
}

//

function filterDstIsNullRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLong( makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.filter( dst );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.filter( dst, undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.vectorAdapter.fromLong( makeLong( [ 2, 3, 4 ] ) );
    var got = _.vectorAdapter.filter( dst, null );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'dst - null' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( _.vectorAdapter.from( [] ), _.vectorAdapter.from( [] ), ( e ) => e, 'extra' ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( [ 1, 2 ], _.vectorAdapter.from( [ 1, 2 ] ), ( e ) => e ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( { 1 : 0 }, _.vectorAdapter.from( [ 1 ] ), ( e ) => e ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( _.vectorAdapter.from( [ 1, 2 ] ), [ 1, 2 ], ( e ) => e ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( _.vectorAdapter.from( [ 1 ] ), { 1 : 0 }, ( e ) => e ) );

  test.case = 'wrong type of onEach';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( _.vectorAdapter.from( [ 1, 2 ] ), _.vectorAdapter.from( [ 1, 2 ] ), [] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( _.vectorAdapter.from( [ 1 ] ), _.vectorAdapter.from( [ 2 ] ), 'wrong' ) );

  test.case = 'only dst, dst - null';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( null ) );

  test.case = 'two arguments, onEach not undefined' ;
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( null, _.vectorAdapter.from( [ 1, 2 ] ) ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( _.vectorAdapter.from( [ 2, 1 ] ), _.vectorAdapter.from( [ 1, 2 ] ) ) );

  test.case = 'dst === src, onEach returns undefined';
  test.shouldThrowErrorSync( () => _.vectorAdapter.filter( [ 1, 2, 3 ], ( e ) => undefined ) );
}

//

function filterDstIsNullRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, undefined );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    test.case = 'dst - vectorAdapter, src - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 2, 3, 4, 5, 6, 7 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, null );
    var exp = _.vectorAdapter.from( makeLong( [ 2, 4, 6 ] ) );
    test.identical( got, exp );
    test.true( got === dst );

    /* - */

    test.open( 'dst - null' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 1 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'dst - null' );
  }
}

//

function filterDstIsNullRoutineFromNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'from vectorAdapter' );

    /* - */

    test.open( 'from number' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach - null';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( _.long.default.make([ 7, 7, 7, 7, 7 ]) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns element';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 7, 7, 7, 7, 7 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns key';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 10, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns src.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns dst.length';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( _.long.default.make( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 5, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'src - vector, onEach returns undefined';
    var dst = null;
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( _.long.default.make( [] ) );
    test.identical( got, exp );
    test.true( got !== src );

    test.close( 'from number' );
  }
}

//

function filterOnlyDstRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () =>
    {
      var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
      var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => undefined );
    });

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.filter( undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.filter( null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.filter( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.filter( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.filter( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.filter( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.filter( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.filter( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.filter( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = src.filter( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.filter( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () =>
    {
      var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
      var got = src.filter( ( e, k, s, d ) => undefined );
    });

    test.close( 'call by instance' );
  }
}

//

function filterOnlyDstRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () =>
    {
      var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
      var got = _.vectorAdapter.filter( src, ( e, k, s, d ) => undefined );
    });

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.filter( undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.filter( null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.filter( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.filter( ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.filter( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.filter( ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.filter( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.filter( ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.filter( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns dst.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = src.filter( ( e, k, s, d ) => d.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got === src );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.filter( ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src - vector, onEach returns undefined';
    test.shouldThrowErrorSync( () =>
    {
      var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
      var got = src.filter( ( e, k, s, d ) => undefined );
    });

    test.close( 'call by instance' );
  }
}

//

function filterDstIsVectorRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -4, -6, -8, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( []  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = makeLong.name === 'bound make' ? _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ) : _.vectorAdapter.from( makeLong ( [ 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( makeLong.name === 'bound make' ? got === dst : got !== dst );

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2 ] ) );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );


    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.filter( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2, 3, 4 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 5, 5, 5, 5, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -4, -6, -8, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( []  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var got = dst.filter( src, ( e ) => e );
    var exp = makeLong.name === 'bound make' ? _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] ) : _.vectorAdapter.from( makeLong( [ 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( makeLong.name === 'bound make' ? got === dst : got !== dst );

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( makeLong( [ -1, -2, -3, -4, -5 ] ) );
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2 ] ) );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    test.close( 'call by instance' );
  }
}

//

function filterDstIsVectorRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -6, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( []  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    test.shouldThrowErrorSync( () =>
    {
      var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5, -6, -7 ] ), 0, 2, 2 );
      var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5, 6, 7 ] ), 0, 4, 2 );
      var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    });

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5, -6, -7 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5, 6, 7 ] ), 0, 2, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );


    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.filter( src, undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.filter( src, null );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ]  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3, 5 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( makeLong( [ 0, 1, 2 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( makeLong( [ 3, 3, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( makeLong( [ -2, -6, -10 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( [] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5 ] ), 0, 3, 2 );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( makeLong( []  ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    test.shouldThrowErrorSync( () =>
    {
      var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5, -6, -7 ] ), 0, 2, 2 );
      var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5, 6, 7 ] ), 0, 4, 2 );
      var got = dst.filter( src, ( e ) => e );
    });

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ -1, -2, -3, -4, -5, -6, -7 ] ), 0, 3, 2 );
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 4, 5, 6, 7 ] ), 0, 2, 2 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( makeLong( [ 1, 3 ] ) );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    test.close( 'call by instance' );
  }
}

//

function filterDstIsVectorRoutineFromNumberWithVectorAdapter( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.open( 'call by namespace, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var exp = _.vectorAdapter.from( [] );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var exp = _.vectorAdapter.from( []  );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2 ] ), 2 );
    var exp = _.vectorAdapter.from( [ 1, 2 ] );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );


    test.close( 'call by namespace, src - from vectorAdapter' );

    /* - */

    test.open( 'call by instance, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.filter( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, null );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -2, -4, -6, -8, -10 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [] ), 0 );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( []  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2, 3, 4, 5 ] ), 5 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( _.vad.fromLong( [ 1, 2 ] ), 2 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 1, 2 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    test.close( 'call by instance, src - from vectorAdapter' );
  }
}

//

function filterDstIsVectorRoutineFromNumberWithNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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
    test.open( 'call by namespace, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.filter( dst, src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, null );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -8, -9, -10, -11, -12 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( []  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ 1, 2 ] );
    var src = _.vectorAdapter.fromNumber( 8, 5 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 8, 8, 8, 8, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 2 );
    var got = _.vectorAdapter.filter( dst, src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    test.close( 'call by namespace, src - from vectorAdapter' );

    /* - */

    test.open( 'call by instance, src - from vectorAdapter' );

    test.case = 'src - empty vector, onEach - undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.filter( src, undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach - null';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.filter( src, null );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ]  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7, 7, 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns key';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.filter( src, ( e, k ) => k );
    var exp = _.vectorAdapter.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns src.length';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.filter( src, ( e, k, s ) => s.length );
    var exp = _.vectorAdapter.from( [ 5, 5, 5, 5, 5 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns substruction dst and src elements';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.filter( src, ( e, k, s, d ) => d.eGet( k ) - s.eGet( k ) );
    var exp = _.vectorAdapter.from( [ -8, -9, -10, -11, -12 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    /* */

    test.case = 'src - empty vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [] );
    var src = _.vectorAdapter.fromNumber( 8, 0 );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( [] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'src - vector, onEach returns undefined';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 5 );
    var got = dst.filter( src, ( e, k, s, d ) => undefined );
    var exp = _.vectorAdapter.from( []  );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    /* */

    test.case = 'dst.length < src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ 1, 2 ] );
    var src = _.vectorAdapter.fromNumber( 8, 5 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 8, 8, 8, 8, 8 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got === dst );

    test.case = 'dst.length > src.length, onEach returns element';
    var dst = _.vectorAdapter.fromLong( [ -1, -2, -3, -4, -5 ] );
    var src = _.vectorAdapter.fromNumber( 7, 2 );
    var got = dst.filter( src, ( e ) => e );
    var exp = _.vectorAdapter.from( [ 7, 7 ] );
    test.identical( got, exp );
    test.true( got !== src );
    test.true( got !== dst );

    test.close( 'call by instance, src - from vectorAdapter' );
  }
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

function forOf( test )
{

  /* */

  test.case = 'long, e';

  var array1 = [ 10, 11, 12 ];
  // test.true( _.iterableIs( array1 ) );
  test.true( !!_.class.methodIteratorOf( array1 ) );

  var got = [];
  for( let e of array1 )
  {
    got.push( e );
  }
  var exp = [ 10, 11, 12 ];
  test.identical( got, exp );

  /* */

  _.vectorAdapter.contextsForTesting
  ({
    onEach : act,
/*
    varyingFormat : 'F32x',
    varyingForm : 'straight',
*/
  });

  function act( a )
  {

    /* */

    test.case = `${a.format} ${a.form} vad from long, e`;

    var vector1 = a.vadMake([ 10, 11, 12 ]);
    // test.true( _.iterableIs( vector1 ) );
    test.true( !!_.class.methodIteratorOf( vector1 ) );

    var got = [];
    for( let e of vector1 )
    {
      got.push( e );
    }
    var exp = [ 10, 11, 12 ];
    test.identical( got, exp );

    /* */

  }

}

// --
// etc
// --

function distributionRangeSummaryValue( test )
{

  test.case = 'basic';
  var a = _.vad.from( new I32x([ 1, 2, 3 ]) );
  var b = _.vad.from( new I32x([ 3, 4, 5 ]) );
  var exp = [ 1, 5 ];
  var got = _.vad.distributionRangeSummaryValue( a, b );
  test.identical( got, exp );

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

//

function cross3( test )
{
  test.open( 'src1 and src2 - vectorAdapter instances' );

  test.case = 'dst - only zeros, src1 and src2 - only zeros';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0, 0, 0 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - only zeros';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0, 0, 0 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - different elements, src1 - only zeros, src2 - different elements';
  var dst = _.vad.from( [ 1, -1, 3 ] );
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 5, 4, 3 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 - different elements, src2 - only zeros';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ 10, -5, 4 ] );
  var src2 = _.vad.from( [ 0, 0, 0 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same positive number';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5, 5, 5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same positive number';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5, 5, 5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same negative number';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = _.vad.from( [ -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5, -5, -5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same negative number';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5, -5, -5 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different positive values';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = _.vad.from( [ 1, 2, 3 ] );
  var src2 = _.vad.from( [ 4, 5, 6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different positive values';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ 1, 2, 3 ] );
  var src2 = _.vad.from( [ 4, 5, 6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different negative values';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = _.vad.from( [ -1, -2, -3 ] );
  var src2 = _.vad.from( [ -4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different negative values';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ -1, -2, -3 ] );
  var src2 = _.vad.from( [ -4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different values';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = _.vad.from( [ -1, 2, 3 ] );
  var src2 = _.vad.from( [ 4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different values';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = _.vad.from( [ -1, 2, 3 ] );
  var src2 = _.vad.from( [ 4, -5, -6 ] );
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.close( 'src1 and src2 - vectorAdapter instances' );

  /* - */

  test.open( 'src1 and src2 - simple vectors' );

  test.case = 'dst - only zeros, src1 and src2 - only zeros';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - only zeros';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 0, 0, 0 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - different elements, src1 - only zeros, src2 - different elements';
  var dst = _.vad.from( [ 1, -1, 3 ] );
  var src1 = [ 0, 0, 0 ];
  var src2 = [ 5, 4, 3 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 - different elements, src2 - only zeros';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ 10, -5, 4 ];
  var src2 = [ 0, 0, 0 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same positive number';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same positive number';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ 5, 5, 5 ];
  var src2 = [ 5, 5, 5 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - same negative number';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - same negative number';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ -5, -5, -5 ];
  var src2 = [ -5, -5, -5 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 0, 0, 0 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different positive values';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = [ 1, 2, 3 ];
  var src2 = [ 4, 5, 6 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different positive values';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ 1, 2, 3 ];
  var src2 = [ 4, 5, 6 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different negative values';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = [ -1, -2, -3 ];
  var src2 = [ -4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different negative values';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ -1, -2, -3 ];
  var src2 = [ -4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ -3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - only zeros, src1 and src2 - different values';
  var dst = _.vad.from( [ 0, 0, 0 ] );
  var src1 = [ -1, 2, 3 ];
  var src2 = [ 4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - different elements, src1 and src2 - different values';
  var dst = _.vad.from( [ 1, -5, 's' ] );
  var src1 = [ -1, 2, 3 ];
  var src2 = [ 4, -5, -6 ];
  var got = dst.cross3( src1, src2 );
  var exp = _.vad.from( [ 3, 6, -3 ] );
  test.identical( got, exp );
  test.true( got === dst );

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

  /* */

  test.case = 'swapVectors vectors';

  var v1 = _.vad.from([ 1, 2, 3 ]);
  var v2 = _.vad.from([ 10, 20, 30 ]);
  var v1Expected = _.vad.from([ 10, 20, 30 ]);
  var v2Expected = _.vad.from([ 1, 2, 3 ]);

  var r = _.vad.swapVectors( v1, v2 );

  test.true( r === undefined );
  test.identical( v1, v1Expected );
  test.identical( v2, v2Expected );

  /* */

  test.case = 'swapVectors arrays';

  var v1 = [ 1, 2, 3 ];
  var v2 = [ 10, 20, 30 ];
  var v1Expected = [ 10, 20, 30 ];
  var v2Expected = [ 1, 2, 3 ];

  var r = _.vector.swapVectors( v1, v2 ); /* qqq : move out to proper test suite this and other test cases */

  test.true( r === undefined );
  test.identical( v1, v1Expected );
  test.identical( v2, v2Expected );

  /* */

  test.case = 'swapVectors empty arrays';

  var v1 = [];
  var v2 = [];
  var v1Expected = [];
  var v2Expected = [];

  var r = _.vector.swapVectors( v1, v2 );

  test.true( r === undefined );
  test.identical( v1, v1Expected );
  test.identical( v2, v2Expected );

  /* */

  test.case = 'scalarsSwap vectors';

  var v1 = _.vad.from([ 1, 2, 3 ]);
  var v1Expected = _.vad.from([ 3, 2, 1 ]);
  var r = _.vad.scalarsSwap( v1, 0, 2 );

  test.true( r === v1 );
  test.identical( v1, v1Expected );

  /* */

  test.case = 'scalarsSwap arrays';

  var v1 = [ 1, 2, 3 ];
  var v1Expected = [ 3, 2, 1 ];
  var r = _.vector.scalarsSwap( v1, 0, 2 );

  test.true( r === v1 );
  test.identical( v1, v1Expected );

  /* */

  test.case = 'scalarsSwap array with single atom';

  var v1 = [ 1 ];
  var v1Expected = [ 1 ];
  var r = _.vector.scalarsSwap( v1, 0, 0 );

  test.true( r === v1 );
  test.identical( v1, v1Expected );

  /* */

  test.case = 'bad arguments';

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.vad.swapVectors() );
  test.shouldThrowErrorSync( () => _.vad.swapVectors( _.vad.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vad.swapVectors( _.vad.from([ 1, 2, 3 ]), _.vad.from([ 1, 2, 3 ]), _.vad.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vad.swapVectors( _.vad.from([ 1, 2, 3 ]), _.vad.from([ 1, 2 ]) ) );
  test.shouldThrowErrorSync( () => _.vad.swapVectors( _.vad.from([ 1, 2, 3 ]), [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.vad.swapVectors( [ 1, 2, 3 ], [ 1, 2, 3 ] ) );

  test.shouldThrowErrorSync( () => _.vad.scalarsSwap() );
  test.shouldThrowErrorSync( () => _.vad.scalarsSwap( _.vad.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vad.scalarsSwap( _.vad.from([ 1, 2, 3 ]), 0 ) );
  test.shouldThrowErrorSync( () => _.vad.scalarsSwap( _.vad.from([ 1, 2, 3 ]), 0, +3 ) );
  test.shouldThrowErrorSync( () => _.vad.scalarsSwap( _.vad.from([ 1, 2, 3 ]), 0, -1 ) );
  test.shouldThrowErrorSync( () => _.vad.scalarsSwap( _.vad.from([ 1, 2, 3 ]), '0', '1' ) );
  test.shouldThrowErrorSync( () => _.vad.scalarsSwap( _.vad.from([ 1, 2, 3 ]), [ 0 ], [ 1 ] ) );

}

//

function inv( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.inv( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'zero';
    var exp = a.vadMake( [ Infinity, Infinity, Infinity ] );
    var src = a.vadMake( [ 0, 0, 0 ] );
    var got = _.vad.inv( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'ones';
    var exp = a.vadMake( [ 1, 1, 1 ] );
    var src = a.vadMake( [ 1, 1, 1 ] );
    var got = _.vad.inv( src );
    test.identical( got, exp );
    test.true( got === src );

    test.close( `src - long, ${a.format}` );
  }

  /* */

  test.case = 'src is dst';
  var exp = _.vad.from( [ 1, 1/2, -1/3, 1/5, 10, 11 ] );
  var src = _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11 ] );
  var got = _.vad.inv( src );
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'new dst';
  var exp = _.vad.from( [ 1, 1/2, -1/3, 1/5, 10, 11 ] );
  var src = _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11 ] );
  var got = _.vad.inv( null, src );
  test.identical( got, exp );
  test.true( got !== src );

  /* */

  test.case = 'first argument is dst';
  var exp = _.vad.from( [ 1, 1/2, -1/3, 1/5, 10, 11, Infinity ] );
  var dst = _.vad.from( [ 0, 0, 0, 0, 1/10, 0, 0 ] );
  var src = _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11, 0 ] );
  var got = _.vad.inv( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11, 0 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.inv( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.inv( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.inv( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

}

//

function invOrOne( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.invOrOne( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'zero';
    var exp = a.vadMake( [ 1, 1, 1 ] );
    var src = a.vadMake( [ 0, 0, 0 ] );
    var got = _.vad.invOrOne( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'ones';
    var exp = a.vadMake( [ 1, 1, 1 ] );
    var src = a.vadMake( [ 1, 1, 1 ] );
    var got = _.vad.invOrOne( src );
    test.identical( got, exp );
    test.true( got === src );

    test.close( `src - long, ${a.format}` );
  }

  /* */

  test.case = 'src is dst';
  var exp = _.vad.from( [ 1, 1/2, -1/3, 1/5, 10, 11 ] );
  var src = _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11 ] );
  var got = _.vad.invOrOne( src );
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'new dst';
  var exp = _.vad.from( [ 1, 1/2, -1/3, 1/5, 10, 11 ] );
  var src = _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11 ] );
  var got = _.vad.invOrOne( null, src );
  test.identical( got, exp );
  test.true( got !== src );

  /* */

  test.case = 'first argument is dst';
  var exp = _.vad.from( [ 1, 1/2, -1/3, 1/5, 10, 11, 1 ] );
  var dst = _.vad.from( [ 0, 0, 0, 0, 1/10, 0, 0 ] );
  var src = _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11, 0 ] );
  var got = _.vad.invOrOne( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 1, 2, -3, 5, 1/10, 1/11, 0 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.invOrOne( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.invOrOne( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.invOrOne( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

}

//

function abs( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.abs( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src is dst';
    var exp = a.vadMake( [ 1, 2, 3, 5, 3.1415, 1.4142 ] );
    var src = a.vadMake( [ 1, -2, 3, -5, -3.1415, 1.4142 ] );
    var got = _.vad.abs( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'new dst';
    var exp = a.vadMake( [ 1, 2, 3, 5, 3.1415, 1.4142 ] );
    var src = a.vadMake( [ 1, -2, 3, -5, -3.1415, 1.4142 ] );
    var got = _.vad.abs( null, src );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'first argument is dst';
    var exp = a.vadMake( [ 0, 1, 2, 3, 5, 100 ] );
    var dst = a.vadMake( [ 5, 0, 0, 0, 0, 0 ] );
    var src = a.vadMake( [ 0, -1, 2, -3, 5, -100 ] );
    var got = _.vad.abs( dst, src );
    test.identical( got, exp );
    test.identical( src, a.vadMake( [ 0, -1, 2, -3, 5, -100 ] ) );
    test.true( got === dst );

    test.close( `src - long, ${a.format}` );
  }

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.abs( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.abs( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.abs( _.vad.from( [ 0, 0, 0, 5 ] ), [ 3, 4, 5 ] ) );

}

//

function floor( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.floor( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'zero';
    var exp = a.vadMake( [ 0, 0, 0 ] );
    var src = a.vadMake( [ 0, 0, 0 ] );
    var got = _.vad.floor( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'ones';
    var exp = a.vadMake( [ 1, 1, 1 ] );
    var src = a.vadMake( [ 1, 1, 1 ] );
    var got = _.vad.floor( src );
    test.identical( got, exp );
    test.true( got === src );

    test.close( `src - long, ${a.format}` );
  }

  /* */

  test.case = 'src is dst';
  var exp = _.vad.from( [ 1, 2, 3, 0, 1, 3, -2, -4, -1 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] );
  var got = _.vad.floor( src );
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'new dst';
  var exp = _.vad.from( [ 1, 2, 3, 0, 1, 3, -2, -4, -1 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] );
  var got = _.vad.floor( null, src );
  test.identical( got, exp );
  test.true( got !== src );

  /* */

  test.case = 'first argument is dst';
  var exp = _.vad.from( [ 1, 2, 3, 0, 1, 3, -2, -4, -1 ] );
  var dst = _.vad.from( [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] );
  var got = _.vad.floor( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.floor( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.floor( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.floor( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

}

//

function ceil( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.ceil( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'zero';
    var exp = a.vadMake( [ 0, 0, 0 ] );
    var src = a.vadMake( [ 0, 0, 0 ] );
    var got = _.vad.ceil( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'ones';
    var exp = a.vadMake( [ 1, 1, 1 ] );
    var src = a.vadMake( [ 1, 1, 1 ] );
    var got = _.vad.ceil( src );
    test.identical( got, exp );
    test.true( got === src );

    test.close( `src - long, ${a.format}` );
  }


  /* */

  test.case = 'src is dst';
  var exp = _.vad.from( [ 1, 2, 3, 1, 2, 4, -1, -3, -0 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] );
  var got = _.vad.ceil( src );
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'new dst';
  var exp = _.vad.from( [ 1, 2, 3, 1, 2, 4, -1, -3, -0 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] );
  var got = _.vad.ceil( null, src );
  test.identical( got, exp );
  test.true( got !== src );

  /* */

  test.case = 'first argument is dst';
  var exp = _.vad.from( [ 1, 2, 3, 1, 2, 4, -1, -3, -0 ] );
  var dst = _.vad.from( [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] );
  var got = _.vad.ceil( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.ceil( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.ceil( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.ceil( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

}

//

function round( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.round( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'zero';
    var exp = a.vadMake( [ 0, 0, 0 ] );
    var src = a.vadMake( [ 0, 0, 0 ] );
    var got = _.vad.round( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'ones';
    var exp = a.vadMake( [ 1, 1, 1 ] );
    var src = a.vadMake( [ 1, 1, 1 ] );
    var got = _.vad.round( src );
    test.identical( got, exp );
    test.true( got === src );

    test.close( `src - long, ${a.format}` );
  }

  /* */

  test.case = 'src is dst';
  var exp = _.vad.from( [ 1, 2, 3, 0, 1, 3, -1, -3, -0, 3, 3 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1, 2.5, 2.6 ] );
  var got = _.vad.round( src );
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'new dst';
  var exp = _.vad.from( [ 1, 2, 3, 0, 1, 3, -1, -3, -0, 3, 3 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1, 2.5, 2.6 ] );
  var got = _.vad.round( null, src );
  test.identical( got, exp );
  test.true( got !== src );

  /* */

  test.case = 'first argument is dst';
  var exp = _.vad.from( [ 1, 2, 3, 0, 1, 3, -1, -3, -0, 3, 3 ] );
  var dst = _.vad.from( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
  var src = _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1, 2.5, 2.6 ] );
  var got = _.vad.round( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 1, 2, 3, 0.1, 1.4142, 3.1415, -1.4142, -3.1415, -0.1, 2.5, 2.6 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.round( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.round( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.round( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

}

//

function normalize( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - long, ${a.format}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.normalize( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'zero';
    var exp = a.vadMake( [ 0, 0, 0 ] );
    var src = a.vadMake( [ 0, 0, 0 ] );
    var got = _.vad.normalize( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'unit';
    var exp = a.vadMake( [ 0, 1, 0 ] );
    var src = a.vadMake( [ 0, 1, 0 ] );
    var got = _.vad.normalize( src );
    test.identical( got, exp );
    test.true( got === src );

    test.close( `src - long, ${a.format}` );
  }

  /* */

  test.case = 'ones';
  var exp = _.vad.from( [ 1/_.math.sqrt( 3 ), -1/_.math.sqrt( 3 ), 1/_.math.sqrt( 3 ) ] );
  var src = _.vad.from( [ 1, -1, 1 ] );
  var got = _.vad.normalize( src );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'src is dst';
  var exp = _.vad.from( [ 1/_.math.sqrt( 39 ), -2/_.math.sqrt( 39 ), 3/_.math.sqrt( 39 ), -5/_.math.sqrt( 39 ) ] );
  var src = _.vad.from( [ 1, -2, 3, -5 ] );
  var got = _.vad.normalize( src );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'new dst';
  var exp = _.vad.from( [ 1/_.math.sqrt( 39 ), -2/_.math.sqrt( 39 ), 3/_.math.sqrt( 39 ), -5/_.math.sqrt( 39 ) ] );
  var src = _.vad.from( [ 1, -2, 3, -5 ] );
  var got = _.vad.normalize( null, src );
  test.identical( got, exp );
  test.true( got !== src );

  test.case = 'first argument is dst';
  var exp = _.vad.from( [ 1/_.math.sqrt( 39 ), -2/_.math.sqrt( 39 ), 3/_.math.sqrt( 39 ), -5/_.math.sqrt( 39 ) ] );
  var dst = _.vad.from( [ 0, 0, 0, 0 ] );
  var src = _.vad.from( [ 1, -2, 3, -5 ] );
  var got = _.vad.normalize( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 1, -2, 3, -5 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.normalize( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.normalize( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.normalize( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

}

//

function ceilToPowerOfTwo( test )
{
  _.vectorAdapter.contextsForTesting( { onEach : act } );

  function act( a )
  {
    test.open( `src - vectorAdapter, ${a.format} ${a.form}` );

    test.case = 'empty';
    var exp = a.vadMake( [] );
    var src = a.vadMake( [] );
    var got = _.vad.ceilToPowerOfTwo( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'src is dst';
    var exp = a.vadMake( [ 1, 2, 4, 8 ] );
    var src = a.vadMake( [ 1, 2, 3, 5 ] );
    var got = _.vad.ceilToPowerOfTwo( src );
    test.identical( got, exp );
    test.true( got === src );

    test.case = 'new dst';
    var exp = a.vadMake( [ 1, 2, 4, 8 ] );
    var src = a.vadMake( [ 1, 2, 3, 5 ] );
    var got = _.vad.ceilToPowerOfTwo( null, src );
    test.identical( got, exp );
    test.true( got !== src );

    test.case = 'first argument is dst';
    var exp = a.vadMake( [ 0, 1024, 1, 2, 4, 4, 8, 64, 0 ] );
    var dst = a.vadMake( [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
    var src = a.vadMake( [ 0, 1000, 1, 2, 3, 4, 5, 50, 0 ] );
    var got = _.vad.ceilToPowerOfTwo( dst, src );
    test.identical( got, exp );
    test.identical( src, a.vadMake( [ 0, 1000, 1, 2, 3, 4, 5, 50, 0 ] ) );
    test.true( got === dst );

    test.close( `src - vectorAdapter, ${a.format} ${a.form}` );
  }

  /* - */

  test.case = 'src - vectorAdapter, real value as elements in src';
  var exp = _.vad.from( [ 4, 1024, 2, 4 ] );
  var dst = _.vad.from( [ 0, 0, 0, 0 ] );
  var src = _.vad.from( [ 3.1415, 1000.1001, 1.4142, 3 ] );
  var got = _.vad.ceilToPowerOfTwo( dst, src );
  test.identical( got, exp );
  test.identical( src, _.vad.from( [ 3.1415, 1000.1001, 1.4142, 3 ] ) );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.vad.ceilToPowerOfTwo( 5, _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vad.ceilToPowerOfTwo( _.vad.from( [ 3, 4, 5 ] ), 5 ) );

  test.case = 'the lengths of dst and src are not equal';
  test.shouldThrowErrorSync( () => _.vad.ceilToPowerOfTwo( _.vad.from( [ 0, 0, 0, 5 ] ), _.vad.from( [ 3, 4, 5 ] ) ) );

  test.case = 'negative elements in src';
  test.shouldThrowErrorSync( () => _.vad.ceilToPowerOfTwo( [ 1, 1, 1 ], [ 1, -1, -10 ] ) );

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

function allRoutineFromLong( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 0, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, 0 ] ) );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 0, 3, -1, -2, -3 ] ) );
    var got = src.all();
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, 0 ] ) );
    var got = src.all( null );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = src.all( undefined );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = src.all( ( e ) => e );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all( ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [] ) );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLong( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by instance' );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.all());

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 'wrong' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( null, ( e, k ) => k ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( undefined, ( e, k ) => k ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 'wrong', ( e, k ) => k ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( [ 0, 1, 2, 3 ], ( e, k ) => k ));

  test.case = 'wrong type of onEach';
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'wrong' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));
}

//

function allRoutineFromLongLrangeAndStride( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 0, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, 0 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 0, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all();
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, 0 ] ), 0, 3, 2 );
    var got = src.all( null );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( undefined );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [] ), 0, 0, 2 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, -1, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromLongLrangeAndStride( makeLong( [ 1, 2, 3, 0, -2, -3 ] ), 0, 3, 2 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by instance' );
  }
}

//

function allRoutineFromNumberWithVectorAdapter( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 0, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, 0 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 0, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all();
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, 0 ] ) ), 6 );
    var got = src.all( null );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = src.all( undefined );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = src.all( ( e ) => e );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [] ) ), 0 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, -1, -2, -3 ] ) ), 6 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( _.vectorAdapter.from( makeLong( [ 1, 2, 3, 0, -2, -3 ] ) ), 6 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by instance' );
  }
}

//

function allRoutineFromNumberWithNumber( test )
{
  var list =
  [
    _.routine.join( _.array, _.array.make ),
    ( ... args ) => { return new I16x( ... args )},
    ( ... args ) => { return new F32x( ... args )}
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

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src, null );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src, undefined );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src, ( e ) => e );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src, ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = _.vectorAdapter.all( src, ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by namespace' );

    /* - */

    test.open( 'call by instance' );

    test.case = 'src - empty vector, without onEach';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector without zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all();
    test.identical( got, true );

    test.case = 'src - vector with zeros, without onEach';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all();
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - null';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all( null );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - null';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all( null );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all( undefined );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - undefined';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all( undefined );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all( ( e ) => e );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns element';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all( ( e ) => e );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    test.case = 'src - vector with zeros, onEach - returns key';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all( ( e, k ) => k );
    test.identical( got, 0 );

    /* */

    test.case = 'src - empty vector, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    test.case = 'src - vector with zeros, onEach - returns src.length';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all( ( e, k, s ) => s.length );
    test.identical( got, true );

    /* */

    test.case = 'src - empty vector, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( 7, 0 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, true );

    test.case = 'src - vector without zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( 7, 6 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.case = 'src - vector with zeros, onEach - returns undefined';
    var src = _.vectorAdapter.fromNumber( 0, 6 );
    var got = src.all( ( e, k, s ) => undefined );
    test.identical( got, undefined );

    test.close( 'call by instance' );
  }
}

//

function allEquivalent( test )
{

  test.case = 'basic';
  var accuracy = 0.1;
  var a = _.vectorAdapter.from([ 1 ]);
  var b = _.vectorAdapter.from([ 1+accuracy ]);
  var got = _.vectorAdapter.allEquivalent( a, b, accuracy );
  var exp = true;
  test.identical( got, exp );

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

function equalentAreIdenticalAreEquivalentWithIdenticalWith( test )
{
  let e = this.accuracy || 10 ** -7;

  /* - */

  test.open( 'without callback' );

  test.case = 'empty vectors';
  var src1 = _.vectorAdapter.fromLong([]);
  var src2 = _.vectorAdapter.fromLong([]);
  debugger;
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), true );
  debugger;
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), true );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), true );
  test.identical( src1.equivalentWith( src2 ), true );
  test.identical( src2.equivalentWith( src1 ), true );
  test.identical( src1.identicalWith( src2 ), true );
  test.identical( src2.identicalWith( src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  /* */

  test.case = 'vectors with single element, identical';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 ]);
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), true );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), true );
  test.identical( src1.equivalentWith( src2 ), true );
  test.identical( src2.equivalentWith( src1 ), true );
  test.identical( src1.identicalWith( src2 ), true );
  test.identical( src2.identicalWith( src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'vectors with several elements, equivalent';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2 ]);
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), true );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), false );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), false );
  test.identical( src1.equivalentWith( src2 ), true );
  test.identical( src2.equivalentWith( src1 ), true );
  test.identical( src1.identicalWith( src2 ), false );
  test.identical( src2.identicalWith( src1 ), false );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with several elements, nor identical and nor equivalent';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e*2 ]);
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), false );
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), false );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), false );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), false );
  test.identical( src1.equivalentWith( src2 ), false );
  test.identical( src2.equivalentWith( src1 ), false );
  test.identical( src1.identicalWith( src2 ), false );
  test.identical( src2.identicalWith( src1 ), false );
  test.notEquivalent( src1, src2 );
  test.notEquivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  /* */

  test.case = 'vectors with several elements, identical';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  var src2 = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), true );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), true );
  test.identical( src1.equivalentWith( src2 ), true );
  test.identical( src2.equivalentWith( src1 ), true );
  test.identical( src1.identicalWith( src2 ), true );
  test.identical( src2.identicalWith( src1 ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'vectors with several elements, equivalent';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2 + e/2 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2, 0, 2 ]);
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), true );
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), true );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), false );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), false );
  test.identical( src1.equivalentWith( src2 ), true );
  test.identical( src2.equivalentWith( src1 ), true );
  test.identical( src1.identicalWith( src2 ), false );
  test.identical( src2.identicalWith( src1 ), false );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with several elements, nor identical and nor equivalent';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2 + e/2 ]);
  var src2 = _.vectorAdapter.fromLong([ 1, 0 + e*2, 2 ]);
  test.identical( _.vectorAdapter.equivalentAre( src1, src2 ), false );
  test.identical( _.vectorAdapter.equivalentAre( src2, src1 ), false );
  test.identical( _.vectorAdapter.identicalAre( src1, src2 ), false );
  test.identical( _.vectorAdapter.identicalAre( src2, src1 ), false );
  test.identical( src1.equivalentWith( src2 ), false );
  test.identical( src2.equivalentWith( src1 ), false );
  test.identical( src1.identicalWith( src2 ), false );
  test.identical( src2.identicalWith( src1 ), false );
  test.notEquivalent( src1, src2 );
  test.notEquivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.close( 'without callback' );

  /* - */

  test.open( 'with callback' );

  test.case = 'empty vectors, onNumbersAreEqual checks identical numbers';
  var src1 = _.vectorAdapter.fromLong([]);
  var src2 = _.vectorAdapter.fromLong([]);
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'empty vectors, onNumbersAreEqual should return false for equivalent numbers';
  var src1 = _.vectorAdapter.fromLong([]);
  var src2 = _.vectorAdapter.fromLong([]);
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b+e };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  /* */

  test.case = 'vectors with single element, identical numbers, onNumbersAreEqual checks identical numbers';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 ]);
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'vectors with single element, identical numbers, onNumbersAreEqual checks equivalent numbers';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'vectors with single element, equivalent numbers, onNumbersAreEqual checks identical numbers';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2 ]);
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.equivalentWith( src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.equivalentWith( src1, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.identicalWith( src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.identicalWith( src1, o ), false );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with single element, equivalent numbers, onNumbersAreEqual checks equivalent numbers';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2 ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with single element, nor identical and nor equivalent numbers, onNumbersAreEqual checks numbers with non statdard accuracy';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + 2*e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.identicalWith( src1, o ), true );
  test.notEquivalent( src1, src2 );
  test.notEquivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with single element, equivalent numbers, onNumbersAreEqual checks numbers with non statdard accuracy';
  var src1 = _.vectorAdapter.fromLong([ 1 ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2 ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  /* */

  test.case = 'vectors with several elements, identical numbers, onNumbersAreEqual checks identical numbers';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var src2 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'vectors with several elements, identical numbers, onNumbersAreEqual checks equivalent numbers';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var src2 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.identical( src1, src2 );
  test.identical( src2, src1 );

  test.case = 'vectors with several elements, equivalent numbers, onNumbersAreEqual checks identical numbers';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2, 0, 2+e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.equivalentWith( src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.equivalentWith( src1, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src1.identicalWith( src2, o ), false );
  var o = { onNumbersAreEqual : ( a, b ) => a === b };
  test.identical( src2.identicalWith( src1, o ), false );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with several elements, equivalent numbers, onNumbersAreEqual checks equivalent numbers';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2, 0, 2+e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with several elements, nor identical and nor equivalent numbers, onNumbersAreEqual checks numbers with non statdard accuracy';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + 2*e, 0, 2+e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.identicalWith( src1, o ), true );
  test.notEquivalent( src1, src2 );
  test.notEquivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.case = 'vectors with several elements, equivalent numbers, onNumbersAreEqual checks numbers with non statdard accuracy';
  var src1 = _.vectorAdapter.fromLong([ 1, 0, 2+e ]);
  var src2 = _.vectorAdapter.fromLong([ 1 + e/2, 0, 2+e ]);
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.equivalentAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src1, src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( _.vectorAdapter.identicalAre( src2, src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.equivalentWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.equivalentWith( src1, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src1.identicalWith( src2, o ), true );
  var o = { onNumbersAreEqual : ( a, b ) => a - b < e*3 };
  test.identical( src2.identicalWith( src1, o ), true );
  test.equivalent( src1, src2 );
  test.equivalent( src2, src1 );
  test.notIdentical( src1, src2 );
  test.notIdentical( src2, src1 );

  test.close( 'with callback' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.vectorAdapter.equivalentAre() );
  test.shouldThrowErrorSync( () => _.vectorAdapter.identicalAre() );
  var src = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  test.shouldThrowErrorSync( () => src.equivalentWith() );
  test.shouldThrowErrorSync( () => src.identicalWith() );

  test.case = 'not enough arguments';
  var src = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  test.shouldThrowErrorSync( () => _.vectorAdapter.equivalentAre( src ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.identicalAre( src ) );

  test.case = 'extra arguments';
  var src = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  test.shouldThrowErrorSync( () => _.vectorAdapter.equivalentAre( src, src, { onNumbersAreEqual : ( a, b ) => a === b }, src ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.identicalAre( src, src, { onNumbersAreEqual : ( a, b ) => a === b }, src ) );
  test.shouldThrowErrorSync( () => src.equivalentWith( src, { onNumbersAreEqual : ( a, b ) => a === b }, src ) );
  test.shouldThrowErrorSync( () => src.identicalWith( src, { onNumbersAreEqual : ( a, b ) => a === b }, src ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.vectorAdapter.equivalentAre( null, [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.identicalAre( null, [ 1, 2 ] ) );
  var src = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  test.shouldThrowErrorSync( () => src.equivalentWith( undefined ) );
  test.shouldThrowErrorSync( () => src.identicalWith( undefined ) );

  test.case = 'wront type of options map';
  var src = _.vectorAdapter.fromLong([ 1, 0, 2 ]);
  test.shouldThrowErrorSync( () => _.vectorAdapter.equivalentAre( src, src, ( a, b ) => a === b ) );
  test.shouldThrowErrorSync( () => _.vectorAdapter.identicalAre( src, src, new Set() ) );
  test.shouldThrowErrorSync( () => src.equivalentWith( src, 'str' ) );
  test.shouldThrowErrorSync( () => src.identicalWith( src, true ) );
}

//

function areParallelDefaultAccuracy( test )
{
  let e = 10 ** -7;

  /* - */

  test.open( 'without deviation' );

  test.case = 'empty vectors, equivalent, zeros';
  var src1 = _.vad.from( [] );
  var src2 = _.vad.from( [] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0 ] );
  var src2 = _.vad.from( [ 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ 5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5 ] );
  var src2 = _.vad.from( [ -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zeros';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 10, -100, 20 ] );
  var src2 = _.vad.from( [ 50, -500, 100 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = _.vad.from( [ 5, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'without deviation' );

  /* - */

  test.open( 'with deviation' );

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0 ] );
  var src2 = _.vad.from( [ 0 + e / 2 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent, zeros';
  var src1 = _.vad.from( [ 0 ] );
  var src2 = _.vad.from( [ 0 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ 5 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5 ] );
  var src2 = _.vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e / 2, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e * 10, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500 + e * 10, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500  + 0.05, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 10, -100, 20 ] );
  var src2 = _.vad.from( [ 50, -500, 100  + 0.05 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e / 2, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e * 10, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5 + e * 10, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5 + e * 100, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = _.vad.from( [ 5 + e * 100, -25, 50, -500, 100 ] );
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
  let e = 10 ** -7;

  /* - */

  test.open( 'without deviation' );

  test.case = 'empty vectors, equivalent, zeros';
  var src1 = _.vad.from( [] );
  var src2 = _.vad.from( [] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0 ] );
  var src2 = _.vad.from( [ 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5 ] );
  var src2 = _.vad.from( [ -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zeros';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 10, -100, 20 ] );
  var src2 = _.vad.from( [ 50, -500, 100 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = _.vad.from( [ 5, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'without deviation' );

  /* - */

  test.open( 'with deviation' );

  test.case = 'single element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0 ] );
  var src2 = _.vad.from( [ 0 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent, zeros';
  var src1 = _.vad.from( [ 0 ] );
  var src2 = _.vad.from( [ 0 + e * 1000 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ 5 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5 ] );
  var src2 = _.vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'single element vectors, not equivalent';
  var src1 = _.vad.from( [ 5 ] );
  var src2 = _.vad.from( [ -5 + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e * 10, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e * 1000, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500 + e * 10, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, with zero';
  var src1 = _.vad.from( [ 10, -100, 0 ] );
  var src2 = _.vad.from( [ 50, -500  + e * 10, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'three element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 10, -100, 20 ] );
  var src2 = _.vad.from( [ 50, -500, 100  + e * 10 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  /* */

  test.case = 'five element vectors, equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e * 10, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent, zeros';
  var src1 = _.vad.from( [ 0, 0, 0, 0, 0 ] );
  var src2 = _.vad.from( [ 0 + e * 1000, 0, 0, 0, 0 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, positive number';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ 5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, negative number';
  var src1 = _.vad.from( [ -5, -5, -5, -5, -5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, -5, -5, -5, -5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, not equivalent';
  var src1 = _.vad.from( [ 5, 5, 5, 5, 5 ] );
  var src2 = _.vad.from( [ -5 + e * 10, 5, 5, 5, 5 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zero in single vector';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5 + e * 10, -25, 50, -500, 1 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = false;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, with zeros';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 0 ] );
  var src2 = _.vad.from( [ 5 + e * 10, -25, 50, -500, 0 ] );
  var got = src1.areParallel( src2, 20 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.case = 'five element vectors, equivalent, different values, without zero';
  var src1 = _.vad.from( [ 1, -5, 10, -100, 20 ] );
  var src2 = _.vad.from( [ 5 + e * 10, -25, 50, -500, 100 ] );
  var got = src1.areParallel( src2, 10 ** -5 );
  var exp = true;
  test.identical( got, exp );

  test.close( 'with deviation' );
}

// --
// proto
// --

const Proto =
{

  name : 'Tools.Math.Vector.Adapter',
  silencing : 1,
  routineTimeOut : 30000,

  context :
  {
  },

  tests :
  {
    // from

    fromLong,
    fromWithLong,
    fromLongLrange,
    fromLongLrangeAndStride,
    fromLongWithStride,

    //update

    updateLrange,

    // is

    vectorAdapterIs,
    vectorIs,
    longIs,
    constructorIsVad,

    //

    assign,
    assignScalar,
    addVectorScalar,

    growAdapter,
    growLong,
    onlyAdapter_,
    onlyLong_,

    // exporter

    to,
    toLong,
    toStr,
    toStrStandard,

    // compare

    entityDiff,
    compare,

    // operation

    // experiment1,
    add,
    subScaled,

    // review

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
    mapDstIsVectorRoutineFromLongLrangeAndStride,
    mapDstIsVectorRoutineFromNumberWithVectorAdapter,
    mapDstIsVectorRoutineFromNumberWithNumber,

    filterDstIsNullRoutineFromLong,
    filterDstIsNullRoutineFromLongLrangeAndStride,
    filterDstIsNullRoutineFromNumber,
    filterOnlyDstRoutineFromLong,
    filterOnlyDstRoutineFromLongLrangeAndStride,
    filterDstIsVectorRoutineFromLong,
    filterDstIsVectorRoutineFromLongLrangeAndStride,
    filterDstIsVectorRoutineFromNumberWithVectorAdapter,
    filterDstIsVectorRoutineFromNumberWithNumber,

    while : _while,

    forOf,

    // etc

    distributionRangeSummaryValue,

    sort,
    cross3,
    swapVectors,

    inv,
    invOrOne,

    abs,

    floor,
    ceil,
    round,

    ceilToPowerOfTwo,

    normalize,

    // isEquivalent, // zzz : implement later
    // allEquivalent,

    allRoutineFromLong,
    allRoutineFromLongLrangeAndStride,
    allRoutineFromNumberWithVectorAdapter,
    allRoutineFromNumberWithNumber,

    any,
    none,

    equalentAreIdenticalAreEquivalentWithIdenticalWith,

    areParallelDefaultAccuracy,
    areParallelNotDefaultAccuracy,

  },

};

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
