function [] = show_sensor(K,img, camnumber)

% DRAW_SENSOR_IMAGE: visualizes sensor image and its image pixel
% coordinates

%-------------------------------------------------------------------------
figure
plot(img(1,:), img(2,:), '+k')
grid minor
axis square
axis ([0 2*K(1,3) 0 2*K(2,3)])
title(['CAM ' num2str(camnumber)])
xlabel('X-Pixel')
ylabel('Y-Pixel')
axis ij     % sets the PLOT origin to the top left
end

