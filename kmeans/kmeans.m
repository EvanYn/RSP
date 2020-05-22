function [Mu, Lambda, WCSS] = kmeans(X, K)
%KMEANS 将样本集 X 中的 N 个样本划分为 K 个聚类
% 输入：X - M*N 的样本矩阵（M 为样本维数，N 为样本个数）
%      K - 聚类簇数
% 输出：Mu - K 个的聚类中心
%      Lambda - 簇标记
%      WCSS - within-cluster sum of squares

[M,N] = size(X);

% 初始化聚类中心
randIdx = randperm(N,K);

Mu = X(:,randIdx);
Lambda = zeros(K,1);
WCSS = 0;

stop = false;
iteration = 0;
iterationMax = 20;

% 循环开始
while(stop == false && iteration < iterationMax)
    % 将每个样本划分到距其最近的聚类中心所对应的类中
    for n = 1:N
        dist = zeros(1,K);
        for k = 1:K
            dist(k) = norm(X(:,n) - Mu(:,k));
        end
        [~, Lambda(n)] = min(dist);
    end
    
    % 计算每个类新的聚类中心
    MuNew = zeros(M,k);
    for k = 1:K
        MuNew(:,k) = mean(X(:,Lambda == k),2);
    end
    
    % 更新聚类中心或停止循环
    if norm(Mu - MuNew) > 1e-6  % 即 Mu 不等于 MuNew
        Mu = MuNew;
    else
        stop = true;
    end
    
    iteration = iteration + 1;
end

% 计算 WCSS
for k = 1:K
    idx = find(Lambda == k);
    nIdx = length(idx);
    
    for i = 1:nIdx
        WCSS = WCSS + norm(X(:,idx(i)) - Mu(:,k))^2;
    end
end

fprintf('kmeans.m 迭代了 %-2d 次, WCSS = %.2f\n', iteration, WCSS);
end