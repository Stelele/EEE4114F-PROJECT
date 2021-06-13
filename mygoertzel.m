function X = mygoertzel(x, kvals, N)

    X = zeros(size(kvals));
    curpos = 1;
    
    for k = kvals
        v = zeros(size(x));
        
        for i = 3:N
           v(i) = x(i) + 2 * cos(2*pi*k/N)*v(i-1) - v(i-2); 
        end
        
        X(curpos) = v(N) - exp( -1i * 2 * pi * k/N)*v(N-1);
        curpos = curpos + 1;
    end

end
