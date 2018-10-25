function simDes = similarityTR(img,desALL,opts)

[sz1,~]=size(desALL);
for i=1:sz1
    desVec=desALL(i,:);
    sim = sqrt(sum((img-desVec).^2));
    simDes(i,1) = sim;
end