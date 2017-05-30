%
%
%	Obsolet, see illumination_exp.m
%
%
% fix illuminants so that energy of grey should be 5.8 at 630 nm, 3.2 at 530 and 1.6 at 450

close all;

%% Parameters

figs_on = 1;

% fake photometer with a constant sensitivity

photometer = ones(331, 4);
photometer(1:331, 1) = 390:720;

% 630 adjustment

magn630 = 16;

illu = magn630 * normpdf([390:720], 630, 4.5);

lms = get_lms(illu, 'N 7/', photometer);

Y = lms(1);
d = 5.8 - Y;

% 530 adjustment

magn530 = 8.74;

illu = magn530 * normpdf([390:720], 530, 4.5);

lms = get_lms(illu, 'N 7/', photometer);

Z = lms(1);
d = 3.2 - Z;

% 450 adjustment

magn450 = 4.415;

illu = magn450 * normpdf([390:720], 450, 4.5);

lms = get_lms(illu, 'N 7/', photometer);

X = lms(1)
d = 1.6 - X


if figs_on
	figure(1), plot(photometer(:,1), photometer(:,2), 'red')  % photometer sensitivity

	% how is the reflectance of the P color, i.e. N 7/?

	load data/munsell380_800_final.mat;

	color_label = 'N 7/';

	indec = find(contains(S, color_label));  % find indexes of string containing label
	index = find(S(indec,1)==color_label(1));  % find indexes of selected strings with same first letter

	hold on, plot(380:800, munsell(1:end, index), '+k')

	% how is the illuminant?
	hold on, aS = area(390:720, illu); aS.FaceColor = 'blue';

	xlabel('wavelength (nm)'), ylabel('energy (legend)')
	legend('constant sensitivity of the photometer', 'reflectance of color N 7/, gray', 'illumination')
end