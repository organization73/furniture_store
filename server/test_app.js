const list1 = [
  { id: 1, name: "Alice" },
  { id: 2, name: "Bob" },
  { id: 3, name: "Charlie" },
];

const list2 = [
  { id: 3, name: "David" },
  { id: 4, name: "Eve" },
  { id: 5, name: "Frank" },
];


console.log(list1.filter((item) => item.id === 1));
