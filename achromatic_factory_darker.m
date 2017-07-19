close all
% clear all

% add very dark achromatic values to Munsell book, like N 1.75/

load data/munsell380_800_final.mat

%% find darker achromatic already existing

index = find(contains(S, 'N 2.5/'));
achro = S(index,:);
achro(:, 1:2) = [];

my_alpha = 1.5;

alpha = str2num(erase(achro(1, :), '/'));

reflects = munsell(:, index);  % get every spectrum answers of hue with right value

new_ref = (my_alpha/alpha)*reflects;  % simple operation

reflects(:, end+1) = new_ref;

%% plots

[~, sz] = size(reflects);

figure(62), hold on, set(62, 'Position', [200 600 1000 500])
plot(380:800, reflects(:, 1))

plot(380:800, reflects(:, end), ':k')
legend(num2str(alpha), [num2str(my_alpha) ' - estimated'])
xlim([380 800]), xlabel('wavelength (nm)'), ylabel('energy')

% munsell2(:,end+1) = new_ref;  % must have been created
% S2(end+1, 1:6) = ['N ', num2str(my_alpha), '/'];