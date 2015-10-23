function logLike=LOGLIKECLUSTER(d,K,ClassData,PI,Means,Cov)
logLike=0;
sizeClass=size(ClassData);
for i=1:sizeClass(1,1)
    t=0;
    for j=1:K
        t=t+PI(1,j)*N(d,ClassData(i,:),Means(j,:),Cov(:,:,j));
    end
    logLike=logLike+log(t);
end