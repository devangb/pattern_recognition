function [PINew,MeansNew,CovNew]=EM(d,K,ClassData,PI,Means,Cov,LogLike)

sizeClass=size(ClassData);
while(1)
    gamma=zeros(sizeClass(1,1), K);
    for i=1:sizeClass
        t=0;
        for j=1:K
            t=t+PI(1,j)*N(d,ClassData(i,:),Means(j,:),Cov(:,:,j));
        end
        for j=1:K
            q=PI(1,j)*N(d,ClassData(i,:),Means(j,:),Cov(:,:,j));
            gamma(i,j)=q/t;
        end
    end
    PINew=zeros(1,K);
    MeansNew=zeros(K,2);
    CovNew=zeros(sizeClass(1,2),sizeClass(1,2),K);
    
    for i=1:K
        PINew(1,i)=sum(gamma(:,i))/sizeClass(1,1);
        for j=1:sizeClass(1,1)
           MeansNew(i,:)=MeansNew(i,:)+gamma(j,i)*ClassData(j,:); 
        end
        MeansNew(i,:)=MeansNew(i,:)/sum(gamma(:,i));
        for j=1:sizeClass(1,1)
           CovNew(:,:,i)=CovNew(:,:,i)+gamma(j,i)*transpose(ClassData(j,:)-MeansNew(i,:))*(ClassData(j,:)-MeansNew(i,:));
        end
        CovNew(:,:,i)=CovNew(:,:,i)/sum(gamma(:,i));
    end
    LogLikeNew=LOGLIKECLUSTER(d,K,ClassData,PINew,MeansNew,CovNew);
    if abs(LogLikeNew-LogLike)<0.1
        break;
    else
        PI=PINew;
        Means=MeansNew;
        Cov=CovNew;
        LogLike=LogLikeNew;
    end
end









