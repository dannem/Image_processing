dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
output2D=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double2D');
output4D=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double4D');
output=output2D';
aver_output=mean(output,1);
output_corr=output-repmat(aver_output,size(output,1),1);
[coeff,score,latent,tsquared,explained,mu] = pca(double(output_corr),'Algorithm','svd','Economy','on');
ndims=size(score,2);
reconstructed = repmat(aver_output',1,240) + (score(:,1:ndims)*coeff(:,1:ndims)')';
Y = (X-repmat(mu, rows(X), 1))*W;
images=rebuildIm(reconstructed,ell_templ);
figure
subplot(1,2,1)
imshow(uint8(images(:,:,:,120)));
subplot(1,2,2)
imshow(uint8(output4D(:,:,:,120)));

dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces'
output2Df=readMultipleImages(dirc,'tif',ell_templ,'flip','off','format','double2D');
faceFam1=output2Df(:,1);
projFace=coeff'*(faceFam1-aver_output');



dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces'
output2Df=readMultipleImages(dirc,'tif',ell_templ,'flip','off','format','double2D');
faceFam1=output2Df(:,1);
projFaceWgt=(faceFam1'-aver_output)*coeff';
projected = aver_output + projFaceWgt'*coeff';
imagesProj=rebuildIm(projected',ell_templ);
imageTrue=rebuildIm(faceFam1,ell_templ);




figure
subplot(1,2,1)
imshow(uint8(imagesProj))
subplot(1,2,2)
imshow(uint8(imageTrue))
