# Vector adapter

Vector adapter is an implementation of the abstract interface, a kind of link that defines how to interpret data as the vector.

The interface of the adapter has many implementations.

### The adapter is an abstraction

The vector can also be specified with the help of an adapter. An adapter is a special object to make algorithms more abstract and to use the same code for very different formats of vector specifying.

```js
var array1 = [ 1, 2, 3 ];
var array2 = [ 4, 5, 6 ];
var vector1 = _.vectorAdapter.from( array1 );
var vector2 = _.vectorAdapter.from( array2 );

console.log( 'vector1 : ', vector1.toStr() );
/* log : vector1 : 1.000, 2.000, 3.000 */
console.log( 'vector2 : ', vector2.toStr() );
/* log : vector2 : 4.000, 5.000, 6.000 */

_.vectorAdapter.add( vector1, vector2 );

console.log( 'vector1 : ', vector1.toStr() );
/* log : vector1 : 5.000, 7.000, 9.000 */
console.log( 'vector2 : ', vector2.toStr() );
/* log : vector2 : 4.000, 5.000, 6.000 */

console.log( 'array1 : ', array1 );
/* log : array1 : [ 5, 7, 9 ] */
console.log( 'array2 : ', array2 );
/* log : array2 : [ 4, 5, 6 ] */
```

The sample creates arrays `array1` and `array2`. For them, simple adapters `vector1` and `vector2` are specified. Vectors `vector2` is added to vector `vector2`. As you can see, not only the value of `vector1` but also the value of `array1` has changed.

Important: Adapters do not own data. Metaphorically, the adapter is an advanced kind of link on data.

