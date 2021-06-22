function [telephonesA, telephonesB, telephonesC] = classify(digits)

    secondDigit = [6,7,8];
    thirdDigitA = [1,2,9];
    thirdDigitB = [4,6];
    thirdDigitC = [3,8];
    telLength = 10;
    
    telephonesA = [];
    telephonesB = [];
    telephonesC = [];
    
    i = 1;
    
    while i <= length(digits)
        
        telephone = zeros(10,1);
        provider = 'A';
        if (digits(i) == 0)
            
            telephone(1) = 0;
            isTelephone = true;

            if (any(secondDigit(:) == digits(i+1) ) )
                telephone(2) = digits(i+1);
            else
                isTelephone = false;
                i = i + 1;
            end

            if (isTelephone)
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

            if (isTelephone)
                for j = 4:telLength
                    if (digits(i+j-1)>=0 && digits(i+j-1)<=9)
                        telephone(j) = digits(i+j-1);
                    else
                        isTelephone = false;
                        i = i + j;
                        break;
                    end
                end
            end
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