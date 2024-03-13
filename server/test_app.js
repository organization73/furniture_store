
const onlineUsers = [
  {
    userId: '65e75073a08657edee44aabf',
    socketId: 'BcCBT9NLr756BzFaAAAF',
    userType: 'user'
  }
]
const userIndex = onlineUsers.findIndex(
  (user) => user.socketId === "BcCBT9NLr756BzFaAAAF"
);
if (userIndex !== -1) {
  console.log(userIndex);
  onlineUsers.splice(userIndex, 1);
}
console.log(onlineUsers);