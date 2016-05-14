function Dp = dissimilarityNormalize( D )

[n,~,p] = size(D);
Dp = zeros(n,n,p);

for j = 1:p

    Sum = zeros(n,1);
    for h=1:n, Sum(h) = sum( D(:,h,j) );  end
    [~,l] = min(Sum);

    Theta = sum(D(:,l,j));
    Dp(:,:,j) = D(:,:,j)./Theta;

end

end

