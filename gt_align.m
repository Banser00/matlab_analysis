clc;clear;
timestamp=xlsread('associate.xlsx');
gt= xlsread('groundtruth.xlsx');
datac=length(timestamp);
datag=length(gt);
fileID = fopen('gt_align_10.txt','w');
for i=1:datac
    min_d=10;
    current=1;
    for j=1:datag
        if(abs(timestamp(i,1)-gt(j,1))<min_d)
           min_d= abs(timestamp(i,1)-gt(j,1));
           current=j;
        end
    end
    gt_align(i,:)=gt(current,:);
   fprintf(fileID,'%f %f %f %f %f %f %f %f\n',gt_align(i,1),gt_align(i,2),gt_align(i,3),gt_align(i,4),gt_align(i,5),gt_align(i,6),gt_align(i,7),gt_align(i,8));
end
fclose(fileID);