function D = getDissimilarityMatrix( X )

n = size(X,1); 
D = zeros(n);

for i=1:n
    for j=i:n
        D(i,j,1) = sum((X(i,:) - X(j,:)).^2).^0.5; D(j,i) = D(i,j);
    end
end

end