from fastapi import FastAPI, File, UploadFile, HTTPException
import uvicorn
from PIL import Image
import tensorflow as tf
from io import BytesIO
import numpy as np
import os
import requests


app = FastAPI()

# Specify the model save path within 'saved_model' directory
model_path = os.path.join('saved_model', 'my_model.keras')
# model_path = os.path.join(os.getcwd(), 'saved_model', 'my_model.keras')

print("hehehe")
print(model_path)

model = tf.keras.models.load_model(model_path)

CLASS_NAMES = ["bed", "chair", "sofa", "swivelchair", "table"]

@app.get("/ping")
async def ping():
    return "Hello, I am alive"

def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.open(BytesIO(data)))
    return image

# @app.post("/predict")
# async def predict(
#     file: UploadFile = File(...)
# ):
#     image = read_file_as_image(await file.read())
#     img_batch = np.expand_dims(image, 0)
    
#     predictions = model.predict(img_batch)

#     predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
#     confidence = np.max(predictions[0])
#     return {
#         'class': predicted_class,
#         'confidence': float(confidence)
#     }

@app.post("/predict")
async def predict(image_url: str):
    print("image_url: ", image_url)
    try:
        # Download the image
        response = requests.get(image_url)
        response.raise_for_status()
        image_data = response.content

        # Save the image temporarily
        image_path = os.path.join("images", "temp_image.jpg")
        with open(image_path, "wb") as f:
            f.write(image_data)

        # Read the saved image
        image = read_file_as_image(image_data)

        # Preprocess the image for prediction
        img_batch = np.expand_dims(image, 0)

        # Make predictions
        predictions = model.predict(img_batch)
        predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
        confidence = np.max(predictions[0])

        # Clean up the temporary image file
        os.remove(image_path)

        return {'class': predicted_class, 'confidence': float(confidence)}

    except requests.exceptions.RequestException as e:
        raise HTTPException(status_code=400, detail=f"Error downloading image: {e}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error during prediction: {e}")


if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)