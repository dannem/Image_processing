



%% creating correlation matrix
cor.L.happ=NaN(54,59);
cor.L.neut=NaN(54,59);
cor.Lab.happ=NaN(54,59);
cor.Lab.neut=NaN(54,59);

for i=1:54
    temp_unf_happ=rgb2lab(ims_unf{i});
    temp_unf_neut=rgb2lab(ims_unf{i+54});
    for j=1:59
        temp_fam_happ=rgb2lab(ims_fam{j});
        temp_fam_neut=rgb2lab(ims_fam{j+59});
        cor.L.happ(i,j)=sqrt(sum(sum((temp_unf_happ(:,:,1)-temp_fam_happ(:,:,1)).^2,1),2));
        cor.L.neut(i,j)=sqrt(sum(sum((temp_unf_neut(:,:,1)-temp_fam_neut(:,:,1)).^2,1),2));
        cor.Lab.happ(i,j)=sqrt(sum(sum(sum((temp_unf_happ-temp_fam_happ).^2,1),2),3));
        cor.Lab.neut(i,j)=sqrt(sum(sum(sum((temp_unf_neut-temp_fam_neut).^2,1),2),3));
    end
end
clear i j temp_fam_happ temp_fam_neut temp_unf_happ temp_unf_neut
cor.happ_min_L=min(cor.L.happ);
cor.neut_min_L=min(cor.L.neut);   
cor.happ_min_Lab=min(cor.Lab.happ);
cor.neut_min_Lab=min(cor.Lab.neut); 
cor.mean_L=mean([cor.happ_min_L;cor.neut_min_L]);
cor.mean_Lab=mean([cor.happ_min_Lab;cor.neut_min_Lab]);
[cor.happ_min_L_a cor.happ_min_L_b]=sort(cor.happ_min_L);
[cor.neut_min_L_a cor.neut_min_L_b]=sort(cor.neut_min_L);
[cor.happ_min_Lab_a cor.happ_min_Lab_b]=sort(cor.happ_min_Lab);
[cor.neut_min_Lab_a cor.neut_min_Lab_b]=sort(cor.neut_min_Lab);
[cor.mean_L_a cor.mean_L_b]=sort(cor.mean_L);
[cor.mean_Lab_a cor.mean_Lab_b]=sort(cor.mean_Lab);
% all_min=[happ_min_L_b' neut_min_L_b' happ_min_Lab_b' neut_min_Lab_b' min_L_b' min_Lab_b'];
cor.all_min_Lab=[cor.happ_min_Lab_b' cor.neut_min_Lab_b' cor.mean_Lab_b'];
cor.all_min_L=[cor.happ_min_L_b' cor.neut_min_L_b' cor.mean_L_b'];
ind_Lab_fam=cor.all_min_Lab(1:6,3);
ind_L_fam=cor.all_min_L(1:6,3);


% x=intersect(all_min([1:10],5)',all_min(1:10,6)');
cor.meanLab=mean(cat(3,cor.Lab.happ,cor.Lab.neut),3);
cor.meanL=mean(cat(3,cor.L.happ,cor.L.neut),3);

for i=1:length(ind_Lab_fam)
    temp=cor.meanLab(:,ind_Lab_fam(i));
    [~,ind_Lab_unf(i)]=min(temp);
    temp=cor.meanL(:,ind_L_fam(i));
    [~,ind_L_unf(i)]=min(temp);
end
clear temp

ims_mixed_Lab=cell(120,1);
ims_mixed_L=cell(120,1);
ims_mixed_Lab([1:54 61:114])=ims_unf;
ims_mixed_L([1:54 61:114])=ims_unf;
ims_mixed_Lab([55:60])=ims_fam(ind_Lab_fam);
ims_mixed_L([55:60])=ims_fam(ind_L_fam);
ims_mixed_Lab([115:120])=ims_fam(ind_Lab_fam+59);
ims_mixed_L([115:120])=ims_fam(ind_L_fam+59);

%computing confusibility matrix for Lab
ims=ims_mixed_Lab;
maxVal=length(ims)/2;
vecInd=nchoosek(1:maxVal,2);
outputVal=zeros(maxVal);
for i=1:length(vecInd)
    a1=double(ims{vecInd(i,1)}(:));
    a2=double(ims{vecInd(i,1)+maxVal}(:));
    a=[a1;a2];
    b1=double(ims{vecInd(i,2)}(:));
    b2=double(ims{vecInd(i,2)+maxVal}(:));
    b=[b2;b1];
    outputVal(vecInd(i,1),vecInd(i,2))=sqrt(sum((a-b).^2));
    outputVal(vecInd(i,2),vecInd(i,1))=sqrt(sum((a-b).^2));
    
end
conf=outputVal;
conf=conf./max(max(conf));% to make them from 0 to 1;
conf_mixed_Lab=conf;
clear outputVal vecInd b b1 b2 a a1 a2 maxVal ims conf i


%computing confusibility matrix for L
ims=ims_mixed_L;
maxVal=length(ims)/2;
vecInd=nchoosek(1:maxVal,2);
outputVal=zeros(maxVal);
for i=1:length(vecInd)
    a1=double(ims{vecInd(i,1)}(:));
    a2=double(ims{vecInd(i,1)+maxVal}(:));
    a=[a1;a2];
    b1=double(ims{vecInd(i,2)}(:));
    b2=double(ims{vecInd(i,2)+maxVal}(:));
    b=[b2;b1];
    outputVal(vecInd(i,1),vecInd(i,2))=sqrt(sum((a-b).^2));
    outputVal(vecInd(i,2),vecInd(i,1))=sqrt(sum((a-b).^2));
    
end
conf=outputVal;
conf=conf./max(max(conf));% to make them from 0 to 1;
conf_mixed_L=conf;
clear outputVal vecInd b b1 b2 a a1 a2 maxVal ims conf i


[load_mixed_Lab,~,~,~,~]=patMDS(conf_mixed_Lab,6,0.0001);
[load_mixed_L,~,~,~,~]=patMDS(conf_mixed_L,6,0.0001);

%% plotting images
figure
for i=1:length(ind_Lab_fam)
    subplot(2,6,i)
    imshow(ims_fam{ind_Lab_fam(i)})
    subplot(2,6,i+6)
    imshow(ims_unf{ind_Lab_unf(i)})
end
suptitle('Lab-based happy')  
figure
for i=1:length(ind_Lab_fam)
    subplot(2,6,i)
    imshow(ims_fam{ind_Lab_fam(i)+59})
    subplot(2,6,i+6)
    imshow(ims_unf{ind_Lab_unf(i)+54})
end    
suptitle('Lab-based neutral') 
figure
for i=1:length(ind_L_fam)
    subplot(2,6,i)
    imshow(ims_fam{ind_L_fam(i)})
    subplot(2,6,i+6)
    imshow(ims_unf{ind_L_unf(i)})
end
suptitle('L-based happy')     
figure
for i=1:length(ind_L_fam)
    subplot(2,6,i)
    imshow(ims_fam{ind_L_fam(i)+59})
    subplot(2,6,i+6)
    imshow(ims_unf{ind_L_unf(i)+54})
end
suptitle('L-based neutral') 

%% plotting face spaces

figure
s=scatter(load_mixed_Lab(1:54,1),load_mixed_Lab(1:54,2))
s.MarkerEdgeColor = 'r';
s.MarkerFaceColor = [0 0.5 0.5];
hold on
scatter(load_mixed_Lab(55:60,1),load_mixed_Lab(55:60,2))
title('Lab-based face space: dimensions 1 and 2')

figure
s=scatter(load_mixed_Lab(1:54,3),load_mixed_Lab(1:54,4))
s.MarkerEdgeColor = 'r';
s.MarkerFaceColor = [0 0.5 0.5];
hold on
scatter(load_mixed_Lab(55:60,3),load_mixed_Lab(55:60,4))
title('Lab-based face space: dimensions 3 and 4')

figure
s=scatter(load_mixed_L(1:54,1),load_mixed_L(1:54,2))
s.MarkerEdgeColor = 'r';
s.MarkerFaceColor = [0 0.5 0.5];
hold on
scatter(load_mixed_L(55:60,1),load_mixed_L(55:60,2))
title('L-based face space: dimensions 1 and 2')

figure
s=scatter(load_mixed_L(1:54,3),load_mixed_L(1:54,4))
s.MarkerEdgeColor = 'r';
s.MarkerFaceColor = [0 0.5 0.5];
hold on
scatter(load_mixed_L(55:60,3),load_mixed_L(55:60,4))
title('L-based face space: dimensions 3 and 4')