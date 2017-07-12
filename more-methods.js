const { PI } = Math;

exports.area = (r) => PI * r * r;

exports.circumference = (r) => 2 * PI * r;

exports.sumNumbers = (a, b) => {
  console.log('(inside sumNumbers)');
  return a+b;
}

exports.sumNumbers2 = function(a,b){
  console.log('(inside sumNumbers2)');
  return a+b;
}
