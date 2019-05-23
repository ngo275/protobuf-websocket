var http = require("http");
var server = http.createServer(function(req,res) {
    res.write("Hello World!!");
    res.end();
});

var io = require('socket.io')(server);

io.on('connection', function(socket) {
    console.log("client connected!!")

    socket.on('disconnect', function() {
        console.log("client disconnected!!")
    });
    socket.on("from_client", function(obj){
        console.log(obj)
    });
});

var send_servertime = function() {
    var now = new Date();
    io.emit("from_server", now.toLocaleString());
    console.log(now.toLocaleString());
    setTimeout(send_servertime, 1000)
};
send_servertime();

server.listen(8080);
