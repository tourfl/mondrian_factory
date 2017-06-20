classdef MondrianBuilder < MondrianHandler
	%MONDRIANBUILDER self explained name!
	%	Note: correction is only applied before writing the image

	properties(Constant)
		filenameBasics = 'data/basics.mat';
	end

	properties
		sensor

		Illuminants
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

			% Construct filenames

			filename_illum = ['data/illum/illum' num2str(solution)];
			filename_shape = ['data/shape/', shapename, 'shape.mat'];

			if solution == 1
				filename_illum = [filename_illum '_' space];
			end

			% Load data

			load(obj.filenameBasics);
			load([filename_illum '.mat']);
			load(filename_shape);

			% Add loaded data to the properties

			obj.base_color_labels = base_color_labels;
			obj.color_labels = color_labels;
			obj.Illuminants = Magnituds;
			obj.shape = shape;

			if strcmp(space, 'HDR')
				% input images need not to be scaled
				obj.scalingCoef = 1;
				obj.sensor = 'LMS';
			else
				obj.scalingCoef = rescale_illum;
				obj.sensor = space;
			end

			fprintf(1, 'scalingCoef = %s\n', obj.scalingCoef);
		end

		function [I, Ipc] = run(obj, experiment)
			% create, return the Mondrians corr. to the experiment
			obj.experiment = experiment;

			I = get_mondrian(obj.scalingCoef*obj.Illuminants(experiment), obj.shape, obj.base_color_labels, obj.sensor);
			Ipc = get_mondrian(obj.scalingCoef*obj.Illuminants('gray'), obj.shape, obj.color_labels(experiment), obj.sensor);

			obj.IcurrentExp = I;
			obj.IcurrentPcp = Ipc;
		end

		function save_current(obj)
			imageHandler = ImageHandler(obj.space, obj.solution, obj.experiment, 0);

			imageHandler.writeInput(obj.funcCorrection(obj.IcurrentExp));
			imageHandler.writeInput(obj.funcCorrection(obj.IcurrentPcp), 'percepted');
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
	end

end