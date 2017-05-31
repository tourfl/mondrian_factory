% author: Raph
% date: 29 May 2017

%% Parameters

figs_on = 1;  % show or not figures
save_on = 1;  % save or not images

image_dir = '../images/';

%% Loading data

load data/mondrian_shape_and_colors.mat;

%% Computing

illum_white = [1.68, 1.9, 1.31];

[Iwhite, Irgb] = get_mondrian(illum_white, shape_Land, clab_white_illum);

% Change illumination
% Recreate Perceived Mondrian

% Gray Exp
illum_gray 	= 0.2 * [16 8.74 4.415];  % values computed in illumination_exp.m

[I, ~] = get_mondrian(illum_gray, shape_Land, clab_white_illum);

[Igreyprc, ~] = get_mondrian(illum_white, shape_Land, clab_greyxp);

% Get gray lms values

graylms = I(123, 201, :);

% Red Experiment
illum_red = 0.1 * [9.46 23.74 7.56];

[Ired, ~] = get_mondrian(illum_red, shape_Land, clab_white_illum);
[Iredperc, ~] = get_mondrian(illum_white, shape_Land, clab_redexp);

% Blue Expriment

Iblue = I.*graylms./I(142, 81, :);
mx = max(Iblue(:)); Iblue = Iblue./mx;
[Iblueprc, ~] = get_mondrian(illum_white, shape_Land, clab_bluexp);

% Green Experiment

Igreen = I.*graylms./I(246, 82, :);
mx = max(Igreen(:)); Igreen = Igreen./mx;
[Igreenpc, ~] = get_mondrian(illum_white, shape_Land, clab_greenx);

% Yellow Experiment

Iyellow = I.*graylms./I(179, 190, :);
mx = max(Iyellow(:)); Iyellow = Iyellow./mx;
[Iyellop, ~] = get_mondrian(illum_white, shape_Land, clab_yellow);

% Plots

if figs_on
	figure(1), imshow(Irgb), title('RGB vision of the Mondrian')
	figure(31), subplot(121), imshow(I), title('grey exp'), hold on, plot(242, 167, '*k'), subplot(122), imshow(Igreyprc), title('perceived')
	figure(32), subplot(121), imshow(Ired), title('red exp'), hold on, plot(99, 182, '*k'), subplot(122), imshow(Iredperc), title('perceived')
	% figure(33), subplot(121), imshow(Iblue), title('blue exp'), hold on, plot(81, 142, '*k'), subplot(122), imshow(Iblueprc), title('perceived')
	% figure(34), subplot(121), imshow(Igreen), title('green exp'), hold on, plot(82, 246, '*k'), subplot(122), imshow(Igreenpc), title('perceived')
	% figure(35), subplot(121), imshow(Iyellow), title('yellow exp'), hold on, plot(190, 179, '*k'), subplot(122), imshow(Iyellop), title('perceived')
end

%% Saving

if save_on
	imwrite(I, strcat(image_dir, 'grey_exp.png'))
	imwrite(Igreyprc, strcat(image_dir, 'grey_perceived.png'))
	imwrite(Ired, strcat(image_dir, 'red_experiment.png'))
	imwrite(Iredperc, strcat(image_dir, 'red_perceived.png'))
end
