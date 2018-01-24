( function _Vector_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  if( typeof wBase === 'undefined' )
  try
  {
    try
    {
      require.resolve( '../../../../dwtools/Base.s' )/*fff*/;
    }
    finally
    {
      require( '../../../../dwtools/Base.s' )/*fff*/;
    }
  }
  catch( err )
  {
    require( 'wTools' );
  }
var _ = wTools;

  _.include( 'wTesting' );

  require( '../cvector/Base.s' );

}

//

var _ = wTools.withArray.Float32;
var Space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var avector = _.avector;
var sqrt = _.sqrt;

var Parent = wTools.Tester;

_.assert( sqrt );

// --
// test
// --

function vectorIs( test )
{

  var a = [ 1,2,3 ];
  var n1 = 1;
  var n2 = '1';
  var n3 = arguments;
  var n4 = function( x ){};

  var v1 = vector.fromArray([ 1,2,3 ]);
  var v2 = vector.fromSubArray( [ -1,1,2,3,-1 ],1,3 );
  var v3 = vector.fromSubArrayWithStride( [ -1,1,-1,2,-1,3,-1 ],1,3,2 );
  var v4 = vector.fromArrayWithStride( [ 1,-1,2,-1,3 ],2 );
  var v5 = vector.from([ 1,2,3 ]);

  test.description = 'vectorIs'; //

  test.shouldBe( !_.vectorIs( a ) );
  test.shouldBe( !_.vectorIs( n1 ) );
  test.shouldBe( !_.vectorIs( n2 ) );
  test.shouldBe( !_.vectorIs( n3 ) );

  test.shouldBe( _.vectorIs( v1 ) );
  test.shouldBe( _.vectorIs( v2 ) );
  test.shouldBe( _.vectorIs( v3 ) );
  test.shouldBe( _.vectorIs( v4 ) );
  test.shouldBe( _.vectorIs( v5 ) );

  test.description = 'clsIsVector'; //

  test.shouldBe( !_.clsIsVector( a.constructor ) );
  test.shouldBe( !_.clsIsVector( n3.constructor ) );
  test.shouldBe( !_.clsIsVector( n4.constructor ) );

  test.shouldBe( _.clsIsVector( v1.constructor ) );
  test.shouldBe( _.clsIsVector( v2.constructor ) );
  test.shouldBe( _.clsIsVector( v3.constructor ) );
  test.shouldBe( _.clsIsVector( v4.constructor ) );
  test.shouldBe( _.clsIsVector( v5.constructor ) );

}

//

function allFinite( test )
{

  test.identical( _.avector.allFinite([ 1,2,3 ]),true );
  test.identical( _.avector.allFinite([ 0,0,0 ]),true );
  test.identical( _.avector.allFinite([ 0,0,1 ]),true );

  test.identical( _.avector.allFinite([ 1,3,NaN ]),false );
  test.identical( _.avector.allFinite([ 1,NaN,3 ]),false );
  test.identical( _.avector.allFinite([ 1,3,-Infinity ]),false );
  test.identical( _.avector.allFinite([ 1,+Infinity,3 ]),false );

  test.identical( _.avector.allFinite([ 1.1,0,1 ]),true );
  test.identical( _.avector.allFinite([ 1,0,1.1 ]),true );

}

//

function anyNan( test )
{

  test.identical( _.avector.anyNan([ 1,2,3 ]),false );
  test.identical( _.avector.anyNan([ 0,0,0 ]),false );
  test.identical( _.avector.anyNan([ 0,0,1 ]),false );

  test.identical( _.avector.anyNan([ 1,3,NaN ]),true );
  test.identical( _.avector.anyNan([ 1,NaN,3 ]),true );
  test.identical( _.avector.anyNan([ 1,3,-Infinity ]),false );
  test.identical( _.avector.anyNan([ 1,+Infinity,3 ]),false );

  test.identical( _.avector.anyNan([ 1.1,0,1 ]),false );
  test.identical( _.avector.anyNan([ 1,0,1.1 ]),false );

}

//

function allInt( test )
{

  test.identical( _.avector.allInt([ 1,2,3 ]),true );
  test.identical( _.avector.allInt([ 0,0,0 ]),true );
  test.identical( _.avector.allInt([ 0,0,1 ]),true );

  test.identical( _.avector.allInt([ 1,3,NaN ]),false );
  test.identical( _.avector.allInt([ 1,NaN,3 ]),false );
  test.identical( _.avector.allInt([ 1,3,-Infinity ]),true );
  test.identical( _.avector.allInt([ 1,+Infinity,3 ]),true );

  test.identical( _.avector.allInt([ 1.1,0,1 ]),false );
  test.identical( _.avector.allInt([ 1,0,1.1 ]),false );

}

//

// function allZero( test )
// {
//
//   test.identical( _.avector.allZero([ 1,2,3 ]),false );
//   test.identical( _.avector.allZero([ 0,0,0 ]),true );
//   test.identical( _.avector.allZero([ 0,0,1 ]),false );
//
//   test.identical( _.avector.allZero([ 0,3,NaN ]),false );
//   test.identical( _.avector.allZero([ 0,NaN,3 ]),false );
//   test.identical( _.avector.allZero([ 0,3,-Infinity ]),false );
//   test.identical( _.avector.allZero([ 0,+Infinity,3 ]),false );
//
//   test.identical( _.avector.allZero([ 1.1,0,1 ]),false );
//   test.identical( _.avector.allZero([ 1,0,1.1 ]),false );
//
// }

//

function to( test )
{

  if( Space )
  {

    test.description = 'vector to space'; //

    var v = vector.from([ 1,2,3 ]);
    var got = v.to( Space );
    var expected = Space.makeCol([ 1,2,3 ]);
    test.identical( got,expected );

  }

  test.description = 'vector to array'; //

  var v = vector.from([ 1,2,3 ]);
  var got = v.to( [].constructor );
  var expected = [ 1,2,3 ];
  test.identical( got,expected );

  test.description = 'vector to vector'; //

  var v = vector.from([ 1,2,3 ]);
  var got = v.to( vector.fromArray( [] ).constructor );
  test.shouldBe( got === v );

  test.description = 'bad arguments'; //

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to() );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( [],1 ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( 1 ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( null ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( '1' ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( [],1 ) );

}

//

function toArray( test )
{

  test.description = 'trivial'; /* */

  var v = vector.from([ 1,2,3 ]);
  var got = v.toArray();
  var expected = [ 1,2,3 ];
  test.identical( got,expected );
  test.shouldBe( v._vectorBuffer === got );

  test.description = 'trivial with fromSubArrayWithStride'; /* */

  var v = vector.fromSubArrayWithStride( [ 1,2,3,4,5 ],0,5,1 );
  var got = v.toArray();
  var expected = [ 1,2,3,4,5 ];
  test.identical( got,expected );
  test.shouldBe( v._vectorBuffer === got );

  test.description = 'with custom offset'; /* */

  var v = vector.fromSubArray( [ 1,2,3,4,5 ],1 );
  var got = v.toArray();
  var expected = [ 2,3,4,5 ];
  test.identical( got,expected );
  test.shouldBe( v._vectorBuffer !== got );

  test.description = 'with custom length'; /* */

  var v = vector.fromSubArray( [ 1,2,3,4,5 ],0,4 );
  var got = v.toArray();
  var expected = [ 1,2,3,4 ];
  test.identical( got,expected );
  test.shouldBe( v._vectorBuffer !== got );

  test.description = 'with fromSubArrayWithStride'; /* */

  var v = vector.fromSubArrayWithStride( [ 1,2,3,4,5 ],1,2,2 );
  var got = v.toArray();
  var expected = [ 2,4 ];
  test.identical( got,expected );
  test.shouldBe( v._vectorBuffer !== got );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( 0 ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( undefined ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( null ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( _.vector.from([ 1,2,3 ]) ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( '123' ) );
  test.shouldThrowErrorSync( () => vector.from([ 1,2,3 ]).to( function( a,b,c ){} ) );

}

//

function _isIdentical( test,r,t,array )
{
  var f = !t;

  // debugger;
  // var res = _.avector[ r ]( '1',3,4 );
  // debugger;

  /* */

  test.description = ' trivial'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( t,f,f );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );

  var expected = array( f,f,t );
  var got = _.avector[ r ]( 3,array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with null dst'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( t,f,f );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar, with null dst'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,array( 1,2,3 ),3 );
  test.identical( got,expected );
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,3,array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar, with null dst'; /* */
  var expected = t;
  var got = _.avector[ r ]( null,3,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( null,3,4 );
  test.identical( got,expected );

  /* */

  debugger;
  test.description = 'trivial, with dst'; /* */
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( t,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'vector and scalar, with dst'; /* */
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),3 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,array( 1,2,3 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'scalar and scalar, with scalar dst'; /* */
  var expected = t;
  var dst = 0;
  var got = _.avector[ r ]( dst,3,3 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );
  var expected = f;
  var dst = t;
  var got = _.avector[ r ]( dst,3,4 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'scalar and scalar, with vector dst'; /* */
  var expected = array( t,t,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,3 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,4 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'empty vectors'; /* */
  var expected = array();
  var got = _.avector[ r ]( array(), array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = [ t,t,t ];
  var got = _.avector[ r ]( [ 1,2,3 ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = array( t,t,t );
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,3 ]  );
  test.identical( got,expected );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

}

//

function isIdentical( test )
{

  this._isIdentical( test,'isIdentical',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isIdentical( test,'isIdentical',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isIdentical( test,'isIdentical',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function isNotIdentical( test )
{

  this._isIdentical( test,'isNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isIdentical( test,'isNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isIdentical( test,'isNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function isEquivalent( test )
{

  this._isIdentical( test,'isEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isIdentical( test,'isEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isIdentical( test,'isEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function isNotEquivalent( test )
{

  this._isIdentical( test,'isNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isIdentical( test,'isNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isIdentical( test,'isNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _isEquivalent( test,r,t,Array,array )
{
  var f = !t;
  var e = _.EPS * 0.5;

  /* */

  test.description = 'trivial'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( t,f,f );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  if( Array !== Uint32Array )
  {

    test.description = 'very close, positive elements'; /* */
    var expected = array( t,t,t,t,t,t );
    debugger;
    var got = _.avector[ r ]( array( 0+e,1+e,1001+e,0-e,1-e,1001-e ),array( -0,+1,+1001,-0,+1,+1001 ) );
    test.identical( got,expected );

    test.description = 'very close, negative elements'; /* */
    var expected = array( t,t,t,t,t,t );
    var got = _.avector[ r ]( array( -0+e,-1+e,-1001+e,-0-e,-1-e,-1001-e ),array( +0,-1,-1001,+0,-1,-1001 ) );
    test.identical( got,expected );

  }

  test.description = 'very close, scalars'; /* */
  var expected = t;
  var got = _.avector[ r ]( 1+e,1 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1-e,1 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1,1+e );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1,1-e );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with null dst'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 3,4,3+e ) );
  test.identical( got,expected );
  var expected = array( t,f,f );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 1+e,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar, with null dst'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,array( 1,2,3 ),3+e );
  test.identical( got,expected );
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,3,array( 1,2,3+e ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar, with null dst'; /* */
  var expected = t;
  var got = _.avector[ r ]( null,3+e,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( null,3,4-e );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with dst'; /* */
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3+e ),array( 3,4,3 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( t,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1+e,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'vector and scalar, with dst'; /* */
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),3+e );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,array( 1,2,3+e ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'scalar and scalar, with scalar dst'; /* */
  var expected = t;
  var dst = 0;
  var got = _.avector[ r ]( dst,3,3+e );
  test.identical( got,expected );
  test.shouldBe( got !== dst );
  var expected = f;
  var dst = t;
  var got = _.avector[ r ]( dst,3,4-e );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'scalar and scalar, with vector dst'; /* */
  var expected = array( t,t,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,3+e );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,4-e );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'different types of containers'; /* */

  var expected = [ t,t,t ] ;
  var got = _.avector[ r ]( [ 1,2,3 ], array( 1+e,2,3 ) );
  test.identical( got,expected );
  var expected = array( t,t,t );
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,3+e ]  );
  test.identical( got,expected );

}

//

function isEquivalent2( test )
{

  this._isEquivalent( test,'isEquivalent',true,Array,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isEquivalent( test,'isEquivalent',true,Float32Array,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isEquivalent( test,'isEquivalent',true,Uint32Array,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _isGreater( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = array( f,f,f );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( f,t,f );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = array( f,f,f );
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );

  var expected = array( t,f,f );
  var got = _.avector[ r ]( 2,array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 4,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with null dst'; /* */
  var expected = array( f,f,f );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( f,t,f );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar, with null dst'; /* */
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,array( 1,2,3 ),2 );
  test.identical( got,expected );
  var expected = array( t,f,f );
  var got = _.avector[ r ]( null,2,array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar, with null dst'; /* */
  var expected = t;
  var got = _.avector[ r ]( null,4,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( null,3,4 );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with dst'; /* */
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),array( 3,4,2 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,t,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'vector and scalar, with dst'; /* */
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( t,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,2,array( 1,2,3 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'scalar and scalar, with scalar dst'; /* */
  var expected = t;
  var dst = 0;
  var got = _.avector[ r ]( dst,4,3 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );
  var expected = f;
  var dst = t;
  var got = _.avector[ r ]( dst,3,4 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'scalar and scalar, with vector dst'; /* */
  var expected = array( t,t,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,4,3 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,4 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'different types of containers'; /* */

  var expected = [ f,f,t ];
  var got = _.avector[ r ]( [ 1,2,4 ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = array( f,f,f );
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,4 ]  );
  test.identical( got,expected );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

}

//

function isGreater( test )
{

  this._isGreater( test,'isGreater',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isGreater( test,'isGreater',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isGreater( test,'isGreater',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

  this._isGreater( test,'gt',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isGreater( test,'gt',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isGreater( test,'gt',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function isLessEqual( test )
{

  this._isGreater( test,'isLessEqual',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isGreater( test,'isLessEqual',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isGreater( test,'isLessEqual',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

  this._isGreater( test,'le',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isGreater( test,'le',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isGreater( test,'le',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _isLess( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = array( t,t,f );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( f,f,t );
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = array( t,t,f );
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );

  var expected = array( f,f,t );
  var got = _.avector[ r ]( 2,array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 4,3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with null dst'; /* */
  var expected = array( t,t,f );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar, with null dst'; /* */
  var expected = array( t,f,f );
  var got = _.avector[ r ]( null,array( 1,2,3 ),2 );
  test.identical( got,expected );
  var expected = array( f,f,t );
  var got = _.avector[ r ]( null,2,array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar, with null dst'; /* */
  var expected = f;
  var got = _.avector[ r ]( null,4,3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( null,3,4 );
  test.identical( got,expected );

  /* */

  test.description = 'trivial, with dst'; /* */
  var expected = array( t,t,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),array( 3,4,2 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),array( 1,1,9 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'vector and scalar, with dst'; /* */
  var expected = array( t,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,array( 1,2,3 ),2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( f,f,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,2,array( 1,2,3 ) );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'scalar and scalar, with scalar dst'; /* */
  var expected = t;
  var dst = 0;
  var got = _.avector[ r ]( dst,3,4 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );
  var expected = f;
  var dst = t;
  var got = _.avector[ r ]( dst,4,3 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'scalar and scalar, with vector dst'; /* */
  var expected = array( f,f,f );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,4,3 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var expected = array( t,t,t );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,3,4 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

}

//

function isLess( test )
{

  this._isLess( test,'isLess',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isLess( test,'isLess',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isLess( test,'isLess',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

  this._isLess( test,'lt',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isLess( test,'lt',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isLess( test,'lt',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function isGreaterEqual( test )
{

  this._isLess( test,'isGreaterEqual',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isLess( test,'isGreaterEqual',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isLess( test,'isGreaterEqual',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

  this._isLess( test,'ge',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isLess( test,'ge',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isLess( test,'ge',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function logical2ArgsZipperWithBadArguments( test,r,t,array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.description = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1,2,3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( null,[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( {}, [ 1,5 ], [ 1,2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1,5 ], { 1 : 1, 2 : 2 } ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1,1 ],[ 1,5 ], { 1 : 1, 2 : 2 } ) );

  }

  /*
  */

  for( r in _.vector )
  {
    if( !_.routineIs( _.vector[ r ] ) )
    continue;

    var op = _.vector[ r ].operation;

    if( r === 'isGreaterEqual' )
    debugger;

    if( !op )
    continue;

    if( op.reducing )
    continue;

    // if( !op.returningBoolean )
    // continue;

    if( !_.arrayIdentical( op.takingArguments,[ 2,3 ] ) )
    continue;

    forRoutine( r );
  }

}

//

function _allIdentical( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,array( 3,3,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 1,2,3 ], array( 1,2,3 ) );
  test.identical( got,expected );

}

//

function allIdentical( test )
{

  this._allIdentical( test,'allIdentical',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allIdentical( test,'allIdentical',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allIdentical( test,'allIdentical',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _anyIdentical( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,6 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,4,6 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),4 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,array( 1,3,5 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = t;
  debugger;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 1,2,3 ], array( 1,2,3 ) );
  test.identical( got,expected );

}

//

function anyIdentical( test )
{

  this._anyIdentical( test,'anyIdentical',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyIdentical( test,'anyIdentical',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyIdentical( test,'anyIdentical',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _noneIdentical( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,6 ),array( 3,2,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 4,5,6 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),4 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,array( 1,3,5 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 3,3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 4,5,6 ], array( 1,2,3 ) );
  test.identical( got,expected );

}

//

function _allNotIdentical( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 4,5,6 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),4 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,array( 3,3,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = f;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  var expected = f;
  var got = _.avector[ r ]( [ 4,5,6 ], array( 1,2,3 ) );
  test.identical( got,expected );

}

//

function allNotIdentical( test )
{
  this._allNotIdentical( test,'allNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allNotIdentical( test,'allNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allNotIdentical( test,'allNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _allEquivalent( test,r,t,Array,array )
{
  var f = !t;
  var e = _.EPS * 0.5;

  /* */

  test.description = 'trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = t
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1 + e, 2 + e, 3 + e ) );
  test.identical( got,expected );

  if( Array !== Uint32Array )
  {

    test.description = 'very close, positive elements'; /* */
    var expected = t;
    debugger;
    var got = _.avector[ r ]( array( 0+e,1+e,1001+e,0-e,1-e,1001-e ),array( -0,+1,+1001,-0,+1,+1001 ) );
    test.identical( got,expected );

    test.description = 'very close, negative elements'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( -0+e,-1+e,-1001+e,-0-e,-1-e,-1001-e ),array( +0,-1,-1001,+0,-1,-1001 ) );
    test.identical( got,expected );

  }

  test.description = 'very close, scalars'; /* */
  var expected = t;
  var got = _.avector[ r ]( 1+e,1 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1-e,1 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1,1+e );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1,1-e );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 1,2,3 ], array( 1+e,2,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,3+e ]  );
  test.identical( got,expected );

}

//

function allEquivalent( test )
{
  this._allEquivalent( test,'allEquivalent',true,Array,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allEquivalent( test,'allEquivalent',true,Float32Array,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allEquivalent( test,'allEquivalent',true,Uint32Array,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function allEquivalent2( test )
{
  this._allIdentical( test,'allEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allIdentical( test,'allEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allIdentical( test,'allEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function allNotEquivalent( test )
{
  this._allNotIdentical( test,'allNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allNotIdentical( test,'allNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allNotIdentical( test,'allNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _allGreater( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 2,2,9 ),array( 1,1,8 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );

  var expected = t;
  var got = _.avector[ r ]( 2,array( 1,1,1 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 4,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = f;
  var got = _.avector[ r ]( [ 1,2,4 ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,4 ]  );
  test.identical( got,expected );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

}

//

function allGreater( test )
{
  this._allGreater( test,'allGreater',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allGreater( test,'allGreater',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allGreater( test,'allGreater',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _anyNotIdentical( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,2,4 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1,2,3 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,array( 3,3,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 3,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = f;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  var expected = f;
  var got = _.avector[ r ]( [ 4,5,6 ], array( 1,2,3 ) );
  test.identical( got,expected );

}

//

function anyNotIdentical( test )
{
  this._anyNotIdentical( test,'anyNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyNotIdentical( test,'anyNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyNotIdentical( test,'anyNotIdentical',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _anyEquivalent( test,r,t,Array,array )
{
  var f = !t;
  var e = _.EPS * 0.5;

  /* */

  test.description = 'trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,5 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = t
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1, 2, 3 + e ) );
  test.identical( got,expected );

  if( Array !== Uint32Array )
  {

    test.description = 'very close, positive elements'; /* */
    var expected = t;
    debugger;
    var got = _.avector[ r ]( array( 0,1,1001,0,1,1001-e ),array( 0,1,1001,0,1,+1001 ) );
    test.identical( got,expected );

    test.description = 'very close, negative elements'; /* */
    var expected = t;
    var got = _.avector[ r ]( array( 0,1,1001,0,1,-1001-e ),array( 0,1,1001,0,1,-1001 ) );
    test.identical( got,expected );

  }

  test.description = 'very close, scalars'; /* */
  var expected = t;
  var got = _.avector[ r ]( 1+e,1 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1-e,1 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1,1+e );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 1,1-e );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 0,1,3+e ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3+e ),[ 0,1,3 ]  );
  test.identical( got,expected );

}

function anyEquivalent( test )
{
  this._anyEquivalent( test,'anyEquivalent',true,Array,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyEquivalent( test,'anyEquivalent',true,Float32Array,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyEquivalent( test,'anyEquivalent',true,Uint32Array,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function anyEquivalent2( test )
{
  this._anyIdentical( test,'anyEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyIdentical( test,'anyEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyIdentical( test,'anyEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function anyNotEquivalent( test )
{
  this._anyNotIdentical( test,'anyNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyNotIdentical( test,'anyNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyNotIdentical( test,'anyNotEquivalent',false,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _anyGreater( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,1,9 ),array( 1,1,8 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,4 ),3 );
  test.identical( got,expected );

  var expected = f;
  var got = _.avector[ r ]( 2,array( 3,3,3 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( 4,3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = t;
  var got = _.avector[ r ]( [ 1,2,4 ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,4 ]  );
  test.identical( got,expected );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

}

//

function anyGreater( test )
{
  this._anyGreater( test,'anyGreater',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyGreater( test,'anyGreater',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyGreater( test,'anyGreater',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function noneIdentical( test )
{
  this._noneIdentical( test,'noneIdentical',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._noneIdentical( test,'noneIdentical',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._noneIdentical( test,'noneIdentical',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function noneNotIdentical( test )
{
  this._allIdentical( test,'noneNotIdentical',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allIdentical( test,'noneNotIdentical',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allIdentical( test,'noneNotIdentical',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _noneEquivalent( test,r,t,Array,array )
{
  var f = !t;
  var e = _.EPS * 0.5;

  /* */

  test.description = 'trivial'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,5 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 1, 2, 3 + e ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 4,5,6 ) );
  test.identical( got,expected );

  if( Array !== Uint32Array )
  {

    test.description = 'very close, positive elements'; /* */
    var expected = f;
    debugger;
    var got = _.avector[ r ]( array( 0,1,1001,0,1,1001-e ),array( 0,1,1001,0,1,+1001 ) );
    test.identical( got,expected );

    test.description = 'very close, negative elements'; /* */
    var expected = f;
    var got = _.avector[ r ]( array( 0,1,1001,0,1,-1001-e ),array( 0,1,1001,0,1,-1001 ) );
    test.identical( got,expected );

  }

  test.description = 'very close, scalars'; /* */
  var expected = f;
  var got = _.avector[ r ]( 1+e,1 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 1-e,1 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 1,1+e );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 1,1-e );
  test.identical( got,expected );

  test.description = 'empty vectors'; /* */
  var expected = t;
  var got = _.avector[ r ]( array(),array() );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),[ 4,5,6 ]  );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( [ 0,1,3+e ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3+e ),[ 0,1,3 ]  );
  test.identical( got,expected );


}

//

function noneEquivalent( test )
{
  this._noneEquivalent( test,'noneEquivalent',true,Array,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._noneEquivalent( test,'noneEquivalent',true,Float32Array,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._noneEquivalent( test,'noneEquivalent',true,Uint32Array,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function noneEquivalent2( test )
{
  this._noneIdentical( test,'noneIdentical',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._noneIdentical( test,'noneIdentical',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._noneIdentical( test,'noneIdentical',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function noneNotEquivalent( test )
{
  this._allIdentical( test,'noneNotEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allIdentical( test,'noneNotEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allIdentical( test,'noneNotEquivalent',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function _noneGreater( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = ' trivial'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),array( 3,4,3 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 2,2,9 ),array( 1,1,8 ) );
  test.identical( got,expected );

  test.description = 'vector and scalar'; /* */
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),3 );
  test.identical( got,expected );

  var expected = f;
  var got = _.avector[ r ]( 2,array( 1,1,1 ) );
  test.identical( got,expected );

  test.description = 'scalar and scalar'; /* */
  var expected = f;
  var got = _.avector[ r ]( 4,3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 3,4 );
  test.identical( got,expected );

  test.description = 'different types of containers'; /* */

  var expected = f;
  var got = _.avector[ r ]( [ 1,2,4 ], array( 1,2,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ),[ 1,2,4 ]  );
  test.identical( got,expected );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector[ r ]() );
  test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

}

//

function noneGreater( test )
{
  this._noneGreater( test,'noneGreater',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._noneGreater( test,'noneGreater',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._noneGreater( test,'noneGreater',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });
}

//

function logical2ArgsReducerWithBadArguments( test,r,t,array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.description = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( null,[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1,2,3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1,5 ], { 1 : 1, 2 : 2 } ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1,5 ], undefined ) );

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

  for( r in _.vector )
  {
    if( !_.routineIs( _.vector[ r ] ) )
    continue;
/*
    // if( r === 'isZero' )
    // debugger;
*/
    var op = _.vector[ r ].operation;

    if( !op )
    continue;

    if( !op.reducing )
    continue;

    if( !op.returningBoolean )
    continue;

    if( !_.arrayIdentical( op.takingArguments,[ 2,2 ] ) )
    continue;

    forRoutine( r );
  }

}

//

function _isZero( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = 'vector'; /* */
  var expected = array( t,t,t );
  var src = array( 0,0,0 );
  var got = _.avector[ r ]( src );
  test.identical( got,expected );
  test.shouldBe( got !== src );
  var expected = array( f,f,t );
  var src = array( 1,2,0 );
  var got = _.avector[ r ]( src );
  test.identical( got,expected );
  test.shouldBe( got !== src );
  var expected = array( t,f,f );
  var src = array( 0,2,3 );
  var got = _.avector[ r ]( src );
  test.identical( got,expected );
  test.shouldBe( got !== src );

  /* */

  test.description = 'scalar'; /* */
  var expected = f;
  var src = 3;
  var got = _.avector[ r ]( src );
  test.identical( got,expected );
  var expected = t;
  var src = 0;
  var got = _.avector[ r ]( src );
  test.identical( got,expected );

  /* */

  test.description = 'empty vector'; /* */
  var expected = array();
  var src = array();
  var got = _.avector[ r ]( src );
  test.identical( got,expected );
  test.shouldBe( got !== src );

  /* */

  test.description = 'vector with null'; /* */
  var expected = array( t,t,t );
  var src = array( 0,0,0 );
  var got = _.avector[ r ]( null,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );
  var expected = array( f,f,t );
  var src = array( 1,2,0 );
  var got = _.avector[ r ]( null,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );
  var expected = array( t,f,f );
  var src = array( 0,2,3 );
  var got = _.avector[ r ]( null,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );

  /* */

  test.description = 'scalar with null'; /* */
  var expected = f;
  var src = 3;
  var got = _.avector[ r ]( null,src );
  test.identical( got,expected );
  var expected = t;
  var src = 0;
  var got = _.avector[ r ]( null,src );
  test.identical( got,expected );

  /* */

  test.description = 'empty vector with null'; /* */
  var expected = array();
  var src = array();
  var got = _.avector[ r ]( null,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );

  /* */

  test.description = 'vector with dst'; /* */
  var expected = array( t,t,t );
  var src = array( 0,0,0 );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );
  var expected = array( f,f,t );
  var src = array( 1,2,0 );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );
  var expected = array( t,f,f );
  var src = array( 0,2,3 );
  var dst = array( -1,-1,-1 );
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );

  /* */

  test.description = 'scalar with dst'; /* */
  var expected = array( f );
  var src = 3;
  var dst = array( -1 );
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  var expected = array( t );
  var src = 0;
  var dst = array( -1 );
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  var expected = f;
  var src = 3;
  var dst = -1;
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  var expected = t;
  var src = 0;
  var dst = -1;
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );

  /* */

  test.description = 'empty vector with dst'; /* */
  var expected = array();
  var src = array();
  var dst = array();
  var got = _.avector[ r ]( dst,src );
  test.identical( got,expected );
  test.shouldBe( got !== src );

}

//

function isZero( test )
{

  this._isZero( test,'isZero',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._isZero( test,'isZero',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._isZero( test,'isZero',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function logical1ArgsSinglerWithBadArguments( test,r,t,array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.description = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1' ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10,10,3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,10,3 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1 ],[ 1 ],[ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,[ 1 ],[ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,10,[ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,[ 1 ],1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1,2,3 ) );

  }

  /*
  */

  for( r in _.vector )
  {

    if( !_.routineIs( _.vector[ r ] ) )
    continue;

    var op = _.vector[ r ].operation;

    if( !op )
    continue;

    if( op.reducing )
    continue;

    if( !op.returningBoolean )
    continue;

    if( !_.arrayIdentical( op.takingArguments,[ 1,2 ] ) )
    continue;

    debugger;
    forRoutine( r );

  }

}

//

function _allZero( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = 'vector';
  var expected = t;
  var got = _.avector[ r ]( array( 0,0,0 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,0 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 0,2,3 ) );
  test.identical( got,expected );

  /* */

  test.description = 'scalar';
  var expected = f;
  var got = _.avector[ r ]( 3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 0 );
  test.identical( got,expected );

  /* */

  test.description = 'empty vector';
  var expected = t;
  var got = _.avector[ r ]( array() );
  test.identical( got,expected );

  /* */

  test.description = 'not';

  test.identical( _.avector[ r ]([ 1,2,3 ]),false );
  test.identical( _.avector[ r ]([ 0,0,1 ]),false );

  test.identical( _.avector[ r ]([ 0,3,NaN ]),false );
  test.identical( _.avector[ r ]([ 0,NaN,3 ]),false );
  test.identical( _.avector[ r ]([ 0,3,-Infinity ]),false );
  test.identical( _.avector[ r ]([ 0,+Infinity,3 ]),false );

  test.identical( _.avector[ r ]([ 1.1,0,1 ]),false );
  test.identical( _.avector[ r ]([ 1,0,1.1 ]),false );

}

//

function allZero( test )
{

  this._allZero( test,'allZero',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._allZero( test,'allZero',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._allZero( test,'allZero',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _anyZero( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = 'vector';
  var expected = t;
  var got = _.avector[ r ]( array( 0,0,0 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,0 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 0,2,3 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,3 ) );
  test.identical( got,expected );

  /* */

  test.description = 'scalar';
  var expected = f;
  var got = _.avector[ r ]( 3 );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( 0 );
  test.identical( got,expected );

  /* */

  test.description = 'empty vector';
  var expected = t;
  var got = _.avector[ r ]( array() );
  test.identical( got,expected );

  /* */

  test.description = 'not';

  test.identical( _.avector[ r ]([ 1,2,3 ]),false );
  test.identical( _.avector[ r ]([ 3,4,1 ]),false );

  test.identical( _.avector[ r ]([ 1,3,NaN ]),false );
  test.identical( _.avector[ r ]([ 1,NaN,3 ]),false );
  test.identical( _.avector[ r ]([ 1,3,-Infinity ]),false );
  test.identical( _.avector[ r ]([ 1,+Infinity,3 ]),false );

  test.identical( _.avector[ r ]([ 1.1,0.001,1 ]),false );
  test.identical( _.avector[ r ]([ 1,0.001,1.1 ]),false );

}

//

function anyZero( test )
{

  this._anyZero( test,'anyZero',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._anyZero( test,'anyZero',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._anyZero( test,'anyZero',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function _noneZero( test,r,t,array )
{
  var f = !t;

  /* */

  test.description = 'vector';
  var expected = f;
  var got = _.avector[ r ]( array( 0,0,0 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 1,2,0 ) );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( array( 0,2,3 ) );
  test.identical( got,expected );
  var expected = t;
  var got = _.avector[ r ]( array( 1,2,3 ) );
  test.identical( got,expected );

  /* */

  test.description = 'scalar';
  var expected = t;
  var got = _.avector[ r ]( 3 );
  test.identical( got,expected );
  var expected = f;
  var got = _.avector[ r ]( 0 );
  test.identical( got,expected );

  /* */

  test.description = 'empty vector';
  var expected = t;
  var got = _.avector[ r ]( array() );
  test.identical( got,expected );

  /* */

  test.description = 'not';

  test.identical( _.avector[ r ]([ 1,0,3 ]),false );
  test.identical( _.avector[ r ]([ 0,0,1 ]),false );

  test.identical( _.avector[ r ]([ 0,3,NaN ]),false );
  test.identical( _.avector[ r ]([ 0,NaN,3 ]),false );
  test.identical( _.avector[ r ]([ 0,3,-Infinity ]),false );
  test.identical( _.avector[ r ]([ 0,+Infinity,3 ]),false );

  test.identical( _.avector[ r ]([ 1.1,0,1 ]),false );
  test.identical( _.avector[ r ]([ 1,0,1.1 ]),false );

}

//

function noneZero( test )
{

  this._noneZero( test,'noneZero',true,function()
  {
    return _.arrayMakeSimilar( Array,arguments );
  });

  this._noneZero( test,'noneZero',true,function()
  {
    return _.arrayMakeSimilar( Float32Array,arguments );
  });

  this._noneZero( test,'noneZero',true,function()
  {
    return _.arrayMakeSimilar( Uint32Array,arguments );
  });

}

//

function logical1ArgsReducerWithBadArguments( test,r,t,array )
{
  var f = !t;

  function forRoutine( r )
  {

    test.description = 'bad arguments for ' + r; /* */

    if( !Config.debug )
    return;

    test.shouldThrowErrorSync( () => _.avector[ r ]() );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1' ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 10,10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 1 ],[ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,10 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,[ 1 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( undefined,3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( '1',3,4 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ],[ 6 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,4 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3,3 ],[ 4 ] ) );

    test.shouldThrowErrorSync( () => _.avector[ r ]( null,[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( [ 3 ],[ 4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( null,1 ) );
    test.shouldThrowErrorSync( () => _.avector[ r ]( 1,2,3 ) );

  }

  /*
  */

  for( r in _.vector )
  {

    if( !_.routineIs( _.vector[ r ] ) )
    continue;

    var op = _.vector[ r ].operation;

    if( !op )
    continue;

    if( !op.reducing )
    continue;

    if( !op.returningBoolean )
    continue;

    if( !_.arrayIdentical( op.takingArguments,[ 1,1 ] ) )
    continue;

    debugger;
    forRoutine( r );

  }

}

//

function sort( test )
{

  // 13.00 13.00 10.00 10.00 10.00 2.00 10.00 15.00 2.00 14.00 10.00 6.00 6.000 15.00 4.00 8.00

  var samples =
  [

    [ 0 ],

    [ 0,1 ],
    [ 1,0 ],

    [ 1,0,2 ],
    [ 2,0,1 ],
    [ 0,1,2 ],
    [ 0,2,1 ],
    [ 2,1,0 ],
    [ 1,2,0 ],

    [ 0,1,1 ],
    [ 1,0,1 ],
    [ 1,1,0 ],

    [ 0,0,1,1 ],
    [ 0,1,1,0 ],
    [ 1,1,0,0 ],
    [ 1,0,1,0 ],
    [ 0,1,0,1 ],

    /*_.arrayFillTimes( [], 16 ).map( function(){ return Math.floor( Math.random() * 16 ) } ),*/

  ];

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample1 = samples[ s ].slice();
    var sample2 = samples[ s ].slice();
    debugger;
    _.vector.sort( _.vector.fromArray( sample1 ) );
    sample2.sort();
    test.identical( sample1,sample2 );
  }

}

//

function dot( test )
{

  var a = [ 1,2,3,4 ];
  var b = [ 6,7,8,9 ];

  var or1 = [ 3,1,5 ];
  var or2 = [ -1,3,0 ];

  test.description = 'anrarrays'; //

  var expected = 80;
  var got = _.avector.dot( a,b );
  test.identical( got,expected )

  test.description = 'orthogonal anrarrays'; //

  var expected = 0;
  var got = _.avector.dot( or1,or2 );
  test.identical( got,expected )

  test.description = 'empty anarrays'; //

  var expected = 0;
  var got = _.avector.dot( [],[] );
  test.identical( got,expected )

  test.description = 'empty vectors'; //

  var expected = 0;
  var got = _.avector.dot( vec([]),vec([]) );
  test.identical( got,expected )

  test.description = 'subarray vectors'; //

  var av = _.vector.fromSubArray( a,1,3 );
  var bv = _.vector.fromSubArray( b,1,3 );
  var expected = 74;
  var got = _.avector.dot( av,bv );
  test.identical( got,expected );

  test.description = 'bad arguments'; //

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector.dot( 1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( undefined,1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ],undefined ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ],[ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [ 1 ],[ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.dot( [],function(){} ) );

  debugger;
}

//

function cross( test )
{
  debugger;

  test.description = 'trivial, make new'; //

  var a = [ 1,2,3 ];
  var b = [ 4,5,6 ];
  var expected = [ -3,+6,-3 ];
  debugger;
  var got = _.avector.cross( null,a,b );
  debugger;
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'zero, make new'; //

  var a = [ 0,0,0 ];
  var b = [ 0,0,0 ];
  var expected = [ 0,0,0 ];
  var got = _.avector.cross( null,a,b );
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'same, make new'; //

  var a = [ 1,1,1 ];
  var b = [ 1,1,1 ];
  var expected = [ 0,0,0 ];
  var got = _.avector.cross( null,a,b );
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'perpendicular1, make new'; //

  var a = [ 1,0,0 ];
  var b = [ 0,0,1 ];
  var expected = [ 0,-1,0 ];
  var got = _.avector.cross( null,a,b );
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'perpendicular2, make new'; //

  var a = [ 0,0,1 ];
  var b = [ 1,0,0 ];
  var expected = [ 0,+1,0 ];
  var got = _.avector.cross( null,a,b );
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'perpendicular3, make new'; //

  var a = [ 1,0,0 ];
  var b = [ 0,1,0 ];
  var expected = [ 0,0,+1 ];
  var got = _.avector.cross( null,a,b );
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'perpendicular4, make new'; //

  var a = [ 0,1,0 ];
  var b = [ 1,0,0 ];
  var expected = [ 0,0,-1 ];
  var got = _.avector.cross( null,a,b );
  test.identical( got,expected );
  test.shouldBe( got !== a );

  test.description = 'trivial'; ///

  var a = [ 1,2,3 ];
  var b = [ 4,5,6 ];
  var expected = [ -3,+6,-3 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'zero'; //

  var a = [ 0,0,0 ];
  var b = [ 0,0,0 ];
  var expected = [ 0,0,0 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'same'; //

  var a = [ 1,1,1 ];
  var b = [ 1,1,1 ];
  var expected = [ 0,0,0 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular1'; //

  var a = [ 1,0,0 ];
  var b = [ 0,0,1 ];
  var expected = [ 0,-1,0 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular2'; //

  var a = [ 0,0,1 ];
  var b = [ 1,0,0 ];
  var expected = [ 0,+1,0 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular3'; //

  var a = [ 1,0,0 ];
  var b = [ 0,1,0 ];
  var expected = [ 0,0,+1 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular4'; //

  var a = [ 0,1,0 ];
  var b = [ 1,0,0 ];
  var expected = [ 0,0,-1 ];
  var got = _.avector.cross( a,b );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'trivial'; ///

  var a = [ 1,2,3 ];
  var b = [ 4,5,6 ];
  var c = [ 7,8,9 ];
  var expected = [ 78,6,-66 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'zero'; //

  var a = [ 0,0,0 ];
  var b = [ 0,0,0 ];
  var c = [ 7,8,9 ];
  var expected = [ 0,0,0 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'same'; //

  var a = [ 1,1,1 ];
  var b = [ 1,1,1 ];
  var c = [ 7,8,9 ];
  var expected = [ 0,0,0 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular1'; //

  var a = [ 1,0,0 ];
  var b = [ 0,0,1 ];
  var c = [ 7,8,9 ];
  var expected = [ -9,0,7 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular2'; //

  var a = [ 0,0,1 ];
  var b = [ 1,0,0 ];
  var c = [ 7,8,9 ];
  var expected = [ 9,0,-7 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular3'; //

  var a = [ 1,0,0 ];
  var b = [ 0,1,0 ];
  var c = [ 7,8,9 ];
  var expected = [ -8,7,0 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'perpendicular4'; //

  var a = [ 0,1,0 ];
  var b = [ 1,0,0 ];
  var c = [ 7,8,9 ];
  var expected = [ 8,-7,0 ];
  var got = _.avector.cross( a,b,c );
  test.identical( got,expected );
  test.shouldBe( got === a );

  test.description = 'bad arguments'; ///

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector.cross( 1 ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( undefined,[ 1,2,3 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( null,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ],undefined ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ],[ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [ 1 ],[ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.cross( [],function(){} ) );

}

//

function subarray( test )
{

  test.description = 'trivial'; //

  var v = vec([ 1,2,3 ]);
  test.identical( v.subarray( 0,2 ),vec([ 1,2 ]) );
  test.identical( v.subarray( 1,3 ),vec([ 2,3 ]) );

  test.description = 'subarray from vector with stride'; //

  var v = vector.fromSubArrayWithStride( [ -1,1,-2,2,-2,3 ],1,3,2 );
  test.identical( v.subarray( 0,2 ),vec([ 1,2 ]) );
  test.identical( v.subarray( 1,3 ),vec([ 2,3 ]) );

  test.description = 'get empty subarray'; //

  var v = vector.fromSubArrayWithStride( [ -1,1,-2,2,-2,3 ],1,3,2 );
  test.identical( v.subarray( 0,0 ),vec([]) );
  test.identical( v.subarray( 2,2 ),vec([]) );
  test.identical( v.subarray( 3,3 ),vec([]) );
  test.identical( v.subarray( 10,3 ),vec([]) );
  test.identical( v.subarray( 10,0 ),vec([]) );
  test.identical( v.subarray( 10,10 ),vec([]) );
  test.identical( v.subarray( 10,11 ),vec([]) );
  test.identical( v.subarray( -2,-2 ),vec([]) );
  test.identical( v.subarray( -2,-1 ),vec([]) );

  test.description = 'missing argument'; //

  test.identical( v.subarray( undefined,2 ),vec([ 1,2 ]) );
  test.identical( v.subarray( 1 ),vec([ 2,3 ]) );

  test.description = 'bad arguments'; //

  var v = vec([ 1,2,3 ]);
  test.shouldThrowErrorSync( () => v.subarray() );
  var v = vec([ 1,2,3 ]);
  test.shouldThrowErrorSync( () => v.subarray( 10,10,10 ) );

  // var v = vector.fromSubArrayWithStride( [ -1,1,-2,2,-2,3 ],1,3,2 );
  // test.shouldThrowErrorSync( () => v.subarray( -1,1 ) );
  //
  // var v = vec([ 1,2,3 ]);
  // test.shouldThrowErrorSync( () => v.subarray( -1,1 ) );
  //
  // var v = vector.fromSubArrayWithStride( [ -1,1,-2,2,-2,3 ],1,3,2 );
  // test.shouldThrowErrorSync( () => v.subarray( 10,10 ) );
  //
  // var v = vec([ 1,2,3 ]);
  // test.shouldThrowErrorSync( () => v.subarray( 10,10 ) );

  debugger;
}

//

function add( test )
{

  test.description = 'vector vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.add( null,ins1,ins2 );

  test.identical( got,[ 4,6,8 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.add( null,ins1,ins2,ins3 );

  test.identical( got,[ 14,26,38 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.add( null,ins1,ins2 );

  test.identical( got,[ 11,12,13 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.add( null,ins1,ins2,ins3 );

  test.identical( got,[ 21,32,43 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.add( null,ins1,ins2 );

  test.identical( got,[ 11,12,13 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.add( null,ins1,ins2,ins3 );

  test.identical( got,[ 21,32,43 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar, new dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.add( null,ins1,ins2 );

  test.identical( got,11 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar scalar, new dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.add( null,ins1,ins2,ins3 );

  test.identical( got,111 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector, first argument is dst'; ///

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var got = _.avector.add( ins1,ins2 );

  test.identical( got,[ 4,6,8 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'vector vector vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.add( ins1,ins2,ins3 );

  test.identical( got,[ 14,26,38 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.add( ins1,ins2 );

  test.identical( got,[ 11,12,13 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.add( ins1,ins2,ins3 );

  test.identical( got,[ 21,32,43 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.add( ins1,ins2 );

  test.identical( got,[ 11,12,13 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];
  var got = _.avector.add( ins1,ins2,ins3 );

  test.identical( got,[ 21,32,43 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'scalar scalar, first argument is dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.add( ins1,ins2 );

  test.identical( got,11 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  test.description = 'scalar scalar scalar, first argument is dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.add( ins1,ins2,ins3 );

  test.identical( got,111 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.avector.add( [ 1,2,3 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.add( [ 1,2,3 ],[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.add( '1',[ 3,4,5 ],null ) );

  test.shouldThrowErrorSync( () => _.avector.add( [ 0,0,0 ],[ 1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.add( [ 0,0 ],[ 1,1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.add( [ 0 ],[ 1,1,1 ] ) );

}

//

function sub( test )
{

  test.description = 'trivial'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var got = _.avector.sub( ins1,ins2 );

  test.identical( got,[ -2,-2,-2 ] );
  test.identical( ins1,[ -2,-2,-2 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got == ins1 );

  test.description = 'vector vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.sub( null,ins1,ins2 );

  test.identical( got,[ -2,-2,-2 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.sub( null,ins1,ins2,ins3 );

  test.identical( got,[ -12,-22,-32 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.sub( null,ins1,ins2 );

  test.identical( got,[ -9,-8,-7 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.sub( null,ins1,ins2,ins3 );

  test.identical( got,[ -19,-28,-37 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.sub( null,ins1,ins2 );

  test.identical( got,[ 9,8,7 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.sub( null,ins1,ins2,ins3 );

  test.identical( got,[ -1,-12,-23 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar, new dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.sub( null,ins1,ins2 );

  test.identical( got,-9 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar scalar, new dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.sub( null,ins1,ins2,ins3 );

  test.identical( got,-109 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector, first argument is dst'; ///

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.sub( ins1,ins2 );

  test.identical( got,[ -2,-2,-2 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'vector vector vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.sub( ins1,ins2,ins3 );

  test.identical( got,[ -12,-22,-32 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.sub( ins1,ins2 );

  test.identical( got,[ -9,-8,-7 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.sub( ins1,ins2,ins3 );

  test.identical( got,[ -19,-28,-37 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.sub( ins1,ins2 );

  test.identical( got,[ 9,8,7 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.sub( ins1,ins2,ins3 );

  test.identical( got,[ -1,-12,-23 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'scalar scalar, first argument is dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.sub( ins1,ins2 );

  test.identical( got,-9 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  test.description = 'scalar scalar scalar, first argument is dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.sub( ins1,ins2,ins3 );

  test.identical( got,-109 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.avector.sub( [ 1,2,3 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 1,2,3 ],[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.sub( '1',[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 0,0,0 ],[ 1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 0,0 ],[ 1,1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.sub( [ 0 ],[ 1,1,1 ] ) );

}

//

function mul( test )
{

  test.description = 'vector vector, new dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.mul( null,ins1,ins2 );

  test.identical( got,[ 3,8,15 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.mul( null,ins1,ins2,ins3 );

  test.identical( got,[ 30,160,450 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.mul( null,ins1,ins2 );

  test.identical( got,[ 10,20,30 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.mul( null,ins1,ins2,ins3 );

  test.identical( got,[ 100,400,900 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.mul( null,ins1,ins2 );

  test.identical( got,[ 10,20,30 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.mul( null,ins1,ins2,ins3 );

  test.identical( got,[ 100,400,900 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar, new dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.mul( null,ins1,ins2 );

  test.identical( got,10 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar scalar, new dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.mul( null,ins1,ins2,ins3 );

  test.identical( got,1000 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector, first argument is dst'; ///

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.mul( ins1,ins2 );

  test.identical( got,[ 3,8,15 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'vector vector vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.mul( ins1,ins2,ins3 );

  test.identical( got,[ 30,160,450 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.mul( ins1,ins2 );

  test.identical( got,[ 10,20,30 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.mul( ins1,ins2,ins3 );

  test.identical( got,[ 100,400,900 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.mul( ins1,ins2 );

  test.identical( got,[ 10,20,30 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.mul( ins1,ins2,ins3 );

  test.identical( got,[ 100,400,900 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'scalar scalar, first argument is dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.mul( ins1,ins2 );

  test.identical( got,10 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  test.description = 'scalar scalar scalar, first argument is dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.mul( ins1,ins2,ins3 );

  test.identical( got,1000 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.avector.mul( [ 1,2,3 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 1,2,3 ],[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.mul( '1',[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 0,0,0 ],[ 1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 0,0 ],[ 1,1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mul( [ 0 ],[ 1,1,1 ] ) );

}

//

function div( test )
{

  test.description = 'vector vector, new dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.div( null,ins1,ins2 );

  test.identical( got,[ 1/3,2/4,3/5 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.div( null,ins1,ins2,ins3 );

  test.identical( got,[ 1/3/10,2/4/20,3/5/30 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.div( null,ins1,ins2 );

  test.identical( got,[ 1/10,2/10,3/10 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.div( null,ins1,ins2,ins3 );

  test.identical( got,[ 1/10/10,2/10/20,3/10/30 ] );
  test.identical( ins1,[ 1,2,3 ] );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar vector, new dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.div( null,ins1,ins2 );

  test.identical( got,[ 10/1,10/2,10/3 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'vector scalar vector, new dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.div( null,ins1,ins2,ins3 );

  test.identical( got,[ 10/1/10,10/2/20,10/3/30 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar, new dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.div( null,ins1,ins2 );

  test.identical( got,1/10 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'scalar scalar scalar, new dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.div( null,ins1,ins2,ins3 );

  test.identical( got,1/10/100 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );
  test.shouldBe( got !== ins1 );

  test.description = 'vector vector, first argument is dst'; ///

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];

  var got = _.avector.div( ins1,ins2 );

  test.identical( got,[ 1/3,2/4,3/5 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'vector vector vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = [ 3,4,5 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.div( ins1,ins2,ins3 );

  test.identical( got,[ 1/3/10,2/4/20,3/5/30 ] );
  test.identical( ins2,[ 3,4,5 ] );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;

  var got = _.avector.div( ins1,ins2 );

  test.identical( got,[ 1/10,2/10,3/10 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = [ 1,2,3 ];
  var ins2 = 10;
  var ins3 = [ 10,20,30 ];

  var got = _.avector.div( ins1,ins2,ins3 );

  test.identical( got,[ 1/10/10,2/10/20,3/10/30 ] );
  test.identical( ins2,10 );
  test.shouldBe( got === ins1 );

  test.description = 'scalar vector, first argument is dst'; //

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];

  var got = _.avector.div( ins1,ins2 );

  test.identical( got,[ 10/1,10/2,10/3 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'vector scalar vector, first argument is dst'; /* */

  var ins1 = 10;
  var ins2 = [ 1,2,3 ];
  var ins3 = [ 10,20,30 ];

  var got = _.avector.div( ins1,ins2,ins3 );

  test.identical( got,[ 10/1/10,10/2/20,10/3/30 ] );
  test.identical( ins1,10 );
  test.identical( ins2,[ 1,2,3 ] );

  test.description = 'scalar scalar, first argument is dst'; //

  var ins1 = 1;
  var ins2 = 10;

  var got = _.avector.div( ins1,ins2 );

  test.identical( got,1/10 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  test.description = 'scalar scalar scalar, first argument is dst'; /* */

  var ins1 = 1;
  var ins2 = 10;
  var ins3 = 100;

  var got = _.avector.div( ins1,ins2,ins3 );

  test.identical( got,1/10/100 );
  test.identical( ins1,1 );
  test.identical( ins2,10 );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.avector.div( [ 1,2,3 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 1,2,3 ],[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.div( '1',[ 3,4,5 ],null ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 0,0,0 ],[ 1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 0,0 ],[ 1,1,1 ] ) );
  test.shouldThrowErrorSync( () => _.avector.div( [ 0 ],[ 1,1,1 ] ) );

}

//

function abs( test )
{

  test.description = 'trivial';

  var expected = [ 1,2,3 ];
  var dst = [ -1,-2,-3 ];
  debugger;
  var got = _.avector.abs( dst );

  test.identical( got,expected );
  test.shouldBe( dst === got );

}

//

function distributionRangeSummary( test )
{

  var empty = [];
  var a = [ 1,2,3,4,5 ];
  var b = [ 55,22,33,99,2,22,3,33,4,99,5,44 ];
  var filter = ( e,o ) => !(e % 2);

  test.description = 'distributionRangeSummary single element'; //

  var ar = [ 1 ];
  var expected =
  {
    min : { value : 1, index : 0, container : vec( ar ) },
    max : { value : 1, index : 0, container : vec( ar ) },
    median : 1,
  };

  var got = _.avector.distributionRangeSummary( ar );
  test.identical( got,expected );

  test.description = 'reduceToMax single element'; //

  var ar = [ 1 ];
  var expected = { value : 1, index : 0, container : vec( ar ) };
  var got = _.avector.reduceToMax( ar );
  test.identical( got,expected );

  var ar = [ 1 ];
  var expected = { value : 1, index : 0, container : vec( ar ) };
  var got = vector.reduceToMax( vec( ar ) );
  test.identical( got,expected );

  test.description = 'trivial'; //

  var expected =
  {
    min : { value : 1, index : 0, container : vec( a ) },
    max : { value : 5, index : 4, container : vec( a ) },
    median : 3,
  };

  var got = _.avector.distributionRangeSummary( a );
  test.identical( got,expected );

  test.description = 'simplest case with filtering'; //

  var expected =
  {
    min : { value : 2, index : 1, container : vec( a ) },
    max : { value : 4, index : 3, container : vec( a ) },
    median : 3,
  };

  var got = _.avector.distributionRangeSummaryConditional( a,filter );
  test.identical( got,expected );

  test.description = 'several vectors'; //

  var expected =
  {
    min : { value : 1, index : 0, container : vec( a ) },
    max : { value : 99, index : 3, container : vec( b ) },
    median : 50,
  };

  var got = _.avector.distributionRangeSummary( a,b );
  test.identical( got,expected );

  test.description = 'several vectors with filtering'; //

  var expected =
  {
    min : { value : 2, index : 1, container : vec( a ) },
    max : { value : 44, index : 11, container : vec( b ) },
    median : 23,
  };

  var got = _.avector.distributionRangeSummaryConditional( a,b,filter );
  test.identical( got,expected );

  test.description = 'empty array'; //

  var expected =
  {
    min : { value : NaN, index : -1, container : null },
    max : { value : NaN, index : -1, container : null },
    median : NaN,
  };
  var got = _.avector.distributionRangeSummary( empty );
  test.identical( got,expected )

  test.description = 'empty array with filtering'; //

  var expected =
  {
    min : { value : NaN, index : -1, container : null },
    max : { value : NaN, index : -1, container : null },
    median : NaN,
  };
  var got = _.avector.distributionRangeSummaryConditional( empty,filter );
  test.identical( got,expected )

  // test.description = 'no array'; //
  //
  // var expected =
  // {
  //   min : { value : NaN, index : -1, container : null },
  //   max : { value : NaN, index : -1, container : null },
  // };
  // var got = _.avector.distributionRangeSummary();
  // test.identical( got,expected )
  //
  // test.description = 'no array with filtering'; //
  //
  // var expected =
  // {
  //   min : { value : NaN, index : -1, container : null },
  //   max : { value : NaN, index : -1, container : null },
  // };
  // var got = _.avector.distributionRangeSummaryConditional( filter );
  // test.identical( got,expected )

  test.description = 'bad arguments'; //

  if( Config.debug )
  {

    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary() );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( 1 ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( '1' ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( [ 1 ],1 ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummary( [ 1 ],undefined ) );

    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional() );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1,2,3 ] ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1,2,3 ],null ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1,2,3 ],() => true ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( 1,filter ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1 ],1,filter ) );
    test.shouldThrowErrorSync( () => _.avector.distributionRangeSummaryConditional( [ 1 ],undefined,filter ) );

  }

}

//

function reduceToMean( test )
{

  test.description = 'simple even'; //

  var expected = 2.5;
  var got = _.avector.reduceToMean([ 1,2,3,4 ]);
  test.equivalent( got,expected );

  test.description = 'simple odd'; //

  var expected = 2;
  var got = _.avector.reduceToMean([ 1,2,3 ]);
  test.equivalent( got,expected );

  test.description = 'several vectors'; //

  var expected = 3;
  var got = _.avector.reduceToMean( [ 1,2,3 ],[ 4,5 ] );
  test.equivalent( got,expected );

  test.description = 'empty'; //

  var expected = NaN;
  var got = _.avector.reduceToMean([]);
  test.equivalent( got,expected );

  test.description = 'simple even, filtering'; //

  var expected = 2;
  debugger;
  var got = _.avector.reduceToMeanConditional( [ 1,2,3,4 ],( e,op ) => e % 2 );
  debugger;
  test.equivalent( got,expected );

  test.description = 'simple odd, filtering'; //

  var expected = 2;
  var got = _.avector.reduceToMeanConditional( [ 1,2,3 ],( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'several vectors, filtering'; //

  var expected = 3;
  var got = _.avector.reduceToMeanConditional( [ 1,2,3 ],[ 4,5 ],( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'empty, filtering'; //

  var expected = NaN;
  var got = _.avector.reduceToMeanConditional( [],( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.avector.reduceToMean() );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( 'x' ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( 1 ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( [ 1 ],'x' ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMean( [ 1 ],1 ) );

  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional() );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( 'x',() => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( 1,() => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( [ 1 ],'x',() => true ) );
  test.shouldThrowErrorSync( () => _.avector.reduceToMeanConditional( [ 1 ],1,() => true ) );

}

//

function median( test )
{

  test.description = 'simple even'; //

  var expected = 5;
  var got = _.avector.median([ 1,2,3,9 ]);
  test.equivalent( got,expected );

  test.description = 'simple odd'; //

  var expected = 5;
  var got = _.avector.median([ 1,2,9 ]);
  test.equivalent( got,expected );

  test.description = 'empty'; //

  var expected = NaN;
  var got = _.avector.median([]);
  test.equivalent( got,expected );

}

//

function mean( test )
{

  test.description = 'simple even'; //

  var expected = 2.5;
  var got = _.avector.mean([ 1,2,3,4 ]);
  test.equivalent( got,expected );

  test.description = 'simple odd'; //

  var expected = 2;
  var got = _.avector.mean([ 1,2,3 ]);
  test.equivalent( got,expected );

  test.description = 'empty'; //

  var expected = 0;
  var got = _.avector.mean([]);
  test.equivalent( got,expected );

  test.description = 'simple even, filtering'; //

  var expected = 2;
  debugger;
  var got = _.avector.meanConditional( [ 1,2,3,4 ],( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'simple odd, filtering'; //

  var expected = 2;
  var got = _.avector.meanConditional( [ 1,2,3 ],( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'empty, filtering'; //

  var expected = 0;
  var got = _.avector.meanConditional( [],( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.mean() );
  test.shouldThrowErrorSync( () => _.mean( 'x' ) );
  test.shouldThrowErrorSync( () => _.mean( 1 ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ],'x' ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.mean( [ 1 ],[ 1 ] ) );

  test.shouldThrowErrorSync( () => _.meanConditional() );
  test.shouldThrowErrorSync( () => _.meanConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( 'x',() => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( 1,() => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ],'x',() => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ],1,() => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ],[ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.meanConditional( [ 1 ],[ 1 ],() => true ) );

}

//

function moment( test )
{
  debugger;

  test.description = 'first even'; //

  var expected = 2.5;
  var got = _.avector.moment( [ 1,2,3,4 ],1 );
  test.equivalent( got,expected );

  test.description = 'first odd'; //

  var expected = 2;
  var got = _.avector.moment( [ 1,2,3 ],1 );
  test.equivalent( got,expected );

  test.description = 'first empty'; //

  var expected = 0;
  var got = _.avector.moment( [],1 );
  test.equivalent( got,expected );

  test.description = 'second even'; //

  var expected = 30 / 4;
  var got = _.avector.moment( [ 1,2,3,4 ],2 );
  test.equivalent( got,expected );

  test.description = 'second odd'; //

  var expected = 14 / 3;
  var got = _.avector.moment( [ 1,2,3 ],2 );
  test.equivalent( got,expected );

  test.description = 'second empty'; //

  var expected = 0;
  var got = _.avector.moment( [],2 );
  test.equivalent( got,expected );

  test.description = 'simple even, filtering'; //

  var expected = 5;
  var got = _.avector.momentConditional( [ 1,2,3,4 ],2,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'simple odd, filtering'; //

  var expected = 5;
  var got = _.avector.momentConditional( [ 1,2,3 ],2,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'empty, filtering'; //

  var expected = 0;
  var got = _.avector.momentConditional( [],2,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.moment() );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.moment( 1 ) );
  test.shouldThrowErrorSync( () => _.moment( 'x',1 ) );
  test.shouldThrowErrorSync( () => _.moment( 1,1 ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ],'x' ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.moment( [ 1 ],[ 1 ] ) );

  test.shouldThrowErrorSync( () => _.momentConditional() );
  test.shouldThrowErrorSync( () => _.momentConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 1 ),() => true );
  test.shouldThrowErrorSync( () => _.momentConditional( 'x',1,() => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 1,1,() => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ],'x',() => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( 1,[ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ],[ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentConditional( [ 1 ],[ 1 ],() => true ) );

}

//

function momentCentral( test )
{

  test.description = 'first even'; //

  var expected = 0;
  var got = _.avector.momentCentral( [ 1,2,3,4 ],1,2.5 );
  test.equivalent( got,expected );

  test.description = 'first odd'; //

  var expected = 0;
  var got = _.avector.momentCentral( [ 1,2,3 ],1,2 );
  test.equivalent( got,expected );

  test.description = 'first empty'; //

  var expected = 0;
  var got = _.avector.momentCentral( [],1,0 );
  test.equivalent( got,expected );

  test.description = 'second even'; //

  var expected = 5 / 4;
  var got = _.avector.momentCentral( [ 1,2,3,4 ],2,2.5 );
  test.equivalent( got,expected );

  test.description = 'second odd'; //

  var expected = 2 / 3;
  debugger;
  var got = _.avector.momentCentral( [ 1,2,3 ],2,2 );
  test.equivalent( got,expected );

  test.description = 'second empty'; //

  var expected = 0;
  var got = _.avector.momentCentral( [],2,0 );
  test.equivalent( got,expected );

  test.description = 'first even'; //

  var expected = 0;
  var got = _.avector.momentCentral( [ 1,2,3,4 ],1 );
  test.equivalent( got,expected );

  test.description = 'first odd'; //

  var expected = 0;
  var got = _.avector.momentCentral( [ 1,2,3 ],1 );
  test.equivalent( got,expected );

  test.description = 'first empty'; //

  var expected = 0;
  var got = _.avector.momentCentral( [],1 );
  test.equivalent( got,expected );

  test.description = 'second even'; //

  var expected = 5 / 4;
  var got = _.avector.momentCentral( [ 1,2,3,4 ],2 );
  test.equivalent( got,expected );

  test.description = 'second odd'; //

  var expected = 2 / 3;
  debugger;
  var got = _.avector.momentCentral( [ 1,2,3 ],2 );
  test.equivalent( got,expected );

  test.description = 'second empty'; //

  var expected = 0;
  var got = _.avector.momentCentral( [],2 );
  test.equivalent( got,expected );

  test.description = 'first even, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentral( [ 1,2,3,4 ],1,null );
  test.equivalent( got,expected );

  test.description = 'first odd, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentral( [ 1,2,3 ],1,null );
  test.equivalent( got,expected );

  test.description = 'first empty, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentral( [],1,null );
  test.equivalent( got,expected );

  test.description = 'second even, with mean : null'; //

  var expected = 5 / 4;
  var got = _.avector.momentCentral( [ 1,2,3,4 ],2,null );
  test.equivalent( got,expected );

  test.description = 'second odd, with mean : null'; //

  var expected = 2 / 3;
  debugger;
  var got = _.avector.momentCentral( [ 1,2,3 ],2,null );
  test.equivalent( got,expected );

  test.description = 'second empty, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentral( [],2,null );
  test.equivalent( got,expected );

  test.description = 'first even, filtering'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1,2,3,4 ],1,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'first odd, filtering'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1,2,3 ],1,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'first empty, filtering'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [],1,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'second even, filtering'; //

  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1,2,3,4 ],2,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'second odd, filtering'; //

  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1,2,3 ],2,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'second empty, filtering'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [],2,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'first even, filtering, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1,2,3,4 ],1,null,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'first odd, filtering, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [ 1,2,3 ],1,null,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'first empty, filtering, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [],1,null,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'second even, filtering, with mean : null'; //

  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1,2,3,4 ],2,null,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'second odd, filtering, with mean : null'; //

  var expected = 1;
  var got = _.avector.momentCentralConditional( [ 1,2,3 ],2,null,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'second empty, filtering, with mean : null'; //

  var expected = 0;
  var got = _.avector.momentCentralConditional( [],2,null,( e,op ) => e % 2 );
  test.equivalent( got,expected );

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.momentCentral() );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ],'1' ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.momentCentral( 1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( 'x',1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( 1,1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ],'x' ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.momentCentral( [ 1 ],[ 1 ] ) );

  test.shouldThrowErrorSync( () => _.momentCentralConditional() );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( () => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ],'1',() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ],[ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 1 ),() => true );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 'x',1,() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 1,1,() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ],'x',() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( 1,[ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ],[ 1 ],() => true ) );
  test.shouldThrowErrorSync( () => _.momentCentralConditional( [ 1 ],[ 1 ],() => true ) );

}

//

function homogeneousWithScalar( test )
{

  test.description = 'assignScalar'; //

  var dst = [ 1,2,3 ];
  _.avector.assignScalar( dst,5 );
  test.identical( dst,[ 5,5,5 ] );

  var dst = vec([ 1,2,3 ]);
  _.vector.assignScalar( dst,5 );
  test.identical( dst,vec([ 5,5,5 ]) );

  var dst = [];
  _.avector.assignScalar( dst,5 );
  test.identical( dst,[] );

  test.description = 'addScalar'; //

  var dst = [ 1,2,3 ];
  _.avector.addScalar( dst,5 );
  test.identical( dst,[ 6,7,8 ] );

  var dst = vec([ 1,2,3 ]);
  _.vector.addScalar( dst,5 );
  test.identical( dst,vec([ 6,7,8 ]) );

  var dst = [];
  _.avector.addScalar( dst,5 );
  test.identical( dst,[] );

  test.description = 'subScalar'; //

  var dst = [ 1,2,3 ];
  _.avector.subScalar( dst,5 );
  test.identical( dst,[ -4,-3,-2 ] );

  var dst = vec([ 1,2,3 ]);
  _.vector.subScalar( dst,5 );
  test.identical( dst,vec([ -4,-3,-2 ]) );

  var dst = [];
  _.avector.subScalar( dst,5 );
  test.identical( dst,[] );

  test.description = 'mulScalar'; //

  var dst = [ 1,2,3 ];
  _.avector.mulScalar( dst,5 );
  test.identical( dst,[ 5,10,15 ] );

  var dst = vec([ 1,2,3 ]);
  _.vector.mulScalar( dst,5 );
  test.identical( dst,vec([ 5,10,15 ]) );

  var dst = [];
  _.avector.mulScalar( dst,5 );
  test.identical( dst,[] );

  test.description = 'divScalar'; //

  var dst = [ 1,2,3 ];
  _.avector.divScalar( dst,5 );
  test.identical( dst,[ 1/5,2/5,3/5 ] );

  var dst = vec([ 1,2,3 ]);
  _.vector.divScalar( dst,5 );
  test.identical( dst,vec([ 1/5,2/5,3/5 ]) );

  var dst = [];
  _.avector.divScalar( dst,5 );
  test.identical( dst,[] );

  test.description = 'bad arguments'; //

  function shouldThrowError( name )
  {

    test.shouldThrowErrorSync( () => _.avector[ name ]() );
    test.shouldThrowErrorSync( () => _.avector[ name ]( 1 ) );
    // test.shouldThrowErrorSync( () => _.avector[ name ]( 1,3 ) );
    test.shouldThrowErrorSync( () => _.avector[ name ]( '1','3' ) );
    test.shouldThrowErrorSync( () => _.avector[ name ]( [],[] ) );
    test.shouldThrowErrorSync( () => _.avector[ name ]( [],1,3 ) );
    test.shouldThrowErrorSync( () => _.avector[ name ]( [],1,undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ name ]( [],undefined ) );

    test.shouldThrowErrorSync( () => _.vector[ name ]() );
    test.shouldThrowErrorSync( () => _.vector[ name ]( 1 ) );
    // test.shouldThrowErrorSync( () => _.vector[ name ]( 1,3 ) );
    test.shouldThrowErrorSync( () => _.vector[ name ]( '1','3' ) );
    test.shouldThrowErrorSync( () => _.vector[ name ]( [],[] ) );
    test.shouldThrowErrorSync( () => _.vector[ name ]( [],1,3 ) );
    test.shouldThrowErrorSync( () => _.vector[ name ]( [],1,undefined ) );
    test.shouldThrowErrorSync( () => _.vector[ name ]( [],undefined ) );

  }

  if( Config.debug )
  {
    shouldThrowError( 'assignScalar' );
    shouldThrowError( 'addScalar' );
    shouldThrowError( 'subScalar' );
    shouldThrowError( 'mulScalar' );
    shouldThrowError( 'divScalar' );
  }

}

//

function homogeneousOnlyVectors( test )
{

  test.description = 'addVectors anarrays'; //

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  _.avector.addVectors( dst,src1 );
  test.identical( dst,[ 4,4,4 ] );

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 11,12,13 ];
  _.avector.addVectors( dst,src1,src2 );
  test.identical( dst,[ 15,16,17 ] );

  test.description = 'addVectors vectors'; //

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  _.avector.addVectors( dst,src1 );
  test.identical( dst,vec([ 4,4,4 ]) );

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 11,12,13 ]);
  _.avector.addVectors( dst,src1,src2 );
  test.identical( dst,vec([ 15,16,17 ]) );

  test.description = 'addVectors anarrays'; //

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  _.avector.addVectors( dst,src1 );
  test.identical( dst,[ 4,4,4 ] );

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 11,12,13 ];
  _.avector.addVectors( dst,src1,src2 );
  test.identical( dst,[ 15,16,17 ] );

  test.description = 'subVectors anarrays'; //

  var dst = ([ 1,2,3 ]);
  var src1 = ([ 3,2,1 ]);
  _.avector.subVectors( dst,src1 );
  test.identical( dst,([ -2,0,+2 ]) );

  var dst = ([ 1,2,3 ]);
  var src1 = ([ 3,2,1 ]);
  var src2 = ([ 11,12,13 ]);
  _.avector.subVectors( dst,src1,src2 );
  test.identical( dst,([ -13,-12,-11 ]) );

  test.description = 'subVectors vectors'; //

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  _.avector.subVectors( dst,src1 );
  test.identical( dst,vec([ -2,0,+2 ]) );

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 11,12,13 ]);
  _.avector.subVectors( dst,src1,src2 );
  test.identical( dst,vec([ -13,-12,-11 ]) );

  test.description = 'mulVectors vectors'; //

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  _.avector.mulVectors( dst,src1 );
  test.identical( dst,vec([ 3,4,3 ]) );

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 11,12,13 ]);
  _.avector.mulVectors( dst,src1,src2 );
  test.identical( dst,vec([ 33,48,39 ]) );

  test.description = 'mulVectors anarrays'; //

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  _.avector.mulVectors( dst,src1 );
  test.identical( dst,[ 3,4,3 ] );

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 11,12,13 ];
  _.avector.mulVectors( dst,src1,src2 );
  test.identical( dst,[ 33,48,39 ] );

  test.description = 'divVectors vectors'; //

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  _.avector.divVectors( dst,src1 );
  test.identical( dst,vec([ 1/3,1,3 ]) );

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 11,12,13 ]);
  _.avector.divVectors( dst,src1,src2 );
  test.identical( dst,vec([ 1/3/11,1/12,3/13 ]) );

  test.description = 'divVectors anarrays'; //

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  _.avector.divVectors( dst,src1 );
  test.identical( dst,[ 1/3,1,3 ] );

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 11,12,13 ];
  _.avector.divVectors( dst,src1,src2 );
  test.identical( dst,[ 1/3/11,1/12,3/13 ] );

  test.description = 'minVectors vectors'; //

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  _.avector.minVectors( dst,src1 );
  test.identical( dst,vec([ 1,2,1 ]) );

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 11,0,13 ]);
  _.avector.minVectors( dst,src1,src2 );
  test.identical( dst,vec([ 1,0,1 ]) );

  test.description = 'minVectors anarrays'; //

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  _.avector.minVectors( dst,src1 );
  test.identical( dst,[ 1,2,1 ] );

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 11,0,13 ];
  _.avector.minVectors( dst,src1,src2 );
  test.identical( dst,[ 1,0,1 ] );

  test.description = 'maxVectors vectors'; //

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  _.avector.maxVectors( dst,src1 );
  test.identical( dst,vec([ 3,2,3 ]) );

  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 11,0,13 ]);
  _.avector.maxVectors( dst,src1,src2 );
  test.identical( dst,vec([ 11,2,13 ]) );

  test.description = 'maxVectors anarrays'; //

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  _.avector.maxVectors( dst,src1 );
  test.identical( dst,[ 3,2,3 ] );

  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 11,0,13 ];
  _.avector.maxVectors( dst,src1,src2 );
  test.identical( dst,[ 11,2,13 ] );

  test.description = 'empty vector'; //

  function checkEmptyVector( rname )
  {

    var dst = [];
    debugger;
    var got = _.avector[ rname ]( dst,[],[] );
    test.shouldBe( got === dst );
    test.identical( got , [] );

    var dst = vec([]);
    var got = _.vector[ rname ]( dst,vec([]),vec([]) );
    test.shouldBe( got === dst );
    test.identical( got , vec([]) );

  }

  checkEmptyVector( 'assignVectors' );
  checkEmptyVector( 'addVectors' );
  checkEmptyVector( 'subVectors' );
  checkEmptyVector( 'mulVectors' );
  checkEmptyVector( 'subVectors' );
  checkEmptyVector( 'minVectors' );
  checkEmptyVector( 'maxVectors' );

  test.description = 'bad arguments'; //

  if( !Config.debug )
  return;

  function shouldThrowError( rname )
  {

    test.shouldThrowErrorSync( () => _.avector[ rname ]() );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],1 ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],'1' ) );

    test.shouldThrowErrorSync( () => _.vector[ rname ]() );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),vec([ 5 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),1 ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),undefined ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),'1' ) );

  }

  shouldThrowError( 'assignVectors' );
  shouldThrowError( 'addVectors' );
  shouldThrowError( 'subVectors' );
  shouldThrowError( 'mulVectors' );
  shouldThrowError( 'subVectors' );
  shouldThrowError( 'minVectors' );
  shouldThrowError( 'maxVectors' );

}

//

function heterogeneous( test )
{

  test.description = 'addScaled null,vector,vector,vector'; //

  var expected = [ 31,42,33 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.addScaled( null,dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  var expected = vec([ 31,42,33 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.addScaled( null,dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'addScaled scalar,vector,vector,vector'; //

  var expected = [ 31,42,33 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.addScaled( 1,dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  var expected = vec([ 31,42,33 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.addScaled( 1,dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'addScaled vector,vector,vector,vector'; //

  var expected = [ 31,42,33 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.addScaled( dst,dst.slice(),src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 31,42,33 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.addScaled( dst,dst.slice(),src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  /* */

  test.description = 'addScaled vector,vector,vector'; //

  var expected = [ 31,42,33 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.addScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 31,42,33 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.addScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'addScaled scalar,vector,vector'; //

  var expected = [ 130,140,130 ];
  var dst = [ 1,2,3 ];
  var dst = 100;
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.addScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  var expected = vec([ 130,140,130 ]);
  var dst = vec([ 1,2,3 ]);
  var dst = 100;
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.addScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'subScaled vector,vector,vector'; //

  var expected = [ -29,-38,-27 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.subScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ -29,-38,-27 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.subScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'mulScaled vector,vector,vector'; //

  var expected = [ 30,80,90 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.mulScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 30,80,90 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.mulScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'divScaled vector,vector,vector'; //

  var expected = [ 1/30,2/40,3/30 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = [ 10,20,30 ];
  var got = _.avector.divScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 1/30,2/40,3/30 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = vec([ 10,20,30 ]);
  var got = _.vector.divScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'addScaled vector,vector,scaler'; //

  var expected = [ 31,22,13 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = 10;
  var got = _.avector.addScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = [ 1,2,3 ];
  var got = _.avector.addScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 31,22,13 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = 10;
  var got = _.vector.addScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = vec([ 1,2,3 ]);
  var got = _.vector.addScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'subScaled vector,vector,scaler'; //

  var expected = [ -29,-18,-7 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = 10;
  var got = _.avector.subScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = [ 1,2,3 ];
  var got = _.avector.subScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ -29,-18,-7 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = 10;
  var got = _.vector.subScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = vec([ 1,2,3 ]);
  var got = _.vector.subScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'mulScaled vector,vector,scaler'; //

  var expected = [ 30,40,30 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = 10;
  var got = _.avector.mulScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = [ 1,2,3 ];
  var got = _.avector.mulScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 30,40,30 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = 10;
  var got = _.vector.mulScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = vec([ 1,2,3 ]);
  var got = _.vector.mulScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'divScaled vector,vector,scaler'; //

  var expected = [ 1/30,2/20,3/10 ];
  var dst = [ 1,2,3 ];
  var src1 = [ 3,2,1 ];
  var src2 = 10;
  var got = _.avector.divScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = [ 1,2,3 ];
  var got = _.avector.divScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 1/30,2/20,3/10 ]);
  var dst = vec([ 1,2,3 ]);
  var src1 = vec([ 3,2,1 ]);
  var src2 = 10;
  var got = _.vector.divScaled( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );
  var dst = vec([ 1,2,3 ]);
  var got = _.vector.divScaled( dst,src2,src1 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'empty vector'; //

  function checkEmpty( rname )
  {
    var op = _.vector[ rname ].operation;

    var dst = [];
    var args = _.dup( [],op.takingArguments[ 0 ]-1 );
    args.unshift( dst );
    var got = _.avector[ rname ].apply( _,args );
    test.shouldBe( got === dst );
    test.identical( got , [] );

    var dst = vec([]);
    var args = _.dup( vec([]),op.takingArguments[ 0 ]-1 );
    args.unshift( dst );
    var got = _.vector[ rname ].apply( _,args );
    test.shouldBe( got === dst );
    test.identical( got , vec([]) );

  }

  checkEmpty( 'addScaled' );
  checkEmpty( 'subScaled' );
  checkEmpty( 'mulScaled' );
  checkEmpty( 'subScaled' );

  test.description = 'bad arguments'; //

  if( !Config.debug )
  return;

  function shouldThrowError( rname )
  {

    test.description = 'bad arguments for ' + rname;

    test.shouldThrowErrorSync( () => _.avector[ rname ]() );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3 ],[ 5,5 ] ) );
    // test.shouldThrowErrorSync( () => _.avector[ rname ]( 1,[ 3,3 ],[ 5,5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],'1' ) );

    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined,[ 1,2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined,[ 1,2 ],[ 3,4 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined,[ 1,2 ],[ 3,4 ],[ 5,6 ] ) );

    test.shouldThrowErrorSync( () => _.vector[ rname ]() );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),vec([ 5 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3 ]),vec([ 5,5 ]) ) );

    // test.shouldThrowErrorSync( () => _.vector[ rname ]( 1,vec([ 3,3 ]),vec([ 5,5 ]) ) );

    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),undefined ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),'1' ) );

    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined,vec([ 1,2 ]) ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined,vec([ 1,2 ]),vec([ 3,4 ]) ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( undefined,vec([ 1,2 ]),vec([ 3,4 ]),vec([ 5,6 ]) ) );

  }

  shouldThrowError( 'addScaled' );
  shouldThrowError( 'subScaled' );
  shouldThrowError( 'mulScaled' );
  shouldThrowError( 'subScaled' );
  // shouldThrowError( 'clamp' );

}

//

function clamp( test )
{

  // test.description = 'clamp vectors, 4 arguments'; //
  //
  // var expected = [ 30,20,20,20,15,15 ];
  // var dst = [ 10,20,10,30,30,15 ];
  // var src1 = [ 30,20,20,20,10,10 ];
  // var src2 = [ 40,20,20,20,15,15 ];
  // var got = _.avector.clamp( dst,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // var expected = vec([ 30,20,20,20,15,15 ]);
  // var dst = vec([ 10,20,10,30,30,15 ]);
  // var src1 = vec([ 30,20,20,20,10,10 ]);
  // var src2 = vec([ 40,20,20,20,15,15 ]);
  // var got = _.vector.clamp( dst,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // test.description = 'clamp vectors, 3 arguments and null'; //
  //
  // var expected = [ 30,20,20,20,15,15 ];
  // var dst = [ 10,20,10,30,30,15 ];
  // var src1 = [ 30,20,20,20,10,10 ];
  // var src2 = [ 40,20,20,20,15,15 ];
  // var got = _.avector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );
  //
  // var expected = vec([ 30,20,20,20,15,15 ]);
  // var dst = vec([ 10,20,10,30,30,15 ]);
  // var src1 = vec([ 30,20,20,20,10,10 ]);
  // var src2 = vec([ 40,20,20,20,15,15 ]);
  // var got = _.vector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );
  //
  // test.description = 'clamp vectors, 3 arguments'; //
  //
  // var expected = [ 30,20,20,20,15,15 ];
  // var dst = [ 10,20,10,30,30,15 ];
  // var src1 = [ 30,20,20,20,10,10 ];
  // var src2 = [ 40,20,20,20,15,15 ];
  // var got = _.avector.clamp( dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // var expected = vec([ 30,20,20,20,15,15 ]);
  // var dst = vec([ 10,20,10,30,30,15 ]);
  // var src1 = vec([ 30,20,20,20,10,10 ]);
  // var src2 = vec([ 40,20,20,20,15,15 ]);
  // var got = _.vector.clamp( dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // test.description = 'clamp vector and scaler, 4 arguments'; //
  //
  // var expected = [ 20,20,20,20,20,15 ];
  // var dst = [ 10,20,10,20,20,15 ];
  // var src1 = [ 20,20,20,20,10,10 ];
  // var src2 = 20;
  // var got = _.avector.clamp( dst,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // var expected = vec([ 20,20,20,20,20,15 ]);
  // var dst = vec([ 10,20,10,20,20,15 ]);
  // var src1 = vec([ 20,20,20,20,10,10 ]);
  // var src2 = 20;
  // var got = _.vector.clamp( dst,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // var expected = [ 15,20,15,20,15,15 ];
  // var dst = [ 10,20,10,30,30,15 ];
  // var src1 = 15;
  // var src2 = [ 40,20,20,20,15,15 ];
  // var got = _.avector.clamp( dst,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // var expected = vec([ 15,20,15,20,15,15 ]);
  // var dst = vec([ 10,20,10,30,30,15 ]);
  // var src1 = 15;
  // var src2 = vec([ 40,20,20,20,15,15 ]);
  // var got = _.vector.clamp( dst,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got === dst );
  //
  // test.description = 'clamp vector and scaler, 3 arguments and null'; //
  //
  // var expected = [ 20,20,20,20,20,15 ];
  // var dst = [ 10,20,10,20,20,15 ];
  // var src1 = [ 20,20,20,20,10,10 ];
  // var src2 = 20;
  // var got = _.avector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );
  //
  // var expected = vec([ 20,20,20,20,20,15 ]);
  // var dst = vec([ 10,20,10,20,20,15 ]);
  // var src1 = vec([ 20,20,20,20,10,10 ]);
  // var src2 = 20;
  // var got = _.vector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );
  //
  // var expected = [ 15,20,15,20,15,15 ];
  // var dst = [ 10,20,10,30,30,15 ];
  // var src1 = 15;
  // var src2 = [ 40,20,20,20,15,15 ];
  // var got = _.avector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );
  //
  // var expected = vec([ 15,20,15,20,15,15 ]);
  // var dst = vec([ 10,20,10,30,30,15 ]);
  // var src1 = 15;
  // var src2 = vec([ 40,20,20,20,15,15 ]);
  // var got = _.vector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );
  //
  // var expected = vec([ 17,20,17,17,10,25 ]);
  // var dst = 17;
  // var src1 = vec([ 15,20,15,10,10,25 ]);
  // var src2 = vec([ 40,20,20,20,10,25 ]);
  // var got = _.vector.clamp( null,dst,src1,src2 );
  // test.identical( got,expected );
  // test.shouldBe( got !== dst );

  test.description = 'clamp vector and scaler, 3 arguments'; //

  var expected = [ 20,20,20,20,20,15 ];
  var dst = [ 10,20,10,20,20,15 ];
  var src1 = [ 20,20,20,20,10,10 ];
  var src2 = 20;
  var got = _.avector.clamp( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 20,20,20,20,20,15 ]);
  var dst = vec([ 10,20,10,20,20,15 ]);
  var src1 = vec([ 20,20,20,20,10,10 ]);
  var src2 = 20;
  var got = _.vector.clamp( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = [ 15,20,15,20,15,15 ];
  var dst = [ 10,20,10,30,30,15 ];
  var src1 = 15;
  var src2 = [ 40,20,20,20,15,15 ];
  var got = _.avector.clamp( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 15,20,15,20,15,15 ]);
  var dst = vec([ 10,20,10,30,30,15 ]);
  var src1 = 15;
  var src2 = vec([ 40,20,20,20,15,15 ]);
  var got = _.vector.clamp( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got === dst );

  var expected = vec([ 17,20,17,17,10,25 ]);
  var dst = 17;
  var src1 = vec([ 15,20,15,10,10,25 ]);
  var src2 = vec([ 40,20,20,20,10,25 ]);
  var got = _.vector.clamp( dst,src1,src2 );
  test.identical( got,expected );
  test.shouldBe( got !== dst );

  test.description = 'empty vectors, 3 arguments'; //

  var op = _.vector.clamp.operation;

  var args = _.dup( [],op.takingArguments[ 0 ] );
  var got = _.avector.clamp.apply( _,args );
  test.shouldBe( got === args[ 0 ] );
  test.identical( got , [] );

  var args = _.dup( vec([]),op.takingArguments[ 0 ] );
  var got = _.vector.clamp.apply( _,args );
  test.shouldBe( got === args[ 0 ] );
  test.identical( got , vec([]) );

  test.description = 'empty vectors, 4 arguments'; //

  var op = _.vector.clamp.operation;

  var dst = [];
  var args = _.dup( [],op.takingArguments[ 0 ] );
  args.unshift( dst );
  var got = _.avector.clamp.apply( _,args );
  test.shouldBe( got === dst );
  test.identical( got , [] );

  var dst = vec([]);
  var args = _.dup( vec([]),op.takingArguments[ 0 ] );
  args.unshift( dst );
  var got = _.vector.clamp.apply( _,args );
  test.shouldBe( got === dst );
  test.identical( got , vec([]) );

  test.description = 'bad arguments'; //

  if( !Config.debug )
  return;

  test.description = 'bad arguments';

  test.shouldThrowErrorSync( () => _.avector.clamp() );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1,2 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1,2 ],[ 3 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1,2 ],[ 3,4 ],[ 5 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1,2 ],[ 3 ],[ 5,5 ] ) );
  // test.shouldThrowErrorSync( () => _.avector.clamp( 1,[ 3,3 ],[ 5,5 ] ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1,2 ],[ 3,4 ],undefined ) );
  test.shouldThrowErrorSync( () => _.avector.clamp( [ 1,2 ],[ 3,4 ],'1' ) );

  test.shouldThrowErrorSync( () => _.vector.clamp() );
  test.shouldThrowErrorSync( () => _.vector.clamp( vec([ 1,2 ]) ) );
  test.shouldThrowErrorSync( () => _.vector.clamp( vec([ 1,2 ]),vec([ 3 ]) ) );
  test.shouldThrowErrorSync( () => _.vector.clamp( vec([ 1,2 ]),vec([ 3,4 ]),vec([ 5 ]) ) );
  test.shouldThrowErrorSync( () => _.vector.clamp( vec([ 1,2 ]),vec([ 3 ]),vec([ 5,5 ]) ) );

  // test.shouldThrowErrorSync( () => _.vector.clamp( 1,vec([ 3,3 ]),vec([ 5,5 ]) ) );

  test.shouldThrowErrorSync( () => _.vector.clamp( vec([ 1,2 ]),vec([ 3,4 ]),undefined ) );
  test.shouldThrowErrorSync( () => _.vector.clamp( vec([ 1,2 ]),vec([ 3,4 ]),'1' ) );

}

//

function mix( test )
{

  // debugger;
  // var r = _.avector.mix( null,[ 1,2 ],[ 3,4 ] );
  // debugger;

  /* 3 arguments */

  test.description = 'all arrays, 3 arguments';

  var src = [ 1,2,3 ];
  var got = _.avector.mix( src,[ 3,4,5 ],[ 0.1,0.2,0.3 ] );
  var expected = [ 1.2 , 2.4 , 3.6 ];

  test.equivalent( got,expected );
  test.shouldBe( src === got );

  test.description = 'mixed, 3 arguments';

  var src = [ 1,2,3 ];
  var got = _.avector.mix( src,5,0.1 );
  var expected = [ 1.4 , 2.3 , 3.2 ];

  test.equivalent( got,expected );
  test.shouldBe( src === got );

  var src = [ 1,2,3 ]
  var got = _.avector.mix( 5,src,0.1 );
  var expected = [ 4.6 , 4.7 , 4.8 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );

  test.description = 'many elements in progress, 3 arguments';

  var got = _.avector.mix( 1,3,[ -1,0,0.3,0.7,1,2 ] );
  var expected = [ -1 , 1 , 1.6 , 2.4 , 3 , 5 ];
  test.equivalent( got,expected );

  test.description = 'only scalars, 3 arguments';

  var got = _.avector.mix( 1,3,0.5 );
  var expected = 2;
  test.equivalent( got,expected );

  /* 4 arguments with null */

  test.description = 'all arrays, 4 arguments, dst null';

  var src = [ 1,2,3 ];
  var got = _.avector.mix( null,src,[ 3,4,5 ],[ 0.1,0.2,0.3 ] );
  var expected = [ 1.2 , 2.4 , 3.6 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );

  test.description = 'mixed, 4 arguments, dst null';

  var src = [ 1,2,3 ];
  var got = _.avector.mix( null,src,5,0.1 );
  var expected = [ 1.4 , 2.3 , 3.2 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );

  var src = [ 1,2,3 ]
  var got = _.avector.mix( null,5,src,0.1 );
  var expected = [ 4.6 , 4.7 , 4.8 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );

  test.description = 'many elements in progress, 4 arguments, dst null';

  var got = _.avector.mix( null,1,3,[ -1,0,0.3,0.7,1,2 ] );
  var expected = [ -1 , 1 , 1.6 , 2.4 , 3 , 5 ];
  test.equivalent( got,expected );

  test.description = 'only scalars, 4 arguments, dst null';

  var got = _.avector.mix( null,1,3,0.5 );
  var expected = 2;
  test.equivalent( got,expected );

  /* 4 arguments with provided container */

  test.description = 'all arrays, 4 arguments, dst null';

  var dst = [ -1,-1,-1 ];
  var src = [ 1,2,3 ];
  var got = _.avector.mix( dst,src,[ 3,4,5 ],[ 0.1,0.2,0.3 ] );
  var expected = [ 1.2 , 2.4 , 3.6 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );
  test.shouldBe( dst === got );

  test.description = 'mixed, 4 arguments, dst null';

  var dst = [ -1,-1,-1 ];
  var src = [ 1,2,3 ];
  var got = _.avector.mix( dst,src,5,0.1 );
  var expected = [ 1.4 , 2.3 , 3.2 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );
  test.shouldBe( dst === got );

  var dst = [ -1,-1,-1 ];
  var src = [ 1,2,3 ]
  var got = _.avector.mix( dst,5,src,0.1 );
  var expected = [ 4.6 , 4.7 , 4.8 ];

  test.equivalent( got,expected );
  test.shouldBe( src !== got );
  test.shouldBe( dst === got );

  test.description = 'many elements in progress, 4 arguments, dst null';

  var dst = [ -1,-1,-1,-1,-1,-1 ];
  var got = _.avector.mix( dst,1,3,[ -1,0,0.3,0.7,1,2 ] );
  var expected = [ -1 , 1 , 1.6 , 2.4 , 3 , 5 ];
  test.equivalent( got,expected );
  test.shouldBe( dst === got );

  test.description = 'only scalars, 4 arguments, dst null';

  var dst = -1;
  var got = _.avector.mix( dst,1,3,0.5 );
  var expected = 2;
  test.equivalent( got,expected );

  /* throwing error */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ],[ 3 ],0.5 ) );

  test.shouldThrowErrorSync( () => _.avector.mix() );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ],[ 3,4 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( null,[ 1,2 ],[ 3,4 ] ) );
  // test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ],[ 3,4 ],[ 5,6 ],1 ) );
  test.shouldThrowErrorSync( () => _.avector.mix( '0',[ 3,4 ],[ 5,6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( undefined,[ 3,4 ],[ 5,6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( undefined,[ 3,4 ],[ 3,4 ],[ 5,6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( false,[ 3,4 ],[ 5,6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( true,[ 3,4 ],[ 5,6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ],'0',[ 5,6 ] ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ],[ 3,4 ],'0' ) );
  test.shouldThrowErrorSync( () => _.avector.mix( [ 1,2 ],[ 3,4 ],[ 5,6 ],[ 4,4 ],[ 3,4 ] ) );

}

//

function swap( test )
{

  test.description = 'swapVectors vectors'; //

  var v1 = vector.from([ 1,2,3 ]);
  var v2 = vector.from([ 10,20,30 ]);
  var v1Expected = vector.from([ 10,20,30 ]);
  var v2Expected = vector.from([ 1,2,3 ]);

  var r = vector.swapVectors( v1,v2 );

  test.shouldBe( r === undefined );
  test.identical( v1,v1Expected );
  test.identical( v2,v2Expected );

  test.description = 'swapVectors arrays'; //

  var v1 = [ 1,2,3 ];
  var v2 = [ 10,20,30 ];
  var v1Expected = [ 10,20,30 ];
  var v2Expected = [ 1,2,3 ];

  var r = avector.swapVectors( v1,v2 );

  test.shouldBe( r === undefined );
  test.identical( v1,v1Expected );
  test.identical( v2,v2Expected );

  test.description = 'swapVectors empty arrays'; //

  var v1 = [];
  var v2 = [];
  var v1Expected = [];
  var v2Expected = [];

  var r = avector.swapVectors( v1,v2 );

  test.shouldBe( r === undefined );
  test.identical( v1,v1Expected );
  test.identical( v2,v2Expected );

  test.description = 'swapAtoms vectors'; //

  var v1 = vector.from([ 1,2,3 ]);
  var v1Expected = vector.from([ 3,2,1 ]);
  var r = vector.swapAtoms( v1,0,2 );

  test.shouldBe( r === v1 );
  test.identical( v1,v1Expected );

  test.description = 'swapAtoms arrays'; //

  var v1 = [ 1,2,3 ];
  var v1Expected = [ 3,2,1 ];
  var r = avector.swapAtoms( v1,0,2 );

  test.shouldBe( r === v1 );
  test.identical( v1,v1Expected );

  test.description = 'swapAtoms array with single atom'; //

  var v1 = [ 1 ];
  var v1Expected = [ 1 ];
  var r = avector.swapAtoms( v1,0,0 );

  test.shouldBe( r === v1 );
  test.identical( v1,v1Expected );

  test.description = 'bad arguments'; //

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => vector.swapVectors() );
  test.shouldThrowErrorSync( () => vector.swapVectors( vector.from([ 1,2,3 ]) ) );
  test.shouldThrowErrorSync( () => vector.swapVectors( vector.from([ 1,2,3 ]), vector.from([ 1,2,3 ]), vector.from([ 1,2,3 ]) ) );
  test.shouldThrowErrorSync( () => vector.swapVectors( vector.from([ 1,2,3 ]), vector.from([ 1,2 ]) ) );
  test.shouldThrowErrorSync( () => vector.swapVectors( vector.from([ 1,2,3 ]), [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => vector.swapVectors( [ 1,2,3 ], [ 1,2,3 ] ) );

  test.shouldThrowErrorSync( () => vector.swapAtoms() );
  test.shouldThrowErrorSync( () => vector.swapAtoms( vector.from([ 1,2,3 ]) ) );
  test.shouldThrowErrorSync( () => vector.swapAtoms( vector.from([ 1,2,3 ]),0 ) );
  test.shouldThrowErrorSync( () => vector.swapAtoms( vector.from([ 1,2,3 ]),0,+3 ) );
  test.shouldThrowErrorSync( () => vector.swapAtoms( vector.from([ 1,2,3 ]),0,-1 ) );
  test.shouldThrowErrorSync( () => vector.swapAtoms( vector.from([ 1,2,3 ]),'0','1' ) );
  test.shouldThrowErrorSync( () => vector.swapAtoms( vector.from([ 1,2,3 ]),[ 0 ],[ 1 ] ) );

}

//

function polynomApply( test )
{

  test.description = 'trivial'; //

  var expected = 7;
  var got = _.avector.polynomApply( [ 1,1,1 ],2 );
  test.identical( got,expected );

  test.description = 'trivial'; //

  var expected = 36;
  var got = _.avector.polynomApply( [ 0,1,2 ],4 );
  test.identical( got,expected );

  test.description = 'trivial'; //

  var expected = 6;
  var got = _.avector.polynomApply( [ 2,1,0 ],4 );
  test.identical( got,expected );

  test.description = 'trivial'; //

  var expected = 262;
  var got = _.avector.polynomApply( [ 2,1,0,4 ],4 );
  test.identical( got,expected );

}

//

function assign( test )
{

  test.description = 'assign scalar';

  var src = [ 1,2,3 ];
  var got = _.avector.assign( src,0 );
  var expected = [ 0,0,0 ];
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'assign scalar to null vector';

  var src = [];
  var got = _.avector.assign( src,1 );
  var expected = [];
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'assign avector';

  var src = [ 1,2,3 ];
  var got = _.avector.assign( src,[ 4,5,6 ] );
  var expected = [ 4,5,6 ];
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'assign multiple scalars';

  var src = [ 1,2,3 ];
  var got = _.avector.assign( src,4,5,6 );
  var expected = [ 4,5,6 ];
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'null avector';

  var src = [];
  var got = _.avector.assign( src );
  var expected = [];
  test.identical( expected,got );
  test.shouldBe( got === src );

  /* */

  test.description = 'assign scalar by method';

  var src = vector.fromArray([ 1,2,3 ]);
  debugger;
  var got = src.assign( 0 );
  var expected = vector.fromArray([ 0,0,0 ]);
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'assign scalar to null vector';

  var src = vector.fromArray([]);
  var got = src.assign( 1 );
  var expected = vector.fromArray([]);
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'assign avector';

  var src = vector.fromArray([ 1,2,3 ]);
  var got = src.assign([ 4,5,6 ] );
  var expected = vector.fromArray([ 4,5,6 ]);
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'assign multiple scalars';

  var src = vector.fromArray([ 1,2,3 ]);
  var got = src.assign([ 4,5,6 ]);
  var expected = vector.fromArray([ 4,5,6 ]);
  test.identical( expected,got );
  test.shouldBe( got === src );

  test.description = 'null avector';

  var src = vector.fromArray([]);
  var got = src.assign();
  var expected = vector.fromArray([]);
  test.identical( expected,got );
  test.shouldBe( got === src );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.avector.assign() );
  test.shouldThrowErrorSync( () => _.avector.assign( [],1,1 ) );
  test.shouldThrowErrorSync( () => _.avector.assign( [ 0 ],1,1 ) );
  test.shouldThrowErrorSync( () => _.avector.assign( [ 0 ],'1' ) );
  test.shouldThrowErrorSync( () => _.avector.assign( [ 0 ],[ 1,1 ] ) );

}

//

function experiment( test )
{

  var summary = _.avector.distributionSummary([ 1,2,3,4,9 ]);
  logger.log( 'summary',summary );

  debugger;
  test.identical( 1,1 );
}

experiment.experimental = 1;

// --
// proto
// --

/*

- check subarray

*/

var Self =
{

  name : 'VectorTest',
  silencing : 1,

  // routine : 'abs',
  // verbosity : 7,

  context :
  {

    _isIdentical : _isIdentical,
    _isEquivalent : _isEquivalent,
    _isGreater : _isGreater,
    _isLess : _isLess,

    _allIdentical : _allIdentical,
    _allNotIdentical : _allNotIdentical,
    _allEquivalent : _allEquivalent,
    _allGreater : _allGreater,

    _anyIdentical : _anyIdentical,
    _anyNotIdentical : _anyNotIdentical,
    _anyGreater : _anyGreater,
    _anyEquivalent : _anyEquivalent,

    _noneIdentical : _noneIdentical,
    _noneGreater : _noneGreater,
    _noneEquivalent : _noneEquivalent,

    _isZero : _isZero,
    _allZero : _allZero,
    _anyZero : _anyZero,
    _noneZero : _noneZero,

  },

  tests :
  {

    vectorIs : vectorIs,

    allFinite : allFinite,
    anyNan : anyNan,
    allInt : allInt,
    // allZero : allZero,

    to : to,
    toArray : toArray,

    /* */

    isIdentical : isIdentical,
    isNotIdentical : isNotIdentical,
    isEquivalent : isEquivalent,
    isNotEquivalent : isNotEquivalent,
    isEquivalent2 : isEquivalent2,
    isGreater : isGreater,
    isLessEqual : isLessEqual,
    isLess : isLess,
    isGreaterEqual : isGreaterEqual,

    logical2ArgsZipperWithBadArguments : logical2ArgsZipperWithBadArguments,

    /* */

    allIdentical : allIdentical,
    allNotIdentical : allNotIdentical,
    allEquivalent : allEquivalent,
    allEquivalent2 : allEquivalent2,
    allNotEquivalent : allNotEquivalent,
    allGreater : allGreater,

    anyIdentical : anyIdentical,
    anyNotIdentical : anyNotIdentical,
    anyEquivalent : anyEquivalent,
    anyEquivalent2 : anyEquivalent2,
    anyNotEquivalent : anyNotEquivalent,
    anyGreater : anyGreater,

    noneIdentical : noneIdentical,
    noneNotIdentical : noneNotIdentical,
    noneEquivalent : noneEquivalent,
    noneEquivalent2 : noneEquivalent2,
    noneNotEquivalent : noneNotEquivalent,
    noneGreater : noneGreater,


    logical2ArgsReducerWithBadArguments : logical2ArgsReducerWithBadArguments,

    /* */

    isZero : isZero,

    logical1ArgsSinglerWithBadArguments : logical1ArgsSinglerWithBadArguments,

    /* */

    allZero : allZero,
    anyZero : anyZero,
    noneZero : noneZero,

    logical1ArgsReducerWithBadArguments : logical1ArgsReducerWithBadArguments,

    /* */

    sort : sort,
    dot : dot,
    cross : cross,
    subarray : subarray,

    add : add,
    sub : sub,
    mul : mul,
    div : div,

    abs : abs,

    distributionRangeSummary : distributionRangeSummary,
    reduceToMean : reduceToMean,
    median : median,
    mean : mean,
    moment : moment,
    momentCentral : momentCentral,

    homogeneousWithScalar : homogeneousWithScalar,
    homogeneousOnlyVectors : homogeneousOnlyVectors,
    heterogeneous : heterogeneous,

    clamp : clamp,
    mix : mix,

    swap : swap,
    polynomApply : polynomApply,

    assign : assign,

    experiment : experiment,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
