% author: Raphael Dein
% date:   May 17 2017

%% designing the Mondrian

% Illuminant is the sum of 3 narrow gaussian curves at 450, 530 qand 630nm
illuL = 1.68;
illuM = 1.9;
illuS = 1.31;

illuminant=illuS*normpdf([1:331],60,4.5)+illuM*normpdf([1:331],140,4.5)+illuL*normpdf([1:331],240,4.5);


% 8-by-8-by-3 color pattern matrix

P = zeros(8, 8, 3);

% color labels in a cell array
color_labels = {'N 6/', '5YR 5/6', '5Y 8.5/10', '2.5BG 6/6', '7.5GY 6/6', '5R 5/12', '10RP 6/10', '2.5PB 6/8', '5GY 8.5/8', '10RP 3/6', 'N 9/', 'N 2.5/', '2.5YR 7/10', '5Y 7/8', '2.5B 8/4', 'N 7/', '5P 7/6', '2.5G 7/6'};

color_index = 0;

% only square structure
P(1, 1:2, :)=P(1, 1:2, :)+get_lms(illuminant, color_labels{2});
P(1:2, 3:5, :)=P(1:2, 3:5, :)+get_lms(illuminant, color_labels{3});
P(1, 6, :)=P(1, 6, :)+get_lms(illuminant, color_labels{4});
P(1:3, 7:8, :)=P(1:3, 7:8, :)+get_lms(illuminant, color_labels{5});
P(2, 1:2, :)=P(2, 1:2, :)+get_lms(illuminant, color_labels{6});
P(2:4, 6, :)=P(2:4, 6, :)+get_lms(illuminant, color_labels{7});  % G
P(3:4, 1, :)=P(3:4, 1, :)+get_lms(illuminant, color_labels{8});
P(3:4, 2:5, :)=P(3:4, 2:5, :)+get_lms(illuminant, color_labels{9});
P(4:6, 7:8, :)=P(4:6, 7:8, :)+get_lms(illuminant, color_labels{10});
P(5:6, 1:2, :)=P(5:6, 1:2, :)+get_lms(illuminant, color_labels{11});  % instead of N 9.6/ it is N 9/
P(5:6, 3:6, :)=P(5:6, 3:6, :)+get_lms(illuminant, color_labels{12});  % instead N 1.25/0 it is N 2.5/
P(7, 1:3, :)=P(7, 1:3, :)+get_lms(illuminant, color_labels{13});
P(7, 4:5, :)=P(7, 4:5, :)+get_lms(illuminant, color_labels{14});
P(7:8, 6:7, :)=P(7:8, 6:7, :)+get_lms(illuminant, color_labels{15});
P(7:8, 8, :)=P(7:8, 8, :)+get_lms(illuminant, color_labels{16});  % instead of N 6.75/ it is N 7/
P(8, 1:2, :)=P(8, 1:2, :)+get_lms(illuminant, color_labels{17});
P(8, 3:5, :)=P(8, 3:5, :)+get_lms(illuminant, color_labels{18});

% normalize
% P=P./max(max(P));

% From pattern to true image
I = zeros(300, 300, 3);
I = I+get_lms(illuminant, color_labels{1});  % instead of N 5.75/ it is N 6/
I(51:250, 51:250, :) = imresize(P, 25, 'nearest');

% conversion from LMS to RGB
I = colorspace('CAT02 LMS->RGB', I);

% Show image
figure(2); imshow(I)
