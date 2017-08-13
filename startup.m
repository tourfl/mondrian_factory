mondrian_path = '~/Documents/MATLAB/'

addpath([mondrian_path 'personalized_tools/'])

setenv('LD_LIBRARY_PATH', strcat(getenv('LD_LIBRARY_PATH'), ':/usr/lib:/usr/local/lib:/lib'))  % updates shared library path

% warning off MATLAB:MKDIR:DirectoryExists

% Install HDR Toolbox
here = pwd;
cd ~/Documents/MATLAB/HDR_Toolbox/; installHDRToolbox
cd(here);