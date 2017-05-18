
% Load data
load('data/munsell380_800_1.mat')
cones_answer = csvread('data/linss2_10e_1.csv');

% compute l, m and s lightness from a given color under a certain illuminant

% gray illuminant

illuS = 1;
illuM = 1;
illuL = 1;

illuminant=illuS*normpdf([1:331],70,4)+illuM*normpdf([1:331],150,4)+illuL*normpdf([1:331],250,4);

lms_color = zeros(1, 1, 3);

index = find(all(ismember(S, '5Y 8/8'), 2));

lms_color(1,1,1)=sum(illuminant.*munsell(index, 11:341).*cones_answer(1:331, 2)');
lms_color(1,1,2)=sum(illuminant.*munsell(index, 11:341).*cones_answer(1:331, 3)');
lms_color(1,1,3)=sum(illuminant.*munsell(index, 11:341).*cones_answer(1:331, 4)');

% construct an image from this color

Image = ones(240, 240, 3).*lms_color;
 
 % rescale

Image = Image/max(max(max(Image)));

figure(1), imagesc(Image);