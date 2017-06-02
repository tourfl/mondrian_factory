% author: Raph
% date: 29 May 2017


%% Loading data

load data/mondrian_shape_and_colors.mat;
load data/illumination_matching_Land_Exp.mat;

%% Parameters

figs_on = 1;  % show or not figures
save_on = 1;  % save or not images

image_dir = '../images/';

experiments = {'gray', 'red', 'blue', 'green', 'yellow'};
figure_indx = containers.Map(experiments, 1:5);

gamma_corr  = 1.0/2.2;  % to achieve Gamma correction - i.e. better quantization in the darker areas because the VHS is more sensitive to change in thoses values

% Illuminations - THE point, computed in illumination_adjustment.m

% so that gray appears gray in RGB
illum_white =[1.68, 1.9, 1.31];
illum_red =  [1 1 1];
illum_blue = [1 1 1];
illum_green = 0.948*[3.2, 1.579, 2.107];
illum_yello = [1 1 1];

illums = containers.Map(experiments, {illum_white, illum_red, illum_blue, illum_green, illum_yello});  % explicit coding


%% Experiments - change illumination & recreate perceived Mondrian

for experiment = experiments

	[I, ~] = get_mondrian(illums(experiment{1}), shape_Land, base_color_labels);
	[Ipc, ~] = get_mondrian(illums('gray'), shape_Land, color_labels(experiment{1}));

	max(I(:))

	if figs_on
		figure(30+figure_indx(experiment{1})), subplot(121), imshow(I), title([experiment{1}, ' exp - no gamma correction'])
		coordinates = ref_color_coordinates(experiment{1});
		hold on, plot(coordinates(1), coordinates(2), '*k')
		subplot(122), imshow(Ipc), title('perceived')
	end

	if save_on
		imwrite(I.^gamma_corr, [image_dir, experiment{1}, '_exp.png'])  % gamma corrected as input of the vce algo
		imwrite(Ipc, [image_dir, experiment{1}, '_perceived.png'])
	end

end