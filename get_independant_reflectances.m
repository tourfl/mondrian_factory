function ind_ref = get_independant_reflectances( color_lab, magnitudes )
%GET_INDEPENDANT_REFLECTANCES get reflectances computed at 630, 530 and
%450, independantly
%   IND_REF = GET_INDEPENDANT_REFLECTANCES(COLOR_LAB, MAGNITUDES) where
%   COLOR_LAB is a label from the Munsell Book of colors and MAGNITUDES are
%   the magnitudes of the 630, 530 and 450 nm light that would independantly
%   illuminate the color.
%   IND_REF is the the energy computed for each light


	% fake photometer with a constant sensitivity

	std = 4.247;  % computed in perfect_illuminant.m
	photometer = ones(331, 4);
	photometer(1:331, 1) = 390:720;

	illum(1, :) = magnitudes(1) * normpdf([390:720], 630, 4.5);
	illum(2, :) = magnitudes(2) * normpdf([390:720], 530, 4.5);
	illum(3, :) = magnitudes(3) * normpdf([390:720], 450, 4.5);

	for i=1:size(magnitudes(:))
		lms = get_lms(illum(i, :), color_lab, photometer);
		ind_ref(i) = lms(1);  % they must all be equal
	end
end

