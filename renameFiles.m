function renameFiles(dirc,fileFormat,nameNew,sort)
cd(dirc)
files=dir(['*.' fileFormat]);
imNum=size(files,1);
for i=1:imNum
    fileMat{i}=imread(files(i).name);
end
ftemp=files;
ims=fileMat;
if sort
    fileMat(1:imNum/2)=ims(1:2:end);
    fileMat(imNum/2+1:imNum)=ims(2:2:end);
    files(1:imNum/2)=ftemp(1:2:end);
    files(imNum/2+1:imNum)=ftemp(2:2:end);
end
for i=1:imNum
    name=files(i).name;
    if ~isempty(name)
        name=[nameNew '_' num2str(i+1000) '.tif'];
    end
    if sort & i<imNum/2+1
        name=['H_' name];
    elseif sort & i>imNum/2
        name=['N_' name];
    else
        disp('No sorting was required')
    end
    imwrite(uint8(fileMat{i}),name,'tif')
end
disp(['Number of images is ' num2str(imNum)]);
disp('Renaming is complete');
        