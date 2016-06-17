function plotMdsSolution(eigMat,dims,kind)

if ndims(kind{1})==3    
else
    kind=kind(length(kind)/2+1:end);
    for i=1:length(kind)
        tempN=strfind(kind{i},'N');
        tempD=strfind(kind{i},'.');
        temp = kind{i}(tempN+1:tempD-1);
        kind{i}=temp;
    end
end
figure
eigMat=eigMat(:,dims);


col_vect=[0.8 0 0];

%%%choose to plot raw or zscored solution
%%% gimage does not work with scatter plot. Stick to plot.
plot(eigMat(:,1),eigMat(:,2),'d', 'MarkerEdgeColor',[.6 .1 .1],'MarkerFaceColor',[.6 .1 .1], 'MarkerSize',5);
%plot(zscore(Y(:,1)), zscore(Y(:,2)),'d', 'MarkerEdgeColor',[.6 .1 .1],'MarkerFaceColor',[.6 .1 .1], 'MarkerSize',5)
xlabel(['dimension' num2str(dims(1))]);
ylabel(['dimension' num2str(dims(2))]);
box off

%%%control (set) aspect ratio & size of plot in inches
%%%(so reproducible in the future); and figure size (to enclose entire plot)

set(gca, 'Units', 'inches');
set(gca, 'Position', [0.5 0.5 10 8]);
set(gca,'PlotBoxAspectRatio', [1.25 1 1]);

set(gcf, 'Units', 'inches');
set(gcf, 'Position', [2 2 11 9]);

%%%choose axis limits appropriately
%if ROI_k==0
%%%bhv plot
%          axis([-0.45 0.6 -0.6 0.45])
%          set(gca,'XTick',-0.45:0.15:0.6)
%          set(gca,'YTick',-0.6:0.15:0.45)
%elseif ROI_k==1
%%%rFG plot
%          axis([-1 1 -1 1])
%          set(gca,'XTick',-1:0.25:1)
%          set(gca,'YTick',-1:0.25:1)
%end

%%%label points with 1-60
%      nm_mat=1:60;
if ndims(kind{1})==3
    gimage(kind)
elseif ischar(kind{1})
    gname(kind)
else
    
end