function val = getvalidation( pvt, i )

k = pvt.NumTestSets;
iter = pvt.idx;
val = (iter == (mod(i,k)+1));
val = pvt.mat_part(:,val);

end

