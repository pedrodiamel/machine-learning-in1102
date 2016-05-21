

clear ; close all; clc
run('addPathToKernel');


p0 = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1];
p1 = [6, 6, 6, 6, 6, 7, 7, 7, 7, 7];
p0 = expandcol(p0,2);
p1 = expandcol(p1,7);

result = ajustedRandIndex(p0, p1);
test('ajustedRandIndex-t1', result, 1.0);

p0 = [0, 0, 0, 0, 4, 4, 4, 4, 8, 9];
p1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
p0 = expandcol(p0,10);
p1 = expandcol(p1,10);

result1 = ajustedRandIndex(p0, p1);
result2 = ajustedRandIndex(p1, p0);
test('ajustedRandIndex-t2', result1, result2);

Tc = [1 1 0; 1 2 1; 0 0 4]; % 0.313
result = ajustedRandIndex(Tc);
test('ajustedRandIndex-t3', result, 0.313);

Tc = [55 1 1 1; 10 76 1 1; 3 2 26 1; 6 2 4 45]; %0.663
result = ajustedRandIndex(Tc);
test('ajustedRandIndex-t4', result, 0.663);

Tc = [ 1 1 2 54; 1 73 4 10; 2 1 3 26; 45 0 2 10];  % 0.519
result = ajustedRandIndex(Tc);
test('ajustedRandIndex-t5', result, 0.519);



