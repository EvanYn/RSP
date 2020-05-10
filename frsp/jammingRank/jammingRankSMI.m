clear; clc; close all;

%%
N = 16;
dl = 1/2;

phi_j = [-30 30 60];
xi_j = [10 20 30];
J = length(phi_j);

fsp_j = dl*sind(phi_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

Rj = Aj*diag(db2pow(xi_j))*Aj';
R = Rj + eye(N);

%%
[V, D] = eig(R);
[eigval, I] = sort(abs(diag(D)),'descend');

figure(1)
plot(db(abs(eigval),'power'),'--s')
hold on

%%
samples = N*[1 2 5];
nRun = 1000;
RSMI = zeros(N,N,nRun);

for iSample = 1:length(samples)
    Ke = samples(iSample);
    
    for iRun = 1:nRun
        Chi = zeros(N,Ke);
        
        for l = 1:Ke
            chi_n = randn(N,1);
            
            alpha_j = db2mag(xi_j).*(randn(1,J) + 1j*randn(1,J))*sqrt(1/2);
            chi_j = Aj*alpha_j.';
            
            Chi(:,l) = chi_j + chi_n;
        end
        
        meanChi = 1/Ke*sum(Chi,2);
        Rsmi = 1/Ke*(Chi*Chi') - (meanChi*meanChi');
        
        RSMI(:,:,iRun) = Rsmi;
    end
    
    Rsmi = mean(RSMI,3);
    [V, D] = eig(Rsmi);
    [eigval, I] = sort(abs(diag(D)),'descend');
    
    plot(db(abs(eigval),'power'),'--s')
end

xlabel('index')
ylabel('eigen value (dB)')
xlim([1 16])
grid on
title('eigen spectrum of interference covariance matirx')
legend('known covariance matrix','Ke = N','Ke = 2N','Ke = 5N')