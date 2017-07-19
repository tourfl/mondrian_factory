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
		color_labels
		base_color_labels

		scalingCoef
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
				sensorname = 'RGB';
			else
				sensorname = space;
			end

			% loading sensor function
			filename = ['data/', sensorname, '_sensor.mat'];
			load(filename); obj.sensor = sensor;
		end

		function [I, Ipc] = run(obj, experiment)
			% create, return the Mondrians from experiment
			obj.setExperiment(experiment);  

			I = obj.getMondrian(obj.Illumination.getScaledMagnituds(experiment), obj.base_color_labels);
			Ipc = obj.getMondrian(obj.Illumination.getScaledMagnituds('gray'), obj.color_labels(experiment));

			obj.Iinput_raw = I;
			obj.Iperceptual_raw = Ipc;
		end

		function save_current(obj)

			obj.writeInput(obj.Iinput_raw);
			obj.writeInput(obj.Iperceptual_raw, 'percepted');
		end

		function I = getMondrian(obj, illum, color_labels)

			% Illuminant is the sum of 3 narrow gaussian curves at 450, 530 qand 630nm
			illuminant=illum(3)*normpdf([1:331],61,4.5)+illum(2)*normpdf([1:331],141,4.5)+illum(1)*normpdf([1:331],241,4.5);

			% 24-by-24-by-3 color pattern matrix
			P = zeros(24, 24, 3);

			for i=2:size(obj.shape(:))
				s=obj.shape{i};
				P(s(1):s(3), s(2):s(4), :)= repmat(obj.getLms(illuminant, color_labels{i}), [s(3)-s(1)+1 s(4)-s(2)+1]);
			end

			% From pattern to true image
			I = zeros(320, 320, 3);
			I = I+obj.getLms(illuminant, color_labels{1});  % A
			I(41:280, 41:280, :) = imresize(P, 10, 'nearest');
		end

		function lms = getLms(obj, illuminant, color_label)

			ref_spectrum = obj.book.getReflectances(color_label);
			ref_spectrum = ref_spectrum(11:end-80);

			for c=2:4
				lms(1,1,c-1)=sum(illuminant'.*ref_spectrum.*obj.sensor(1:331, c));
			end
		end
	end

	methods(Static)
	end

end