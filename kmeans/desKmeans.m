function [desK,C] = desKmeans(des,opts)
%C为聚类中心

[~,sz1]=size(des);
%load('desK1.mat');
des2=des{1,1};
for i=2:sz1
    des2=[des2;des{1,i}];
end
[desK1,C]=kmeans(des2,opts.kmeansNum);
 t=1;
 for i=1:sz1
     [sz2,~]=size(des{1,i});
     desKvec=desK1(t:t+sz2-1);
     t=t+sz2;
     desK{i,1}=desKvec;
     
 end

