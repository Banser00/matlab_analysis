clc;clear;
CQmap_dis1=xlsread('CQmap1.xlsx');
CQmap_dis2=xlsread('CQmap2.xlsx');
CQmap_dis3=xlsread('CQmap3.xlsx');
CQmap_dis4=xlsread('CQmap4.xlsx');
CQmap_dis5=xlsread('CQmap5.xlsx');
CQmap_dis6=xlsread('CQmap6.xlsx');
CQmap_dis7=xlsread('CQmap7.xlsx');
CQmap_dis8=xlsread('CQmap8.xlsx');
datac1=length(CQmap_dis1);
datac2=length(CQmap_dis2);
datac3=length(CQmap_dis3);
datac4=length(CQmap_dis4);
datac5=length(CQmap_dis5);
datac6=length(CQmap_dis6);
datac7=length(CQmap_dis7);
datac8=length(CQmap_dis8);
NSRc(1:13)=1;
for i=1:datac1
   if(CQmap_dis1(i,1)~=0 && CQmap_dis1(i,1)>1.2)
      u=CQmap_dis1(i,2:4);
      v=CQmap_dis1(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(1,NSRc(1))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(1)=NSRc(1)+1;
      end
   end
end

for i=1:datac2
   if(CQmap_dis2(i,1)~=0 && CQmap_dis2(i,1)>1.2)
      u=CQmap_dis2(i,2:4);
      v=CQmap_dis2(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(2,NSRc(2))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(2)=NSRc(2)+1;
      end
   end
end

for i=1:datac3
   if(CQmap_dis3(i,1)~=0 && CQmap_dis3(i,1)>1.2)
      u=CQmap_dis3(i,2:4);
      v=CQmap_dis3(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(3,NSRc(3))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(3)=NSRc(3)+1;
      end
   end
end

for i=1:datac4
   if(CQmap_dis4(i,1)~=0 && CQmap_dis4(i,1)>1.2)
      u=CQmap_dis4(i,2:4);
      v=CQmap_dis4(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(4,NSRc(4))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(4)=NSRc(4)+1;
      end
   end
end
for i=1:datac5
   if(CQmap_dis5(i,1)~=0 && CQmap_dis5(i,1)>1.2)
      u=CQmap_dis5(i,2:4);
      v=CQmap_dis5(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(5,NSRc(5))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(5)=NSRc(5)+1;
      end
   end
end
for i=1:datac6
   if(CQmap_dis6(i,1)~=0 && CQmap_dis6(i,1)>1.2)
      u=CQmap_dis6(i,2:4);
      v=CQmap_dis6(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(6,NSRc(6))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(6)=NSRc(6)+1;
      end
   end
end
for i=1:datac7
   if(CQmap_dis7(i,1)~=0 && CQmap_dis7(i,1)>1.2)
      u=CQmap_dis7(i,2:4);
      v=CQmap_dis7(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(7,NSRc(7))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(7)=NSRc(7)+1;
      end
   end
end
for i=1:datac8
   if(CQmap_dis8(i,1)~=0  && CQmap_dis8(i,1)>1.2)
      u=CQmap_dis8(i,2:4);
      v=CQmap_dis8(i,5:7);
      if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
         NSR(8,NSRc(8))= acosd(dot(u,v)/(norm(u)*norm(v)));
         NSRc(8)=NSRc(8)+1;
      end
   end
end

plot([1:8],[sum(NSR(1,:)')/NSRc(1) sum(NSR(2,:)')/NSRc(2) sum(NSR(3,:)')/NSRc(3) sum(NSR(4,:)')/NSRc(4)...
    sum(NSR(5,:)')/NSRc(5) sum(NSR(6,:)')/NSRc(6) sum(NSR(7,:)')/NSRc(7) sum(NSR(8,:)')/NSRc(8) ]);