import uvicorn
from fastapi import FastAPI, HTTPException, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from tensorflow.keras.applications.vgg16 import VGG16, preprocess_input, decode_predictions
from tensorflow.keras.preprocessing import image
from PIL import Image
import numpy as np
import logging
import io

# Create the FastAPI application
app = FastAPI()

# CORS configuration
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load VGG16 model
def load_model():
    model = VGG16(weights="imagenet")
    return model

vgg16_model = load_model()

# Prediction function
async def prediction_model(file):
    img = Image.open(io.BytesIO(file))
    img = img.resize((224, 224))
    img_array = image.img_to_array(img)
    img_batch = np.expand_dims(img_array, axis=0)
    pre_processed = preprocess_input(img_batch)

    preds = vgg16_model.predict(pre_processed)
    decoded_result = decode_predictions(preds, top=1)[0][0]
    predicted_label = decoded_result[1]  # 예측된 레이블

    return predicted_label

@app.get("/")
async def read_root():
    logger.info("Root URL was requested")
    return "VGG16 모델을 사용하는 API를 만들어 봅시다."

@app.post("/upload")
async def upload_image(file: UploadFile = File(...)):
    try:
        image_data = await file.read()
        predicted_label = await prediction_model(image_data)

        return {
            "predicted_label": predicted_label
        }
    except Exception as e:
        logger.error("Prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")

# Run the server
if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8080, log_level="info")
