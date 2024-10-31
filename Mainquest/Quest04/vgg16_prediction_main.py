import tensorflow as tf
from tensorflow.keras.applications.vgg16 import preprocess_input
from tensorflow.keras.preprocessing import image
from tensorflow.keras.applications.imagenet_utils import decode_predictions
from PIL import Image
import numpy as np
import os

def load_model():
    model_path = os.path.expanduser('./vgg16.h5')
    if not os.path.exists(model_path):
        raise FileNotFoundError(f"Model file not found: {model_path}")
    model = tf.keras.models.load_model(model_path)
    return model

async def prediction_model(model):
    img_path = os.path.expanduser('./sample_data/jellyfish.jpg')
    if not os.path.exists(img_path):
        raise FileNotFoundError(f"Image file not found: {img_path}")
    
    img = Image.Image.open(file.stream)
    target_size = 224
    img = img.resize((target_size, target_size))

    np_img = image.img_to_array(img)
    img_batch = np.expand_dims(np_img, axis=0)
    pre_processed = preprocess_input(img_batch)
    
    y_preds = model.predict(pre_processed)
    np.set_printoptions(suppress=True, precision=5)
    # 예측 결과를 디코드
    result = decode_predictions(y_preds, top=1)[0][0]
    predicted_label = str(result[1])  # 예측된 레이블
    predicted_score = str(result[2])   # 예측 확률
    
    return predicted_label, predicted_score  # 각각 반환