Map<String, dynamic> jsonChats = {
  "chats": [
    {
      "id": 1,
      "participants": [
        {"id": 1, "name": "User1"},
        {"id": 2, "name": "User2"}
      ],
      "messages": [
        {
          "id": "1",
          "sender": {"id": 1, "name": "User1"},
          "timestamp": "2023-12-15/2:25 AM",
          "text":
              "Hello, how are you?Hello, how are you?Hello, how are you?Hello, how are you?",
          "status": "sent"
        },
        {
          "id": "2",
          "sender": {"id": 2, "name": "User2"},
          "timestamp": "2023-12-15/2:25 AM",
          "text": "Hi! I'm good, thanks.",
          "status": "delivered"
        },
        {
          "id": "3",
          "sender": {"id": 1, "name": "User1"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "That's great!",
          "status": "read"
        }
      ]
    },
    {
      "id": 2,
      "participants": [
        {"id": 1, "name": "User1"},
        {"id": 3, "name": "User3"}
      ],
      "messages": [
        {
          "id": "1",
          "sender": {"id": 1, "name": "User1"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Hey there!",
          "status": "sent"
        },
        {
          "id": "2",
          "sender": {"id": 3, "name": "User3"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Hello!",
          "status": "delivered"
        },
        {
          "id": "3",
          "sender": {"id": 1, "name": "User1"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "What's up?",
          "status": "read"
        },
        {
          "id": "4",
          "sender": {"id": 3, "name": "User3"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Not much, just chilling.",
          "status": "sent"
        },
        {
          "id": "5",
          "sender": {"id": 1, "name": "User1"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Cool! Anything exciting happening?",
          "status": "delivered"
        }
      ]
    },
    {
      "id": 3,
      "participants": [
        {"id": 2, "name": "User2"},
        {"id": 3, "name": "User3"}
      ],
      "messages": [
        {
          "id": "1",
          "sender": {"id": 2, "name": "User2"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Hey folks!",
          "status": "sent"
        },
        {
          "id": "2",
          "sender": {"id": 3, "name": "User3"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Hello!",
          "status": "delivered"
        },
        {
          "id": "3",
          "sender": {"id": 2, "name": "User2"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "What's new?",
          "status": "read"
        },
        {
          "id": "4",
          "sender": {"id": 3, "name": "User3"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "Just got back from a trip!",
          "status": "sent"
        },
        {
          "id": "5",
          "sender": {"id": 2, "name": "User2"},
          "timestamp": "2023-12-16/2:25 AM",
          "text": "That sounds exciting! Tell me more.",
          "status": "delivered"
        }
      ]
    }
  ]
};
