
%{
    Test the classifier script used to test the detectDigits and classify
    functions

    insert the file name with the extension and observe results
%}
name = input('Enter File name: ', 's');
[signal, fs] = audioread(name);

% display signal spectrogram
figure(500);
spectrogram(signal,128,120,128,fs,'yaxis');

% detect digits
digits = detectDigits(signal,fs);
[telephonesA, telephonesB, telephonesC] = classify(digits);

% display telephones from provider A
size_A = size(telephonesA);
if size_A(1) > 0
    fprintf("Provider A has %i number(s)\n", size_A(2));
    disp(telephonesA');
end

% display telephones from provider B
size_B = size(telephonesB);
if size_B(1) > 0
    fprintf("Provider B has %i number(s)\n", size_B(2));
    disp(telephonesB');
end

% display telephones from provider C
size_C = size(telephonesC);
if size_C(1) > 0
    fprintf("Provider C has %i number(s)\n", size_C(2));
    disp(telephonesC');
end