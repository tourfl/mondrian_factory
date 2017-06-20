clear all, close all

% how are the cones answers?

load data/good_cones_answers.mat;

figure(31), hold off
% plot(cones_answers(:,1), cones_answers(:,2), 'red')  % long
% hold on, plot(cones_answers(:,1), cones_answers(:,3), 'green')  % mid
% hold on, plot(cones_answers(:,1), cones_answers(:,4), 'blue')  % short

% how is the reflectance of the C color, i.e. 5Y 8.5/10?

load data/munsell380_800_final.mat;

color_label = 'N 7/';

indec = find(contains(S, color_label));  % find indexes of string containing label
index = find(S(indec,1)==color_label(1));  % find indexes of selected strings with same first letter

hold on, plot(380:800, munsell(1:end, index), '+k')

% how are the illuminants?

illum = [11.5, 7.8, 3.3];

illuminantL=illum(1)*normpdf([380:800], 630, 4);
illuminantM=illum(2)*normpdf([380:800], 530, 4);
illuminantS=illum(3)*normpdf([380:800], 450, 4);

hold on, aS = area(380:800, illuminantS)
aS.FaceColor = 'blue';
hold on, aM = area(380:800, illuminantM)
aM.FaceColor = 'green';
hold on, aL = area(380:800, illuminantL)
aL.FaceColor = 'red';

% Presentation

title('illumination and reflectance')
xlabel('wavelength (nm)'), ylabel('energy (legend)')
% legend('long range wavelength cones answer', 'mid range', 'short range', 'reflectance of color N 7/, gray', 'blue illuminant', 'green', 'red')
legend('reflectance of color N 7/, gray', 'blue illuminant', 'green', 'red')
