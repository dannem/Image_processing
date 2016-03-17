Z=NaN(59,59,20);
Y_proj=[];
[Wold, Yold] = cmdscale(conf_orig);
Wold=Wold(:,1:20);
ims=[];
for j=1:59
    ims=ims_orig(1:59);
    ims(60)=ims_pca(j);
    ims(61:119)=ims_orig(60:118);
    ims(120)=ims_pca(j+59);
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
    Y_proj(j,:,:) = tf.b*Wnew(:,1:20)*tf.T + repmat(tf.c(1,:), 60, 1);
    j
   
end
temp=squeeze(Y_proj(1,:,:));
Wpca=squeeze(Y_proj(:,60,:));
typeData=1:59;


%% plotting
figure
xlabel('1st dimension');
ylabel('2nd dimension');
plot(Wold(:,1),Wold(:,2),'.', 'MarkerEdgeColor','r','MarkerFaceColor','r', 'MarkerSize',21);
hold on
plot(Wpca(:,1),Wpca(:,2),'.', 'MarkerEdgeColor','b','MarkerFaceColor','b', 'MarkerSize',21);
hold on
plot(temp(:,1),temp(:,2),'.', 'MarkerEdgeColor','g','MarkerFaceColor','g', 'MarkerSize',21);
hold on
% plot(Wnew(:,1),Wnew(:,2),'.', 'MarkerEdgeColor','c','MarkerFaceColor','c', 'MarkerSize',21);
box off
legend('ogriginal solution','pca-corrected solution','Projection onto the original space')

set(gca, 'Units', 'inches');set(gca, 'Position', [0.5 0.5 10 8]);
set(gca,'PlotBoxAspectRatio', [1.25 1 1]);set(gcf, 'Units', 'inches');
set(gcf, 'Position', [2 2 11 9]);
if iscell(typeData)
    gimage(typeData)
elseif typeData
    gname(typeData)
else    
end