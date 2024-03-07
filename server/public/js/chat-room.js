//db

const currentUserId = currentUser._id;
let currentRoomId = {};
let isConnected = false;

//signin
const socket = io();
socket.emit("setup", currentUser);
socket.on("connected", () => {
  isConnected = true;
});

// Initialize an empty contact list
const contactListItems = document.getElementById("contact-list-items");
const addContactButton = document.getElementById("open-contact");
const contactDropdown = document.getElementById("contact-dropdown");
//send message
const messageContainer = document.getElementById("message-input");
const sendBtn = document.getElementById("send-message-btn");
//search contact
const input = document.getElementById("contact-input");
const suggestions = document.getElementById("contact-suggestions");

input.addEventListener("input", async () => {
  const value = input.value.toLowerCase();
  suggestions.innerHTML = "";
  if (value.length === 0) {
    return;
  }
  let response = await fetch(`/chat/users?search=${value.trim()}`);
  response = await response.json();
  const contacts = response.users;
  console.log("value", value);
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

//fetching Users contacts
fetch("/chat/rooms")
  .then((res) => {
    return res.json();
  })
  .then((data) => {
    console.log(data);
    console.log(typeof data.chatRooms);
    data.chatRooms.forEach((chatRoom) => {
      const listItem = document.createElement("li");
      listItem.addEventListener("click", selectContact);
      listItem.textContent = chatRoom.fullName;
      listItem.dataset.id = chatRoom._id; // Add a data-contact-id attribute to the list item
      contactListItems.prepend(listItem); // Add the new list item to the beginning of the list
    });
  })
  .catch((err) => {
    console.log(err);
  });

const contacts = [];
const protocol = window.location.protocol;
const hostname = window.location.hostname;
const port = window.location.port;
const url = `${protocol}://${hostname}:${port}`;

// Function to add a new contact to the list
addContactButton.addEventListener("click", addContact);
async function addContact() {
  //add new contact in the db on server
  let chatRoom;
  try {
    const response = await fetch("/chat/access-room", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        userId: input.dataset.id,
      }),
    });
    if (response.status !== 201 && response.status !== 200) {
      throw new Error("Error adding contact");
    }
    chatRoom = await response.json();
  } catch (err) {
    return console.log(err);
  }

  const listItem = document.createElement("li");
  listItem.textContent = input.value;
  listItem.dataset.userId = chatRoom._id; // Add a data-contact-id attribute to the list item
  //clean the input field
  input.value = "";
  input.dataset.id = "";
  contactListItems.prepend(listItem); // Add the new list item to the beginning of the list
}

// Function to select a contact and send a GET request to the API
function selectContact() {
  const contactId = this.dataset.id;
  messageContainer.disabled = false;
  messageContainer.autofocus = true;

  // Remove the "selected" class from any previously selected contact
  const previouslySelectedContact = document.querySelector(
    "#contact-list li.selected"
  );
  currentRoomId = contactId;
  if (previouslySelectedContact) {
    //leave old room.
    console.log("leave room", previouslySelectedContact.dataset.id);
    socket.emit("leave-room", previouslySelectedContact.dataset.id);
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
  const messagesList = document.getElementById("messages");
  messagesList.innerHTML = "";

  console.log("join room", contactId);

  // Send a GET request to the API to retrieve messages for the selected contact
  fetch(`/chat/room/${contactId}`)
    .then((response) => response.json())
    .then((messages) => {
      // Clear any existing messages
      const messagesList = document.getElementById("messages");
      messagesList.innerHTML = "";
      // Add the new messages to the messages div
      messages.forEach((message) => {
        const messageElement = document.createElement("p");
        messageElement.textContent = `${message.sender.username}: ${message.content}`;
        messagesList.appendChild(messageElement);
      });
    })
    .catch((error) => {
      console.error("Error retrieving messages:", error);
    });
  //join room
  socket.emit("join-room", contactId);
}

// Function to send a message to the currently selected contact
sendBtn.addEventListener("click", sendMessage);
async function sendMessage() {
  const message = messageContainer.value;
  if (message) {
    const selectedContact = document.querySelector("#contact-list li.selected");
    const messagesList = document.getElementById("messages");
    try {
      const response = await fetch(`/chat/message`, {
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
    } catch (error) {
      return console.log(error);
    }
    const messageElement = document.createElement("p");
    messageElement.textContent = `${
      selectedContact.textContent.split(" ")[0]
    }: ${message}`;
    messagesList.appendChild(messageElement);
    document.getElementById("message-input").value = "";
  }
}
// function sendMessage() {
//   const messageInput = document.getElementById("message-input");
//   const messageText = messageInput.value;
//   // if (messageText && contacts.length > 0) {
//   if (messageText) {
//     const selectedContact = document.querySelector(
//       "#contact-list li.selected"
//     );
//     if (selectedContact) {
//       const contactId = selectedContact.dataset.contactId;
//       const message = {
//         sender: "You",
//         text: messageText,
//       };
//       fetch(`/api/messages/${contactId}`, {
//         method: "POST",
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: JSON.stringify(message),
//       })
//         .then((response) => response.json())
//         .then((newMessage) => {
//           // Add the new message to the messages div
//           const messagesDiv = document.getElementById("messages");
//           const messageElement = document.createElement("p");
//           messageElement.textContent = `${newMessage.sender}: ${newMessage.text}`;
//           messagesDiv.appendChild(messageElement);

//           // Clear the message input field
//           messageInput.value = "";
//         })
//         .catch((error) => {
//           console.error("Error sending message:", error);
//         });
//     }
//   }
// }
