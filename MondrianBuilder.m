classdef MondrianBuilder < MondrianHandler
	%MONDRIANBUILDER self explained name!

	properties(Constant)
		filenameBasics = 'data/basics.mat';
		book = MunsellBook;
	end

	properties
		sensor

		Illumination
		shape
		perceptual_color_labels
		base_color_labels
	end

	methods
		%% Constructor
		function obj = MondrianBuilder(space, solution, shapename)
			% call to superclass constructor
			obj = obj@MondrianHandler(space, solution);

			% getting the illumination data, in a dedicated object
			obj.Illumination = IlluminationHandler(solution, space);

			% Load the shape and color labels
			filename_shape = ['data/shape/', shapename, 'shape.mat'];
			load(obj.filenameBasics);
			load(filename_shape);

			obj.base_color_labels = base_color_labels;
			obj.perceptual_color_labels = perceptual_color_labels;
			obj.shape = shape;

			% loading sensor function (in case of LMS, human cones answers)
			if strcmp(space, 'HDR')
				sensorname = 'RGB';
			else
				sensorname = space;
			end
			filename = ['data/', sensorname, '_sensor.mat'];
			load(filename); obj.sensor = sensor;
		end

		%% create and return two Mondrians: an experimental and a perceptual
		function [I, Ipc] = run(obj, experiment)
			obj.experiment = experiment;

			% Experimental is build under an experimental illumination and with the actual colors
			I = obj.build(obj.Illumination.getScaledMagnituds(experiment), obj.base_color_labels);

			% Perceptual is built under gray illumination but with perceptual colors
			Ipc = obj.build(obj.Illumination.getScaledMagnituds('gray'), obj.perceptual_color_labels(experiment));

			obj.Iexperimental = I;
			obj.Iperceptual = Ipc;
		end

		function save_current(obj)
			obj.writeInput(obj.Iexperimental);
			obj.writeInput(obj.Iperceptual, 'percepted');
		end

		%% build a Mondrian: 320*320*3 matrix
		function I = build(obj, illum, color_labels)

			% Illuminant is the sum of 3 narrow gaussian curves at 450, 530 qand 630nm
			illuminant=illum(3)*normpdf([1:331],61,4.5)+illum(2)*normpdf([1:331],141,4.5)+illum(1)*normpdf([1:331],241,4.5);

			% 24-by-24-by-3 color pattern matrix
			P = zeros(24, 24, 3);

			% filling the areas with colors
			for i=2:size(obj.shape(:))
				s = obj.shape{i};  % contains indexes of the limits of the areas
				tri = obj.getTristimulus(illuminant, color_labels{i});
				P(s(1):s(3), s(2):s(4), :)= repmat(tri, [s(3)-s(1)+1 s(4)-s(2)+1]);
			end

			% From pattern to true image
			I = zeros(320, 320, 3);
			I = I+obj.getTristimulus(illuminant, color_labels{1});  % Adding the gray surrond
			I(41:280, 41:280, :) = imresize(P, 10, 'nearest');  % nearest neighbor, just replicate 10 times the same values
		end

		%% get the tristimulus values, i.e. integrating reflectance with the three channels answers of the sensor
		function tri = getTristimulus(obj, illuminant, color_label)

			reflectance = obj.book.getReflectances(color_label);
			reflectance = reflectance(11:end-80);

			for c=2:4
				tri(1,1,c-1)=sum(illuminant'.*reflectance.*obj.sensor(1:331, c));
			end
		end

		function loadExisting(obj)
			% load existing files

			if strcmp(obj.experiment, 'None'), return, end

			obj.Iexperimental = obj.readImage(obj.filenames.getRaw_input);
			obj.Iperceptual = obj.readImage(obj.filenames.getPerceptual);
		end

		%% buildPres: build Ipres, see Presenter
		function achieved = buildPres(obj)

			Iin = obj.Iexperimental;
			Ipcp= obj.Iperceptual;

			if (isempty(Iin) || isempty(Ipcp))
				achieved = false;
				return
			end

			obj.Ipres = Presenter.build(Iin, Ipcp);
			obj.titlePres = 'input, perceptual';

			achieved = true;
		end
	end

	methods(Access = private)
	end
end