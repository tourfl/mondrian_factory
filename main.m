% author: Raph
% date: 29 May 2017

clear all, close all

%% Init

% parameters
space = 'HDR'  % color space, RGB, LMS or HDR (this last case is particular)
shape = 'Land'
solution = 4  % out of 5 possibilities

figs_on = false  % show or not figures
save_on = true  % save or not images
stat_on = true

% Loading the variable "experiments" that contains the label of the experiments
filename_basics = 'data/basics.mat';
load(filename_basics);

% creating the Mondrian builder
builder = MondrianBuilder(space, solution, shape);

%% Experiments - change illumination & recreate perceived Mondrian

for experiment = experiments
	builder.run(experiment{1});

	if save_on, builder.save_current(); end
	if figs_on, builder.showInputs(); end
	if stat_on, builder.stats(); end
end