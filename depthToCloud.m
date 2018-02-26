function [pcloud, distance] = depthToCloud(depth)
% depthToCloud.m - Convert depth image into 3D point cloud
% Author: Liefeng Bo and Kevin Lai
%
% Input: 
% depth - the depth image
% topleft - the position of the top-left corner of depth in the original depth image. Assumes depth is uncropped if this is not provided
%
% Output:
% pcloud - the point cloud, where each channel is the x, y, and z euclidean coordinates respectively. Missing values are NaN.
% distance - euclidean distance from the sensor to each point
%

depth= double(depth);
depth(depth == 0) = nan;

% RGB-D camera constants
center = [318.6 255.3];
[imh, imw] = size(depth);
constant = 570.3;

fx= 517.3;
fy= 516.5;

% convert depth image to 3d point clouds
pcloud = zeros(imh,imw,3);
xgrid = ones(imh,1)*(1:imw)  - center(1);
ygrid = (1:imh)'*ones(1,imw)  - center(2);
pcloud(:,:,1) = xgrid.*depth/fx;
pcloud(:,:,2) = ygrid.*depth/fy;
pcloud(:,:,3) = depth;
distance = sqrt(sum(pcloud.^2,3));

