function [Pi, Cov]=INIT_PARAMS(type,K,d,ClassNum,sizeClass)

Pi=zeros(1,K);
Cov=zeros(d,d,K);
fileNameTemp=strcat(type,int2str(K),'Class',int2str(ClassNum),'_75Cluster');
for i=1:K
    fileName=strcat(fileNameTemp,int2str(i),'.txt');
    M=dlmread(fileName);
    Pi(1,i)=size(M)/sizeClass;
    Cov(:,:,i)=cov(M);
end