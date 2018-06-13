clc;clear;
txtname='desk_sample.txt';
fileID = fopen(txtname,'r');
formatSpec = '%f';
sample_in = fscanf(fileID,formatSpec);
sample=reshape(sample_in,6,length(sample_in)/6);
sample=sample';
datas=length(sample);

framecnt=1;
frame_ind(1:1000)=1;
for i=1:datas
    match=0;
    if(i==1)
        frame_sample(1,1,:)=sample(i,:);
        frame_ind(1)=frame_ind(1)+1;
        framecnt=framecnt+1;
    else
        for j=1:framecnt-1
           if(sample(i,1)==frame_sample(j,1,1))
              frame_sample(j,frame_ind(j),:)=sample(i,:);
              frame_ind(j)=frame_ind(j)+1;
              match=1;
           end
        end
        if(match==0)
           frame_sample(framecnt,frame_ind(framecnt),:)=sample(i,:); 
           frame_ind(framecnt)=frame_ind(framecnt)+1;
           framecnt=framecnt+1;
        end
    end
end

frame_size(:)=size(frame_sample);
for k=1:frame_size(1)
  time=num2str(frame_sample(k,1,1),'%.6f\n');
  filename=['./sample/' time '.txt'];
  sample_write(:,:)=frame_sample(k,:,:);

  fileID = fopen(filename,'w');
  for i=1:length(sample_write)
    if(sample_write(i,1)==0)
        break;
    end
    fprintf(fileID,'%f %.0f %.0f %.0f %.0f %.0f\n',sample_write(i,1),sample_write(i,2)...
        ,sample_write(i,3),sample_write(i,4),sample_write(i,5),sample_write(i,6));
  end
  fclose(fileID);
  clear sample_write 
end