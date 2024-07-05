const product_grid = document.querySelector(".grid");
async function deleteProduct(product, id) {
  const nextSibling = product.nextElementSibling;
  const previousSibling = product.previousElementSibling;
  console.log(nextSibling);
  console.log(previousSibling);

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
        showNotification(
          `Failed to delete product ${
            product.querySelector("header h1").textContent
          }`
        );
      } else if (previousSibling) {
        // product_grid.insertBefore(articleCopy, previousSibling);
        product_grid.append(articleCopy);
        showNotification(
          `Failed to delete product ${
            product.querySelector("header h1").textContent
          }`
        );
      }
      throw new Error("Failed to delete product");
    } else {
      showNotification(
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

async function approveProduct(product, id) {
  console.log("approveProduct", product);
  try {
    const response = await fetch(`/admin/approve-product/${id}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
      },
    });
    if (response.status != 201) {
      throw new Error("Failed to approve product");
    }
    const data = await response.json();
    product.remove();
    console.log(data);
    showNotification(
      `Product ${
        product.querySelector("header h1").textContent
      } was approved successfully`,
      "success"
    );
  } catch (error) {
    console.log(error);
    showNotification(
      `Failed to approve product ${
        product.querySelector("header h1").textContent
      }`,
      "error"
    );
  }
}

// fetch details
async function fetchProduct(id) {
  window.location.href = `/admin/product-details/${id}`;
}

function showNotification(message, type = "error") {
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
  }, 5000);
}
