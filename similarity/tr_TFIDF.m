function [img,codDes] = tr_TFIDF(I,ALL)
[~,sz1]=size(ALL);
for i=1:sz1
    desVec=ALL{1,i};
    desALL(i,:)=desVec;
 
end
desALL(sz1+1,:)=I;
 desALL = tfidf( desALL );
 img=desALL(sz1+1,:);
 codDes=desALL(1:sz1,:);
 
