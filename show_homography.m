function [] = show_homography(H_to_last, H_to_previous, img_previous, img_last, camnumber, matrices, pitches)
K_previous = matrices{1,camnumber-1};
K_last = matrices{1,camnumber};

imglast_from_previous = H_to_last*img_previous;
imglast_from_previous = imglast_from_previous ./ repmat(imglast_from_previous(3,:), 3, 1);

imgprevious_from_last = H_to_previous*img_last;
imgprevious_from_last = imgprevious_from_last ./ repmat(imgprevious_from_last(3,:), 3, 1);




img_last(1,:) = img_last(1,:).* (str2num(pitches{1,camnumber-1})*10^-6); %convert 
img_last(1,:) = img_last(1,:)./ (str2num(pitches{1,camnumber})*10^-6);          
img_last(2,:) = img_last(2,:).* (str2num(pitches{2,camnumber-1})*10^-6);  %convert 
img_last(2,:) = img_last(2,:)./ (str2num(pitches{2,camnumber})*10^-6); 

imglast_from_previous(1,:) = imglast_from_previous(1,:).* (str2num(pitches{1,camnumber-1})*10^-6); %convert 
imglast_from_previous(1,:) = imglast_from_previous(1,:)./ (str2num(pitches{1,camnumber})*10^-6);          
imglast_from_previous(2,:) = imglast_from_previous(2,:).* (str2num(pitches{2,camnumber-1})*10^-6);  %convert 
imglast_from_previous(2,:) = imglast_from_previous(2,:)./ (str2num(pitches{2,camnumber})*10^-6); 
          



figure
hold on
subplot(2,2,1)
plot(img_previous(1,:), img_previous(2,:), '.b')
title(['CAM ', num2str(camnumber-1)])
grid minor
axis square
axis ([0 2*K_previous(1,3) 0 2*K_previous(1,3)])
xlabel('X-Pixel')
ylabel('Y-Pixel')

subplot(2,2,2)
plot(img_last(1,:), img_last(2,:), '.b')
title(['CAM ', num2str(camnumber)])
grid minor
axis square
axis ([0 2*K_last(1,3) 0 2*K_last(1,3)])
xlabel('X-Pixel')
ylabel('Y-Pixel')

subplot(2,2,3)
plot(imgprevious_from_last(1,:), imgprevious_from_last(2,:), '.b')
title(['CAM ', num2str(camnumber-1), ' based on ', num2str(camnumber) ])
grid minor
axis square
axis ([0 2*K_previous(1,3) 0 2*K_previous(1,3)])
xlabel('X-Pixel')
ylabel('Y-Pixel')

subplot(2,2,4)
plot(imglast_from_previous(1,:), imglast_from_previous(2,:), '.b')
title(['CAM ', num2str(camnumber), ' based on ', num2str(camnumber-1) ])
grid minor
axis square
axis ([0 2*K_last(1,3) 0 2*K_last(1,3)])
xlabel('X-Pixel')
ylabel('Y-Pixel')

suptitle('HOMOGRAPHY')
end

