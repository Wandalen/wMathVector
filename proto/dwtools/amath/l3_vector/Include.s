(function _Include_s_() {

'use strict';

/**
 * Collection of functions for vector math. MathVector introduces missing in JavaScript type VectorAdapter. VectorAdapter is a reference, it does not contain data but only refer on actual ( aka Long ) container of lined data. VectorAdapter could have offset, length and stride what makes look original container differently. Length of VectorAdapter is not necessarily equal to the length of the original container, siblings elements of VectorAdapter is not necessarily sibling in the original container, so storage format of vectors does not make a big difference for math algorithms. MathVector implements functions for the VectorAdapter and mirrors them for Array/BufferNode. Use MathVector to be more functional with math and less constrained with storage format.
  @module Tools/math/Vector
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wEqualer' )
  _.include( 'wMathScalar' )

}

if( module !== 'undefined' )
{
  require( './l1/Core.s' );
  require( './l3/Operations.s' );
  require( './l5/Routines.s' );
  require( './l7/Long.s' );
  require( './l7/Methods.s' );
}

})();
