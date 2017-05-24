%
%
% Obsolet!
%
%
% Red Experiment:
% Adjusting illuminants so that the G area of the Mondrian
% As the same LMS values as the P area of the Mondrian under
% White illuminant.

% illuminants
illum = [1 5.2 2.2];

illuminant=illum(3)*normpdf([1:331],60,4.5)+illum(2)*normpdf([1:331],140,4.5)+illum(1)*normpdf([1:331],240,4.5);
illumi_ref=1.31*normpdf([1:331],60,4.5)+1.9*normpdf([1:331],140,4.5)+1.68*normpdf([1:331],240,4.5);

% lightness per cones on the G area


lms(1,1,:) = get_lms(illuminant, '10RP 6/10');
lms(1,2,:) = get_lms(illumi_ref, 'N 7/')
