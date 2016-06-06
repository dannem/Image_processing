function cont_lum_normalization(foldIn,foldOut,bck)
ims=readMultipleImages(foldIn,'tif');
mkdir(foldOut);
for i=1:size(ims,1)
    temp=ims{i};
    temp=double(temp(bck));
    for j=1:3
        num=1+length(temp)/3*(j-1);
        av(i,j)=mean(temp(num:num+length(temp)/3));
        con(i,j)=std(temp(num:num+length(temp)/3));
    end
end
aver=mean(av,1);
cont=mean(con,1);
for i=1:size(ims,1)
    temp=ims{i};
    temp=double(temp);
    for j=1:3
        vec=temp(:,:,j);
        vec=vec+aver(j)-av(i,j);
        vec=vec*(cont(j)/av(j));
        temp(:,:,j)=vec;
    end
    ims{i}=temp;
end

    
    
    
