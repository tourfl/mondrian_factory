function [ I, Irgb ] = get_mondrian( illum, shape, color_labels )
%GET_MONDRIAN Construct a Mondrian with a given 24-by-24 shape
%   [I, IRGB] = GET_MONDRIAN_SHAPE_1(ILLUM, SHAPE, COLOR_LABELS) Construct a given
%	shape under the illuminant ILLUM, which is the sum of 3 narrow gaussian
%	curves at 450, 530 and 630 nm. You need to provide the references of colors
%	from Munsell book in the cell array of strings COLOR_LABELS.
%	ILLUM must be a row vector with magnitudes in the ascendant order of wave
%	length
%	I is the LMS answer of the Mondrian
%	SHAPE is a cell array of matrices 2 by 2


% Illuminant is the sum of 3 narrow gaussian curves at 450, 530 qand 630nm
illuminant=illum(3)*normpdf([1:331],60,4.5)+illum(2)*normpdf([1:331],140,4.5)+illum(1)*normpdf([1:331],240,4.5);


% 24-by-24-by-3 color pattern matrix

P = zeros(24, 24, 3);


for i=2:size(shape(:))
	s=shape{i};
	P(s(1):s(3), s(2):s(4), :)= repmat(get_lms(illuminant, color_labels{i}), [s(3)-s(1)+1 s(4)-s(2)+1]);
end

% From pattern to true image
I = zeros(300, 300, 3);
I = I+get_lms(illuminant, color_labels{1});  % A
I(31:270, 31:270, :) = imresize(P, 10, 'nearest');

% conversion from LMS to RGB
Irgb = colorspace('CAT02 LMS->RGB', I);

% normalize LMS, so that it never goes up to 1
I=I./1.0874;

end

