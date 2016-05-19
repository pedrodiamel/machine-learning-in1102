function D = dissimilarityMatrix( X )
% D=dissimilarityMatrix( X ), claculate of dissimilarity matrix for
% euclidian distance.
% @param X vector de rasgos X_i^j 
% @return D dissimilary matrix
% 
n = size(X,1); 
D = zeros(n);

for i=1:n
    for j=i:n
        % Euclidian diastance
        D(i,j,1) = sum((X(i,:) - X(j,:)).^2).^0.5; 
        % Simetric
        D(j,i) = D(i,j);
    end
end
end