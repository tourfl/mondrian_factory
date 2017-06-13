% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

clear all; close all

%% Data

load data/illumination_Land_xyz.mat

magnituds_gray = [11.5000    7.8000    3.3000];
magnituds_red = [6.2542 19.5275 5.21];
magnituds_blue = [20.706 8.3222 2.138];
magnituds_green = [20.1455 5.9745 4.9];
magnituds_yellow = [5.6801 4.7065 10.725];

current_magnituds = containers.Map(experiments, {magnituds_gray, magnituds_red, magnituds_blue, magnituds_green, magnituds_yellow})

%% Parameters

solution = label_solution
experiment = 'yellow'
label = labels(experiment)
magnituds = Magnituds(experiment)  % magnitudes of L, M and S illuminants
myxyz = xyz

%% Adjusting the Tristimulus values

ref = get_independant_reflectances(label, magnituds)

dif = myxyz - ref
ratio = myxyz./ref

%% add new data to file

