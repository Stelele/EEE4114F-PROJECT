function X = mygoertzel(x, kvals, N)
%{
        This function implements the Goertzel Algorithm to determine the
        signal energy approximations for a given range of frequencies

       
    Inputs:   x: The input signal being transformed
              kvals: the k frequency components to be determined
              N: n-point dft approximation
        
    Outputs:  |X(k)|^2: squared magnitude information
%}
    X = zeros(size(kvals));
    
    curpos = 1;
    
    for k = kvals
        v = zeros(size(x));
        
        for i = 1:N
            if(i == 1)
               v(i) = x(i);
            elseif(i == 2)
                v(i) = x(i) + 2 * cos(2*pi*k/N)*v(i-1);
            else
                v(i) = x(i) + 2 * cos(2*pi*k/N)*v(i-1) - v(i-2); 
            end
        end
        
        val = v(N) - exp(-1j * 2 * pi * k/N) * v(N-1);
        X(curpos) = real(val)^2 + imag(val)^2;
        curpos = curpos + 1;
    end
end
