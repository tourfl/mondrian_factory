function [ mixed_reflect ] = achromatic_mixer( alpha, Raw_alphas, reflects )
%ACHROMATIC_MIXER from multiple reflectances, construct an alpha-level one
%   MIXED_REFLECT = ACHROMATIC_MIXER(ALPHA, RAW_ALPHAS, REFLECTS)
%   REFLECTS contains reflectances for the different RAW_ALPHAS. The
%   function construct a new MIXED_REFLECTANCE, doing some kind of mean and
%   based on the given ALPHA

[sz ~] = size(reflects);
mixed_reflect = zeros(sz, 1);

	for ind = 1:size(Raw_alphas(:))
	coef = 1;
		for other_alpha = setdiff(Raw_alphas, Raw_alphas(ind))
			coef = coef * (alpha - other_alpha)/(Raw_alphas(ind) - other_alpha);
		end
		coef = coef* (1 + alpha - Raw_alphas(ind));
		mixed_reflect = mixed_reflect + coef*reflects(:, ind);
	end
end

