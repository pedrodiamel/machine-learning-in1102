function [ X,Y ] = generateRandNormData( N )
%GENERATERANDNORMDATA: Summary of this function goes here
%   Detailed explanation goes here

MU = [0 4; -5 -0; 5 -2];
SIGMA = cat(3,[2 0; 0 1], [1 0; 0 1], [1 0; 0 2]);
M = 3;

Y = repelem(1:M,N)'; 
X = zeros(M*N,2);
for i = 1:M  
X(Y==i,:) = mvnrnd(MU(i,:),SIGMA(:,:,i),N);  
end

end