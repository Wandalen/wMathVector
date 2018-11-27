if( typeof module !== 'undefined' )
require( 'wmathvector' );

var _ = wTools;

debugger;

function onEvaluate( src )
{
  return - 5 < src && src < 0 ; // numbers in range
}

var v1 = _.vector.from( [ -1, -1.5, -2 ] );
var bool = _.vector.all( v1, onEvaluate );
logger.log('ALL true -', bool );

var v1 = _.vector.from( [ 0, 1, -2 ]);
var bool = _.vector.all( v1, onEvaluate );
logger.log('ALL false -', bool );
debugger;

var v1 = _.vector.from( [ -1, 1, 2 ]);
var bool = _.vector.any( v1, onEvaluate );
logger.log('ANY true -', bool );

var v1 = _.vector.from( [ 0, 1, 2 ]);
var bool = _.vector.all( v1, onEvaluate );
logger.log('ANY false -', bool );

var v1 = _.vector.from( [ 1, 1.5, 2 ]);
var bool = _.vector.none( v1, onEvaluate );
logger.log('NONE true -', bool );

var v1 = _.vector.from( [ 0, 1, -2 ]);
var bool = _.vector.none( v1, onEvaluate );
logger.log('NONE false -', bool );
