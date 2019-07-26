var http = require('http');

const onRequest = (req, res)  => {
    res.writeHead(200,{ 'Content-Type': 'text/plain'});
    res.write(`${new Date().toISOString()} - Hello world!`);
    res.end();
};

const port = 3000;
console.log(`${new Date().toISOString()} - Server listening on port ${port}`);
http.createServer(onRequest).listen(port);