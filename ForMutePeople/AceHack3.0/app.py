import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'

from flask import Flask , request , jsonify
import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision



model_path = 'E:\see_speak\gesture_recognizer.task'

BaseOptions = mp.tasks.BaseOptions
GestureRecognizer = mp.tasks.vision.GestureRecognizer
GestureRecognizerOptions = mp.tasks.vision.GestureRecognizerOptions
VisionRunningMode = mp.tasks.vision.RunningMode
app = Flask(_name_)

@app.route('/' , methods=['POST'])
# ‘/’ URL is bound with hello_world() function.
def hello_world():
	image = request.files['image']
	image.save('E:\see_speak\photos\download.jpg')
	options = GestureRecognizerOptions(
    base_options=BaseOptions(model_asset_path=model_path),
    running_mode=VisionRunningMode.IMAGE)
	with GestureRecognizer.create_from_options(options) as recognizer:

		# thumbs up
		mp_image = mp.Image.create_from_file('E:\see_speak\photos\download.jpg')

		
		gesture_recognition_result = recognizer.recognize(mp_image)
		print("output : ")
		# print(gesture_recognition_result)
		# result = gesture_recognition_result(...)
		print(gesture_recognition_result.gestures[0][0].category_name)
		print(gesture_recognition_result.handedness[0][0].category_name)
		# print("gesture  :")
		# print(gesture)
	return jsonify({
		'Sign' : gesture_recognition_result.gestures[0][0].category_name , 
		'Hand' : gesture_recognition_result.handedness[0][0].category_name
    })

# main driver function
if _name_ == '_main_':
	app.run()