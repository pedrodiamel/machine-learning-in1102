function [ X,Y ] = generateRandNormData( N )
%GENERATERANDNORMDATA: Summary of this function goes here
%   Detailed explanation goes here

MU = [2 2; -2 -1; 7 -1];
SIGMA = cat(3,[2 0; 0 1], [1 0; 0 1], [1 0; 0 2]);
M = 3; 

X = zeros(M*N,2); Y = zeros(M*N,1); idx = 1:N;
for i = 1:M    
X(idx(:) + (i-1)*N,:) = mvnrnd(MU(i,:),SIGMA(:,:,i),N);
Y(idx(:) + (i-1)*N) = (ones(1,N)*i)';    
end

end