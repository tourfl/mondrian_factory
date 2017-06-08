% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

%% Loading data

load data/Land_exp_data.mat

experiments = {'gray', 'red', 'blue', 'green', 'yellow'};

%% Parameters

experiment = 'gray'

label = labels(experiment)

magnituds = magnituds_Land(experiment)  % magnitudes of L, M and S illuminants

%% Adjusting the Tristimulus values

xyz_Land = [5.8 3.2 1.6];

xyz = xyz_Land

ref = get_independant_reflectances(label, magnituds)

dif = xyz - ref
ratio = xyz./ref