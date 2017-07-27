classdef ToneMapper < handle
	%TONEMAPPER brings tools to achieve Tone Mapping

	properties(Constant)
		k = [100/1.85 100/1.85 100/8.7];
		n = 0.74;
	end

	properties
		r = 0;
		Is= [];
		m
		Im

		Iin
		Iout
	end

	methods
		function obj = ToneMapper(Iin, r)

			if nargin == 2
				obj.r=r;
			end

			obj.Iin = Iin;

			% for each channel compute Is then Im, m

			for channel=1:3
				% temp_Is = obj.get_semisat(I(:, channel), r);
				% [obj.Is, obj.Im, obj.m] = [obj.Is temp_Is];
			end
		end


		function I = run()

		end
	end

	methods(Static)
		function [Is, Im, m] = get_Is_Im_m(Iin, r)
			%GET_IS_N_IM get Is Im and m for a single channel Image
			%	IS semisaturation
			%	IM threshold
			%	M  internal noise in the visual mechanism
				mn = mean(Iin(:));
				md = median(Iin(:));

				Ib = mn^.5*md^.5;
				% Ib = Ib*10^-r;  % not totally clear in the paper

				Is = ToneMapper.semisat(Ib, r)
				Im = Is * 100;
				m = Is * 10^-1.2;
		end

		function Is = semisat(Ib, r)
			%SEMISAT get semi saturation from background intensity
			Is = Ib^(1-0.37) * 10^(1.9-0.37*(4-r));
		end

		function C = tonemap(I, m, Is, Im, channel)
			%TONE_MAP get tone_mapped value
			
			s0 = ToneMapper.get_s0(m, Is, Im, channel)

			C = ToneMapper.wf_part(I.*(I<=Im), m, s0, channel) + ToneMapper.nr_part(I.*(I>Im), Is);
		end

		function C = wf_part(I, m, s0, channel)
			%WF_PART TM value if I <= Im, Weber-Fechner's law

			C = ToneMapper.k(channel) * log10(I + m) + s0;
		end

		function C = nr_part(I, Is)
			%NR_PART TM value if I > Im, Naka-Rushton's law

			C = I.^ToneMapper.n ./ (I.^ToneMapper.n + Is.^ToneMapper.n);
		end

		function s0 = get_s0(m, Is, Im, channel)
			% GET_S0 compute s0 to ensure continuity of the TM function

			s0 = ToneMapper.nr_part(Im, Is) - ToneMapper.wf_part(Im, m, 0, channel);
		end
	end
end