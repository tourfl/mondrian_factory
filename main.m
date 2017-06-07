% author: Raph
% date: 29 May 2017


%% Loading data

load data/mondrian_shape_and_colors.mat;
load data/illuminations.mat;

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
illum_red =  0.605*[0.993, 5.161, 2.242];
illum_blue = 1.2102*[3.288, 2.2, 0.9205];
illum_green = 0.948*[3.2, 1.579, 2.107];
illum_yello = 0.4364*[0.902, 1.244, 4.612];

% illums = containers.Map(experiments, {illum_white, illum_red, illum_blue, illum_green, illum_yello});  % explicit coding
illums = illums_gray_appears_gray;


%% Experiments - change illumination & recreate perceived Mondrian

for experiment = experiments

	[I, ~] = get_mondrian(illums(experiment{1}), shape_Land, base_color_labels);
	[Ipc, ~] = get_mondrian(illums('gray'), shape_Land, color_labels(experiment{1}));

	max(I(:))

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