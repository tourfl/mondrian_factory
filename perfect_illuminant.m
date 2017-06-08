% In order to exactly respect McCann's illuminants
% i.e. to have a bandwidth of 10 nm at half-height

moy = 0;
std = 4.247;
mag = 1;
x = [-20:20];

illum = mag * normpdf(x, moy, std);
hhdot = max(illum(:))/2 * ones(size(x));

% Cost
cost = illum(16) - hhdot(16) 

% Plots
figure(81); plot(x, illum);
hold on, plot(x, hhdot);