CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis)

check=0;
CQmap(1:480,1:640)=0;
depthmap(1:480,1:640)=0;
for i=2:datac
    if(abs(CQmap_dis(i,1)-1305031529.457)<0.001)
        check=1;
        continue;
    end
    if(abs(CQmap_dis(i,1)-1305031529.491)<0.001)
        break;
    end
    if(check==1)
        CQmap(CQmap_dis(i,2),CQmap_dis(i,1))=CQmap_dis(i,3); 
        depthmap(CQmap_dis(i,2),CQmap_dis(i,1))=CQmap_dis(i,4); 
    end
    
end
figure();
imagesc(CQmap);
colorbar;

figure();
imagesc(depthmap);
colorbar;
%figure();
%rgb=imread('1305031530.939462.png');
%imshow(rgb);