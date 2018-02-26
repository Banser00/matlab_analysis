CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis)
frame_c=0;
fdata_c=1;
for i=1:datac
    if (CQmap_dis(i,2)==99 && CQmap_dis(i,3)==99)
       
       frame_c=frame_c+1;
       framename(frame_c)=CQmap_dis(i,1);
       fdata_c=1;
       continue;
    end
    if frame_c>0
        CQ(frame_c,fdata_c)=CQmap_dis(i,3);
        fdata_c=fdata_c+1;
    end
end
for i=1:frame_c
    draw=CQ(i,:);
    draw(find(draw==0))=[]
    error(i)=mean(draw);
    str = sprintf('h%d.png',i);
    f=figure;
    histogram(draw);
    saveas(f,str)
end