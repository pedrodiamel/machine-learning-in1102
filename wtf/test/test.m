function b = test( name, result, expected )
% b=test(name,result,expected)

b = (result - expected) < 0.001;
if b
fprintf('%s: succeed \n', name);
else
fprintf('%s: faild \n', name);  
end

end