if( typeof module !== 'undefined' )
require( 'wmathvector' );

let _ = wTools;

function onEvaluate( src )
{
  return - 5 < src && src < 0 ; // numbers in range
}

var v1 = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
var bool = _.vectorAdapter.all( v1, onEvaluate );
logger.log('ALL true -', bool );
/* log : "ALL true - true" */

var v1 = _.vectorAdapter.from( [ 0, 1, -2 ]);
var bool = _.vectorAdapter.all( v1, onEvaluate );
logger.log('ALL false -', bool );
/* log : "ALL false - false" */

var v1 = _.vectorAdapter.from( [ -1, 1, 2 ]);
var bool = _.vectorAdapter.any( v1, onEvaluate );
logger.log('ANY true -', bool );
/* log : "ANY true - true" */

var v1 = _.vectorAdapter.from( [ 0, 1, 2 ]);
var bool = _.vectorAdapter.all( v1, onEvaluate );
logger.log('ANY false -', bool );
/* log : "ANY false - false" */

var v1 = _.vectorAdapter.from( [ 1, 1.5, 2 ]);
var bool = _.vectorAdapter.none( v1, onEvaluate );
logger.log('NONE true -', bool );
/* log : "NONE true - true" */

var v1 = _.vectorAdapter.from( [ 0, 1, -2 ]);
var bool = _.vectorAdapter.none( v1, onEvaluate );
logger.log('NONE false -', bool );
/* log : "NONE false - false" */

var v1 = _.vectorAdapter.from( [ 0, 1, 2 ] );
var v2 = _.vectorAdapter.from( [ 0, 4, 8 ] );
logger.log( 'AREPARALLEL true - ', _.vectorAdapter.areParallel( v1, v2, 0.005 ) );
/* log : "AREPARALLEL true - true" */

var v1 = _.vectorAdapter.from( [ 0, 1, 2 ] );
var v2 = _.vectorAdapter.from( [ 0, 2, 8 ] );
logger.log( 'AREPARALLEL false - ', _.vectorAdapter.areParallel( v1, v2, 0.005 ) );
/* log : "AREPARALLEL false - false" */
