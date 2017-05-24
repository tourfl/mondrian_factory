% author: Raphael Dein
% date:   May 17 2017

%% designing the Mondrian

illum_white = [1.68, 1.9, 1.31];
% illum_gray = [1 5.2 2.2];

% color labels in a cell array; there are some modification in A, K, L and P
clab_white_illum = {'N 6/', '5YR 5/6', '5Y 8.5/10', '2.5BG 6/6', '7.5GY 6/6', '5R 5/12', '10RP 6/10', '2.5PB 6/8', '5GY 8.5/8', '10RP 3/6', 'N 9/', 'N 2.5/', '2.5YR 7/10', '5Y 7/8', '2.5B 8/4', 'N 7/', '5P 7/6', '2.5G 7/6'};

[I, Irgb] = get_mondrian_shape_1(illum_white, clab_white_illum);

%% Change illumination by applying Von Kries'rule

% Get gray lms values

graylms = I(242, 242, :);

% Red Experiment

Ired = I.*graylms./I(97, 183, :);
mx = max(Ired(:));
Ired = Ired./mx;

% Blue Expriment

Iblue = I.*graylms./I(124, 64, :);
mx = max(Iblue(:));
Iblue = Iblue./mx;

% Green Experiment

Igreen = I.*graylms./I(234, 119, :);
mx = max(Igreen(:));
Igreen = Igreen./mx;

% Yellow Experiment

Iyellow = I.*graylms./I(62, 133, :);
mx = max(Iyellow(:));
Iyellow = Iyellow./mx;

%% Images show

figure(1), imshow(Irgb);
figure(2), subplot(221), imshow(Ired), hold on, plot(183, 97, '*k'), title('LMS in the red experiment')
subplot(222), imshow(Iblue), hold on, plot(64, 124, '*k'), title('blue exp')
subplot(223), imshow(Igreen), hold on, plot(119, 234, '*k'), title('green exp')
subplot(224), imshow(Iyellow), hold on, plot(133, 62, '*k'), title('yellow exp')

%% Recreate perceived Mondrian

