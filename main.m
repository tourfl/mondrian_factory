% author: Raphael Dein
% date:   May 17 2017

%% Loading the data

load('data/munsell380_800_1.mat')
cones_answer = csvread('data/ss2_10q_1.csv');

%% designing the Mondrian

% 8-by-8-by-3 color pattern matrix

P = ones(8, 8, 3);

% only square structure
%TODO

% From pattern to true image
I = .5*ones(300, 300, 3);  % gray background for the surround
I(51:250, 51:250, :) = imresize(P, 25, 'nearest');

% Show image
figure(1); imshow(I)





