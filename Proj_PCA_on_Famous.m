%% this script projects PCA-corrected famous images on the original famous faces space
% load('/Users/dannem/Documents/Reconstruction/Image_Preparation/Projection of PCA faces on original famous/matlab.mat')
Z=NaN(93,54,20);
Y_proj=[];
[Wold, Yold] = cmdscale(conf_unf); % msd of the ogirinal space
Wold=Wold(:,1:20);
ims=[];
for j=1:93
    ims=ims_unf(1:54);
    ims(55)=ims_famous(j);
    ims(56:109)=ims_unf(55:108);
    ims(110)=ims_famous(j+93);
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
    [Wnew, Ynew] = cmdscale(conf);
    Wnew_temp=Wnew(1:size(Wnew,1)-1,1:20);
    [d,Z(j,:,:),tf] = procrustes(Wold,Wnew_temp);
    Y_proj(j,:,:) = tf.b*Wnew(:,1:20)*tf.T + repmat(tf.c(1,:), 55, 1);
end
temp=squeeze(Y_proj(1,1:54,:));
it=[26 46 28 8 29 32];
Wfam=squeeze(Y_proj(it,55,:));
typeData=cell(60+93,1);
typeData(1:60)=names_unfam(1:60);
typeData=[26 46 28 8 29 32];
typeData=num2cell(typeData)';


%% plotting
dim1=3;
dim2=4;
figure
a=plot(temp(:,dim1),temp(:,dim2),'.', 'MarkerEdgeColor','g','MarkerFaceColor','g', 'MarkerSize',21);
hold on
b=plot(Wfam(:,dim1),Wfam(:,dim2),'.', 'MarkerEdgeColor','b','MarkerFaceColor','b', 'MarkerSize',21);
box off
legend('Unfamiliar','Famous')
set(gca, 'Units', 'inches');set(gca, 'Position', [0.5 0.5 10 8]);
set(gca,'PlotBoxAspectRatio', [1.25 1 1]);set(gcf, 'Units', 'inches');
set(gcf, 'Position', [2 2 11 9]);
xlabel('1st dimension');
ylabel('2nd dimension');
gname(it)
% gname(typeData)
% plotMdsSolution(temp,[1 2],names_unfam)
% plotMdsSolution(Wfam,[3 4],names_famous)

%% plotting
figure
a=scatter3(temp(:,1),temp(:,2),temp(:,3));
hold on
b=scatter3(Wfam(:,1),Wfam(:,2),Wfam(:,3));
box off
legend('Unfamiliar','Famous')
hold off
xlabel('1st dimension');
ylabel('2nd dimension');
zlabel('3rd dimension');
set(gca, 'Units', 'inches');set(gca, 'Position', [0.5 0.5 10 8]);
set(gca,'PlotBoxAspectRatio', [1.25 1 1]);set(gcf, 'Units', 'inches');
set(gcf, 'Position', [2 2 11 9]);
% xlabel('1st dimension');
% ylabel('2nd dimension');
% h=gname(typeData,b);

%% computing distance
tempMean=mean(temp);
meanMat=repmat(tempMean,93,1);
for i=1:93
    out(i)=sum((meanMat(i,3:4)-Wfam(i,3:4)).^2);
end
[a,d]=sort(out);
sortedNames=typeData(d);

%% making names cell
names_mixed=[];
for i=1:54
    names_mixed{i,1}=['Filt_H' num2str(i+300)];
    names_mixed{i+60,1}=['Filt_N' num2str(i+300)];
end
names_mixed(55:60)=names_fam(1:6);
names_mixed(115:120)=names_fam(7:12);

%% showing faces
for i=1:60
    figure
    subplot(1,2,1)
    imshow(ims_mixed{i})
    subplot(1,2,2)
    imshow(ims_mixed{i+60})
end
%% this script projects PCA-corrected famous images on the original famous faces space
% % load('/Users/dannem/Documents/Reconstruction/Image_Preparation/Projection of PCA faces on original famous/matlab.mat')
% Z=NaN(59,59,20);
% Y_proj=[];
% [Wold, Yold] = cmdscale(conf_orig); % msd of the ogirinal space
% Wold=Wold(:,1:20);
% ims=[];
% for j=1:59
%     ims=ims_orig(1:59);
%     ims(60)=ims_pca(j);
%     ims(61:119)=ims_orig(60:118);
%     ims(120)=ims_pca(j+59);
%     maxVal=length(ims)/2;
%     vecInd=nchoosek(1:maxVal,2);
%     outputVal=zeros(maxVal);
%     for i=1:length(vecInd)
%         a1=double(ims{vecInd(i,1)}(:));
%         a2=double(ims{vecInd(i,1)+maxVal}(:));
%         a=[a1;a2];
%         b1=double(ims{vecInd(i,2)}(:));
%         b2=double(ims{vecInd(i,2)+maxVal}(:));
%         b=[b2;b1];
%         outputVal(vecInd(i,1),vecInd(i,2))=sqrt(sum((a-b).^2));
%         outputVal(vecInd(i,2),vecInd(i,1))=sqrt(sum((a-b).^2));
%         
%     end
%     conf=outputVal;
%     conf=conf./max(max(conf));% to make them from 0 to 1;
%     [Wnew, Ynew] = cmdscale(conf);
%     Wnew_temp=Wnew(1:size(Wnew,1)-1,1:20);
%     [d,Z(j,:,:),tf] = procrustes(Wold,Wnew_temp);
%     Y_proj(j,:,:) = tf.b*Wnew(:,1:20)*tf.T + repmat(tf.c(1,:), 60, 1);
% end
% temp=squeeze(Y_proj(1,:,:));
% Wpca=squeeze(Y_proj(:,60,:));
% typeData=1:59;
% 
% 
% %% plotting
% figure
% xlabel('1st dimension');
% ylabel('2nd dimension');
% plot(Wold(:,1),Wold(:,2),'.', 'MarkerEdgeColor','r','MarkerFaceColor','r', 'MarkerSize',21);
% hold on
% plot(Wpca(:,1),Wpca(:,2),'.', 'MarkerEdgeColor','b','MarkerFaceColor','b', 'MarkerSize',21);
% hold on
% plot(temp(:,1),temp(:,2),'.', 'MarkerEdgeColor','g','MarkerFaceColor','g', 'MarkerSize',21);
% hold on
% % plot(Wnew(:,1),Wnew(:,2),'.', 'MarkerEdgeColor','c','MarkerFaceColor','c', 'MarkerSize',21);
% box off
% legend('ogriginal solution','pca-corrected solution','Projection onto the original space')
% 
% set(gca, 'Units', 'inches');set(gca, 'Position', [0.5 0.5 10 8]);
% set(gca,'PlotBoxAspectRatio', [1.25 1 1]);set(gcf, 'Units', 'inches');
% set(gcf, 'Position', [2 2 11 9]);
% if iscell(typeData)
%     gimage(typeData)
% elseif typeData
%     gname(typeData)
% else    
% end