function F = homography_costfun(x, img, img2)

H = zeros(3);
H(1,:) = x(1:3);
H(2,:) = x(4:6);
H(3,:) = x(7:9);

 
img2_calc = H * img;
img2_calc = img2_calc./ repmat(img2_calc(3,:), 3, 1);

img2_calc = img2_calc(1:2,:);
img2 = img2(1:2,:);


F = img2_calc(:) - img2(:);
