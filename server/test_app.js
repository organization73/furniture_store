const resultString = "products { _id title price description details{ wood } creator{username} createdAt images{imageUrl} }";

// Split the string by spaces to get an array of tokens
const tokens = resultString.split(" ");
console.log(tokens);
// Create an object to store the parsed data
const parsedObject = {};

// Iterate over the tokens and build the object
for (let i = 0; i < tokens.length; i++) {
  const token = tokens[i];

  // Check if the token is a field name
  if (token.endsWith("{")) {
    const fieldName = token.slice(0, -1); // Remove the trailing '{'
    parsedObject[fieldName] = {};
  } else if (token.endsWith("}")) {
    // If the token ends with '}', move to the next iteration
    continue;
  } else {
    // Check if the previous token exists and is a field name
    const prevToken = tokens[i - 1];
    if (prevToken && prevToken.endsWith("{")) {
      const fieldName = prevToken.slice(0, -1);
      parsedObject[fieldName] = token;
    }
  }
}

console.log(parsedObject);