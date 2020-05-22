clear; clc; close all;

%% 多次运行，取误差最小那次的结果
load data.mat;
X = X.';
[M,N] = size(X);

K = 4;
nRun = 10;
WCSS = zeros(1,nRun);
Center = zeros(M,K,nRun);
Label = zeros(N,nRun);

for i = 1:nRun
[center, label, wcss] = kmeans(X,K);
WCSS(i) = wcss;
Center(:,:,i) = center;
Label(:,i) = label;
end

[wcss,iRun] = min(WCSS);
center = Center(:,:,iRun);
label = Label(:,iRun);

%% 聚类结果
colors = {'#0072BD','#D95319','#EDB120','#7E2F8E','#77AC30','#4DBEEE','#A2142F'};
colors = colors(1:K);

figure(1)
for k = 1:K
    index = find(label == k);
    cluster = X(:,index);
    
    plot(cluster(1,:),cluster(2,:),'o','Color', colors{k},'MarkerSize',5)
    hold on
    plot(center(1,k),center(2,k),'x','Color', colors{k},'MarkerSize',12,'LineWidth',4)
end
xlabel('x_1')
ylabel('x_2')
title(['K = ', num2str(K)])

%% 运行次数与误差
figure(2)
plot(1:nRun,WCSS,'--s')
xlabel('运行次数')
ylabel('平方误差 WCSS')