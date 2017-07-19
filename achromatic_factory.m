% add achromatic values to Munsell table of colour

% load data
load data/munsell380_800_perso3.mat;

% find indexes of every hues that have the right value regarding Munsell classification

index1 = find(contains(S, '6/1'));
inde10 = find(contains(S, '6/10'));
inde12 = find(contains(S, '6/12'));
inde14 = find(contains(S, '6/14'));


intw10 = find(ismember(index1, inde10));  % find indexes that are in both arrays
index1(intw10) = [];  % remove intersection values

intw12 = find(ismember(index1, inde12));  % find indexes that are in both arrays
index1(intw12) = [];  % remove intersection values

intw14 = find(ismember(index1, inde14));  % find indexes that are in both arrays
index1(intw14) = [];  % remove intersection values

reflects = munsell(:, index1);  % get every spectrum answers of hue with right value

ach_reflect = mean(reflects, 2);  % Mean everything and it is done!

% plot

figure(41), hold off, plot(380:800, reflects)
hold on, h = plot(380:5:800, ach_reflect(1:5:421), '+Black')
legend(h, 'estimated reflectance of N 6/'), xlim([380 800])

xlabel('wavelength (nm)'), ylabel('energy')

% add to the table

munsell(:,end+1) = ach_reflect;
S(end+1, 1:4) = 'N 6/';

% save data

save('data/munsell380_800_final.mat', 'S', 'C', 'munsell')
