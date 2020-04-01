# Інтерфейс та особливості адаптера

Описано використання інтерфейсу адаптера, виконання операцій над адаптером.

### Довжина вектора

Довжина вектору міститься в полі `length` адаптера.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.length: ', v1.length )
/* log "v1.length:  3" */
console.log( 'a1.length: ', a1.length )
/* log "a1.length:  3" */
```

Довжина вектора `v1` рівна кількості елементів у контейнері `a1`.

### Зчитування даних

Метод `eGet` повертає значення елемента по індексу.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.eGet( 2 ): ', v1.eGet( 2 ) );
/* log "v1.eGet( 2 ):  3" */
```

### Запис даних

Метод `eSet` змінює значення елемента по індексу.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
v1.eSet( 0, 5 );
console.log( 'v1.toStr(): ',  v1.toStr() );
/* log "v1.toStr():  5.000 2.000 3.000" */
```

### Метод `toStr`

Метод `toStr` повертає вміст вектору у вигляді рядка.

```js
var a1 = [ 1, 2, 3 ];
var v1 = _.vectorAdapter.from( a1 );
console.log( 'v1.toStr(): ',  v1.toStr() );
/* log "v1.toStr():  1.000 2.000 3.000" */
```

### Використання скаляра аргументом рутини

Векторизація скаляру - створення вектору необхідної довжини та заповнення значенням скаляру.

```js
var a1 = [ 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
_.vectorAdapter.add( v1, 3 );
console.log( 'v1.toStr(): ', v1.toStr() );
/* log "v1.toStr():  4.000 4.000" */
```

Виклик `_.vectorAdapter.add( v1, 3 )` перетворить скаляр `3` у вектор із довжиною вектору `v1` та заповнить його значенням скаляру.
В результаті отримаємо вектор `[ 3, 3 ]`, який буде додано до вектору `v1`. Такий метод виключає необхідність ручного створення векторів із однаковим вмістом.

### Операції з множиною векторів

```javascript
var v1 = _.vectorAdapter.from( [ 1, 1, 1 ] );
var v2 = _.vectorAdapter.from( [ 1, 1, 1 ] );
var v3 = _.vectorAdapter.from( [ 1, 1, 1 ] );
var result = _.vectorAdapter.add( v1, v2, v3 );
console.log( 'result.toStr(): ', result.toStr() );
/* log "result.toStr():  3.000 3.000 3.000" */
```

Змінна `result` містить вектор із результатом додавання трьох векторів: `v1`, `v2`, `v3`.

### Попередження помилкових даних

```js
var a1 = [ 1, 1 ];
var a2 = [ 1, 1, 1 ];
var v1 = _.vectorAdapter.from( a1 );
var v2 = _.vectorAdapter.from( a2 );
_.vectorAdapter.add( v1, v2 );
```
Виклик `_.vectorAdapter.add( v1, v2 )` завершиться із помилкою тому, що всі вектори повинні мати однакову довжину.

Методи `sub`, `mul`, `div` працюють за аналогічним із `add` принципом, відмінністю є лише операція,яку вони виконують із вектором.

