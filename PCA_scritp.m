load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
output2D=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double2D');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces'
output2Df=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double2D');



output=[output2D output2Df]';

% for i=241:299
    i=261
    out=241:59:size(output,1);
    outputTemp=output;
    outputTemp(out,:)=[];
    aver_output=mean(outputTemp,1);
    output_corr=outputTemp-repmat(aver_output,size(outputTemp,1),1);
    [coeff,score,latent,tsquared,explained,mu] = pca(double(output_corr),'Algorithm','svd','Economy','on');
    ndims=size(score,2);
    reconstructed = repmat(aver_output',1,ndims+1) + (score(:,1:ndims)*coeff(:,1:ndims)')';
% images=rebuildIm(reconstructed,ell_templ);
% imageTrue=rebuildIm(output2D(:,120),ell_templ);
% figure
% subplot(1,2,1)
% imshow(lab2rgb(images(:,:,:,120)));
% subplot(1,2,2)
% imshow(lab2rgb(imageTrue));

% dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces'
% output2Df=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double2D');
% dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces'
% output2Df=readMultipleImages(dirc,'tif',ell_templ,'flip','off','format','double2D');
faceFam1=output(i,:);
projFaceWgt_T=(faceFam1-aver_output)*coeff;
projected = aver_output + projFaceWgt_T*coeff';
imagesProj=rebuildIm(projected',ell_templ);
imageTrue=rebuildIm(faceFam1',ell_templ);




% figure
% subplot(1,2,1)
% imshow(lab2rgb(imagesProj))
% subplot(1,2,2)
% imshow(lab2rgb(imageTrue))
figure
subplot(1,2,1)
imshow(uint8(imagesProj))
subplot(1,2,2)
imshow(uint8(imageTrue))
% end
