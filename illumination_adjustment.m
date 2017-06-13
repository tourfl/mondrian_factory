% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

clear all; close all

%% Data

load data/illumination_Land_xyz.mat

magnituds_gray = [2.192 1.785 1.2065];  % white illuminants!
magnituds_red = [1.192 4.469 1.91];
magnituds_blue = [3.9465 1.9045 0.784];
magnituds_green = [3.8395 1.3672 1.79];
magnituds_yellow = [1.0826 1.077 3.92];

current_magnituds = containers.Map(experiments, {magnituds_gray, magnituds_red, magnituds_blue, magnituds_green, magnituds_yellow})

%% Parameters

solution = 'solution 1 - LMS answer 1 for pure white (N 10/ spectrum equal to 1 everywhere)'
experiment = 'yellow'
label = labels(experiment)
% label = 'N 10/'  % most pure white, artificially made
magnituds = current_magnituds(experiment)  % magnitudes of L, M and S illuminants
myxyz = [0.7309    0.6023    0.4034]

%% Adjusting the Tristimulus values

ref = get_independant_reflectances(label, magnituds)

dif = myxyz - ref
ratio = myxyz./ref

%% for white ref purpose

% illuminant=magnituds(3)*normpdf([1:331],60,4.5)+magnituds(2)*normpdf([1:331],140,4.5)+magnituds(1)*normpdf([1:331],240,4.5);
% load data/good_cones_answers.mat;
% lms = get_lms(illuminant, label, cones_answers)
% [1 1 1] - lms(1,:)

%% add new data to file

