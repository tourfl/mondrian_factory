% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

clear all; close all

%% Data

load data/Land_exp_data.mat

experiments = {'gray', 'red', 'blue', 'green', 'yellow'};

xyz_Land = [5.8 3.2 1.6];
xyz_Gray = [3.83481686033628 2.63186762910496 1.10341406138189];

magnituds_gray = [17.393 9.484 4.785];
magnituds_red = [9.4593 23.743 7.5575];
magnituds_blue = [31.317 10.119 3.1025];
magnituds_green = [30.469 7.2645 7.102];
magnituds_yellow = [8.591 5.7225 15.552];

magnituds_matching_xyz_Land = containers.Map(experiments, {magnituds_gray, magnituds_red, magnituds_blue, magnituds_green, magnituds_yellow})

%% Parameters

experiment = 'yellow'
label = labels(experiment)
magnituds = magnituds_matching_xyz_Land(experiment)  % magnitudes of L, M and S illuminants
xyz = xyz_Land

%% Adjusting the Tristimulus values

ref = get_independant_reflectances(label, magnituds)

dif = xyz - ref
ratio = xyz./ref

%% add new data to file

save('data/illuminations.mat', 'magnituds_matching_xyz_Land', '-append')