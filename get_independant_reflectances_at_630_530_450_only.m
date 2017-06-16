function ind_ref = get_independant_reflectances_at_630_530_450_only( color_lab, magnitudes)
%GET_INDEPENDANT_REFLECTANCES_AT_630_530_450_ONLY get reflectances computed at 630,
%530 and 450, only



	% fake a weird photometer with a sensitivity at 630, 530 and 450 only

	photometer = zeros(331, 4);
	photometer(61, :) = 1;  % 450 nm
	photometer(141, :) = 1;
	photometer(241, :) = 1;

	illum(1, :) = magnitudes(1) * normpdf([390:720], 630, 4.5);
	illum(2, :) = magnitudes(2) * normpdf([390:720], 530, 4.5);
	illum(3, :) = magnitudes(3) * normpdf([390:720], 450, 4.5);

	for i=1:size(magnitudes(:))
		lms = get_lms(illum(i, :), color_lab, photometer);
		ind_ref(i) = lms(1);  % they must all be equal
	end
end

