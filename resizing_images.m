dircOut='/Users/dannem/Desktop/Filtered Stimuli 32'
ims=readMultipleImages('/Users/dannem/Desktop/Filtered Stimuli 32','tif');
ell=imresize(ell_templ, 0.55,'nearest');
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
%     sz_im=size(temp);
%     temp=temp(:);
    temp(~repmat(ell_templ,1,1,3))=mean(temp(repmat(ell_templ,1,1,3)));
%     temp=reshape(temp,sz_im);
% %     temp=imresize(temp, 0.55,'bilinear');
% %     temp(ell==0)=0;
    imwrite(temp,[dircOut '/small_' files(i).name],'tif');
    
end

