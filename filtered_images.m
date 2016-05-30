function [output_orig,output_recon]=filtered_images
load('/Users/dannem/Documents/Reconstruction/Analysis/Behavioral_Reconstruction/Ideal observer/idealObserver.mat');
cps=[8 16 32 64];
for i=1:size(cps,2)
    for j=1:118
        temp_orig=ims{j};
        temp_recon=squeeze(recon_mat_sq_rgb(:,:,:,j));
        sz_im=size(temp_orig);
        temp_orig=rgb2lab(temp_orig);
        temp_recon=rgb2lab(temp_recon);
        temp_orig=temp_orig(:);
        temp_recon=temp_recon(:);
        temp_orig(bck)=mean(temp_orig(setdiff(1:max(bck),bck)));
        temp_recon(bck)=mean(temp_recon(setdiff(1:max(bck),bck)));
        temp_orig=reshape(temp_orig,sz_im);
        temp_recon=reshape(temp_recon,sz_im);
        temp_orig=filtperform(temp_orig,cps(i));
        temp_recon=filtperform(temp_recon,cps(i));
        output_orig(i,j,:,:,:)=temp_orig;
        output_recon(i,j,:,:,:)=temp_recon;
    end
end

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