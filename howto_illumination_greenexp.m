% plot three figures in a row: one for each color matching function, with reflectance and illumination

%% Init

clear all, close all

space = 'RGB'
solution = 1
experiment1 = 'gray'
experiment2 = 'green'
illum_rescaler = 3

book = MunsellBook();

% Loadings

load(['data/illum/illum', num2str(solution) '_' space '.mat']);
load(['data/' space '_sensor.mat']);

%% Plotting

figure(64)

for k = 1:2

	if k == 1
		illum = Magnituds(experiment1);
		color_label = 'N 1.25/'
	else
		illum = Magnituds(experiment2);
		color_label = '2.5G 7/6'
	end

	reflectance = book.getReflectances(color_label);

	illuminantL=illum(1)*normpdf([1:331],241,4.5);
	illuminantM=illum(2)*normpdf([1:331],141,4.5);
	illuminantS=illum(3)*normpdf([1:331],61,4.5);

	subplot(1, 2, k)

	plot(380:5:800, reflectance(1:5:421, 1), '*k');
	
	% how are the illuminants?
	hold on, aS = area(390:720, illum_rescaler*illuminantS);
	aS.FaceColor = 'blue';
	aM = area(390:720, illum_rescaler*illuminantM);
	aM.FaceColor = 'green';
	aL = area(390:720, illum_rescaler*illuminantL);
	aL.FaceColor = 'red';

	% Presentation

	if k == 1
		ylabel('energy')
	end

	axis([380 800 0 1.5])

	refl_leg = ['reflectance of color ' color_label];
	illuminant_leg = 'illuminant - ';

	if k == 1
		legend(refl_leg, [illuminant_leg 'red'], [illuminant_leg 'green'], [illuminant_leg 'blue'])
	else
		legend(refl_leg)
	end

	sL = spectrumLabel(gca);
	xlabel(sL, 'wavelength (nm)')

	% resize axis space so that xlabel appears
	scale = 0.7;
	pos = get(gca, 'Position');
	pos(2) = pos(2)+scale*pos(4);
	pos(4) = (1-scale)*pos(4);
	set(gca, 'Position', pos)
end

%% Another plot

label_white = 'N 10/';

illumination = illuminantL+illuminantM+illuminantS;
illumination = illumination(1:331);

whitePicture = repmat(get_lms(illumination, label_white, sensor), [320 320]);

whitePicture = whitePicture./max(whitePicture(:));

mondrianBase = im2double(imread('/home/raph/Code/mondrian_exp/images/RGB/solution1/greenexp_s1_RGB.png'));
mondrianBase = mondrianBase./max(mondrianBase(:));

figure(29)

subplot(121), imshow(whitePicture)
subplot(122), imshow(mondrianBase)



