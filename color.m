
% compute l, m and s lightness from a given color under a certain illuminant

% gray illuminant

illuS = 1;
illuM = 1;
illuL = 1;

illuminant=illuS*normpdf([1:331],70,4)+illuM*normpdf([1:331],150,4)+illuL*normpdf([1:331],250,4);

lms_color = get_lms(illuminant, '5Y 8/8');

% construct an image from this color

Image = ones(240, 240, 3).*lms_color;
 
 % normalize

Image = Image/max(Image(:));

figure(1), imagesc(Image);