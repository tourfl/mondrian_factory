% build an image with manufactured achromatic colors, under white illuminant

%% Init

space = 'RGB'
solution = 1

average_label = {'N 2.5/', 'N 6/', 'N 7/', 'N 9/'};
interpo_label = {'N 5.75/', 'N 6.75/', 'N 9.6/'};
darkitp_label = {'N 1.25/', 'N 1.5/', 'N 1.75/'};

book = MunsellBook();

% Loadings

load(['data/illum/illum', num2str(solution) '_' space '.mat']);
load(['data/' space '_sensor.mat']);

illum = Magnituds('gray');

illuminantL=illum(1)*normpdf([1:331],241,4.5);
illuminantM=illum(2)*normpdf([1:331],141,4.5);
illuminantS=illum(3)*normpdf([1:331],61,4.5);
illumination = illuminantL+illuminantM+illuminantS;



labels = interpo_label;
for k=1:size(labels,2)
	label = labels{k}

	lms = get_lms(illumination, label, sensor)

	I(:, :, :, k) = repmat(lms, [150 150]);
end

mx = max(I(:));
I=I./mx;
Ipres = Presenter.build(I(:,:,:,1), I(:,:,:,2), I(:,:,:,3));

figure(22), imshow(Ipres)



labels = average_label;
for k=1:size(labels,2)
	label = labels{k}

	lms = get_lms(illumination, label, sensor)

	I(:, :, :, k) = repmat(lms, [150 150]);
end


I=I./mx;
Ipres = Presenter.build(I(:,:,:,1), I(:,:,:,2), I(:,:,:,3), I(:,:,:,4));

figure(56), imshow(Ipres)



labels = darkitp_label;
for k=1:size(labels,2)
	label = labels{k}

	lms = get_lms(illumination, label, sensor)

	I(:, :, :, k) = repmat(lms, [150 150]);
end


I=I./mx;
Ipres = Presenter.build(I(:,:,:,1), I(:,:,:,2), I(:,:,:,3));

figure(29), imshow(Ipres)