function [matOut,szIm]=cell2matIms(cellIn)
if iscell(cellIn)
else
    error('The argument does not contain a legal cell array')
end
szIm=size(cellIn{1});
for i=1:length(cellIn)
    matOut(:,:,:,i)=cellIn{i};
end