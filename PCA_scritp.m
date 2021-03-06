% clc
clear all;
dircout='/Users/dannem/Documents/Reconstruction/Image_Preparation/pca_derived_faces';
mkdir(dircout);

%% reconstruction RGB+all+4out;
load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Memory/old_stimuli';
[faces_ufr1,names_ufr1]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Memory/new_stimuli';
[faces_ufr2,names_ufr2]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
faces_all=[faces_ufr faces_fam]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[1+(i-1)*2 2+(i-1)*2 119+(i-1)*2 120+(i-1)*2]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    stat.hap_rgb_all_4out(i)=statMat.dist;
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'hap_rgb_all_4out');
    
    
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(2,:));
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(2+(i-1)*2),dirc,'neut_rgb_all_4out');
    stat.neut_rgb_all_4out(i)=statMat.dist;
    i
    toc
    
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)

%% reconstruction LAB+all+4out;
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
faces_all=[faces_ufr faces_fam]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[1+(i-1)*2 2+(i-1)*2 119+(i-1)*2 120+(i-1)*2]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    a=lab2rgb(reshape(projMat',size(projMat,2)/3,3))*255;
    b=lab2rgb(reshape(facesPro(1,:)',size(projMat,2)/3,3))*255;
    stat.hap_lab_all_4out(i)=sqrt(sum((a(:) - b(:)) .^ 2));
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'hap_lab_all_4out',1);
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(2,:));
    a=lab2rgb(reshape(projMat',size(projMat,2)/3,3))*255;
    b=lab2rgb(reshape(facesPro(2,:)',size(projMat,2)/3,3))*255;
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(2+(i-1)*2),dirc,'neut_lab_all_4out',1);
    stat.neut_lab_all_4out(i)=sqrt(sum((a(:) - b(:)) .^ 2));
    i
    toc
    
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)



%% reconstruction RGB+all+2out;
load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
faces_all=[faces_ufr faces_fam]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[1+(i-1)*2 119+(i-1)*2]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    stat.hap_rgb_all_2out(i)=statMat.dist;
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'hap_rgb_all_2out');
    
    faces=faces_all;
    ind=size(faces_ufr,2)+[2+(i-1)*2 120+(i-1)*2];
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(2+(i-1)*2),dirc,'neut_rgb_all_2out');
    stat.neut_rgb_all_2out(i)=statMat.dist;
    i
    toc
    
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)

%% reconstruction LAB+all+2out;
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
faces_all=[faces_ufr faces_fam]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[1+(i-1)*2 119+(i-1)*2]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    a=lab2rgb(reshape(projMat',size(projMat,2)/3,3))*255;
    b=lab2rgb(reshape(facesPro(1,:)',size(projMat,2)/3,3))*255;
    stat.hap_lab_all_2out(i)=sqrt(sum((a(:) - b(:)) .^ 2));
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'hap_lab_all_2out',1);
    
    faces=faces_all;
    ind=size(faces_ufr,2)+[2+(i-1)*2 120+(i-1)*2];
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    a=lab2rgb(reshape(projMat',size(projMat,2)/3,3))*255;
    b=lab2rgb(reshape(facesPro(1,:)',size(projMat,2)/3,3))*255;
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(2+(i-1)*2),dirc,'neut_lab_all_2out',1);
    stat.neut_lab_all_2out(i)=sqrt(sum((a(:) - b(:)) .^ 2));
    i
    toc
    
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)
% 
% 
%% reconstruction RGB+neutral;
load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
faces_fam_neut=faces_fam(:,2:2:end);
faces_all=[faces_ufr faces_fam_neut]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[i 59+i]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    stat.neut_rgb(i)=statMat.dist;
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'neut_rgb');
    i
    toc
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)

%% reconstruction RGB+happy;
load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
faces_fam_hap=faces_fam(:,1:2:end);
faces_all=[faces_ufr faces_fam_hap]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[i 59+i]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    stat.hap_rgb(i)=statMat.dist;
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'hap_rgb');
    i
    toc
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)
%% reconstruction LAB+neutral;
load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
faces_fam_neut=faces_fam(:,2:2:end);
faces_all=[faces_ufr faces_fam_neut]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[i 59+i]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    a=lab2rgb(reshape(projMat',size(projMat,2)/3,3))*255;
    b=lab2rgb(reshape(facesPro(1,:)',size(projMat,2)/3,3))*255;
    stat.neut_lab(i)=sqrt(sum((a(:) - b(:)) .^ 2));
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'neut_lab',1);
    i
    toc
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)

%% reconstruction LAB+happy;
% load('/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Unfamiliar Faces';
[faces_ufr,names_ufr]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
dirc='/Users/dannem/Dropbox/CompNeuroLab/PCA Faces/Familiar Famous Faces';
[faces_fam,names_fam]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','on');
faces_fam_hap=faces_fam(:,1:2:end);
faces_all=[faces_ufr faces_fam_hap]';
cd(dircout)
tic
for i=1:size(names_fam,2)/2
    faces=faces_all;
    ind=size(faces_ufr,2)+[i 59+i]
    facesPro=faces(ind,:);
    faces(ind,:)=[];
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,facesPro(1,:));
    a=lab2rgb(reshape(projMat',size(projMat,2)/3,3))*255;
    b=lab2rgb(reshape(facesPro(1,:)',size(projMat,2)/3,3))*255;
    stat.hap_lab(i)=sqrt(sum((a(:) - b(:)) .^ 2));
    imagesProj=mat2ims(projMat',ell_templ,1,names_fam(1+(i-1)*2),dirc,'hap_lab',1);
    i
    toc
    
end
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)
%%
% figure
% subplot(1,2,1)
% imshow(lab2rgb(imagesProj))
% subplot(1,2,2)
% imshow(lab2rgb(imageTrue))
% figure
% subplot(1,2,1)
% imshow(uint8(imagesProj))
% subplot(1,2,2)
% imshow(uint8(imageTrue))
% end
load('/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/bck.mat')
dirc='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Memory/old_stimuli';
[faces_ufr1,names_ufr1]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Memory/new_stimuli';
[faces_ufr2,names_ufr2]=ims2mat(dirc,'tif',ell_templ,'flip','on','format','double2D','Convert','off');
dirc='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Memory/ToBePCA';
[faces_ufr3,names_ufr3]=ims2mat(dirc,'tif',ell_templ,'flip','off','format','double2D','Convert','off');
dirc_target='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Memory/Projected';
faces_all=[faces_ufr1 faces_ufr2]';
cd(dirc_target)
tic

for i=1:size(names_ufr3,2)
    faces=faces_all;
    [reconMat,projMat,statMat]=rec_proj_PCA(faces,faces_ufr3(:,i)');
    stat.ims(i)=statMat.dist;
    imagesProj=mat2ims(projMat',ell_templ,1,names_ufr3(i),dirc_target,'projected');
end
toc
disp('End of process');
S(2) = load('handel');
sound(S(2).y,S(2).Fs)