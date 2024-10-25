// Импорт необходимых модулей
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

// Подключение WebSocket
io.on('connection', (socket) => {
  console.log('A user connected:', socket.id);

  // Получение и распространение сообщения всем подключенным клиентам
  socket.on('message', (msg) => {
    io.emit('message', msg); // Рассылка сообщения всем клиентам
  });

  // Когда пользователь отключается
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

// Запуск сервера на порту 3000
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
