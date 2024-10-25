import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  final String chatName;
  ChatPage({required this.chatName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    // Подключение к WebSocket-серверу
    channel = IOWebSocketChannel.connect('ws://localhost:3000');

    // Подписка на получение сообщений
    channel.stream.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

 void _sendMessage() {
  if (_messageController.text.isNotEmpty) {
    // Добавление сообщения в WebSocket
    channel.sink.add(_messageController.text);

    // Добавление сообщения в локальный список и обновление интерфейса
    setState(() {
      _messages.add(_messageController.text);
      _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
