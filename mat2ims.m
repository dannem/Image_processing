function imMat=mat2ims(inMat,bck,type,names,dirc,suffix,lab)
%mat2ims takes matlab matrices and returns rebuild matrice and/or saves it
%   as files.
%   Input:  inMat - matrix with pixels
%           bck - logical matrix with background pixels for one color
%                   channel
%           type - output type: 1 - saving only; 2 - saviong and outputing
%                   as cell
%           names - filenames for images
%           dirc - directory where to save
%           suffix - adding suffix after the existing name.
%           lab - converting to lab space: 1 - on; 0 - off
if ndims(inMat)==2
    numIm=min(size(inMat));
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
    lab=0;
elseif nargin<4
    dirc=pwd;
    suffix=[];
    for i=1:numIm;
        names{i}=['im' num2str(i)];
    end
    lab=0;
elseif nargin<5
    dirc=pwd;
    lab=0;
elseif nargin<7
    lab=0;
    for i=1:numIm;
        temp=names{i};
        ind = strfind(temp, '.');
        names{i}=[temp(1:ind-1) '_' suffix '.tiff'];
    end
elseif nargin<8
    for i=1:numIm;
        temp=names{i};
        ind = strfind(temp, '.');
        names{i}=[temp(1:ind-1) '_' suffix '.tiff'];
    end
end

imMat=zeros(size(bck,1)*size(bck,2)*3,size(inMat,2));
ind_mat=repmat(bck(:),3,size(inMat,2));
imMat(ind_mat)=inMat;
imMat=reshape(imMat,size(bck,1),size(bck,2),3,size(inMat,2));
if nargin>3
    for i=1:numIm
        temp=squeeze(imMat(:,:,:,i));
        if lab
            temp=lab2rgb(temp)*255;
        end
        imwrite(uint8(temp),names{i},'tiff')
    end
end
if type==2
    for i=1:numIm
        if lab
            imMat{i}=lab2rgb(imMat(:,:,:,i))*255;
        else
            imMat{i}=imMat(:,:,:,i);
        end
    end
end


