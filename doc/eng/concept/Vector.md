# Vector

An ordered set of scalars.

The vector in this module means an ordered set of scalars. The vector is not an object, but an abstraction.

### Formats of vector specifying

The vector can be defined by

- an array ( Array )
- a typed buffer ( BufferTyped )
- an adapter ( VectorAdapter )

To use the vector in the form of an array or a buffer, use the namespace `_.avector`. To use the vector specified by the adapter, use the namespace `_.vectorAdapter`.

### Simple operation on vectors

A simple example of the operation of adding two vectors.

```js
var vector1 = [ 1, 2, 3 ];
var vector2 = [ 4, 5, 6 ];

_.avector.add( vector1, vector2 );

console.log( 'vector1 : ', vector1 );
/* log : vector1 [ 5, 7, 9 ] */
console.log( 'vector2 : ', vector2 );
/* log : vector2 : [ 4, 5, 6 ] */
```

Vector `vector1` is used simultaneously as a container to store the result and as one of the arguments of a mathematical function.

[Back to content](../README.md#Tutorials)
