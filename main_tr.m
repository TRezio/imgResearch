% create 2018.10.9    tr
% �޸� ���� 2018.10.21   tr
% ��ĩ  2018.10.25  tr

clear 
close all
addpath('.\sift','.\kmeans','.\similarity','.\mat','.\testImage','.\finalExam');
opts.alldataSet='..\resource\dataset\image\';
opts.kmeansNum=25;
opts.kmeansNum2=5;
opts.expandNum=9;
opts.recallNum=15;%���ҵ�����
opts.sample=1;%����
opts.op=1;%1ʱ�Ƚ�����ͼƬ ��2ʱ����ͼ���

input='A1F201_20151031094926_6576521154.jpg';
imageList=dir(opts.alldataSet);
%% ������ȡ
%[desALL,real,realPath]=siftDemo(imageList,opts); 
load('desALL.mat');load('real.mat');load('realPath.mat');%һ��ϸ������һ���������������


%% ����
%[desK,C] = desKmeans(desALL,opts);
load('C');load('desK');

%% ����    
%codDes = codingTR(desK,opts.kmeansNum);
load('codDes');

%% �������ͼ��
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
%�õ�����ͼ��ı���codI   1*50

%% ST IDF
img=count';  %����ͼ��ı���
[img,codDesVec] = tr_TFIDF(img,codDes);% img 1*k     codDesVec   m*k

%% ���ƶȼ���
simDes = similarityTR(img,codDesVec,opts);
simDes=simDes/max(simDes);

%% ����
[~,simDesSort ]= sort(simDes(:));

%% ����
realClass=19;%���ȸ����ı�ǩ����������
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
% xlabel('�ٻ���');
% ylabel('��ȷ��');
% set(gca,'XTick');
% 
% figure,
% plot(opts.recallNum,recall)
% xlabel('�ٻ���');
% ylabel('�ٻ���');
% set(gca,'XTick');


%% �ڶ�����ҵ-----------------------------------------------------
%
%% ������-----------------------------------------------------
[resort_desVecI,resort_desALL]=recoding_tr(des,desALL,simDesSort,opts);
resort_codDes = codingTR(resort_desALL,opts.kmeansNum2);%�ٻ�ͼ��ı���
[resort_count,~] = hist(resort_desVecI,opts.kmeansNum2);   %����ͼ��ı���
[~,mainFeature_I] = max(resort_count);
re_simDesSort = simDesSort(1:opts.recallNum);
resort_simDesSort = resort(mainFeature_I,resort_codDes,re_simDesSort,opts);

%% ��չ
for i=1:opts.expandNum
    vec2(i,:) = codDes{1,resort_simDesSort(i)}';
end
VecFeature = round(sum(vec2)/opts.expandNum);  %��չ�ı���
%% ���ƶȼ���
[VecFeature,expand_codDesVec] = tr_TFIDF(VecFeature,codDes);% img 1*k     codDesVec   m*k

expand_simDes = similarityTR(VecFeature,expand_codDesVec,opts);
expand_simDes=expand_simDes/max(expand_simDes);

%% ����
[~,expand_simDesSort ]= sort(expand_simDes(:));


