async function deleteProduct(product) {
  const product_grid = document.querySelector(".grid");
  const nextSibling = product.nextElementSibling;
  const previousSibling = product.previousElementSibling;
  console.log(nextSibling);
  console.log(previousSibling);
  const id = document
    .querySelector("article")
    .querySelector(".card__actions")
    .querySelector("input").value;
  const articleCopy = product.cloneNode(true);
  try {
    product.remove();
    const respond = await fetch(`/admin/product/${id}`, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
    });
    if (respond.status != 200) {
      if (nextSibling) {
        product_grid.insertBefore(articleCopy, nextSibling);
        showErrorNotification(
          `Failed to delete product ${
            product.querySelector("header h1").textContent
          }`
        );
      } else if (previousSibling) {
        // product_grid.insertBefore(articleCopy, previousSibling);
        product_grid.append(articleCopy);
        showErrorNotification(
          `Failed to delete product ${
            product.querySelector("header h1").textContent
          }`
        );
      }
      throw new Error("Failed to delete product");
    } else {
      showErrorNotification(
        `Product ${
          product.querySelector("header h1").textContent
        } was deleted successfully`,
        "success"
      );
    }
    console.log(id);
  } catch (error) {
    console.log(error);
  }
}

function showErrorNotification(message, type = "error") {
  // Create a new div element
  const notification = document.createElement("div");

  // Set the class name of the div element to "error-notification"

  if (type === "error") {
    notification.className = "error-notification";
  } else if (type === "success") {
    notification.className = "success-notification";
  }

  // Set the text content of the div element to the message
  notification.textContent = message;

  // Add the div element to the body of the document
  document.body.appendChild(notification);

  // Set a timeout to hide the notification after 5 seconds
  setTimeout(() => {
    notification.style.display = "none";
  }, 2000);
}
