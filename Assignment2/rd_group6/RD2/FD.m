function [fileDescriptor]=FD(type, K, ClassNum)

fileNameTemp=strcat(type,int2str(K),'Class',int2str(ClassNum),'_75Cluster');
fileDescriptor=zeros(1,K);
for i=1:K
    fileName=strcat(fileNameTemp,int2str(i),'.txt');
    fileDescriptor(1,i)= fopen(fileName,'w+');
end
