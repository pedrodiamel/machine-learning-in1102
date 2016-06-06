function tes = gettest( pvt, i )

iter = pvt.idx;
tes = (iter == i);
tes = pvt.mat_part(:,tes);

end

