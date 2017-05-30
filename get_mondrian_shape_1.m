function [ I, Irgb ] = get_mondrian_shape_1( illum, color_labels )
%GET_MONDRIAN_SHAPE_1 Construct a Mondrian with a constant shape (obsolet)
%   [I, IRGB] = GET_MONDRIAN_SHAPE_1(ILLUM, COLOR_LABELS) Construct a given
%	shape under the illuminant ILLUM, which is the sum of 3 narrow gaussian
%	curves at 450, 530 and 630 nm. You need to provide the references of colors
%	from Munsell book in the cell array of strings COLOR_LABELS.
%	ILLUM must be a row vector with magnitudes in the ascendant order of wave
%	length
%	I is the LMS answer of the Mondrian


% Illuminant is the sum of 3 narrow gaussian curves at 450, 530 qand 630nm
illuminant=illum(3)*normpdf([1:331],60,4.5)+illum(2)*normpdf([1:331],140,4.5)+illum(1)*normpdf([1:331],240,4.5);


% 8-by-8-by-3 color pattern matrix

P = zeros(8, 8, 3);

% only rect structure
P(1, 1:2, :)=P(1, 1:2, :)+get_lms(illuminant, color_labels{2});  % A
P(1:2, 3:5, :)=P(1:2, 3:5, :)+get_lms(illuminant, color_labels{3});  % B
P(1, 6, :)=P(1, 6, :)+get_lms(illuminant, color_labels{4});
P(1:3, 7:8, :)=P(1:3, 7:8, :)+get_lms(illuminant, color_labels{5});
P(2, 1:2, :)=P(2, 1:2, :)+get_lms(illuminant, color_labels{6});
P(2:4, 6, :)=P(2:4, 6, :)+get_lms(illuminant, color_labels{7});  % G
P(3:4, 1, :)=P(3:4, 1, :)+get_lms(illuminant, color_labels{8});
P(3:4, 2:5, :)=P(3:4, 2:5, :)+get_lms(illuminant, color_labels{9});
P(4:6, 7:8, :)=P(4:6, 7:8, :)+get_lms(illuminant, color_labels{10});
P(5:6, 1:2, :)=P(5:6, 1:2, :)+get_lms(illuminant, color_labels{11});  % K
P(5:6, 3:6, :)=P(5:6, 3:6, :)+get_lms(illuminant, color_labels{12});  % L
P(7, 1:3, :)=P(7, 1:3, :)+get_lms(illuminant, color_labels{13});
P(7, 4:5, :)=P(7, 4:5, :)+get_lms(illuminant, color_labels{14});
P(7:8, 6:7, :)=P(7:8, 6:7, :)+get_lms(illuminant, color_labels{15});
P(7:8, 8, :)=P(7:8, 8, :)+get_lms(illuminant, color_labels{16});  % P
P(8, 1:2, :)=P(8, 1:2, :)+get_lms(illuminant, color_labels{17});
P(8, 3:5, :)=P(8, 3:5, :)+get_lms(illuminant, color_labels{18});

% From pattern to true image
I = zeros(300, 300, 3);
I = I+get_lms(illuminant, color_labels{1});  % A
I(51:250, 51:250, :) = imresize(P, 25, 'nearest');

% conversion from LMS to RGB
Irgb = colorspace('CAT02 LMS->RGB', I);

% normalize LMS, so that it never goes up to 1
I=I./1.0874;

end

