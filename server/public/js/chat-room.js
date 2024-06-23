//db

const currentUserId = currentUser._id;
let currentRoomId;
let isConnected = false;

//signin
const socket = io();
socket.emit("setup", currentUser);
socket.on("connected", () => {
  isConnected = true;
  console.log("connected");
});

// Initialize an empty contact list
const contactListItems = document.getElementById("contact-list-items");
const addContactButton = document.getElementById("open-contact");
const contactDropdown = document.getElementById("contact-dropdown");
//send message
const messagesList = document.getElementById("messages");
const messageContainer = document.getElementById("message-input");
const sendBtn = document.getElementById("send-message-btn");

let typingTimeoutID = null;
let typingElement = document.createElement("p");

/*send typing event*/
messageContainer.addEventListener("input", (event) => {
  if (event.keyCode === 13) {
    event.preventDefault(); // Prevent the default behavior of the Enter key
    sendMessage(); // Call the sendMessage function
  }

  const currentRoomElement = document.querySelector(
    "#contact-list li.selected"
  );
  const currentRoomData = JSON.parse(currentRoomElement.dataset.chatRoom);
  const reciever = currentRoomData.users.find(
    (user) => user._id !== currentUser._id
  );
  socket.emit("typing", {
    recieverId: reciever._id,
    recieverUsername: reciever.username,
  });
});

/*recieve typing event*/
socket.on("recieve-typing", (senderUsername) => {
  if (document.getElementById("typing")) {
    // Clear the old timeout if it exists
    if (typingTimeoutID) {
      clearTimeout(typingTimeoutID);
    }
    // Create a new timeout
    typingTimeoutID = setTimeout(() => {
      typingElement.remove();
    }, 3000);
    return;
  }
  // const typingElement = document.createElement("p");
  typingElement.id = "typing";
  typingElement.textContent = `${senderUsername}: typing...`;
  messagesList.appendChild(typingElement);
  messagesList.scrollTop = messagesList.scrollHeight;

  // Clear the old timeout if it exists
  if (typingTimeoutID) {
    clearTimeout(typingTimeoutID);
  }
  // Create a new timeout
  typingTimeoutID = setTimeout(() => {
    typingElement.remove();
  }, 3000);
});

//fetching Users contacts
fetch("/admin/chat/rooms")
  .then((res) => {
    return res.json();
  })
  .then((data) => {
    console.log(data);
    console.log(typeof data.chatRooms);
    data.chatRooms.forEach((chatRoom) => {
      console.log("chatRoom");
      console.log(chatRoom);
      const listItem = document.createElement("li");
      listItem.className = "contact-item";
      const listItemDiv = document.createElement("div");
      const listItemDivP = document.createElement("p");
      listItemDiv.append(listItemDivP);
      listItem.append(listItemDiv);
      listItemDivP.textContent = chatRoom.fullName;
      listItem.dataset.chatRoom = JSON.stringify(chatRoom); // Add a data-chat-room attribute to the list item
      listItem.dataset.id = chatRoom._id; // Add a data-contact-id attribute to the list item
      listItem.addEventListener("click", selectContact);
      const lastMessage = document.createElement("h6");
      if (chatRoom.latestMessage) {
        console.log('sadfd',chatRoom);
        lastMessage.textContent = `${
          chatRoom.latestMessage.sender.username.split(".")[0]
        } :${chatRoom.latestMessage.content}`;
      } else {
        lastMessage.textContent = "No messages yet";
      }

      listItemDiv.append(lastMessage);
      contactListItems.appendChild(listItem); // Add the new list item to the beginning of the list
    });
  })
  .catch((err) => {
    console.log(err);
  });

//search contact
const input = document.getElementById("contact-input");
const suggestions = document.getElementById("contact-suggestions");

input.addEventListener("input", async () => {
  const value = input.value.toLowerCase();
  suggestions.innerHTML = "";
  if (value.length === 0) {
    return;
  }
  let response = await fetch(`/admin/chat/users?search=${value.trim()}`);
  response = await response.json();
  const contacts = response.users;
  filteredContacts = contacts;

  filteredContacts.forEach((contact) => {
    const p = document.createElement("p");
    p.textContent = contact.username;
    p.contact = contact;
    p.addEventListener("click", () => {
      input.value = contact.username;
      input.dataset.id = contact._id;
      suggestions.style.display = "none";
    });
    suggestions.appendChild(p);
  });
  suggestions.style.display = "block";
});

//selecting a search contact
document.addEventListener("click", (event) => {
  if (!event.target.matches("#contact-input")) {
    suggestions.style.display = "none";
  }
});

const contacts = [];
const protocol = window.location.protocol;
const hostname = window.location.hostname;
const port = window.location.port;
const url = `${protocol}://${hostname}:${port}`;

//Function to add a new contact to the list
addContactButton.addEventListener("click", addContact);
async function addContact() {
  //add new contact in the db on server
  let chatRoom;
  try {
    let response = await fetch("/admin/chat/access-room", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        userId: input.dataset.id,
      }),
    });
    let jsonResponse = await response.json();
    if (response.status !== 201 && response.status !== 200) {
      throw new Error(jsonResponse.message);
    }
    chatRoom = jsonResponse.chatRoom;
  } catch (err) {
    return console.log(err);
  }

  const listItem = document.createElement("li");
  const listItemDiv = document.createElement("div");
  const listItemDivP = document.createElement("p");
  const lastMessage = document.createElement("h6");
  listItem.dataset.id = chatRoom._id; // Add a data-contact-id attribute to the list item
  listItem.addEventListener("click", selectContact);
  listItemDiv.append(listItemDivP);
  if (chatRoom.lastMessage) {
    lastMessage.textContent = chatRoom.lastMessage.content || "No messages yet";
  } else {
    lastMessage.textContent = "No messages yet";
  }
  listItemDiv.append(lastMessage);
  listItemDivP.textContent = input.value;
  listItem.append(listItemDiv);
  contactListItems.prepend(listItem); // Add the new list item to the beginning of the list
  //clean the input field
  input.value = "";
  input.dataset.id = "";
}

//recieve new contact(room)
socket.on("recieve-new-room", (chatRoom) => {
  const listItem = document.createElement("li");
  const listItemDiv = document.createElement("div");
  const listItemDivP = document.createElement("p");
  const lastMessage = document.createElement("h6");
  listItem.dataset.id = chatRoom._id; // Add a data-contact-id attribute to the list item
  listItem.addEventListener("click", selectContact);
  listItemDiv.append(listItemDivP);
  if (chatRoom.lastMessage) {
    lastMessage.textContent = chatRoom.lastMessage.content || "No messages yet";
  } else {
    lastMessage.textContent = "No messages yet";
  }
  listItemDiv.append(lastMessage);
  listItemDivP.textContent = input.value;
  listItem.append(listItemDiv);
  contactListItems.prepend(listItem); // Add the new list item to the beginning of the list
  //clean the input field
  input.value = "";
  input.dataset.id = "";
});

//select a contact and send a GET request to the API
function selectContact() {
  console.log("user", currentUserId);
  const contactId = this.dataset.id;

  messageContainer.disabled = false;
  messageContainer.autofocus = true;

  // Remove the "selected" class from any previously selected contact
  const previouslySelectedContact = document.querySelector(
    "#contact-list li.selected"
  );
  currentRoomId = contactId;
  //for speaking in a group.
  if (previouslySelectedContact) {
    //leave old room.
    console.log("leave room", previouslySelectedContact.dataset.id);
    socket.emit("leave-room", previouslySelectedContact.dataset.id); //
    previouslySelectedContact.classList.remove("selected");
  }
  // Add the "selected" class to the newly selected contact
  const newSelectedContact = document.querySelector(
    `#contact-list li[data-id="${contactId}"]`
  );
  if (newSelectedContact) {
    newSelectedContact.classList.add("selected");
  }
  // Clear any existing messages
  messagesList.innerHTML = "";

  console.log("join room", contactId);

  // Send a GET request to the API to retrieve messages for the selected contact
  fetch(`/admin/chat/room/${contactId}`)
    .then((response) => response.json())
    .then((messages) => {
      // Clear any existing messages
      const messagesList = document.getElementById("messages");
      messagesList.innerHTML = "";
      // Add the new messages to the messages div
      messages.forEach((message) => {
        const messageElement = document.createElement("p");
        console.log(`message sender${message.sender}`);
        messageElement.textContent = `${
          message.sender.username.split(" ")[0]
        }: ${message.content}`;
        messagesList.appendChild(messageElement);
      });
      messagesList.scrollTop = messagesList.scrollHeight;
    })
    .catch((error) => {
      console.error("Error retrieving messages:", error);
    });
  //join room
  socket.emit("join-room", contactId);
}

/*receive message*/
socket.on("recieve-message", (newMessage) => {
  console.log("new message", newMessage);
  //delete typing element
  if (document.getElementById("typing")) {
    typingElement.remove();
  }
  if (newMessage.chatRoom._id === currentRoomId) {
    const messageElement = document.createElement("p");
    messageElement.textContent = `${
      newMessage.sender.username.split(" ")[0]
    }: ${newMessage.content}`;
    messagesList.appendChild(messageElement);
    messagesList.scrollTop = messagesList.scrollHeight;
  }
});

//send a message to the currently selected contact
sendBtn.addEventListener("click", sendMessage);
async function sendMessage() {
  const message = messageContainer.value;
  document.getElementById("message-input").value = "";
  //condition to check if the message is not empty.
  if (message) {
    const selectedContact = document.querySelector("#contact-list li.selected");
    const messagesList = document.getElementById("messages");
    try {
      const response = await fetch(`/admin/chat/message`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          content: message,
          roomId: selectedContact.dataset.id,
        }),
      });
      if (response.status !== 201 && response.status !== 200) {
        throw new Error("Error sending message");
      }
      const newMessage = await response.json();
      // socket.emit("new-message", newMessage);
    } catch (error) {
      return console.log(error);
    }
    const messageElement = document.createElement("p");
    messageElement.textContent = `${currentUser.username}: ${message}`;
    messagesList.appendChild(messageElement);
    messagesList.scrollTop = messagesList.scrollHeight;
    //update the latest message in the contact list
    selectedContact.querySelector("h6").textContent = `${
      currentUser.username.split(".")[0]
    }: ${message}`;
  }
}
