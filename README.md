**Sign-Language-To-Text-and-Speech-Conversion**

**ABSTRACT:** 

 Sign language is one of the oldest and most natural form of language for communication, hence we have come up with a real time method using neural networks for finger spelling based American sign language. Automatic human gesture recognition from camera images is an interesting topic for developing vision. We propose a convolution neural network (CNN) method to recognize hand gestures of human actions from an image captured by camera. The purpose is to recognize hand gestures of human task activities from a camera image. The position of hand and orientation are applied to obtain the training and testing data for the CNN. The hand is first passed through a filter and after the filter is applied where the hand is passed through a classifier which predicts the class of the hand gestures. Then the calibrated images are used to train CNN. 



**Introduction:**

 American sign language is a predominant sign language Since the only disability D&M people have been communication related and they cannot use spoken languages hence the only way for them to communicate is through sign language. Communication is the process of exchange of thoughts and messages in various ways such as speech, signals, behavior and visuals. Deaf and dumb(D&M) people make use of their hands to express different gestures to express their ideas with other people. Gestures are the nonverbally exchanged messages and these gestures are understood with vision. This nonverbal communication of deaf and dumb people is called sign language. 

In our project we basically focus on producing a model which can recognise Fingerspelling based hand gestures in order to form a complete word by combining each gesture. The gestures we aim to train are as given in the image below. 


![Spanish_SL](https://user-images.githubusercontent.com/99630855/201489493-585ffe5c-f460-402a-b558-0d03370b4f92.jpg)

**Requirements:**

More than 70 million deaf people around the world use sign languages to communicate. Sign language allows them to learn, work, access services, and be included in the communities.  

It is hard to make everybody learn the use of sign language with the goal of ensuring that people with disabilities can enjoy their rights on an equal basis with others. 

So, the aim is to develop a user-friendly human computer interface (HCI) where the computer understands the American sign language This Project will help the dumb and deaf people by making their life easy. 


Mediapipe Landmark System: 

![2410344](https://user-images.githubusercontent.com/99630855/201489741-3649959e-df4d-4c32-898a-8f994be92ca2.png)

![a12](https://user-images.githubusercontent.com/99630855/201490095-96402d48-b289-4ff3-9738-ed99ffcffca6.jpg)

![a23](https://user-images.githubusercontent.com/99630855/201490105-87b17583-45c5-4e3b-82d1-0c9a6f98fc55.jpg)

![7](https://user-images.githubusercontent.com/99630855/201490124-dc41d7ad-313f-47b7-b50c-0f9db3155e0d.jpg)

![b11](https://user-images.githubusercontent.com/99630855/201490119-55ff1b2d-1826-4bc6-994e-8c8c528c8c35.jpg)

![b16](https://user-images.githubusercontent.com/99630855/201490122-46d87005-ccb6-46ac-9dcf-185a569d6958.jpg)

![127](https://user-images.githubusercontent.com/99630855/201490130-b0aae39b-a623-4cf8-b41d-0611c02637ed.jpg)
 

Now we get this landmark points and draw it in plain white background using opencv library 

-By doing this we tackle the situation of background and lightning conditions because the mediapipe labrary will give us landmark points in any background and mostly in any lightning conditions. 


![2022-10-31](https://user-images.githubusercontent.com/99630855/201489669-1b262755-23f8-4e02-91ba-393aa6482620.png)
![2022-10-31 (1)](https://user-images.githubusercontent.com/99630855/201489673-08a8dad8-30a4-426a-8f62-02190416191d.png)

 ![hhee2022-10-31 (2)](https://user-images.githubusercontent.com/99630855/201496302-f67b360a-1ef5-4486-8ff7-cc56cee30b97.png)



-Finally, we got **97%** Accuracy (with and without clean background and proper lightning conditions) through our method. And if the background is clear and there is good lightning condition then we got even **99%** accurate results 



**Text To Speech Translation:**

The model translates known gestures into words. we have used pyttsx3 library to convert the recognized words into the appropriate speech. The text-to-speech output is a simple workaround, but it's a useful feature because it simulates a real-life dialogue. 

**Project Requirements :**

**Hardware Requirement:**

Webcam 

**Software Requirement:**

Operating System: Windows 8 and Above 

IDE: PyCharm 

Programming Language: Python 3.9 5 

Python libraries: OpenCV, NumPy, Keras,mediapipe,Tensorflow 


**System Diagrams:**


**System Flowchart:**

![system flowchart](https://user-images.githubusercontent.com/99630855/201490238-224f65aa-071f-473a-8c23-a9d60e0a47d8.png)

**Use-case diagram:**

![Untitled Diagram drawio](https://user-images.githubusercontent.com/99630855/201490218-85f4c194-0496-4dfb-b920-e486256bd6b7.png)
 
**DFD diagram:**

![Flowcharts (2)](https://user-images.githubusercontent.com/99630855/201490221-f543fa6d-75ba-4db0-bc35-ee8c06e25018.png)
![Flowcharts (1)](https://user-images.githubusercontent.com/99630855/201490226-966bcc44-8149-433d-ab3b-b0a23deb1c91.png)
 

**Sequence diagram:**

![sequence2](https://user-images.githubusercontent.com/99630855/201490230-b903c365-7a4c-4972-8268-5687060b9cd0.png)
 
