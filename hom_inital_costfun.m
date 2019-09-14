function F = hom_inital_costfun(x, img_base, img_target)

H = [x(1:3,1)'; x(4:6,1)'; x(7:9,1)'];

img_est = H*img_base;
img_est = img_est .*  repmat(1./img_est(3,:), 3, 1);


img_est = img_est(1:2,:);
img_target = img_target(1:2,:);

F = sum(sum(img_target - img_est))^2;