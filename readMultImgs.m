dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
output4D=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double4D');
output2D=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','double2D');
outputCell=readMultipleImages(dirc,'tif',ell_templ,'flip','on','format','cell');
outputCelln=readMultipleImages(dirc,'tif',ell_templ,'flip','off','format','cell');
output2Dn=readMultipleImages(dirc,'tif',ell_templ,'flip','off','format','double2D');
output4Dn=readMultipleImages(dirc,'tif',ell_templ,'flip','off','format','double4D');
i=1
figure
subplot(2,3,1)
imshow(uint8(output4D(:,:,:,i)))
subplot(2,3,4)
imshow(uint8(outputCell{i}))
subplot(2,3,2)
imshow(uint8(output4Dn(:,:,:,i)))
subplot(2,3,5)
imshow(uint8(outputCelln{i}))
subplot(2,3,6)
imshow(uint8(images(:,:,:,i)))
% subplot(2,3,5)
% imshow(uint8(outputCelln{i}))

rec_im=zeros(172,115,3,240);
b=reshape(output2D,172,115,3,240);
ind_mat=repmat(ell_templ,3,240);
rec_im(ind_mat)=b;



output2Dnew=readMultipleImages(dirc,'tif',ell_templ);