function createFilteredImages(dircIn,cps,ell_templ,fileFormat,factor,dircOut)
if nargin<6
    dircOut='/Filtered Images';
end

% creating smaller background
ell=imresize(ell_templ, factor,'bilinear');

ell1=fliplr(ell);
ell=(ell+ell1)/2;
ell=ell>0.5;
ell1=flipud(ell);
ell=(ell+ell1)/2;
% ell=round(ell);
ell=ell>0.2;
ell=logical(ell);
ell=repmat(ell,1,1,3);

 
ims=readMultipleImages(dircIn,fileFormat);
cd(dircIn)
mkdir(dircOut);
files=dir(['*.' fileFormat]);
cd(dircOut);
for i=1:length(ims)
    temp=ims{i};
    temp=rgb2lab(temp);
    sz_im=size(ell_templ);
    temp(logical(cat(3,ell_templ,zeros([sz_im 2]))))=mean(temp(logical(cat(3,~ell_templ,zeros([sz_im 2])))));
    temp(logical(cat(3,zeros(sz_im),ell_templ,zeros(sz_im))))=mean(temp(logical(cat(3,zeros(sz_im),~ell_templ,zeros(sz_im)))));
    temp(logical(cat(3,zeros([sz_im 2]),ell_templ)))=mean(temp(logical(cat(3,zeros([sz_im 2]),~ell_templ))));
    temp=filtperform(temp,cps);
    temp=imresize(temp, factor,'bilinear');
    temp(ell==1)=0;
    temp=lab2rgb(temp);
    imwrite(temp,[dircOut '/Filt_' files(i).name(1,1:end-4) '.tif'],'tif');
    
    
end
save('bck.mat','ell')
end

function im_filt=filtperform(inIm,filt_sd)
[sz1, sz2, sz3] = size(inIm);
[U, V] = dftuv(sz1, sz2);
D_mat = sqrt(U.^2 + V.^2);
H = exp(-(D_mat.^2)./(2*(filt_sd^2)));
im_filt=zeros(size(inIm));
for cond=1:3
    F=fft2(inIm(:,:,cond));
    im_filt(:,:,cond)=real(ifft2(H.*F));
end
end

function [U, V] = dftuv(M, N)
%DFTUV Computes meshgrid frequency matrices.
%   [U, V] = DFTUV(M, N) computes meshgrid frequency matrices U and
%   V. U and V are useful for computing frequency-domain filter 
%   functions that can be used with DFTFILT.  U and V are both M-by-N.

% Set up range of variables.
u = 0:(M-1);
v = 0:(N-1);

% Compute the indices for use in meshgrid
idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v > N/2);
v(idy) = v(idy) - N;

% Compute the meshgrid arrays
[V, U] = meshgrid(v, u);
end
    