% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.


img1 = imread('A0C573_20151029074136_6562078379.jpg');
img2 = imread('A0C632_20151103112213_6597218318.jpg');
[des1,loc1] = getFeatures(img1);
[des2,loc2] = getFeatures(img2);
matched = match(des1,des2);
drawFeatures(img1,loc1);
drawFeatures(img2,loc2);
drawMatched(matched,img1,img2,loc1,loc2);
toc