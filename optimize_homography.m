function[H_opti] = optimize_homography(H, img, img2)

options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','Display','iter');

params = [H(1,:), H(2,:), H(3,:)];

x = lsqnonlin(@homography_costfun, params ,[],[], options, img, img2);

H_opti = zeros(3);
H_opti(1,:) = x(1:3);
H_opti(2,:) = x(4:6);
H_opti(3,:) = x(7:9);