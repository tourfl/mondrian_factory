close all
% clear all

% add precise achromatic values to Munsell book, like N 5.75/

load data/munsell380_800_final.mat

%% find every achromatic already existing

index = find(contains(S, 'N'));
achro = S(index,:);
achro(:, 1:2) = [];

my_alpha = 6.75;

for ind=1:size(achro)
	alphas(ind) = str2num(erase(achro(ind, :), '/'));
end

reflects = munsell(:, index);  % get every spectrum answers of hue with right value

new_ref = achromatic_mixer(my_alpha, alphas, reflects);  % mixing reflectances to get the good one

reflects(:, end+1) = new_ref;

%% plots

[~, sz] = size(reflects);

figure(62), hold on, set(62, 'Position', [200 600 1000 500])

for p=1:sz-1
	plot(380:800, reflects(:, p))
end

plot(380:800, reflects(:, end), ':k')
legend(num2str(alphas(1)), num2str(alphas(2)), num2str(alphas(3)), num2str(alphas(4)), num2str(my_alpha))

% munsell2(:,end+1) = new_ref;  % must have been created
% S2(end+1, 1:7) = ['N ', num2str(my_alpha), '/'];