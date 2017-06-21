classdef MondrianBuilder < MondrianHandler
	%MONDRIANBUILDER self explained name!
	%	Note: correction is only applied before writing the image

	properties(Constant)
		filenameBasics = 'data/basics.mat';
	end

	properties
		sensor

		Illumination
		shape
		color_labels
		base_color_labels

		scalingCoef

		IcurrentExp
		IcurrentPcp
	end

	methods
		function obj = MondrianBuilder(space, solution, shapename)
			% Constructor

			% superclass constructor call
			obj = obj@MondrianHandler(space, solution);

			obj.Illumination = IlluminationHandler(solution, space);

			% Construct filenames

			filename_shape = ['data/shape/', shapename, 'shape.mat'];

			% Load data

			load(obj.filenameBasics);
			load(filename_shape);

			% Add loaded data to the properties

			obj.base_color_labels = base_color_labels;
			obj.color_labels = color_labels;
			obj.shape = shape;

			if strcmp(space, 'HDR')
				obj.sensor = 'RGB';
			else
				obj.sensor = space;
			end
		end

		function [I, Ipc] = run(obj, experiment)
			% create, return the Mondrians corr. to the experiment
			obj.experiment = experiment;

			I = obj.get_mondrian(obj.Illumination.getScaledMagnituds(experiment), obj.shape, obj.base_color_labels, obj.sensor);
			Ipc = obj.get_mondrian(obj.Illumination.getScaledMagnituds('gray'), obj.shape, obj.color_labels(experiment), obj.sensor);

			obj.IcurrentExp = I;
			obj.IcurrentPcp = Ipc;
		end

		function save_current(obj)
			imageHandler = ImageHandler(obj.space, obj.solution, obj.experiment, 0);

			imageHandler.writeInput(obj.IcurrentExp);
			imageHandler.writeInput(obj.IcurrentPcp, 'percepted');
		end

		function plot_current(obj)
			id = MondrianBuilder.simpleHash(obj.experiment)
			titleBase = [obj.experiment, 'exp, solution', num2str(obj.solution), ', ', obj.space ', ']

			figure(id), imshow(obj.IcurrentExp), title([titleBase 'illuminated']);
			figure(id+1), imshow(obj.IcurrentPcp), title([titleBase 'percepted']);
		end
	end

	methods(Static)
		% create a numeric identifiant from the given string
		function hash = simpleHash(experiment)
			numExp = double(experiment);

			hash = (numExp(1) + numExp(end)) * 2;
		end

		function I = get_mondrian( illum, shape, color_labels, sensorname )
		%GET_MONDRIAN Construct a Mondrian with a given 24-by-24 shape
		%   [I, IRGB] = GET_MONDRIAN_SHAPE_1(ILLUM, SHAPE, COLOR_LABELS) Construct a given
		%	shape under the illuminant ILLUM, which is the sum of 3 narrow gaussian
		%	curves at 450, 530 and 630 nm. You need to provide the references of colors
		%	from Munsell book in the cell array of strings COLOR_LABELS.
		%	ILLUM must be a row vector with magnitudes in the ascendant order of wave
		%	length
		%	I is the LMS answer of the Mondrian
		%	SHAPE is a cell array of matrices 2 by 2

			% Cones answer as sensor
			filename = ['data/', sensorname, '_sensor.mat'];
			load(filename)


			% Illuminant is the sum of 3 narrow gaussian curves at 450, 530 qand 630nm
			illuminant=illum(3)*normpdf([1:331],60,4.5)+illum(2)*normpdf([1:331],140,4.5)+illum(1)*normpdf([1:331],240,4.5);


			% 24-by-24-by-3 color pattern matrix

			P = zeros(24, 24, 3);


			for i=2:size(shape(:))
				s=shape{i};
				P(s(1):s(3), s(2):s(4), :)= repmat(get_lms(illuminant, color_labels{i}, sensor), [s(3)-s(1)+1 s(4)-s(2)+1]);
			end

			% From pattern to true image
			I = zeros(320, 320, 3);
			I = I+get_lms(illuminant, color_labels{1}, sensor);  % A
			I(41:280, 41:280, :) = imresize(P, 10, 'nearest');
		end
	end

end