% choosing 30 unfamiliar to match best famous faces. 

numOfPerm=1000;
load('fam_best.mat')
averFam=mean(all,1);
stdFam=std(all,1);

outres=NaN(4,numOfPerm);

outvec=NaN(30,numOfPerm);

for i=1:numOfPerm
    indextrue=[3:15 17:59];
    index = randperm(56);
    index=indextrue(index(1:30));
    temp=[aver_im_happ(index(1:30),:) aver_im_neut(index(1:30),:)];
    outres(1:2,i)=(mean(temp,1)-averFam)';
    outres(5,i)=sum((mean(temp,1)-averFam).^2);
    outres(3:4,i)=(std(temp,1)-stdFam)';
    outres(8:9,i)=(std(temp,1))';
    outres(6:7,i)=(mean(temp,1))';
    outvec(:,i)=index(1:30);
end
outresZ=(zscore(outres'))';
outresMean=mean(outresZ);
[a,b]=min(outres(5,:));   
vectIm=sort(outvec(:,b));   