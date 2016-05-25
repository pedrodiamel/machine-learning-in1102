%% PROJETO AM 2016-1
% =========================================================================  
%  In this script will use MVFCMddV to compress an image aplication. To do 
%  this, you will first run MVFCMddV on the RGB colors subspace and Lac 
%  color subspace of the pixels in the image and then you will map each 
%  pixel on to it's closest centroid.
%

%% Initialization
clear ; close all; clc
run('addPathToKernel');

fprintf('Projeto AM 2016-1 ... \n');
fprintf('Running the image compress application ... \n');

%% Load 
fprintf('Load image.\n');

%  Load an image of a bird
A = double(imread('../db/bird_small.png'));
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

% Size of the image
img_size = size(A);

% Reshape the image into an Nx3 matrix where N = number of pixels.
Xrgb = reshape(A, img_size(1) * img_size(2), 3); % RGB space
XLac = rgb2lab(Xrgb); % Lac space

% Create data for multiple signal 
p = 2; % number the signal
X = cat(3,Xrgb,XLac);
n = size(X,1);

%% Calculate Dissimilarity Matrix
fprintf('Calculate Dissimilarity Matrix ... \n');

D = zeros(n,n,p);
for i=1:p
D(:,:,i) = pdist2(X(:,:,i),X(:,:,i));
end

% normalize matrix
D = dissimilarityNormalize( D );


%% Run your MVFCMddV algorithm on this data
% You should try different values of K and max_iters here
fprintf('Fuzzy c-medoids ... \n');

K = 32; 
m = 1.1;        % paramaetro m    
T = 5;         % numero de iteraciones
e = 1e-10;      % umbral
[ G, Lambda, U, J, Jt, Gt ] = MVFCMddV(D, K, m, T, e );

% hard partition 
Q  = hardClusters(U);


%% Image Compression
%  Will use the clusters of MVFCMddV to compress an image. To do this, we 
%  first find the closest clusters for each example. After that, we 

fprintf('Applying MVFCMddV to compress an image.\n');

% Find closest cluster members
idx = vec2ind(Q')';

% Recontruction in RGB color space
centroids = Xrgb(G(:,1),:);

% Essentially, now we have represented the image X as in terms of the
% indices in idx. 

% We can now recover the image from the indices (idx) by mapping each pixel
% (specified by it's index in idx) to the centroid value
X_recovered = centroids(idx,:);

% Reshape the recovered image into proper dimensions
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% Display the original image 
subplot(1, 2, 1);
imagesc(A); 
title('Original');

% Display compressed image side by side
subplot(1, 2, 2);
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));


