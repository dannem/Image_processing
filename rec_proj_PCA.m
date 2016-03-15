function [reconMat,projMat,statMat]=rec_proj_PCA(trainMat,testMat)
if size(trainMat,2)<size(trainMat,1)
    trainMat=trainMat';
end
train_aver=mean(trainMat,1);
train_corr=trainMat-repmat(train_aver,size(trainMat,1),1);
[statMat.coeff,statMat.score,statMat.latent,statMat.tsquared...
    ,statMat.explained,statMat.mu] = pca(double(train_corr),...
    'Algorithm','svd','Economy','on');
dims=size(statMat.score,2);

%% reoncstruction
reconMat = repmat(train_aver',1,dims+1) + (statMat.score(:,1:dims)...
    *statMat.coeff(:,1:dims)')';

%% projection
projFaceWgt_T=(testMat-repmat(train_aver,size(testMat,1),1))...
    *repmat(statMat.coeff,size(testMat,1));
projMat = repmat(train_aver,size(testMat,1),1) + projFaceWgt_T*statMat.coeff';
statMat.dist=sqrt(sum((projMat(:) - testMat(:)) .^ 2));