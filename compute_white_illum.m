
%% Init

space = 'RGB'
solution = 1
experiment = 'gray'

% Loadings

load(['data/' space '_sensor.mat']);


cmf = sensor(:, 2:4)';
gss = [normpdf([1:331], 241,4.5); normpdf([1:331],141,4.5); normpdf([1:331],61,4.5)];

A = cmf*gss'

magnituds = inv(A)*ones(3, 1)