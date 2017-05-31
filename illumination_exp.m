% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

%% Parameters

gray_lab = 'N 7/';
red_lab  = '10RP 6/10';
blue_lab = '2.5PB 6/8';
green_lab= '2.5G  7/6';
yello_lab= '5Y 8.5/10';
color_lab = red_lab;

magnituds = [9.46 23.74 7.56]  % magnitudes of L, M and S illuminants

xyz = [4.1687    2.8562    1.1956]

ref = get_independant_reflectances(color_lab, magnituds)

dif = xyz - ref