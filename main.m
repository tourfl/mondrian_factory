% author: Raph
% date: 29 May 2017

clear all, close all

%% Parameters

space = 'RGB'
shape = 'Land'
illum = 1  % out of 4 possibilities
correction = @gamma_cor  %TODO

figs_on = 0  % show or not figures
save_on = 1  % save or not images

%% Loading data
filename_basics = 'data/basics.mat';
filename_shape = ['data/shape/', shape, 'shape.mat'];
filename_illum = ['data/illum/illum' num2str(illum) '_' space '.mat'];

load(filename_basics), load(filename_shape), load(filename_illum)

%% Various things

gamma_corr  = 1.0/2.2;  % to achieve Gamma correction - i.e. better quantization in the darker areas because the VHS is more sensitive to change in thoses values

rescale = rescale_illum  % or rescale_illum

% construct the path
path_images = ['../images/', space, '/solution', num2str(illum), '/'];

illums = Magnituds;

%% Experiments - change illumination & recreate perceived Mondrian

for experiment = experiments
	experiment=experiment{1}

	I = get_mondrian(rescale*illums(experiment), shape, base_color_labels, space);
	Ipc = get_mondrian(rescale*illums('gray'), shape, color_labels(experiment), space);

	mx = max(I(:))

	if figs_on
		figure(30+figure_indx(experiment)), imshow(I)
		coordinates = ref_color_coordinates(experiment);
		hold on, plot(coordinates(1), coordinates(2), '*k')
		pause(0.1), title([experiment, 'exp, illum', num2str(illum), ' ', space])

		figure(40+figure_indx(experiment)), imshow(Ipc)
		pause(0.1), title([experiment, 'pcp, illum', num2str(illum), ' ', space])
	end

	if save_on
		mkdir(path_images);

		filename_exp = [path_images, experiment, 'exp_s', num2str(illum), '_', space, '_corrected.png'];
		filename_pcp = [path_images, experiment, 'pcp_s', num2str(illum), '_', space, '.png'];
		imwrite(I.^gamma_corr, filename_exp);  % gamma corrected as input of the vce algo
		imwrite(Ipc, filename_pcp);
	end

end