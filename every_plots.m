% how are the cones answers?

load data/good_cones_answers.mat;

figure(31), hold off, plot(cones_answers(:,1), cones_answers(:,2), 'red')  % long
hold on, plot(cones_answers(:,1), cones_answers(:,3), 'green')  % mid
hold on, plot(cones_answers(:,1), cones_answers(:,4), 'blue')  % short

% how is the reflectance of the C color, i.e. 5Y 8.5/10?

load data/munsell380_800_1.mat;

index = find(ismember(S, {'2.5PB 7/8'}));  % cells to compare whole strings!

hold on, plot(380:800, munsell(1:end, index), '+c')

% how are the illuminants?

illuL = 2;
illuM = 1.8;
illuS = 3;

illuminantL=illuL*normpdf([380:800],630,4.5);
illuminantM=illuM*normpdf([380:800],530,4.5);
illuminantS=illuS*normpdf([380:800],450,4.5);

hold on, aS = area(380:800, illuminantS)
aS.FaceColor = 'blue';
hold on, aM = area(380:800, illuminantM)
aM.FaceColor = 'green';
hold on, aL = area(380:800, illuminantL)
aL.FaceColor = 'red';

% Presentation

xlabel('wavelength (nm)'), ylabel('energy (arbitrary)')
legend('long range wavelength cones answer', 'mid range', 'short range', 'reflectance of color 2.5PB 7/8, kind of blue', 'blue illuminant', 'green', 'red')
