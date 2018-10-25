function [desALL,real,realPath]=siftDemo(imageList,opts)
t=1;
tz=1;
desALL=1;
len=0;
leibie=0;
[fileNum,~]=size(imageList);
imageList=imageList(3:fileNum,:);fileNum=fileNum-2;
for i=1:fileNum
    %tic
  %  t
    fileList=dir([opts.alldataSet,imageList(i).name,'\']);
    [fileNum2,~]=size(fileList);
    
    for j=3:fileNum2-1
        
         imageName=fileList(j).name;
         %img=imread([opts.alldataSet,imageList(i).name,'\',imageName]);
         %[des,~]=getFeatures(img);
        % desALL{t}=des;
        realPath{t}=[opts.alldataSet,imageList(i).name,'\',imageName];
        t=t+1;
    end
   % toc
    leibie=leibie+1;
    len = fileNum2-3;
    real(tz:tz+len-1) = leibie;
    tz = tz+len;
end
%getFeatures(img1);