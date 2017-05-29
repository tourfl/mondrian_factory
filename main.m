% author: Raph
% date: 29 May 2017

%% Loading data

load('data/mondrian_shape_and_colors.mat');

[I, Irgb] = get_mondrian(illum_white, shape_Land, clab_white_illum);

figure(1), imshow(Irgb);