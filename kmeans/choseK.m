clear; clc; close all;

%% 
load data.mat;
X = X.';
[M,N] = size(X);

Ks = [1 2 3 4 5 6 7];
nKs = length(Ks);
perf = zeros(nKs,1);

for i = 1:nKs
    K = Ks(i);
    fprintf('\nK = %d\n',K)
    
    nRun = 10;
    WCSS = zeros(1,nRun);
    
    for iRun = 1:nRun
        [~, ~, wcss] = kmeans(X,K);
        WCSS(iRun) = wcss;
    end
    
    [perf(i),~] = min(WCSS);
    
end

%% 
plot(Ks,perf,'--s')
xlabel('迭代次数')
ylabel('平方误差 WCSS')
