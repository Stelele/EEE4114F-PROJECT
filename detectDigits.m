function digits = detectDigits(x,fs)
%{
    This function detects the multiple keys in a given input audio

    Inputs:     x: The input audio signal
                fs: sampling rate

    Outputs:    digits: All the digits detected in the order of occurance
%}
    N = 102; % length of each sample being taken
    overlap = 16; % amount of overlap 
    sampleLength = 3 * (N-overlap) + N;
    sampleNum = floor(length(x)/sampleLength);
    
    digits = zeros(sampleNum,1);
    curpos = 1;

    for i = 1:sampleNum
       startSection = (i-1)*sampleLength + 1;
       endSection = startSection + sampleLength;    
       
       xSection = zeros(2*sampleLength,1);
       xSection(1:(endSection-startSection)+1) = x(startSection:endSection);
       
       digits(curpos) = detectKeyPress(xSection,fs);
       curpos = curpos + 1;
    end
    
    %clean up duplicate detections
    digitFound = 0;
    for i = 1:length(digits)
        if digitFound == 0 && digits(i) ~= -1
            digitFound = i;
        elseif digitFound ~= 0 && digits(i) == digits(digitFound)
            digits(i) = -1;
        else
            digitFound = 0;
        end
    end
    
    %return only found digits
    digits = digits(digits ~= -1);
end