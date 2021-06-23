# EEE4114F Project
## Telephone Number Classification from a DTMFDecoder
[Gift Mugweni](https://github.com/Stelele) & [Lindelani Mbatha](https://github.com/lindelanimcebo)

## Background

Dual Tone Multiple Frequency (DTMF) signaling was developed as a means to identify destination telephone numbers for push-button telephones. It replaced
the rotary dial telephone, and has since been used for other applications including ATMS and remote controll.
As a result, it was standardized by  the  International  Telecommunication  Union  (ITU)  [1]. 

This repository contains matlab scripts used to implement and test a DTMF decoding system which extracts telephone numbers from an audio input and classify
them according to artifictial providers used in this experiment.

## Running Tests
### Decoder Noise Performance
run the [test_noise.m](test_noise.m) script to test the dtmf decoder for noise performance

### Test Classifier
run the [make_inputs](make_inputs.m) to generate input audio files under the [numbers](numbers/) directory

run the [test.m](test.m) script to test the cell number extractor and classifier

## References
[1]  “Recommendation q.23: Technical features of push-button telephone sets,” 1988. [Online]. Available: https://www.itu.int/rec/T-REC-Q.23-198811-I/en
