% adjust illuminants so that energy of a given color is 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

%% Parameters

color_lab = '10RP 6/10';

magnituds = [9.46 23.74 7.56]  % magnitudes of L, M and S illuminants

xyz = [5.8 3.2 1.6]

ref = get_independant_reflectances(color_lab, magnituds)

dif = [5.8 3.2 1.6] - ref