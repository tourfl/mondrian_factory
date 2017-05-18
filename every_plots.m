% how are the cones answers?

load data/good_cones_answers.mat;

figure(31), plot(cones_answers(:,1), cones_answers(:,2), 'red')  % long
hold on, plot(cones_answers(:,1), cones_answers(:,3), 'green')  % mid
hold on, plot(cones_answers(:,1), cones_answers(:,4), 'blue')  % short

% how is the reflectance of the C color, i.e. 5Y 8.5/10?

load data/munsell380_800_1.mat;

index = find(all(ismember(S, {'5Y 8.5/10'}), 2));  % accolade to have the exact value!
indeb = find(all(ismember(S, {'2.5B 8/4'}), 2));

hold on, plot(380:800, munsell(1:end, index), 'black')
hold on, plot(380:800, munsell(1:end, indeb), '--m')

% how are the illuminants?

illuL = 2;
illuM = 1.8;
illuS = 3;

illuminantL=illuL*normpdf([380:800],630,4.5);
illuminantM=illuM*normpdf([380:800],530,4.5);
illuminantS=illuS*normpdf([380:800],450,4.5);

hold on, plot(380:800, illuminantS, '--blue')
hold on, plot(380:800, illuminantM, '--green')
hold on, plot(380:800, illuminantL, '--r')

% Presentation

xlabel('wavelength (nm)'), ylabel('energy (?)')
legend('long range wavelength cones answer', 'mid range', 'short range', 'reflectance of 5Y 8.5/10', 'reflectance of 2.5B 8/4', 'blue illuminant', 'green', 'red')
