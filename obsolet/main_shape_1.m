% author: Raphael Dein
% date:   May 17 2017

%% Meta

figures_on = 0;  % show or not figures
savings_on = 1;  % save or not images

image_dir = '../images/';

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

% Images show

if figures_on
	figure(1), imshow(Irgb);
	figure(2), subplot(221), imshow(Ired), hold on, plot(183, 97, '*k'), title('LMS in the red experiment')
	subplot(222), imshow(Iblue), hold on, plot(64, 124, '*k'), title('blue exp')
	subplot(223), imshow(Igreen), hold on, plot(119, 234, '*k'), title('green exp')
	subplot(224), imshow(Iyellow), hold on, plot(133, 62, '*k'), title('yellow exp')
end

%% Recreate perceived Mondrian

% From Grey Exp

clab_greyxp = {'10YR 6/1', '5YR 5/8', '5Y 8.5/12', '5BG 6/6', '5GY 6/6', '7.5R 5/12', '2.5R 6/10', '2.5PB 6/8', '2.5GY 8/10', '5R 4/6', '10R 9/2', 'N 2.5/', '2.5YR 7/10', '2.5Y 7/8', '7.5B 8/4', '5YR 6/1', '10P 7/6', '10GY 7/6'};

[Igreyprc, ~] = get_mondrian_shape_1(illum_white, clab_greyxp);

% From Red Exp

clab_redexp = {'7.5G 6/2', '2.5Y 5/4', '10Y 9/10', '7.5G 7/4', '7.5GY 7/8', '7.5R 5/8', '5R 6/6', '10B 7/6', '5GY 8/10', '10R 4/4', '5G 9/1', 'N 2.5/', '10YR 7/6', '2.5GY 7/8', '7.5BG 8/4', '10G 7/1', '7.5PB 8/4', '10GY 8/6'};

[Iredperc, ~] = get_mondrian_shape_1(illum_white, clab_redexp);

% From Blue Exp

clab_bluexp = {'5YR 6/1', '5YR 6/10', '2.5Y 8/12', '7.5G 6/4', '2.5GY 6/6', '7.5R 5/12', '5R 6/10', '2.5PB 6/4', '10Y 8.5/10', '5R 4/8', '2.5YR 9/2', 'N 2.5/', '2.5YR 6/12', '2.5Y 7/10', '2.5B 8/2', '5YR 6/1', '5RP 8/6', '7.5GY 8/6'};

[Iblueprc, ~] = get_mondrian_shape_1(illum_white, clab_bluexp);

% From Green Exp

clab_greenx = {'5RP 5/2' '2.5YR 5/8', '10YR 8/10' '5B 6/4' '2.5GY 6/4', '7.5R 5/12', '2.5R 5/12', '7.5PB 5/10', '7.5Y 8/10', '5R 4/8' '7.5RP 8/4', 'N 2.5/' '2.5YR 7/12', '10YR 7/10' '5PB 8/4' '7.5RP 6/2', '10P 7/8' '10GY 7/4'};

[Igreenpc, ~] = get_mondrian_shape_1(illum_white, clab_greenx);

% From Yellow Exp

clab_yellow = {'10PB 5/4' '5YR 4/6' '5Y 8/8' '7.5B 6/6', '10GY 5/4' '7.5R 4/12', '5RP 6/10' '7.5PB 5/12', '5GY 8/6' '5RP 3/6' '2.5P 8/4', 'N 2.5/' '2.5YR 6/10', '10YR 7/8' '5PB 7/6' '10PB 6/4' '2.5P 7/8', '2.5BG 7/4'};

[Iyellop, ~] = get_mondrian_shape_1(illum_white, clab_yellow);

% Plots

if figures_on
	figure(31), subplot(121), imshow(I), title('grey exp'), hold on, plot(240, 241, '*k'), subplot(122), imshow(Igreyprc), title('perceived')
	figure(32), subplot(121), imshow(Ired), title('red exp'), hold on, plot(183, 97, '*k'), subplot(122), imshow(Iredperc), title('perceived')
	figure(33), subplot(121), imshow(Iblue), title('blue exp'), hold on, plot(64, 124, '*k'), subplot(122), imshow(Iblueprc), title('perceived')
	figure(34), subplot(121), imshow(Igreen), title('green exp'), hold on, plot(119, 234, '*k'), subplot(122), imshow(Igreenpc), title('perceived')
	figure(35), subplot(121), imshow(Iyellow), title('yellow exp'), hold on, plot(133, 62, '*k'), subplot(122), imshow(Iyellop), title('perceived')
end

% Saving images

if savings_on
	imwrite(I, strcat(image_dir, 'mondrian_base.png'))
	imwrite(Igreyprc, strcat(image_dir, 'grey_perceived.png'))
	imwrite(Ired, strcat(image_dir, 'red_experiment.png'))
	imwrite(Iredperc, strcat(image_dir, 'red_perceived.png'))
end

