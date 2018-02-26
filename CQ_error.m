CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
error05_c=0;error06_c=0;error07_c=0;error08_c=0;
error09_c=0;error10_c=0;error11_c=0;error12_c=0;
error13_c=0;error14_c=0;error15_c=0;error16_c=0;
error17_c=0;error18_c=0;error19_c=0;error20_c=0;
for i=1:datac
    if CQmap_dis(i,4) < 0.55
        error05_c=error05_c+1;
        error05(error05_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 0.65
        error06_c=error06_c+1;
        error06(error06_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 0.75
        error07_c=error07_c+1;
        error07(error07_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 0.85
        error08_c=error08_c+1;
        error08(error08_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 0.95
        error09_c=error09_c+1;
        error09(error09_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.05
        error10_c=error10_c+1;
        error10(error10_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.15
        error11_c=error11_c+1;
        error11(error11_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.25
        error12_c=error12_c+1;
        error12(error12_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.35
        error13_c=error13_c+1;
        error13(error13_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.45
        error14_c=error14_c+1;
        error14(error14_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.55
        error15_c=error15_c+1;
        error15(error15_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.65
        error16_c=error16_c+1;
        error16(error16_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.75
        error17_c=error17_c+1;
        error17(error17_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.85
        error18_c=error18_c+1;
        error18(error18_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 1.95
        error19_c=error19_c+1;
        error19(error19_c)=CQmap_dis(i,3);
    elseif CQmap_dis(i,4) < 2.05
        error20_c=error20_c+1;
        error20(error20_c)=CQmap_dis(i,3);
    end
end
std05=std(error05);std06=std(error06);std07=std(error07);
std08=std(error08);std09=std(error09);std10=std(error10);
std11=std(error11);std12=std(error12);std13=std(error13);
std14=std(error14);std15=std(error15);std16=std(error16);
std17=std(error17);std18=std(error18);std19=std(error19);
std20=std(error20);
x=[0.5:0.1:2];
y=[mean(error05) mean(error06) mean(error07) mean(error08) mean(error09) mean(error10) mean(error11) mean(error12) mean(error13) mean(error14) mean(error15) mean(error16) mean(error17) mean(error18) mean(error19) mean(error20)];
e=[std05 std06 std07 std08 std09 std10 std11 std12 std13 std14 std15 std16 std17 std18 std19 std20];

errorbar(x,y,e);
