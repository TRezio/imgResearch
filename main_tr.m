% create 2018.10.9    tr
% 修改 检索 2018.10.21   tr
% 期末  2018.10.25  tr

clear 
close all
addpath('.\sift','.\kmeans','.\similarity','.\mat','.\testImage','.\finalExam');
opts.alldataSet='..\resource\dataset\image\';
opts.kmeansNum=25;
opts.kmeansNum2=5;
opts.expandNum=9;
opts.recallNum=15;%查找的数量
opts.sample=1;%样例
opts.op=1;%1时比较两张图片 ，2时检索图像库

input='A1F201_20151031094926_6576521154.jpg';
imageList=dir(opts.alldataSet);
%% 特征提取
%[desALL,real,realPath]=siftDemo(imageList,opts); 
load('desALL.mat');load('real.mat');load('realPath.mat');%一个细胞存着一个矩阵的特征向量


%% 聚类
%[desK,C] = desKmeans(desALL,opts);
load('C');load('desK');

%% 编码    
%codDes = codingTR(desK,opts.kmeansNum);
load('codDes');

%% 处理测试图像
I = imread(input);
[des,~]=getFeatures(I);
[Im,~]=size(des);

for i=1:Im
    sim_min = 99999999;
    vec=des(i,:);
    for j=1:opts.kmeansNum
        vecJ=C(j,:);
        sim = sqrt(sum((vec-vecJ).^2));
        if sim<sim_min
            sim_min=sim;
            codI(i,1) = j;
        end
    end
end
codI=codI';
[count,~] = hist(codI,opts.kmeansNum);
%得到测试图像的编码codI   1*50

%% ST IDF
img=count';  %测试图像的编码
[img,codDesVec] = tr_TFIDF(img,codDes);% img 1*k     codDesVec   m*k

%% 相似度计算
simDes = similarityTR(img,codDesVec,opts);
simDes=simDes/max(simDes);

%% 检索
[~,simDesSort ]= sort(simDes(:));

%% 评价
realClass=19;%事先给定的标签，以做评价
    renum = opts.recallNum;
    for i = 1:renum 
        
        class(i)=real(simDesSort(i));
        [~,sz]=size(class(class==realClass));
        [~,sz2]=size(real(real==realClass));

        acc = sz/renum;
        recall = sz/sz2;
    end

% figure,
% plot(opts.recallNum,acc)
% xlabel('召回数');
% ylabel('正确率');
% set(gca,'XTick');
% 
% figure,
% plot(opts.recallNum,recall)
% xlabel('召回数');
% ylabel('召回率');
% set(gca,'XTick');


%% 第二次作业-----------------------------------------------------
%
%% 重排序-----------------------------------------------------
[resort_desVecI,resort_desALL]=recoding_tr(des,desALL,simDesSort,opts);
resort_codDes = codingTR(resort_desALL,opts.kmeansNum2);%召回图像的编码
[resort_count,~] = hist(resort_desVecI,opts.kmeansNum2);   %测试图像的编码
[~,mainFeature_I] = max(resort_count);
re_simDesSort = simDesSort(1:opts.recallNum);
resort_simDesSort = resort(mainFeature_I,resort_codDes,re_simDesSort,opts);

%% 拓展
for i=1:opts.expandNum
    vec2(i,:) = codDes{1,resort_simDesSort(i)}';
end
VecFeature = round(sum(vec2)/opts.expandNum);  %拓展的编码
%% 相似度计算
[VecFeature,expand_codDesVec] = tr_TFIDF(VecFeature,codDes);% img 1*k     codDesVec   m*k

expand_simDes = similarityTR(VecFeature,expand_codDesVec,opts);
expand_simDes=expand_simDes/max(expand_simDes);

%% 检索
[~,expand_simDesSort ]= sort(expand_simDes(:));


