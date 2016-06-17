function [output,names]=readMultipleImages(dirc,fileFormat,bck,varargin)
%readMultipleImages converts files of desingated type into matrices. In
%   addition it can add flipped images to augment the sample and convert
%   images to LAB format.
%   Input:  dirc - directory
%           fileFormat - image files' extension
%           bck - background indices for one color channel
%           Format - output format (cell,double4D,double2D). default-cell
%           Flip - whether augment matrices by flipping images (on,off).
%                   default -off
%           Convert - converting to LAB (on,off). Default - off
%   Function is written by DN for VisRecLab
cd(dirc)
files=dir(['*.' fileFormat]);

%# define defaults at the beginning of the code so that you do not need to
%# scroll way down in case you want to change something or if the help is
%# incomplete
% paramNames = {'Format','Flip','Convert'};
% defaults   = {'cell','off','off'};
flipVal={'on','off'};
formatVal={'cell','double2D','double4D'};
convertVal={'on','off'};
options = struct('Format',{formatVal},'Flip',{flipVal},'Convert',{convertVal});
%# read the acceptable names
% optionNames = fieldnames(options);
% loading files
for i=1:length(files)
    fileMat{i}=imread(files(i).name);
    names{i}=files(i).name;
end
names=names';
fileMat=fileMat';
%# count arguments
nArgs = length(varargin);
if nargin<2
    error('No image file format provided');
elseif ~nArgs & nargin<3
    output=fileMat;
elseif ~nArgs
    disp('no flipping and conversion is performed');
    output=NaN(sum(bck(:))*3,length(fileMat));
    bck=repmat(bck(:),3,1);
    for i=1:size(fileMat,1)
        temp=fileMat{i};
        temp=temp(:);
        temp=temp(bck);
        output(:,i)=temp;
    end
elseif round(nArgs/2)~=nArgs/2
    error('EXAMPLE needs propertyName/propertyValue pairs')
else
    % creating vector with pairs of method names
    args=lower(reshape(varargin,1,2));
    % checking Convert
    checkVar=lower('Convert');
    if any(any(strcmp(args,checkVar)))
        [indTemp ~] =find(strcmp(args,checkVar));
        valTemp=args{indTemp,2};
        args(indTemp,:)=[];
        switch valTemp
            case 'on'
                for i=1:size(fileMat,1)
                    fileMat{i}=rgb2lab(fileMat{i});
                end
                output=fileMat;
            case 'off'
                disp('No LAB convesion was requested')
        end
    else
        disp('No LAB convesion was requested')
    end
    % checking flip
    checkVar=lower('Flip');
    if any(any(strcmp(args,checkVar)))
        [indTemp ~] =find(strcmp(args,checkVar));
        valTemp=args{indTemp,2};
        args(indTemp,:)=[];
        switch valTemp
            case 'on'
                imsNum=size(fileMat,1);
                for i=1:imsNum
                    fileMat{i+imsNum}=fliplr(fileMat{i});
                end
                output=fileMat;
            case 'off'
                disp('No flipping augmentation was requested')
        end
    else
        disp('No flipping augmentation was requested')
    end
    
    % checking format
    checkVar=lower('Format');
    if any(any(strcmp(args,checkVar)))
        [indTemp ~] =find(strcmp(args,checkVar));
        valTemp=args{indTemp,2};
        args(indTemp,:)=[];
        switch valTemp
            case 'cell'
                output=fileMat;
            case 'double4d'
                for i=1:size(fileMat,1)
                    output(:,:,:,i)=fileMat{i};
                end
            case 'double2d'
                output=NaN(sum(bck(:))*3,length(fileMat));
                bck=repmat(bck(:),3,1);
                for i=1:size(fileMat,1)
                    temp=fileMat{i};
                    temp=temp(:);
                    temp=temp(bck);
                    output(:,i)=temp;
                end
        end
    else
    end
    if ~isempty(args)
        error('Some argument names are not recognized');
    end
end
