from fastapi import FastAPI, File, UploadFile
import uvicorn
from io import BytesIO
from PIL import Image
import tensorflow as tf
import numpy as np
import os

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

@app.post("/predict")
async def predict(
    file: UploadFile = File(...)
):
    image = read_file_as_image(await file.read())
    img_batch = np.expand_dims(image, 0)
    
    predictions = model.predict(img_batch)

    predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
    confidence = np.max(predictions[0])
    return {
        'class': predicted_class,
        'confidence': float(confidence)
    }

if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)