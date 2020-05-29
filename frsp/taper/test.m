clear; clc; close all;

%% 产生随机负向量
N = 16;
a = randn(N,1) + 1j*randn(N,1);
b = randn(N,1) + 1j*randn(N,1);
c = randn(N,1) + 1j*randn(N,1);
d = randn(N,1) + 1j*randn(N,1);

answer = zeros(7,1);
%% 內积
x = a'*b;
y = conj(b'*a);
answer(1) = norm(x - y);

x = (a'*b)*(c'*d);
y = a'*(b*c')*d;
answer(2) = norm(x - y);

x = (a*b')*c;
y = a*(b'*c);
answer(3) = norm(x - y);

%% 哈达玛积
x = (a.*b)*(c.*d)';
y = (a*c').*(b*d');
answer(4) = norm(x - y);

x = (a.*b)'*(a.*b);
y = (conj(a).*a)'*(conj(b).*b);
answer(5) = norm(x - y);

x = a'*(a.*b);
y = (conj(a).*a)'*b;
answer(6) = norm(x - y);

x = (a.*b)'*c;
y = a'*(conj(b).*c);
answer(7) = norm(x - y);

%% 判断所有等式是否成立
abs(sum(answer)) < 1e-12