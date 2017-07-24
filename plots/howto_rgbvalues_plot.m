% plot three figures in a row: one for each color matching function, with reflectance and illumination

%% Init

clear all, close all

% Parameters

space = 'RGB'
solution = 1
experiment = 'green'
color_label = '5Y 8.5/10'  % C color, i.e. 5Y 8.5/10

illum_rescaler = 3

% Loadings

load(['data/illum/illum', num2str(solution) '_' space '.mat']);
load(['data/' space '_sensor.mat']);

% building things to plot

illum = Magnituds(experiment);

illuminantL=illum(1)*normpdf([1:331],241,4.5);
illuminantM=illum(2)*normpdf([1:331],141,4.5);
illuminantS=illum(3)*normpdf([1:331],61,4.5);

illumination = illuminantL+illuminantM+illuminantS;

illumination = illum_rescaler*illumination;

book = MunsellBook();

reflectance = book.getReflectances(color_label);



%% Plotting

figure(44)

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

	illArea = area(390:720, illumination);
	illArea.FaceColor = 'y';


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



