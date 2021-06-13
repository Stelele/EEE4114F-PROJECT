function Val = detectKeyPress(x, fs)
    tolerance = 0.015; % frequency passband range
    threshold = 40; % value above which detection has occured
    
    fl = [697, 770, 852, 941];
    fh = [1209, 1336, 1477, 1633];
    
    flDetect = zeros(size(fl));
    fhDetect = zeros(size(fh)); 

    N = length(x);
    kvals = 0:N/2;
    
    Xabs = 20 * log(mygoertzel(x, kvals, N));
    
    %detect low frequency signal
    curpos = 1; 
    for ftest = fl
       kmin = floor(ftest * N * (1-tolerance)/fs);
       kmax = ceil(ftest * N * (1+tolerance)/fs);
       
       detection = max(Xabs(kmin:kmax) > threshold);
       
       if detection == 1
          flDetect(curpos) = 1;
       end
       curpos = curpos + 1;
    end
    
    %detect high frequency signal
    curpos = 1; 
    for ftest = fh
       kmin = floor(ftest * N * (1-tolerance)/fs);
       kmax = ceil(ftest * N * (1+tolerance)/fs);
       
       detection = max(Xabs(kmin:kmax) >= threshold);
       
       if detection == 1
          fhDetect(curpos) = 1;
       end
       curpos = curpos + 1;
    end
    
    %get position of frequency
    [Ml, flIndex] = max(flDetect);
    [Mh, fhIndex] = max(fhDetect);
    
    if (Ml == 1) && (Mh == 1)
        switch flIndex
            case 1
                switch fhIndex
                    case 1
                        Val = 1;
                    case 2
                        Val = 2;
                    case 3
                        Val = 3;
                    case 4
                        Val = 'A';
                end
            case 2
                switch fhIndex
                    case 1
                        Val = 4;
                    case 2
                        Val = 5;
                    case 3
                        Val = 6;
                    case 4
                        Val = 'B';
                end
            case 3
                switch fhIndex
                    case 1
                        Val = 7;
                    case 2
                        Val = 8;
                    case 3
                        Val = 9;
                    case 4
                        Val = 'C';
                end
            case 4
                switch fhIndex
                    case 1
                        Val = '*';
                    case 2
                        Val = 0;
                    case 3
                        Val = '#';
                    case 4
                        Val = 'D';
                end
        end
    else
       Val = -1; 
    end
end