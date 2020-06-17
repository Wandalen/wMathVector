# Vector

An ordered set of scalars.

The vector in this module means an ordered set of scalars. The vector is not an object, but an abstraction.

### Formats of vector specifying

The vector can be defined by

- an array ( Array )
- a typed buffer ( BufferTyped )
- an adapter ( VectorAdapter )

To use the vector in the form of an array or a buffer, use the namespace `_.vector`. To use the vector specified by the adapter, use the namespace `_.vectorAdapter`.

# Vector adapter

Vector adapter is an implementation of the abstract interface, a kind of link that defines how to interpret data as the vector.

An adapter is a special object to make algorithms more abstract and to use the same code for very different formats of vector specifying. The interface of the adapter has many implementations.

[Back to content](../README.md#Tutorials)
