ECHO Processing and moving images related to the Test Estimation test
cd test-threshold-estimation

magick Slide1.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/ThesholdEstimationUI.png 
magick Slide2.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/UpDown.png 
magick Slide3.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/DiscreteUpDown.png 
magick Slide4.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/PsiMethod.png 
magick Slide5.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskFYN.png 
magick Slide6.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskManualYesNo.png 
magick Slide7.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskCRS.png 
magick Slide8.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskManualCRS.png 
magick Slide9.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskNRS.png 
magick Slide10.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskManualNRS.png 
magick Slide11.PNG  -trim ../../assets/images/experiments/tests/threshold-estimation/TaskVAS.png 
copy Slide12.PNG "../../assets/images/experiments/tests/threshold-estimation/TaskAFC.png" 
copy Slide13.PNG "../../assets/images/experiments/tests/threshold-estimation/TaskIFC.png"

cd ..


pause

