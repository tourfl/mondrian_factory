height = normpdf([1:1:340],10,1);
figure, plot(height)
height = normpdf([1:1:340],200,10);
figure, plot(height)
height = normpdf([1:1:340],200,5);
figure, plot(height)
figure, plot(height*5)
illuminant=normpdf([1:1:340],70,5)+normpdf([1:1:340],150,5)+normpdf([1:1:340],250,5);
figure, plot(illuminant)