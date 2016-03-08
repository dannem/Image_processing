% computing regression of images on each other
% goal is to estimate the high cut off of accuracy


mat=[];
ypred=[];
imNew=[];
for i=1:118
    a=double(labout{i});
    mat(:,i)=a(:);
end
% mat(bck,:)=[];
for i=1:59
   diff=setdiff([1:59],i);
   mdl = fitlm(mat(:,diff),mat(:,i)) ;
   ypred(:,i) = predict(mdl,mat(:,diff));
end
for i=1:59
    imNew(:,:,:,i)=reshape(ypred(:,i),168, 117, 3);
end
% l=2
% figure
% imshow(uint8(ims{l}))
% % subplot(1,2,1)
% figure
% imshow(uint8(imNew{l}))
% % subplot(1,2,2)
