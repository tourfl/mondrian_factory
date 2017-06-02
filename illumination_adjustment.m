% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

%% Parameters

gray_lab = 'N 7/';
red_lab  = '10RP 6/10';
blue_lab = '2.5PB 6/8';
green_lab= '2.5G 7/6';
yello_lab= '5Y 8.5/10';

color_lab = green_lab;

magnituds = [3.2, 1.579, 2.107]  % magnitudes of L, M and S illuminants


%% Adjusting the Tristimulus values

xyz = [0.6090    0.6957    0.4746]

ref = get_independant_reflectances(color_lab, magnituds)

dif = xyz - ref