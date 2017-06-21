% author: Raph
% date: 29 May 2017

clear all, close all

%% Parameters

space = 'LMS'
shape = 'Land'
solution = 2  % out of 4 possibilities

figs_on = 0  % show or not figures
save_on = 1  % save or not images

%% Loading data
filename_basics = 'data/basics.mat';

load(filename_basics);  % to get the experiments list

%% Various things

gamma_corr  = 1.0/2.2;  % to achieve Gamma correction - i.e. better quantization in the darker areas because the VHS is more sensitive to change in thoses values

builder = MondrianBuilder(space, solution, shape);

%% Experiments - change illumination & recreate perceived Mondrian

for experiment = experiments
	experiment=experiment{1}

	[I, Ipc] = builder.run(experiment);

	mx = max(I(:))

	% if figs_on
	% 	figure(30+figure_indx(experiment)), imshow(I)
	% 	coordinates = ref_color_coordinates(experiment);
	% 	hold on, plot(coordinates(1), coordinates(2), '*k')
	% 	pause(0.1), title([experiment, 'exp, illum', num2str(illum), ' ', space])

	% 	figure(40+figure_indx(experiment)), imshow(Ipc)
	% 	pause(0.1), title([experiment, 'pcp, illum', num2str(illum), ' ', space])
	% end

	if save_on, builder.save_current(); end
	if figs_on, builder.plot_current(); end

end