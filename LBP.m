clc;clear;
edge=xlsread('record.xlsx');
datae=length(edge);

for i=1:datae
   for j=1:9
       sb=[edge(i,1+mod(j-1,3)+5*floor((j-1)/3)) edge(i,2+mod(j-1,3)+5*floor((j-1)/3)) edge(i,3+mod(j-1,3)+5*floor((j-1)/3)) ...
           edge(i,6+mod(j-1,3)+5*floor((j-1)/3)) edge(i,7+mod(j-1,3)+5*floor((j-1)/3)) edge(i,8+mod(j-1,3)+5*floor((j-1)/3)) ...
           edge(i,11+mod(j-1,3)+5*floor((j-1)/3)) edge(i,12+mod(j-1,3)+5*floor((j-1)/3)) edge(i,13+mod(j-1,3)+5*floor((j-1)/3))];
       sb(find(sb==0))=[];
       if(length(sb)>0)
           edge_avg(i,j)=sum(sb)/length(sb);
       else
           edge_avg(i,j)=0;
       end
   end
   % LBP encode
   for k=1:8
       if(k<5)
           k_ind=k;
       else
           k_ind=k+1;
       end
       if(edge_avg(i,k_ind)<=edge_avg(i,5))
           LBP_code(i,k)=1;
       else
           LBP_code(i,k)=0;
       end
   end   
end

LBP_code_ori=LBP_code;
% LBP rotation invarint
for i=1:length(LBP_code)
   for j=1:8
       if(LBP_code(i,1)==0) 
           LBP_temp=LBP_code(i,1);
           LBP_code(i,1)=LBP_code(i,2);
           LBP_code(i,2)=LBP_code(i,3);
           LBP_code(i,3)=LBP_code(i,4);
           LBP_code(i,4)=LBP_code(i,5);
           LBP_code(i,5)=LBP_code(i,6);
           LBP_code(i,6)=LBP_code(i,7);
           LBP_code(i,7)=LBP_code(i,8);
           LBP_code(i,8)=LBP_temp;
       else
           break;
       end
   end
   LBP_ten(i) = LBP_code(i,1)*(2^7) + LBP_code(i,2)*(2^6) + LBP_code(i,3)*(2^5) + ...
       LBP_code(i,4)*(2^4) + LBP_code(i,5)*(2^3) + LBP_code(i,6)*(2^2) + ...
       LBP_code(i,7)*(2^1) + LBP_code(i,8)*(2^0);
end