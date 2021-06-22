function sequence = generate(samples, delay_width, noiselevel,name)
    % Generates a sequence DTMF tones seperated by a specified delay
    % 
    % args:
    %       samples <array(1,)> : the sequence of tones to generate as
    %                             numbers. NOTE: * = 10; 0 = 11; # = 12
    %                             e.g for *0123#45, samples = [10,11,1,2,3,12,4,5]
    %       delay_width (int)   : delay between tones in (ms)
    %       name (String)       : name of the Audio file to write to (with extension)
    %
    % courtesy of pavan chillapur: 
    % https://www.mathworks.com/matlabcentral/answers/305491-dtmf-tone-using-matlab
    
    symbols = {'1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'};
    values = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
    
    map = containers.Map(symbols, values);
    
    lfg = [697 770 852 941]; % Low frequency group
    hfg = [1209 1336 1477 1633];  % High frequency group
    f  = [];
    for c=1:4
        for r=1:4
            f = [ f [lfg(c);hfg(r)] ];
        end
    end
    
    Fs  = 8000;       % Sampling frequency 8 kHz
    N = 800;          % Tones of 100 ms
    t   = (0:N-1)/Fs; % 800 samples at Fs
    pit = 2*pi*t;
    tones = zeros(N,size(f,2));
    ampl = 10;

    for toneChoice=1:16
        % Generate tone
        tones(:,toneChoice) = sum(sin(f(:,toneChoice)*pit))';
    end
    
    % Generate Sequence
    sequence = [];
    delay_max = (delay_width/1000) * Fs;
    delay_N = round(delay_max*rand);
    
    for sample = samples
      sequence =  [sequence ; zeros(delay_N,1) ; tones(:,map(sample))];
      delay_N = round(delay_max*rand);
      if (delay_N < 65)
          delay_N = 65;
      end
    end
    
    % add noise
    noise = wgn(length(sequence), 1, -100);
    sequence = sequence + noise;
    
    % Write sequence to an Audio file
    audiowrite(name,sequence,Fs);
    
    % plot sequence
    plot(sequence);
    
end