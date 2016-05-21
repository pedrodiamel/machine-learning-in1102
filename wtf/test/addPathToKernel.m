% Adicionar al path la direcci�n del kernel, de esta manera se podr�n
% direccionar todas las funciones. 

% pathKernel  = getenv('CCHART_DIR');
% pathKernel = '<dir absolute>'

kernel = 'Kernel';
[fileDir,script,ext] = fileparts(mfilename('fullpath'));
file = 'test';
N = length(fileDir) - length(file) - 1;
pathKernel = [fileDir(1:N) filesep kernel];

addpath(genpath(pathKernel));