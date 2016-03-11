function imMat=rebuildIm(inMat,bck,type)
if nargin<2
    error('The background indices not provided')
elseif nargin<3
    type=1;
end

imMat=zeros(size(bck,1)*size(bck,2)*3,size(inMat,2));
ind_mat=repmat(bck(:),3,size(inMat,2));
imMat(ind_mat)=inMat;
imMat=reshape(imMat,size(bck,1),size(bck,2),3,size(inMat,2));
if type==2
    for i=1:size(inMat,2)
        imMat{i}=imMat(:,:,:,i);
    end
end