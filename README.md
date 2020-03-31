
# wMathVector [![Build Status](https://travis-ci.org/Wandalen/wMathVector.svg?branch=master)](https://travis-ci.org/Wandalen/wMathVector)

Collection of functions for vector math. `MathVector` introduces missing in JavaScript type `VectorAdapter`. Vector adapter is an implementation of the abstract interface, a kind of link that defines how to interpret data as the vector. The adapter could specify offset, length, and stride what changes how the original container is interpreted but does not alter its data. The length of the vector specified by the adapter is not necessarily equal to the length of the original container, siblings elements of such vector are not necessarily sibling in the original container. Thanks to adapters storage format of vectors do not make a big difference for math algorithms. Module `MathVector` implements math functions that accept vector specified by either adapter or Array/Buffer. Use MathVector to be more functional with math and less constrained with storage format.

### Try out

```
npm install
node sample/Sample.js
```
