ECHO Processing and moving images related to the Test Response Recording section
cd test-response-recording

magick Slide1.PNG  -trim ../../assets/images/experiments/tests/response-recording/ResponseRecordingUI.png 
magick Slide2.PNG  -trim ../../assets/images/experiments/tests/response-recording/VASRecording.png 
magick Slide3.PNG  -trim ../../assets/images/experiments/tests/response-recording/NRSRecording.png 
magick Slide4.PNG  -trim ../../assets/images/experiments/tests/response-recording/CRSRecording.png 
magick Slide5.PNG  -trim ../../assets/images/experiments/tests/response-recording/SetupLIO.png 
magick Slide6.PNG  -trim ../../assets/images/experiments/tests/response-recording/SetupJoystick.png 

cd ..

pause

