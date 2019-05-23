const WebSocket = require('ws');
const DataModel = require('./protos/DataModel');

const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
  });

  ws.send('something');

  const sendRepeatedly = () => {
    const buf = DataModel.BookInfo.encode({
      id: new Date().getTime(),
      title: 'Harry Potter',
      author: 'J.K. Rowling'
    });
    ws.send(buf);
    setTimeout(sendRepeatedly, 3000);
  }

  sendRepeatedly();
});
