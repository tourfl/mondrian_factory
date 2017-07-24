%% Init

clear all, close all

space = 'RGB'
senson = true
solution = 1
experiment = 'green'
illum_rescaler = 1

load(['data/illum/illum', num2str(solution) '_' space '.mat']);

% how are the illuminants?

illum = Magnituds(experiment);

illuminantL=illum(1)*normpdf([1:331],241,4.5);
illuminantM=illum(2)*normpdf([1:331],141,4.5);
illuminantS=illum(3)*normpdf([1:331],61,4.5);

%% Plotting

figure(40)

hold on, aS = area(390:720, illum_rescaler*illuminantS);
aS.FaceColor = 'blue';
hold on, aM = area(390:720, illum_rescaler*illuminantM);
aM.FaceColor = 'green';
hold on, aL = area(390:720, illum_rescaler*illuminantL);
aL.FaceColor = 'red';

stem(630, illum(1)*0.089, '*k')
stem(530, illum(2)*0.089, '*k')
stem(450, illum(3)*0.089, '*k')

% Presentation

ylabel('energy')
xlim([380 800])

lgd = legend('blue illuminant', 'green', 'red');
lgd.FontSize = 14;

sL = spectrumLabel(gca);
xlabel(sL, 'wavelength (nm)')

% resize axis space so that xlabel appears
scale = 0.1;
pos = get(gca, 'Position');
pos(2) = pos(2)+scale*pos(4);
pos(4) = (1-scale)*pos(4);
set(gca, 'Position', pos)
