function [Means]=KMEANS(type,K,ClassNum,ClassData,InitialMean)

sizeClass=size(ClassData);
fileNameTemp=strcat(type,int2str(K),'Class',int2str(ClassNum),'_75Cluster');
while(1)
    fd=FD(type,K,ClassNum);
    eD=zeros(sizeClass(1,1),K);
    for c1=1:sizeClass(1,1)
        for x=1:K
            eD(c1,x)=norm(ClassData(c1,:)-InitialMean(x,:))^2;
        end
    end
    for c1=1:sizeClass(1,1)
        assignedCluster=find(eD(c1,:)==min(min(eD(c1,:))));
        fprintf(fd(1,assignedCluster),'%f\t%f\n',ClassData(c1,1),ClassData(c1,2));
    end
    Means=zeros(K,2);
    for i=1:K
        fileName=strcat(fileNameTemp,int2str(i),'.txt');
        M=dlmread(fileName);
        Means(i,:)=mean(M);
    end
    if isequal(Means,InitialMean)
        break;
    else
        InitialMean=Means;
    end
end