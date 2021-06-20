function Val = detectKeyPress(x, fs)
%{
    This function detects if a single key exsists in a section of x

    Inputs:     x:  input signal section with possible key
                fs: sampling rate

    Outputs:    Val: value of key detected or -1 if no key found
%}

    N = 102; % sample length sections to be used
    overlap = 16; % number of samples that overlap with each other 
    THR_SIG = 2e-6;  % threshold sum of powers must be above 
    THR_TWIREV = 8; % threshold in dB of acceptable reverse twist
    THR_TWISTD = 4; % threshold in dB of acceptable standard twist
    THR_ROWREL = 1e-6; % row relative threshold power must be above for all neighbours
    THR_COLREL = 1e-6; % col relative threshold power must be above for all neighbours
    
    %define dtmf frequencies
    row = [697 770 852 941];
    col = [1209 1336 1477 1633];

    % define array for k values for center frequencies
    kRowCenter = zeros(size(row));
    kColCenter = zeros(size(col));
    
    % define array for k values for +1.5% + 2Hz
    kRowRight = zeros(size(row));
    kColRight = zeros(size(col));
    
    % define array for k values for -1.5% - 2Hz
    kRowLeft = zeros(size(row));
    kColLeft = zeros(size(col));
    
     % calculate k values for center and tolerances for row frequencies
    for curPos = 1:length(row)
        kRowCenter(curPos) = round(N * row(curPos)/fs, 2);
        kRowRight(curPos) = round(N * (row(curPos)*1.015 + 2)/fs, 2);
        kRowLeft(curPos) =  round(N * (row(curPos)*0.985 - 2)/fs, 2);
    end
    
    % calculate k values for center and tolerances for col frequencies 
    for curPos = 1:length(col)
        kColCenter(curPos) = round(N * col(curPos)/fs, 2);
        kColRight(curPos) = round(N * (col(curPos)*1.015 + 2)/fs, 2);
        kColLeft(curPos) =  round(N * (col(curPos)*0.985 - 2)/fs, 2);
    end
    
    %signalEnergy = sum(abs(x)^2);
    candidateNumber = ones(size(row)) * -1;
    
    
    for i = 1:4
        if i == 1
            startPos = (i-1)*N + 1;
        else
            startPos = (i-1)*N + 1 - overlap;
        end
        endPos = startPos + N -1;
        
        %define window function
        hammingWindow = hamming(N);
        hammingWindow = reshape(hammingWindow, size(x(startPos:endPos)));
        
        %get section of signal for detection
        xSection = x(startPos:endPos) .* hammingWindow;
        
        %calculate signal energy for 8 center frequencies
        XERowCenter = mygoertzel(xSection, kRowCenter, N) / N;
        XEColCenter = mygoertzel(xSection, kColCenter, N) / N;

        % detemine max energy location for row and col frequencies
        [rowMax, rowIndex] = max(XERowCenter);
        [colMax, colIndex] = max(XEColCenter); 
        
        % check if signal within RBW
        %{
        XERowBands = mygoertzel(xSection, [kRowLeft(rowIndex) kRowRight(rowIndex)], N);
        XEColBands = mygoertzel(xSection, [kColLeft(colIndex) kColRight(colIndex)], N);
        
        accRowLeftMin = XERowCenter * 0.985 -2;
        accRowLeftMax = XERowCenter * 0.965;
        accRowRightMin = XERowCenter * 1.015 + 2;
        accRowRightMax = XERowCenter * 1.035;
        
        accColLeftMin = XEColCenter * 0.985 -2;
        accColLeftMax = XEColCenter * 0.965;
        accColRightMin = XEColCenter * 1.015 + 2;
        accColRightMax = XEColCenter * 1.035;
        
        if XERowBands(1) < accRowLeftMin && XERowBands(1) > accRowLeftMax
            candidateNumber(i) = -1;
        elseif XERowBands(2) < accRowRightMin && XERowBands(2) > accRowRightMax
            candidateNumber(i) = -1;
        elseif XEColB
        %}
        
        % check signal power
        if rowMax + colMax < THR_SIG
            candidateNumber(i) = -1;
            
        % check reverse twist 
        elseif 10 * log(rowMax/colMax) > THR_TWIREV
            candidateNumber(i) = -1;
        
        %check standard twist
        elseif 10 * log(colMax/rowMax) > THR_TWISTD
            candidateNumber(i) = -1;
        else
            %check relative diffrences between neighbours
            rowDifferences = rowMax - XERowCenter;
            colDifferences = colMax - XEColCenter;
            
            rowPass = 1;
            colPass = 1;
            
            for j = 1:length(row)
                if j ~= rowIndex && rowDifferences(j) < THR_ROWREL
                    rowPass = 0;
                end
                
                if j ~= colIndex && colDifferences(j) < THR_COLREL
                    colPass = 0;
                end
            end
            
            if rowPass == 0 || colPass == 0
                candidateNumber(i) = -1;
            else
               
               % all tests passed added number to candidates
               switch rowIndex
                    case 1
                        switch colIndex
                            case 1
                                candidateNumber(i) = 1;
                            case 2
                                candidateNumber(i) = 2;
                            case 3
                                candidateNumber(i) = 3;
                            case 4
                                candidateNumber(i) = 'A';
                        end
                    case 2
                        switch colIndex
                            case 1
                                candidateNumber(i) = 4;
                            case 2
                                candidateNumber(i) = 5;
                            case 3
                                candidateNumber(i) = 6;
                            case 4
                                candidateNumber(i) = 'B';
                        end
                    case 3
                        switch colIndex
                            case 1
                                candidateNumber(i) = 7;
                            case 2
                                candidateNumber(i) = 8;
                            case 3
                                candidateNumber(i) = 9;
                            case 4
                                candidateNumber(i) = 'C';
                        end
                    case 4
                        switch colIndex
                            case 1
                                candidateNumber(i) = '*';
                            case 2
                                candidateNumber(i) = 0;
                            case 3
                                candidateNumber(i) = '#';
                            case 4
                                candidateNumber(i) = 'D';
                        end
                end
            end
        end        
    end
    
    % add final number if detected at least 3 times
    numRejections = sum(candidateNumber == -1);
    
    if numRejections > 1
        Val = -1;
    else
        Val = mode(candidateNumber);
    end        
end