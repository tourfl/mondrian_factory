% author: Raph
% date: 29 May 2017

clear all, close all

%% Loading data

load data/mondrian_shape_and_colors.mat;
load data/illuminations.mat;

%% Parameters

figs_on = 0;  % show or not figures
save_on = 1;  % save or not images

image_dir = '../images/';

experiments = {'gray', 'red', 'blue', 'green', 'yellow'};
figure_indx = containers.Map(experiments, 1:5);

gamma_corr  = 1.0/2.2;  % to achieve Gamma correction - i.e. better quantization in the darker areas because the VHS is more sensitive to change in thoses values

% Illuminations - THE point, computed in illumination_adjustment.m

rescale_illum = 1/9.4093

% illums = containers.Map(experiments, {illum_white, illum_red, illum_blue, illum_green, illum_yello});  % explicit coding
illums = magnituds_matching_xyz_Land;


%% Experiments - change illumination & recreate perceived Mondrian

for experiment = experiments

	[I, ~] = get_mondrian(rescale_illum*illums(experiment{1}), shape_Land, base_color_labels);
	[Ipc, ~] = get_mondrian(rescale_illum*illums('gray'), shape_Land, color_labels(experiment{1}));

	mx = max(I(:))

	if figs_on
		figure(30+figure_indx(experiment{1})), imshow(I), title([experiment{1}, ' exp - no gamma correction'])
		coordinates = ref_color_coordinates(experiment{1});
		hold on, plot(coordinates(1), coordinates(2), '*k')
		figure(40+figure_indx(experiment{1})), imshow(Ipc), title('perceived')
	end

	if save_on
		imwrite(I.^gamma_corr, [image_dir, experiment{1}, '_exp.png'])  % gamma corrected as input of the vce algo
		imwrite(Ipc, [image_dir, experiment{1}, '_perceived.png'])
	end

end