function sequence = generate(samples, delay_width, name)
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
    
    symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};
    lfg = [697 770 852 941]; % Low frequency group
    hfg = [1209 1336 1477];  % High frequency group
    f  = [];
    for c=1:4
        for r=1:3
            f = [ f [lfg(c);hfg(r)] ];
        end
    end
    Fs  = 8000;       % Sampling frequency 8 kHz
    N = 800;          % Tones of 100 ms
    t   = (0:N-1)/Fs; % 800 samples at Fs
    pit = 2*pi*t;
    tones = zeros(N,size(f,2));

    for toneChoice=1:12
        % Generate tone
        tones(:,toneChoice) = sum(sin(f(:,toneChoice)*pit))';
        
        % write tone to sound file - uncomment
%         filename = strcat('sounds/' , int2str(toneChoice) , '.wav');
%         audiowrite(filename,tones(:,toneChoice),Fs);
        
        % Uncomment to plot indivindual tones
        % Plot tone
%         subplot(4,3,toneChoice),plot(t*1e3,tones(:,toneChoice));
%         title(['Symbol "', symbol{toneChoice},'": [',num2str(f(1,toneChoice)),',',num2str(f(2,toneChoice)),']'])
%         set(gca, 'Xlim', [0 25]);
%         ylabel('Amplitude');
%         if toneChoice>9, xlabel('Time (ms)'); end
        
    end
    
    % Uncomment to plot indivindual tones
%     set(gcf, 'Color', [1 1 1], 'Position', [1 1 1280 1024])
%     annotation(gcf,'textbox', 'Position',[0.38 0.96 0.45 0.026],...
%         'EdgeColor',[1 1 1],...
%         'String', '\bf Time response of each tone of the telephone pad', ...
%         'FitBoxToText','on');
    
    % Generate Sequence
    sequence = [];
    delay_N = (delay_width/1000) * Fs;
    delay = zeros( delay_N,1);
    
    for sample = samples
      sequence =  [sequence ; delay ; tones(:,sample)];
    end
    
    % Write sequence to an Audio file
    audiowrite(name,sequence,Fs);
    
    % plot sequence
    plot(sequence);
    
end