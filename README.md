
# wMathVector [![Build Status](https://travis-ci.org/Wandalen/wMathVector.svg?branch=master)](https://travis-ci.org/Wandalen/wMathVector)

Collection of functions for vector math. MathVector introduces missing in JavaScript type VectorImage. VectorImage is a reference, it does not contain data but only refer on actual ( aka Long ) container of lined data. VectorImage could have offset, length and stride what makes look original container differently. Length of VectorImage is not necessarily equal to the length of the original container, siblings elements of VectorImage is not necessarily sibling in the original container, so storage format of vectors does not make a big difference for math algorithms. MathVector implements functions for the VectorImage and mirrors them for Array/Buffer. Use MathVector to be more functional with math and less constrained with storage format.

### Try out
```
npm install
node sample/Sample.s
```
















