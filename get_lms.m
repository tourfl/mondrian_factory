function [ lms ] = get_lms(illuminant, color_label, sensor_answer)
%GET_LMS get long, medium and short answers from a labelled color
%   LMS = GET_LMS(ILLUMINANT, COLOR_LABEL, SENSOR_ANSWER) return a 1-by-1-by-3 matrix
%	which are the response of the SENSOR_ANSWER under a certain
%	ILLUMINANT and for a color designated by the COLOR_LABEL on the Munsell
%	book of color. Cones' answers and Munsell color table must be loaded,
%	unless if it is gray color.

	% Load data
	load data/munsell380_800_final.mat;

	indec = find(contains(S, color_label));  % find indexes of string containing label
	indef = find(S(indec,1)==color_label(1));  % find indexes of selected strings with same first letter

	index = indec(indef);  % remove intersection values

	ref_spectrum = munsell(11:341, index(1,1));  % always take the 1,1 value (10PB 6/1, 10PB 6/10)

	lms(1,1,1)=sum(illuminant'.*ref_spectrum.*sensor_answer(1:331, 2));
	lms(1,1,2)=sum(illuminant'.*ref_spectrum.*sensor_answer(1:331, 3));
	lms(1,1,3)=sum(illuminant'.*ref_spectrum.*sensor_answer(1:331, 4));
end

