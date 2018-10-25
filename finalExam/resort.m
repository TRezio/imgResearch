function resort_simDesSort = resort(mainFeature_I,resort_codDes,re_simDesSort,opts)

[~,sz]=size(resort_codDes);
re_simDesSort_2=re_simDesSort;
t=1;%”√”⁄≈≈–Ú
for i=1:sz
    bowVec=resort_codDes{1,i}; %25*1
    [~,mainF] = max(bowVec);
    if mainF == mainFeature_I
        reSort(t,1)= re_simDesSort(i);
        re_simDesSort_2(i)=0;
        t=t+1;
    end
end
re_simDesSort_2(re_simDesSort_2==0)=[];
resort_simDesSort=[reSort;re_simDesSort_2];
1

    