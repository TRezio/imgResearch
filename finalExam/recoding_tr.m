function [desVecI,desK]=recoding_tr(I,ALL,simDesSort,opts)
%%%%%%%%
%���� ͼ���� ��������(n*128)
%��� ��kmeans��Ľ��


des2=I;
[featureNum,~]=size(des2);
for i=1:opts.recallNum
    des2=[des2;ALL{1,simDesSort(i)}];
end

[desK2,~]=kmeans(des2,opts.kmeansNum2);

desVecI = desK2(1:featureNum);
t=featureNum+1;
for i=1:opts.recallNum
     [sz2,~]=size(ALL{1,simDesSort(i)});
     desKvec=desK2(t:t+sz2-1);
     t=t+sz2;
     desK{i,1}=desKvec;
end
t %����