clc;clear;
edge=xlsread('record.xlsx');
datac=length(edge);

for i=1:datac
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