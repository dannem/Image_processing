function output=readMultipleImages(dirc,fileFormat,bck,varargin)
cd(dirc)
files=dir(['*.' fileFormat]);
output=[];
%# define defaults at the beginning of the code so that you do not need to
%# scroll way down in case you want to change something or if the help is
%# incomplete
formatVal={'cell','double4D','double2D'};
flipVal={'on','off'};
options = struct('format',{formatVal},'flip',{flipVal});
%# read the acceptable names
optionNames = fieldnames(options);

%# count arguments
nArgs = length(varargin);
if nargin<2
    error('No image file format provided');
elseif ~nArgs & nargin<3
    for i=1:length(files)
        temp=imread(files(i).name);
        matIm{i}=temp;
    end
    output=matIm';
elseif ~nArgs
    disp('no flipping is performed');
    output=NaN(sum(bck(:))*3,length(files));
    bck=repmat(bck(:),3,1);
    for i=1:length(files)
        temp=imread(files(i).name);
        temp=temp(:);
        temp=temp(bck);
        output(:,i)=temp;
    end
elseif round(nArgs/2)~=nArgs/2
    error('EXAMPLE needs propertyName/propertyValue pairs')
end

for pair = reshape(varargin,2,[]) %# pair is {propName;propValue}
    inpName = lower(pair{1}); %# make case insensitive
    
    if any(strcmp(inpName,optionNames))
        %# overwrite options. If you want you can test for the right class here
        %# Also, if you find out that there is an option you keep getting wrong,
        %# you can use "if strcmp(inpName,'problemOption'),testMore,end"-statements
        if strcmp(inpName,'flip')
            if strcmp(pair{2},'on')
                for i=1:length(files)
                    temp=imread(files(i).name);
                    matIm{i}=temp;
                    matIm{i+length(files)}=fliplr(temp);
                end
                output=matIm';
            elseif strcmp(pair{2},'off')
                for i=1:length(files)
                    temp=imread(files(i).name);
                    matIm{i}=temp;
                end
                output=matIm';
            else error ('The value for flip is not defined correctly');
            end
        end
        if strcmp(inpName,'format')
            if strcmp(pair{2},'cell')
                if isempty(output)
                    for i=1:length(files)
                        temp=imread(files(i).name);
                        matIm{i}=temp;
                    end
                    output=matIm';
                else
                end  
            elseif strcmp(pair{2},'double2D')
                if isempty(output)
                    output=NaN(sum(bck(:))*3,length(files));
                    bck=repmat(bck(:),3,1);
                    for i=1:length(file)
                        temp=imread(files(i).name);
                        temp=temp(:);
                        temp=temp(bck);
                        output(:,i)=temp;
                    end
                else
                    out=output;
                    output=NaN(sum(bck(:))*3,length(files));
                    bck=repmat(bck(:),3,1);
                    for i=1:length(out)
                        temp=out{i};
                        temp=temp(:);
                        temp=temp(bck);
                        output(:,i)=temp;
                    end
                end  
            elseif strcmp(pair{2},'double4D')
                if isempty(output)
                    for i=1:length(file)
                        temp=imread(files(i).name);
                        output(:,:,:,i)=temp;
                    end
                else
                    out=output;
                    output=[];
                    for i=1:length(out)
                        temp=out{i};
                        output(:,:,:,i)=temp;
                    end
                end           
            else error ('The value for format is not defined correctly');
            end
        end
    else
        error('%s is not a recognized parameter name',inpName)
    end
end
