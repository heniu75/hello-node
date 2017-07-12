var methods = require('./methods.js');
var more_methods = require('./more-methods.js')

console.log(methods);
methods.myMethods.eatCookies();

console.log(more_methods);
var area = more_methods.area(10.0);
console.log('area: ' + area);

console.log('a-sum of 10, 2 is ' + more_methods.sumNumbers(10,2))
console.log('b-sum of 10, 2 is ' + more_methods.sumNumbers2(10,2))
//response.eatCookies();
