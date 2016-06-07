
clear ; close all; clc
run('addPathToKernel');

% global dir
path_in_db = '../db/';
path_out = '../out/';

% signal load file
% 1. mfeat-fou: 76 Fourier coefficients of the character shapes; 
% 2. mfeat-fac: 216 profile correlations;  ***
% 3. mfeat-kar: 64 Karhunen-Loève coefficients; *** 
% 4. mfeat-pix: 240 pixel averages in 2 x 3 windows; (15x16)
% 5. mfeat-zer: 47 Zernike moments; 
% 6. mfeat-mor: 6 morphological features. ***

n=2000;
% X1 = load([path_in_db 'mfeatfac.mat'],'X'); X1 = X1.X(1:n,:); 
% X2 = load([path_in_db 'mfeatfou.mat'],'X'); X2 = X2.X(1:n,:); 
% X3 = load([path_in_db 'mfeatkar.mat'],'X'); X3 = X3.X(1:n,:); 
X4 = load([path_in_db 'mfeatpix.mat'],'X'); X4 = X4.X(1:n,:); 
% X5 = load([path_in_db 'mfeatzer.mat'],'X'); X5 = X5.X(1:n,:); 
% X6 = load([path_in_db 'mfeatmor.mat'],'X'); X6 = X6.X(1:n,:); 


% X = importfile([path_in_db 'mfeat-mor']);
% I = X4(:,1); I = reshape(I,15,16);
% imshow(I,[])

X = X4(1:50:2000,:);
displayData(X, 16)



