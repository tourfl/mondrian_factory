% plot three figures in a row: one for each color matching function, with reflectance and illumination

%% Init

clear all, close all

space = 'RGB'
solution = 1
experiment = 'gray'
color_label = 'N 10/'
illum_rescaler = 3

book = MunsellBook();
reflectance = book.getReflectances(color_label);

% Loadings

load(['data/illum/illum', num2str(solution) '_' space '.mat']);
load(['data/' space '_sensor.mat']);

% building things to plot

illum = Magnituds(experiment);

illuminantL=illum(1)*normpdf([1:331],241,4.5);
illuminantM=illum(2)*normpdf([1:331],141,4.5);
illuminantS=illum(3)*normpdf([1:331],61,4.5);

illumination = illuminantL+illuminantM+illuminantS;
illumination = illumination(1:331);

%% Plotting

figure(64)

for rgbChannel = 1:3

	switch rgbChannel
		case 1
			color = 'red';
		case 2
			color = 'green';
		otherwise
			color = 'blue';
	end

	subplot(1, 3, rgbChannel)

	plot(sensor(:,1), sensor(:,rgbChannel+1), color), hold on

	
	% how are the illuminants?
	hold on, aS = area(390:720, illum_rescaler*illuminantS);
	aS.FaceColor = 'blue';
	hold on, aM = area(390:720, illum_rescaler*illuminantM);
	aM.FaceColor = 'green';
	hold on, aL = area(390:720, illum_rescaler*illuminantL);
	aL.FaceColor = 'red';


	plot(380:5:800, reflectance(1:5:421, 1), '*k');

	% Presentation

	if rgbChannel == 1
		ylabel('energy')
	end

	axis([380 800 -0.3 3])

	refl_leg = ['reflectance of color ' color_label];
	sens_leg = ['color matching function rgb - ' color];

	lgd = legend(sens_leg);
	lgd.FontSize = 14;

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

whitePicture = repmat(get_lms(illumination, color_label, sensor), [320 320]);

whitePicture = whitePicture./max(whitePicture(:));

mondrianBase = im2double(imread('/home/raph/Code/mondrian_exp/images/RGB/solution1/grayexp_s1_RGB.png'));
mondrianBase = mondrianBase./max(mondrianBase(:));

figure(29)

subplot(121), imshow(whitePicture)
subplot(122), imshow(mondrianBase)



