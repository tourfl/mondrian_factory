function [ lms ] = get_lms( illuminant, color_label)
%GET_LMS get long, medium and short answers from a labelled color
%   LMS = GET_LMS(ILLUMINANT, COLOR_LABEL) return a 1-by-1-by-3 matrix
%	which are the response of the three human eye's cones under a certain
%	ILLUMINANT and for a color designated by the COLOR_LABEL on the Munsell
%	book of color. Cones' answers and Munsell color table must be loaded!

	% Load data
	load('data/munsell380_800_1.mat')
	cones_answer = csvread('data/linss2_10e_1.csv');

	index = find(all(ismember(S, color_label), 2))

	lms(1,1,1)=sum(illuminant'.*munsell(11:341, index).*cones_answer(1:331, 2));
	lms(1,1,2)=sum(illuminant'.*munsell(11:341, index).*cones_answer(1:331, 3));
	lms(1,1,3)=sum(illuminant'.*munsell(11:341, index).*cones_answer(1:331, 4))

end

