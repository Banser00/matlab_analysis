clc;clear;
BAerror=xlsread('error.xlsx');
BAc=length(BAerror);

keyc=0;
esum=0;
framec=1;
for i=1:BAc
    if(BAerror(i,2)==0.01)
       keyframe(framec,1)=keyc;
       keyframe(framec,2)=esum/keyc;
       esum=0; 
       keyc=0;
       framec=framec+1;
    end
    esum=esum+BAerror(i,1);
    keyc=keyc+1;
end

scatter(keyframe(:,1) ,keyframe(:,2));
ylim([-6*10^-3 6*10^-3]);
xlabel('number of frames between keyframe');
ylabel('average error');