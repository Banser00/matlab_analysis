depth_t=xlsread('associate.xlsx');
datac=length(depth_t);

gt=xlsread('groundtruth.xlsx');
gtc=length(gt);


for i=1:datac
    min_t=10;
    for j=1:gtc
        if(abs(depth_t(i)-gt(j,1))<min_t)
           min_t= abs(depth_t(i)-gt(j,1));
           gt_align(i,:)=gt(j,:);
        end
    end
end


fileID = fopen('gt_align.txt','w');

nbytes = fprintf(fileID,'%4f %4f %4f %4f %4f %4f %4f %4f\n',gt_align');

fclose(fileID);