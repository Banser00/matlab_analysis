clc;clear;
edge=xlsread('record.xlsx');
datae=length(edge);

for i=1:datae
    for j=1:11
       if(j>1 && edge(i,j)==0)
          edge(i,j)=edge(i,j-1); 
       end
       if(j>1)
           if(abs(edge(i,j)-edge(i,j-1))>0.05)
               LBP_ND(i,j-1) = 1;
           else
               LBP_ND(i,j-1) = 0;
           end
       end
    end
    LBP_ten(i) = LBP_ND(i,1)*(2^9) + LBP_ND(i,2)*(2^8) + ...
       LBP_ND(i,3)*(2^7) + LBP_ND(i,4)*(2^6) + LBP_ND(i,5)*(2^5) + ...
       LBP_ND(i,6)*(2^4) + LBP_ND(i,7)*(2^3) + LBP_ND(i,8)*(2^2) + ...
       LBP_ND(i,9)*(2^1) + LBP_ND(i,10)*(2^0);
end

