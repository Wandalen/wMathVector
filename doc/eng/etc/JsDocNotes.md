## Module

**Each module should be defined, otherwise members of that module will not be displayed in doc.**

```
/**
 * Some description here
  @module Tools/math/Vector
*/
```

## Namespace

**Each namespace should be defined, otherwise members of that namespace will not be displayed in doc.**

Single `namespace`:

```
/**
 *@summary Collection of functions for vector math
  @namespace "wTools.avector"
  @memberof module:Tools/math/Vector
*/
```

Several `namespaces` in one `jsdoc` block:

```
/**
 *@summary Collection of functions for vector math
  @namespaces "wTools.avector","wTools.vectorAdapter"
  @memberof module:Tools/math/Vector
*/
```


## Member of entity

**Each entity used in `memberof*` tag should be defined, otherwise members of that entity will not be displayed in doc.**

Use `memberof` tag if entity is a member of single namespace or other possible entity:

```
/**
 * @memberof module:Tools/math/Vector.wTools.avector
*/

```

Use `memberofs` tag instead of two `memberof` if `jsdoc` entity is a member of several other entities, separate them by a comma.

```
/**
 * @memberofs module:Tools/math/Vector.wTools.avector,module:Tools/math/Vector.wTools.vectorAdapter
*/

```

Entity in `memberofs` tag can be quoted to improve readability:

```
/**
 * @memberofs "module:Tools/math/Vector.wTools.avector","module:Tools/math/Vector.wTools.vectorAdapter"
*/

```

Please take a note that the name of the module and namespace in "memberof/memberofs" tag should be identical with the name specified in "module" and "namespace" tags, otherwise member will not be displayed in the doc.

For example, we have line "@memberof module:Tools/math/Vector.wTools.avector".
In that line:

* "module:" specifies entity kind
* "Tools/math/Vector" is a module name
* "wTools.avector" is a namespace name


## Routine jsdoc example

Key points:

- Short summary on first line
- Details on second and following lines( optional )
- Should have at least one example of usage
- Should have @returns tag
- Should have @throws tag
- Should have @memberof or @memberofs tag
- Should have tag which specifies king of entity, like @function

Example:

```

/**
 * Routine assign() assigns the values of second argument to the vector {-dst-}.
 * If arguments.length is more then two, then routine assigns elements of pseudo array {-arguments-} to the vector {-dst-}.
 * The assigning starts from the index 1.
 *
 * @param { Long|VectorAdapter } dst - Destination vector.
 * @param { * } ... - Source vector. If arguments.length is 2, then source vector is second argument.
 * Otherwise, the source vector is copy of arguments starting from index 1.
 *
 * @example
 * var got = _.vector.assign( [ 1, 2, 3 ], 0 );
 * console.log( got );
 * // log [ 0, 0, 0 ];
 *
 * @returns { Long|VectorAdapter } - Returns original {-dst-} vector filled by values from source vector.
 * @function assign
 * @throws { Error } If length of {-src-} and {-dst-} vectors are different.
 * @memberofs module:Tools/math/Vector.wTools.avector,module:Tools/math/Vector.wTools.vectorAdapter
*/

```


