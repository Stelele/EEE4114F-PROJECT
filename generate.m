function sequence = generate(samples, delay_width, noiselevel,name)
    % Generates a sequence DTMF tones seperated by a specified delay
    % 
    % Inputs:
    %       samples <array(1,)> : the sequence of tones to generate as
    %                             characters. NOTE: use Alphabets for A,B,C,D
    %                             e.g for *0123#45, samples = ['*','0','1','2','3','#','4','5']
    %       delay_width (int)   : maximum delay between tones in (ms)
    %       noiselevel (int)    : power of the noise signal in dbm
    %       name (String)       : name of the Audio file to write to (with extension)
    % Outputs:
    %       sequence <arrray>   : sequence with generated audio data
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
    pt = 2*pi*t;
    tones = zeros(N,size(f,2));
    ampl = 4;

    for toneChoice=1:16
        % Generate tone
        tones(:,toneChoice) = ampl * sum(sin(f(:,toneChoice)*pt))';
    end
    
    % Generate Sequence
    sequence = [];
    delay_max = (delay_width/1000) * Fs;
    %delay_N = round(delay_max*rand);
    
    for sample = samples
      delay_N = round(delay_max*rand);
      if (delay_N < 65)
          delay_N = 65;
      end
      sequence =  [sequence ; zeros(delay_N,1) ; tones(:,map(sample))];
    end
    
    % add noise
    noise = wgn(length(sequence), 1, noiselevel, 'dBm');
    sequence = sequence + noise;
    
    % normalise data
    dataMax = max(abs(sequence));
    sequence = sequence / dataMax;
    
    % Write sequence to an Audio file
    audiowrite(name,sequence,Fs);
    
    
end