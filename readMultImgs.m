dirc='/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/Final_Stimuli_Feb_23';
%dirc='/Users/Jenkin/Dropbox/CompNeuroLab/EEG Reconstruction/Stimuli/FINAL STIMULI - FEB 19';
cd(dirc)
files=dir('*.tif');
for i=1:length(files)
    a=imread(files(i).name);
    matIm{i}=a;
end

ims=matIm';
clear matIm i files dirc a
%% presenting images
% fileNum=1
% imtool(squeeze(matIm(:,:,:,fileNum)/255));