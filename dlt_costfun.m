function F = dlt_costfun(x, img, object)

P = [x(1:4,1)'; x(5:8,1)'; x(9:12,1)'];

img_est = P*object;
img_est = img_est .*  repmat(1./img_est(3,:), 3, 1);

img_est = img_est(1:2,:);
img = img(1:2,:);

F = sum(sum(img - img_est))^2;