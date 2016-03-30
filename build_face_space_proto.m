function build_face_space_proto(ims,conf,ndims)
%% built for Hassan
if length(ims)~=length(conf)
    error('The number of identities in confusability matrix and number of images are inconsitent');
elseif nargin<3
    ndims=2;
elseif isscalar(ndims)
    ndims=1:ndims;
end

%% convert ims from cell to double
for i=1:length(ims)
    im_mat(:,:,:,i)=double(ims{i});
end

%% compute porototypes
[Y,e] = cmdscale(conf);
zconf=zscore(Y);
for i=ndims
    ind_pos=find(zconf(:,i)>0);
    ind_neg=find(zconf(:,i)<0);
    im_mat_neg=im_mat(:,:,:,ind_neg);
    im_mat_pos=im_mat(:,:,:,ind_pos);
    prot_pos=sum(im_mat_pos.*repmat(reshape(zconf(ind_pos,i),1,1,1,length(ind_pos)),size(im_mat,1),...
        size(im_mat,2),3),4);
    prot_neg=sum(im_mat_neg.*repmat(reshape(zconf(ind_neg,i),1,1,1,length(ind_neg)),size(im_mat,1),...
        size(im_mat,2),3),4);
    prot_pos=prot_pos/max(prot_pos(:))*255;
    prot_neg=prot_neg/min(prot_neg(:))*255;
    figure
    imshow(uint8(prot_pos))
    title(['Dimension ' num2str(i) ', positive']);
    figure
    imshow(uint8(prot_neg))
    title(['Dimension ' num2str(i) ', negative']);
end


