function ran = ranks(a)

[maxr,maxcol] = size(a);
ran = zeros(size(a));

for i = 1:maxcol
    [~, rr] = sort(a(:,i)); [~, b2] = sort(rr);
    for j = 1 : maxr % check for ties
        inr = a(:,i) == a(j,i);
        b2(inr) = mean(b2(inr));
    end
    ran(:,i) = b2;
end


end


