var http = require('http'); // http is a known system module
var server = http.createServer(engine);

const port = 8080;
server.listen(port, function(){
  console.log('Server was hit with a request.')
})
//console.log(server);

function engine(request, response){
  console.log('Writing a response...');
    console.log('request: ' + request.url);
  response.writeHead(200, { 'Content-Type': 'text/plain', 'MyCustomHeader':'MyCustomValue'});
  response.write('hello world!');
  response.end();
}


console.log('Listening on port ' + port);
//http.createServer(engine).listen(port); // leets
