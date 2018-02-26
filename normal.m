clc;clear;
for i=0:0
    rgb=imread('0.png');
    depth=double(rgb(:,:,1));
    tum_depth=depth/5000;
    [pcloud distance] = depthToCloud(tum_depth);
    ptCloud = pointCloud(pcloud)
    normals = pcnormals(ptCloud);
      
end