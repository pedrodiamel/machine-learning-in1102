function trai = gettraining( pvt, i)

k = pvt.NumTestSets;
iter = pvt.idx;

tes = (iter == i);
val = (iter == (mod(i,k)+1));

trai = ~(val|tes);
trai = pvt.mat_part(:,trai);
trai = sum(trai,2)>=1;

end

