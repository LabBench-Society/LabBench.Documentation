ECHO Processing and moving images related to the Test Estimation test
cd test-algometry

magick Slide1.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusResponseUI.png 
magick Slide2.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusResponseStopMode.png 
magick Slide3.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusResponseSecondCuff.png 
magick Slide4.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusResponseConditioningTime.png 
magick Slide5.PNG  -trim ../../assets/images/experiments/tests/algometry/CPMTestUI.png 
magick Slide6.PNG  -trim ../../assets/images/experiments/tests/algometry/CPMTestStopMode.png 
magick Slide7.PNG  -trim ../../assets/images/experiments/tests/algometry/CPMTestConditioning.png 
magick Slide8.PNG  -trim ../../assets/images/experiments/tests/algometry/TemporalSummationUI.png 
magick Slide9.PNG  -trim ../../assets/images/experiments/tests/algometry/TemporalSummationSecondCuff.png 
magick Slide10.PNG  -trim ../../assets/images/experiments/tests/algometry/StaticTemporalSummationUI.png 
magick Slide11.PNG  -trim ../../assets/images/experiments/tests/algometry/ArbitraryTemporalSummationUI.png 
magick Slide12.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusRatingUI.png 
magick Slide13.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusRatingMeasurement.png 
magick Slide14.PNG  -trim ../../assets/images/experiments/tests/algometry/StimulusRatingConditioningTime.png 
magick Slide15.PNG  -trim ../../assets/images/experiments/tests/algometry/ConditionedPainRatingUI.png 
magick Slide16.PNG  -trim ../../assets/images/experiments/tests/algometry/ConditionedPainRatingConditioning.png 

cd ..


pause

