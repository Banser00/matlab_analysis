clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
frame_cnt=1;
local_c=1;
cnt(1:20)=1;
for i=1:datac
   for(j=0.4:0.08:1.92)
      if(CQmap_dis(i,3)>j && CQmap_dis(i,3)<=j+0.08)
         index=int32(1+(j-0.4)/0.08);
         CQ_dep(index,cnt(index))=1/(CQmap_dis(i,2)); 
         CQ_nor(index,cnt(index))=rad2deg(CQmap_dis(i,5)); 
         cnt(index)=cnt(index)+1;
      end
   end
end
draw1=CQ_dep(1,:);
draw1(find(draw1==0))=[NaN];
nor1=CQ_nor(1,:);
nor1(find(nor1==0))=[NaN];
draw2=CQ_dep(2,:);
draw2(find(draw2==0))=[NaN];
nor2=CQ_nor(2,:);
nor2(find(nor2==0))=[NaN];
draw3=CQ_dep(3,:);
draw3(find(draw3==0))=[NaN];
nor3=CQ_nor(3,:);
nor3(find(nor3==0))=[NaN];
draw4=CQ_dep(4,:);
draw4(find(draw4==0))=[NaN];
nor4=CQ_nor(4,:);
nor4(find(nor4==0))=[NaN];
draw5=CQ_dep(5,:);
draw5(find(draw5==0))=[NaN];
nor5=CQ_nor(5,:);
nor5(find(nor5==0))=[NaN];
draw6=CQ_dep(6,:);
draw6(find(draw6==0))=[NaN];
nor6=CQ_nor(6,:);
nor6(find(nor6==0))=[NaN];
draw7=CQ_dep(7,:);
draw7(find(draw7==0))=[NaN];
nor7=CQ_nor(7,:);
nor7(find(nor7==0))=[NaN];
draw8=CQ_dep(8,:);
draw8(find(draw8==0))=[NaN];
nor8=CQ_nor(8,:);
nor8(find(nor8==0))=[NaN];
draw9=CQ_dep(9,:);
draw9(find(draw9==0))=[NaN];
nor9=CQ_nor(9,:);
nor9(find(nor9==0))=[NaN];
draw10=CQ_dep(10,:);
draw10(find(draw10==0))=[NaN];
nor10=CQ_nor(10,:);
nor10(find(nor10==0))=[NaN];
draw11=CQ_dep(11,:);
draw11(find(draw11==0))=[NaN];
nor11=CQ_nor(11,:);
nor11(find(nor11==0))=[NaN];
draw12=CQ_dep(12,:);
draw12(find(draw12==0))=[NaN];
nor12=CQ_nor(12,:);
nor12(find(nor12==0))=[NaN];
draw13=CQ_dep(13,:);
draw13(find(draw13==0))=[NaN];
nor13=CQ_nor(13,:);
nor13(find(nor13==0))=[NaN];
draw14=CQ_dep(14,:);
draw14(find(draw14==0))=[NaN];
nor14=CQ_nor(14,:);
nor14(find(nor14==0))=[NaN];
draw15=CQ_dep(15,:);
draw15(find(draw15==0))=[NaN];
nor15=CQ_nor(15,:);
nor15(find(nor15==0))=[NaN];
draw16=CQ_dep(16,:);
draw16(find(draw16==0))=[NaN];
nor16=CQ_nor(16,:);
nor16(find(nor16==0))=[NaN];
draw17=CQ_dep(17,:);
draw17(find(draw17==0))=[NaN];
nor17=CQ_nor(17,:);
nor17(find(nor17==0))=[NaN];
draw18=CQ_dep(18,:);
draw18(find(draw18==0))=[NaN];
nor18=CQ_nor(18,:);
nor18(find(nor18==0))=[NaN];
draw19=CQ_dep(19,:);
draw19(find(draw19==0))=[NaN];
nor19=CQ_nor(19,:);
nor19(find(nor19==0))=[NaN];
draw20=CQ_dep(20,:);
draw20(find(draw20==0))=[NaN];
nor20=CQ_nor(20,:);
nor20(find(nor20==0))=[NaN];

if(draw1(1)==draw1(1))
    f(1)=figure(1);
    boxplot(draw1,10*ceil(nor1/10));
    title('depth=0.4~0.48');
end

if(draw2(1)==draw2(1))
    f(2)=figure(2);
    boxplot(log(draw2),10*ceil(nor2/10));
    title('depth=0.48~0.56');
end
f(3)=figure(3);
boxplot(log(draw3),10*ceil(nor3/10));
title('depth=0.56~0.64');

f(4)=figure(4);
boxplot(log(draw4),10*ceil(nor4/10));
title('depth=0.64~0.72');

f(5)=figure(5);
boxplot(log(draw5),10*ceil(nor5/10));
title('depth=0.72~0.80');

f(6)=figure(6);
boxplot(log(draw6),10*ceil(nor6/10));
title('depth=0.80~0.88');

f(7)=figure(7);
boxplot(log(draw7),10*ceil(nor7/10));
title('depth=0.88~0.96');

f(8)=figure(8);
boxplot(log(draw8),10*ceil(nor8/10));
title('depth=0.96~1.04');

f(9)=figure(9);
boxplot(log(draw9),10*ceil(nor9/10));
title('depth=1.04~1.12');

f(10)=figure(10);
boxplot(log(draw10),10*ceil(nor10/10));
title('depth=1.12~1.20');

f(11)=figure(11);
boxplot(log(draw11),10*ceil(nor11/10));
title('depth=1.20~1.28');

f(12)=figure(12);
boxplot(log(draw12),10*ceil(nor12/10));
title('depth=1.28~1.36');

f(13)=figure(13);
boxplot(log(draw13),10*ceil(nor13/10));
title('depth=1.36~1.44');

f(14)=figure(14);
boxplot(log(draw14),10*ceil(nor14/10));
title('depth=1.44~1.52');

f(15)=figure(15);
boxplot(log(draw15),10*ceil(nor15/10));
title('depth=1.52~1.60');

f(16)=figure(16);
boxplot(log(draw16),10*ceil(nor16/10));
title('depth=1.60~1.68');

f(17)=figure(17);
boxplot(log(draw17),10*ceil(nor17/10));
title('depth=1.68~1.76');

f(18)=figure(18);
boxplot(log(draw18),10*ceil(nor18/10));
title('depth=1.76~1.84');

f(19)=figure(19);
boxplot(log(draw19),10*ceil(nor19/10));
title('depth=1.76~1.84');

f(20)=figure(20);
boxplot(log(draw20),10*ceil(nor20/10));
title('depth=1.84~1.92');


%str = sprintf('%.5f.png',CQmap_dis(i-1,1));
%f=figure;

%ylim([0 max(CQmap_dis(:,2))]);
%str2 = sprintf('speed: %.5f',(CQmap_dis(i-1,4)));
%title(str2);
%saveas(f,str);