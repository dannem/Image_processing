function build_face_space_proto(ims,conf,ndims)
if length(ims)~=length(conf)
    error('The number of identities in confusability matrix and number of images are inconsitent');
elseif nargin<3
    ndims=2;
elseif isscalar(ndims)
    ndims=1:ndims;
end

%% convert ims from cell to double
for i=length(ims)
    im_mat(:,:,:,i)=ims{i};
end

%% compute porototypes
[Y,e] = cmdscale(conf)
zconf=zscore(Y);
for i=ndims
    ind_pos=find(zconf(:,i)>0);
    ind_neg=find(zconf(:,i)<0);
    im_mat_neg=im_mat(:,:,:,ind_neg);
    im_mat_pos=im_mat(:,:,:,ind_pos);
    prot_pos=sum(im_mat_pos.*repmat(zconf(ind_pos,i),size(im_mat,1),...
        size(im_mat,2),3,1),2);
    prot_neg=sum(im_mat_neg.*repmat(zconf(ind_neg,i),size(im_mat,1),...
        size(im_mat,2),3,1),2);
    figure
    imagesc(prot_pos)
    title(['Dimension ' num2str(i) ', positive']);
    figure
    imagesc(prot_neg)
    title(['Dimension ' num2str(i) ', negative']);
end


