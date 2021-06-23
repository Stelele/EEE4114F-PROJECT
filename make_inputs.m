
% Provider A
generate(['0','7','2','2','5','0','0','0','0','6'], 500, -40 ,'numbers/num_A_1.wav');
generate(['0','8','1','2','5','6','8','0','5','9'], 500, -40 ,'numbers/num_A_2.wav');

% Provider B
generate(['0','7','4','2','3','1','1','3','3','5'], 500, -40 ,'numbers/num_B_1.wav');
generate(['0','6','6','2','3','5','1','4','4','5'], 500, -40, 'numbers/num_B_2.wav');

% Provider C
generate(['0','8','3','9','5','5','9','0','0','0'], 500, -40 ,'numbers/num_C_1.wav');
generate(['0','7','8','5','1','2','3','4','1','0'], 500, -40, 'numbers/num_C_2.wav');

% Looks like but not one of the providers A, B & C
generate(['0','8','7','9','5','4','2','0','4','0'], 500, -40 ,'numbers/num_N_1.wav');
generate(['0','5','8','4','2','2','3','3','4','4'], 500, -40, 'numbers/num_N_2.wav');

% 10 digits with characters
generate(['0','8','3','9','5','*','2','0','4','0'], 500, -40 ,'numbers/num_1.wav');
generate(['0','7','4','4','2','2','D','3','4','4'], 500, -40, 'numbers/num_2.wav');

% Noise characters
generate(['0','A','D','#'], 500, -40 ,'numbers/char_1.wav');
generate(['*','B','C'], 500, -40, 'numbers/char_2.wav');


% Make combinations
[A1, fs] = audioread("numbers/num_A_1.wav");
[A2, fs] = audioread("numbers/num_A_2.wav");
[B1, fs] = audioread("numbers/num_B_1.wav");
[B2, fs] = audioread("numbers/num_B_2.wav");
[C1, fs] = audioread("numbers/num_C_1.wav");
[C2, fs] = audioread("numbers/num_C_2.wav");
[N1, fs] = audioread("numbers/num_N_1.wav");
[N2, fs] = audioread("numbers/num_N_2.wav");
[nc1, fs] = audioread("numbers/num_1.wav");
[nc2, fs] = audioread("numbers/num_2.wav");
[chr1, fs] = audioread("numbers/char_1.wav");
[chr2, fs] = audioread("numbers/char_2.wav");

audiowrite("numbers/ABC.wav",[A1; B2; chr1 ;C2],fs);
audiowrite("numbers/2AB2C.wav",[A1; chr2; A2 ;B2; C1 ;C2],fs);
audiowrite("numbers/ANC.wav",[A1; N2 ; C2],fs);
