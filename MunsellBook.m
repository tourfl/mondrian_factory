classdef MunsellBook < handle
	%MUNSELLBOOK handler of data from Munsell MunsellBook

	properties(Constant)
		munsellpath = 'data/munsell_380_800_grays_n_white.mat';
	end

	properties
		values
		labels
	end

	methods
		%% Construct a basic MunsellBook
		function obj = MunsellBook()

			load(obj.munsellpath);

			obj.values = munsell;
			obj.labels = S;
		end

		%% Return reflectances of given LABEL as a column vector
		function R = getReflectances(obj, label)

			indec = find(contains(obj.labels, label));  % find indexes of string containing label
			indef = find(obj.labels(indec,1)==label(1));  % find indexes of selected strings with same first letter

			index = indec(indef);  % remove intersection values

			R = obj.values(:, index(1,1));  % always take the 1,1 value (10PB 6/1, 10PB 6/10)
		end
	end
end