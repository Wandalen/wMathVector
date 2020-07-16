# Інтерфейс адаптера

Як використовувати методи адаптера.

### Довжина вектора

Довжина вектору міститься в полі `length` адаптера.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.length:', v1.length )
/* log : "v1.length:  3" */
console.log( 'a1.length:', a1.length )
/* log : "a1.length:  3" */
```

Довжина вектора `v1` рівна кількості елементів у контейнері `a1`.

### Зчитування даних

Метод `eGet` повертає значення елемента по індексу.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.eGet( 2 ):', v1.eGet( 2 ) );
/* log : "v1.eGet( 2 ):  3" */
```

### Запис даних

Метод `eSet` змінює значення елемента по індексу.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
v1.eSet( 0, 5 );
console.log( 'v1:',  v1 );
/* log : "v1:  5.000 2.000 3.000" */
```

### Метод `toStr`

Метод `toStr` повертає вміст вектору у вигляді рядка.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1:',  v1 );
/* log : "v1:  1.000 2.000 3.000" */
```
