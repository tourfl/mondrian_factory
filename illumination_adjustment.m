% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

clear all; close all

%% Data

load data/basics  % containing labels
load data/illum/adjustment_data  % containing labels

magnituds_gray = [83.2886                   107.689                   117.008];  % white illuminants!
magnituds_red = magnituds_gray.*[0.543841457983631          2.50353406951974          1.57936695410528];
magnituds_blue = magnituds_gray.*[1.80053735489996          1.06695108119779         0.648375762843677];
magnituds_green = magnituds_gray.*[1.75178261680712         0.765975371337883           1.4841152432953];
magnituds_yellow = magnituds_gray.*[0.493923914092421         0.603394202013505          3.24994587717272];

Magnituds = containers.Map(experiments, {magnituds_gray, magnituds_red, magnituds_blue, magnituds_green, magnituds_yellow})

%% Parameters

label_solution = 'having projectors intensities equal to D65 energy at their wavelengthes'
solution=5
experiment = 'red'
label = labels(experiment)
% label = 'N 10/'  % most pure white, artificially made
magnituds = Magnituds(experiment)  % magnitudes of L, M and S illuminants
xyz = [27.7736110916352           36.336306809062          39.1237189376281]

%% Adjusting the Tristimulus values

ref = get_independant_reflectances(label, magnituds)
% % ref = get_independant_reflectances_at_630_530_450_only(label, magnituds)

dif = xyz - ref
ratio = xyz./ref

%% for white ref purpose

% illuminant=magnituds(3)*normpdf([1:331],61,4.5)+magnituds(2)*normpdf([1:331],141,4.5)+magnituds(1)*normpdf([1:331],241,4.5);
% load data/RGB_sensor.mat;
% lms = get_lms(illuminant, label, sensor)
% [1 1 1] - lms(1,:)

