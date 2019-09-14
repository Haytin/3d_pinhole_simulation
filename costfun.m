function F = costfun(x, img, object)
% costfunction for calibration optimization

K = [x(1) 0 x(2); 0 x(3) x(4); 0 0 1];
R = to_rotation(x(5:7));
Rt = [R x(8:10)'];

% get estimated ideal img
P = K*Rt;
img_est = P*object;
img_est = img_est .*  repmat(1./img_est(3,:), 3, 1);

% normalize distorted real img
img_n = inv(K) * img;

%get coeffs from distorted to ideal
 L = zeros(3, size(img_n,2));      
 P = zeros(3, size(img_n,2));  

 
 r = (img_n(1,:)).^2 + (img_n(2,:)).^2;
 
 L(1,:) = img_n(1,:).*(x(11)*r + x(12)*(r).^2); 
 L(2,:) = img_n(2,:).*(x(11)*r + x(12)*(r).^2);
 
 
 P(1,:) = x(13)*(r + 2*img_n(1,:).^2)  + 2*x(14)*img_n(1,:).*img_n(2,:);
 P(2,:) = 2*x(13)*img_n(1,:).*img_n(2,:) +  x(14)*(r + 2*img_n(2,:).^2);

 img_corr_n = img_n + L + P;
 img_corr = K *img_corr_n;
 %costfunction
 img_est = img_est(1:2,:);
 img_corr = img_corr(1:2,:);
 
 F = img_est(:) - img_corr(:);
 
 

