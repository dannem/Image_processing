scatter(loadAll(:,1),loadAll(:,2))
gname([1:60])
cls1=[12 21 18 17 22 11 9 15 4 3 1 20 13 7 8 10 19 5 2 6 16 14];
cls2=[29 58 59 60 42 48 47 44 54 43 51 45 50 52 46 38 39 49 40 53 41 57];
cls1=sort(unique(cls1))';
cls2=sort(unique(cls2))';
cls1mat=loadAll(cls1,:);
cls2mat=loadAll(cls2,:);
% scatter(cls1mat(:,1),cls1mat(:,2))
% scatter(cls2mat(:,1),cls1mat(:,2))

for i=1:1000
    i
    ind1=randperm(length(cls1));
    ind2=randperm(length(cls2));
    temp1a=cls1mat(ind1(1:6),:);
    temp1a_names(:,i)=cls1(ind1(1:6));
    temp1b=cls1mat(ind1(7:12),:);
    temp1b_names(:,i)=cls1(ind1(7:12));
    out1(1,i)=norm(mean(temp1a,1)-mean(temp1b,1));
    out1(2,i)=sum(sum((repmat(mean(temp1a,1),6,1)-temp1a).^2));
    out1(3,i)=sum(sum((repmat(mean(temp1b,1),6,1)-temp1b).^2));
    
    temp2a=cls2mat(ind2(1:6),:);
    temp2a_names(:,i)=cls2(ind2(1:6));
    temp2b=cls2mat(ind2(7:12),:);
    temp2b_names(:,i)=cls2(ind2(7:12));
    out2(1,i)=norm(mean(temp2a,1)-mean(temp2b,1));
    out2(2,i)=sum(sum((repmat(mean(temp2a,1),6,1)-temp2a).^2));
    out2(3,i)=sum(sum((repmat(mean(temp2b,1),6,1)-temp2b).^2));
end
figure
scatter(out2(1,:),mean(out2(2:3,:),1))
xlabel('Distance between means')
ylabel('Average distance within cluster')
gname([1:1000])

figure
scatter(out1(1,:),mean(out1(2:3,:),1))
xlabel('Distance between means')
ylabel('Average distance within cluster')
gname([1:1000])

figure
cluster1(:,1,1)=temp1a_names(:,129);
cluster1(:,2,1)=temp1b_names(:,129);
cluster1(:,1,2)=temp1a_names(:,42);
cluster1(:,2,2)=temp1b_names(:,42);

cluster2(:,1,1)=temp2a_names(:,111);
cluster2(:,2,1)=temp2b_names(:,111);
cluster2(:,1,2)=temp2a_names(:,344);
cluster2(:,2,2)=temp2b_names(:,344);

figure
for i=1:2
subplot(2,6,1+(i-1)*6)
imshow(ims{cluster1(1,i,1)})
title(num2str(cluster1(1,i,1)))
subplot(2,6,2+(i-1)*6)
imshow(ims{cluster1(2,i,1)})
title(num2str(cluster1(2,i,1)))
subplot(2,6,3+(i-1)*6)
imshow(ims{cluster1(3,i,1)})
title(num2str(cluster1(3,i,1)))
subplot(2,6,4+(i-1)*6)
imshow(ims{cluster1(4,i,1)})
title(num2str(cluster1(4,i,1)))
subplot(2,6,5+(i-1)*6)
imshow(ims{cluster1(5,i,1)})
title(num2str(cluster1(5,i,1)))
subplot(2,6,6+(i-1)*6)
imshow(ims{cluster1(6,i,1)})
title(num2str(cluster1(6,i,1)))
end
k=2;
figure
for i=1:2
subplot(2,6,1+(i-1)*6)
imshow(ims{cluster1(1,i,k)})
title(num2str(cluster1(1,i,k)))
subplot(2,6,2+(i-1)*6)
imshow(ims{cluster1(2,i,k)})
title(num2str(cluster1(2,i,k)))
subplot(2,6,3+(i-1)*6)
imshow(ims{cluster1(3,i,k)})
title(num2str(cluster1(3,i,k)))
subplot(2,6,4+(i-1)*6)
imshow(ims{cluster1(4,i,k)})
title(num2str(cluster1(4,i,k)))
subplot(2,6,5+(i-1)*6)
imshow(ims{cluster1(5,i,k)})
title(num2str(cluster1(5,i,k)))
subplot(2,6,6+(i-1)*6)
imshow(ims{cluster1(6,i,k)})
title(num2str(cluster1(6,i,k)))
end

figure
for i=1:2
subplot(2,6,1+(i-1)*6)
imshow(ims{cluster2(1,i,1)})
title(num2str(cluster2(1,i,1)))
subplot(2,6,2+(i-1)*6)
imshow(ims{cluster2(2,i,1)})
title(num2str(cluster2(2,i,1)))
subplot(2,6,3+(i-1)*6)
imshow(ims{cluster2(3,i,1)})
title(num2str(cluster2(3,i,1)))
subplot(2,6,4+(i-1)*6)
imshow(ims{cluster2(4,i,1)})
title(num2str(cluster2(4,i,1)))
subplot(2,6,5+(i-1)*6)
imshow(ims{cluster2(5,i,1)})
title(num2str(cluster2(5,i,1)))
subplot(2,6,6+(i-1)*6)
imshow(ims{cluster2(6,i,1)})
title(num2str(cluster2(6,i,1)))
end
k=2;
figure
for i=1:2
subplot(2,6,1+(i-1)*6)
imshow(ims{cluster2(1,i,k)})
title(num2str(cluster2(1,i,k)))
subplot(2,6,2+(i-1)*6)
imshow(ims{cluster2(2,i,k)})
title(num2str(cluster2(2,i,k)))
subplot(2,6,3+(i-1)*6)
imshow(ims{cluster2(3,i,k)})
title(num2str(cluster2(3,i,k)))
subplot(2,6,4+(i-1)*6)
imshow(ims{cluster2(4,i,k)})
title(num2str(cluster2(4,i,k)))
subplot(2,6,5+(i-1)*6)
imshow(ims{cluster2(5,i,k)})
title(num2str(cluster2(5,i,k)))
subplot(2,6,6+(i-1)*6)
imshow(ims{cluster2(6,i,k)})
title(num2str(cluster2(6,i,k)))
end