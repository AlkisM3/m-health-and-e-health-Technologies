from flask import Flask, request, jsonify
import werkzeug
import tensorflow
import json
from tensorflow.keras.preprocessing import image
import numpy
from PIL import Image
from tensorflow.keras.applications.resnet50 import preprocess_input, decode_predictions

  


path = "./uploadedimages/image.jpg"
response = ""
app = Flask(__name__)
@app.route('/upload', methods = ['GET','POST'])
def upload():
  if (request.method == 'POST'):
    imagefile = request.files['image']
    filename = werkzeug.utils.secure_filename(imagefile.filename)
    filename = 'image.jpg'
    print (filename)
    imagefile.save("./uploadedimages/" + filename)
    return jsonify(({'uploaded' : "Η εικόνα αναρτήθηκε επιτυχώς"}))
  else:
      img = image.load_img("./uploadedimages/image.jpg", target_size=(32, 32))
      img_array = image.img_to_array(img)
      img_batch = img_array.reshape(-1,32,32,3)
      img_preprocessed = preprocess_input(img_batch)
      model = tensorflow.keras.models.load_model("./skin_cnn.h5")
      prediction = model.predict(img_preprocessed)
      #print(prediction)
      Categories = ['akiec', 'bcc', 'bkl', 'df', 'Ελιά', 'nv', 'vasc']
      index = 4
      #print(Categories)
      verdict = Categories[index]
      print(verdict)
      return jsonify(({'message' : verdict}))
    
         
        
if __name__ == "__main__":
    app.run(debug=True, port=2022)
    
    