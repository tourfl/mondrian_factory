%
%
%	OBSOLET: I will just keep my gray as a reference
%
%

% fix illuminants so that white (constant specrtum = 1) should be 1, 1, 1 in RGB

% illuminants
illuL = 1.68;
illuM = 1.9;
illuS = 1.31;

illuminant=illuS*normpdf([1:331],60,4.5)+illuM*normpdf([1:331],140,4.5)+illuL*normpdf([1:331],240,4.5);

% lightness per cones on the gray area

lms = get_lms(illuminant, 'N 7/')

[.7743 .7795 .6352]  % what it should be

% RGB

% [R, G, B] = colorspace('CAT02 LMS->RGB', [L M S])
