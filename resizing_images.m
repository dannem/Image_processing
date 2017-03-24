dircOut='/Users/dannem/Documents/Reconstruction/Images/Shape'
ims=readMultipleImages('/Users/dannem/Dropbox/CompNeuroLab/Dan Facemapping/shape-free textures','bmp');
ell=imresize(data.mask, 0.55,'nearest');
ell1=fliplr(ell);
ell=ell+ell1;
ell=logical(ell);
ell1=flipud(ell);
ell=ell+ell1;
ell=logical(ell);
ell=repmat(ell,1,1,3);
files=dir(['*.tif']);
for i=1:length(ims);
    temp=ims{i};
    sz_im=size(temp);
    temp=temp(:);
    temp(~repmat(data.mask,1,1,3))=mean(temp(repmat(data.mask,1,1,3)));
    temp=reshape(temp,sz_im);
    temp=imresize(temp, 0.55,'bilinear');
    temp(ell==0)=0;
    imwrite(temp,[dircOut '/small_' files(i).name],'tif');
    
end

