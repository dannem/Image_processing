function imMat=mat2ims(inMat,bck,type,names,dirc,prefix)
%mat2ims takes matlab matrices and returns rebuild matrice and/or saves it
%as files.
%
if ndims(inMat)==2
    numIm=size(inMat,2);
elseif ndims(inMat)==4
    numIm=size(inMat,4);
elseif iscell(inmat)
    numIm=size(inMat,1);
else
    error('Unkown matrix type for images');
end

if nargin<2
    error('The background indices not provided')
elseif nargin<3
    type=1;
elseif nargin<4
    dirc=pwd;
    prefix=[];
    for i=1:numIm;
        names{i}=['im' num2str(i)];
    end
elseif nargin<5
    dirc=pwd;
elseif nargin==6
    for i=1:numIm;
        names{i}=[prefix '_' names{i}];
    end
end

imMat=zeros(size(bck,1)*size(bck,2)*3,size(inMat,2));
ind_mat=repmat(bck(:),3,size(inMat,2));
imMat(ind_mat)=inMat;
imMat=reshape(imMat,size(bck,1),size(bck,2),3,size(inMat,2));
if nargin>3
    for i=1:numIm
        imwrite(squeeze(imMat(:,:,:,i)),names{i},'tiff')
    end
end
if type==2
    for i=1:numIm
        imMat{i}=imMat(:,:,:,i);
    end
end


        