%% A multi-view relational fuzzy c-medoid vectors clustering algorithm
% mfeat-fac, mfeat-fou, mfeat-kar

%% Initialization
clear ; close all; clc

%% load data

n = 100;
% X = importfile('db/mfeat-fac', 1, n);
% X = importfile('db/mfeat-fou', 1, n);
% X = importfile('db/mfeat-kar', 1, n);
X1 = load('db/mfeatfac.mat','X'); X1 = X1.X(1:n,:);
X2 = load('db/mfeatfou.mat','X'); X2 = X2.X(1:n,:);
X3 = load('db/mfeatkar.mat','X'); X3 = X3.X(1:n,:);

D = zeros(n,n,3);
for i=1:n
for j=i:n
    D(i,j,1) = sum((X1(i,:) - X1(j,:)).^2).^0.5; D(j,i,1) = D(i,j,1);
    D(i,j,2) = sum((X2(i,:) - X2(j,:)).^2).^0.5; D(j,i,2) = D(i,j,2);
    D(i,j,3) = sum((X3(i,:) - X3(j,:)).^2).^0.5; D(j,i,3) = D(i,j,3);
end
end

K = 10; m = 1.6; T = 150; e = 10e-10;
[ G, Lambda, U, J ] = MVFCMddV( D, K, m, T, e );





