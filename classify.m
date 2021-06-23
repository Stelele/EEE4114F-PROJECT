function [telephonesA, telephonesB, telephonesC] = classify(digits)
    %{
    This function extracts cell numbers from a sequence of touch tones and
    classify them according to 3 artificial providers

    Inputs:     digits:  sequnce of digits/touch tones

    Outputs:    telephonesX <matix(10,n)>: cell numbers classified as provider X 
    %}

    secondDigit = [6,7,8];
    thirdDigitA = [1,2,9];
    thirdDigitB = [4,6];
    thirdDigitC = [3,8];
    telLength = 10;
    
    telephonesA = [];
    telephonesB = [];
    telephonesC = [];
    
    i = 1;
    stop = length(digits) - 9;
    
    while i <= stop
        
        telephone = zeros(10,1);
        provider = 'A';
        % check first digit
        if (digits(i) == 0)
            
            telephone(1) = 0;
            isTelephone = true;
            % check second digit
            if (any(secondDigit(:) == digits(i+1) ) )
                telephone(2) = digits(i+1);
            else
                isTelephone = false;
                i = i + 1;
            end

            if (isTelephone)
                % chech third digit and classify
                if ( any( thirdDigitA(:) == digits(i+2) ) )
                    telephone(3) = digits(i+2);
                    provider = 'A';
                elseif ( any( thirdDigitB(:) == digits(i+2) ) )
                    telephone(3) = digits(i+2);
                    provider = 'B';
                elseif ( any( thirdDigitC(:) == digits(i+2) ) )
                    telephone(3) = digits(i+2);
                    provider = 'C';              
                else 
                    isTelephone = false;
                    i = i + 1;
                end
            end
            % Evaluate the next 7 digits
            if (isTelephone)
                for j = 4:telLength
                    if (digits(i+j-1)>=0 && digits(i+j-1)<=9)
                        telephone(j) = digits(i+j-1);
                    else
                        isTelephone = false;
                        i = i + j; % jump to after the point of failure
                        break;
                    end
                end
            end
            % Add cell number to the appropriate provider
            if (isTelephone)
                switch provider
                    case 'A'   
                        telephonesA = [telephonesA telephone];
                        i = i+9;
                    case 'B'
                        telephonesB = [telephonesB telephone];
                        i = i+9;
                    case 'C'
                        telephonesC = [telephonesC telephone];
                        i = i+9;
                end
                        
            end
               
        end
        i = i+1;
    end
end