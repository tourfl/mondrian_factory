% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

clear all; close all

%% Data

load data/basics  % containing labels
load data/illum/adjustment_data  % containing labels

magnituds_gray = [1.52 2.8 3.25];  % white illuminants!
magnituds_red = magnituds_gray.*[0.543988720949516 2.50413560512236 1.57980926216635];
magnituds_blue = magnituds_gray.*[1.80102490962234 1.06720744242307 0.648557343081103];
magnituds_green = magnituds_gray.*[1.75225696958025 0.766159415750222 1.48453087573206];
magnituds_yellow = magnituds_gray.*[0.494057660241125 0.603539182303308 3.25085603757324];

Magnituds = containers.Map(experiments, {magnituds_gray, magnituds_red, magnituds_blue, magnituds_green, magnituds_yellow})

%% Parameters

label_solution = 'RGB answer 1 for pure white (N 10/ spectrum equal to 1 everywhere)'
solution=1
experiment = 'yellow'
label = labels(experiment)
% label = 'N 10/'  % most pure white, artificially made
magnituds = Magnituds(experiment)  % magnitudes of L, M and S illuminants
xyz = [0.507 0.945 1.087]

%% Adjusting the Tristimulus values

ref = get_independant_reflectances(label, magnituds)

dif = xyz - ref
ratio = xyz./ref

%% for white ref purpose

% illuminant=magnituds(3)*normpdf([1:331],60,4.5)+magnituds(2)*normpdf([1:331],140,4.5)+magnituds(1)*normpdf([1:331],240,4.5);
% load data/RGB_sensor.mat;
% lms = get_lms(illuminant, label, sensor)
% [1 1 1] - lms(1,:)

