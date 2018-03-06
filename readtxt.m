clc;clear;

txtname='record_D1.txt';

fileID = fopen(txtname,'r');
formatSpec = '%f';
A = fscanf(fileID,formatSpec);

Acount=1;
for i=1:length(A)
    
    if(mod(i,77)==0)
       Acount=Acount; 
    end
end