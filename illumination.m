% fix illuminants so that white (constant specrtum = 1) should be 1, 1, 1 in RGB

% load data
load data/good_cones_answers.mat;

% illuminants
illuL = 1.68;
illuM = 1.9;
illuS = 1.31;

illuminant=illuS*normpdf([1:331],60,4.5)+illuM*normpdf([1:331],140,4.5)+illuL*normpdf([1:331],240,4.5);

% lightness per cones

L=sum(illuminant'.*cones_answers(1:331, 2))
M=sum(illuminant'.*cones_answers(1:331, 3))
S=sum(illuminant'.*cones_answers(1:331, 4))

colorspace('RGB -> CAT02 LMS', [1, 1, 1])  % what it should be

% RGB

% [R, G, B] = colorspace('CAT02 LMS->RGB', [L M S])