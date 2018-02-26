clc;clear;
rgb_t=readtable('rgb.xlsx','ReadVariableNames',true);
depth_t=readtable('depth.xlsx','ReadVariableNames',true);
rgb=table2array(rgb_t(:,1));
depth=table2array(depth_t(:,1));
rgb2=table2array(rgb_t(:,2));
depth2=table2array(depth_t(:,2));
datac=length(depth);
datag=length(rgb);
fileID = fopen('associate.txt','w');
for i=1:datac
    min_d=10;
    current=1;
    for j=1:datag
        if(abs(depth(i,1)-rgb(j,1))<min_d)
           min_d= abs(depth(i,1)-rgb(j,1));
           current=j;
        end
    end
       fprintf(fileID,'%f %s %f %s\n',depth(i,1),char(depth2(i,1)),rgb(current,:),char(rgb2(current,:)));
end
fclose(fileID);