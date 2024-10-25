import 'package:flutter/material.dart';
import 'chat_page.dart';
class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Chat 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(chatName: 'Chat 1')),
              );
            },
          ),
          ListTile(
            title: Text('Chat 2'),
            onTap: () 
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(chatName: 'Chat 2'))

              );
            },
          ),
          // Добавь больше чатов, если нужно
        ],
      ),
    );
  }
}
