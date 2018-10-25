function [codDes] = codingTR(des,kmeansNum)


[sz1,~]=size(des);
for i=1:sz1
    desVec=des{i,1};
    [count,~] = hist(desVec,kmeansNum);
    
    codDes{1,i} = count';
    
end

