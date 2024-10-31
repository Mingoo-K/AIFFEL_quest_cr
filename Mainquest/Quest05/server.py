import uvicorn   # pip install uvicorn 
from fastapi import FastAPI, HTTPException   # pip install fastapi 
from fastapi.middleware.cors import CORSMiddleware
import vgg16_prediction_quest
import logging

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

# Load the model once
try:
    vgg16_model = vgg16_prediction_main.load_model()
except Exception as e:
    logger.error("Failed to load model: %s", e)
    raise

# A simple example of a GET request
@app.get("/")
async def read_root():
    logger.info("Root URL was requested")
    return "Quest 입니다."

@app.get("/re")
async def result_prediction():
    try:
        predicted_label, _ = await vgg16_prediction_main.prediction_model(vgg16_model)  # 확률은 무시
        logger.info("Root URL was requested /re")
        return {
            "predicted_label": predicted_label
        }
    except Exception as e:
        logger.error("Prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")

@app.get('/pro')
async def score_prediction():
    try:
        _, predicted_score = await vgg16_prediction_main.prediction_model(vgg16_model)  # 레이블은 무시
        logger.info("Root URL was requested /pro")
        return {
            "prediction_score": predicted_score
        }
    except Exception as e:
        logger.error("Prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")      

# Run the server
if __name__ == "__main__":
    uvicorn.run("server_fastapi_quest:app",
            reload= True,   # Reload the server when code changes
            host="127.0.0.1",   # Listen on localhost 
            port=8080,   # Listen on port 8080 
            log_level="info"   # Log level
            )