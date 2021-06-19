function digits = detectDigits(x,fs)
    sectionDuration = 0.4;
    sampleLength = sectionDuration * fs;
    sampleNum = floor(length(x)/sampleLength);
    
    
    digits = zeros(sampleNum,1);
    curpos = 1;

    for i = 1:sampleNum
       startSection = (i-1)*sampleLength + 1;
       endSection = startSection + sampleLength;
       hammingWindow = transpose(hamming(length(x(startSection:endSection))));
       
       xSection = zeros(2*sampleLength,1);
       xSection(1:(endSection-startSection)+1) = x(startSection:endSection) .* hammingWindow;
       
       digits(curpos) = detectKeyPress(xSection,fs);
       curpos = curpos + 1;
    end

end