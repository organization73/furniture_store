class Chat {
  final int id;
  final List<Map<String, dynamic>> participants;
  final List<Message> messages;

  Chat({required this.id, required this.participants, required this.messages});
}

class Message {
  final String id;
  final Map<String, dynamic> sender;
  final String timestamp;
  final String text;
  final String status;

  Message({
    required this.id,
    required this.sender,
    required this.timestamp,
    required this.text,
    required this.status,
  });
}
