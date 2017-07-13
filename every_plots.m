clear all, close all

space = 'LMS'
senson = true
solution = 1
experiment = 'green'
color_label = 'N 7/'  % C color, i.e. 5Y 8.5/10

book = MunsellBook();
load(['data/illum/illum', num2str(solution) '_' space '.mat']);

figure(32)

if senson
	% how are the sensor answers?
	load(['data/' space '_sensor.mat']);
		plot(sensor(:,1), sensor(:,2), 'red')  % long
		hold on, plot(sensor(:,1), sensor(:,3), 'green')  % mid
		plot(sensor(:,1), sensor(:,4), 'blue')  % short
end

hold on, plot(380:800, book.getReflectances(color_label), '+k');

% how are the illuminants?

illum = Magnituds(experiment);

illuminantL=illum(1)*normpdf([380:800], 630, 4);
illuminantM=illum(2)*normpdf([380:800], 530, 4);
illuminantS=illum(3)*normpdf([380:800], 450, 4);

hold on, aS = area(380:800, illuminantS);
aS.FaceColor = 'blue';
hold on, aM = area(380:800, illuminantM);
aM.FaceColor = 'green';
hold on, aL = area(380:800, illuminantL);
aL.FaceColor = 'red';

% Presentation

ylabel('energy (legend)')
title('illumination, reflectance and sensors answers')
% legend('long range wavelength cones answer', 'mid range', 'short range', 'reflectance of color N 7/, gray', 'blue illuminant', 'green', 'red')

refl_leg = ['reflectance of color ' color_label];
blue_leg = ['blue illuminant from sol ' num2str(solution)];

if senson
	legend(['Long-wave sensor (' space ')'], 'Mid-wave sensor', 'Short-wave sensor', refl_leg, blue_leg, 'green', 'red')
else
	legend(refl_leg, blue_leg, 'green', 'red')
end

sL = spectrumLabel(gca);
xlabel(sL, 'wavelength (nm)')

% resize axis space so that xlabel appears
scale = 0.7;
pos = get(gca, 'Position');
pos(2) = pos(2)+scale*pos(4);
pos(4) = (1-scale)*pos(4);
set(gca, 'Position', pos)

