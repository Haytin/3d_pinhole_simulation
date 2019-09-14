function [ output_args ] = commonpixel(handles )
% calculates common pixel in two cameras
camnumber = handles.camnumber;
matrices = handles.matrices;
pitches = handles.pitches;

images = handles.images;
img_previous = images{2,camnumber-1};       % with distorted
img_last = images{2,camnumber};


img_last_tr = img_last;
%convert to previous pixel system
img_last_tr(1,:) = img_last_tr(1,:).* (str2num(pitches{1,camnumber})*10^-6); %convert 
img_last_tr(1,:) = img_last_tr(1,:)./ (str2num(pitches{1,camnumber-1})*10^-6);          
img_last_tr(2,:) = img_last_tr(2,:).* (str2num(pitches{2,camnumber})*10^-6);  %convert 
img_last_tr(2,:) = img_last_tr(2,:)./ (str2num(pitches{2,camnumber-1})*10^-6); 

%calculate homography
H_to_last = homography(img_previous, img_last_tr);
H_to_last = optimize_homography(H_to_last, img_previous, img_last_tr);


img_previous_tr = img_previous;
%calculate to last pixel system
img_previous_tr(1,:) = img_previous_tr(1,:).* (str2num(pitches{1,camnumber-1})*10^-6); %convert 
img_previous_tr(1,:) = img_previous_tr(1,:)./ (str2num(pitches{1,camnumber})*10^-6);          
img_previous_tr(2,:) = img_previous_tr(2,:).* (str2num(pitches{2,camnumber-1})*10^-6);  %convert 
img_previous_tr(2,:) = img_previous_tr(2,:)./ (str2num(pitches{2,camnumber})*10^-6); 
%calculate homography
H_to_previous = homography(img_last, img_previous);
H_to_previous = optimize_homography(H_to_previous, img_last, img_previous_tr);
     

K_previous = matrices{1,camnumber-1};
K_last = matrices{1,camnumber};



%create testarray in previous camera
[x_prev y_prev] = meshgrid(1:16:2*K_previous(1,3), 1:16:2*K_previous(2,3));
x_prev = x_prev(:)';
y_prev = y_prev(:)';
test_point_prev = [x_prev; y_prev; ones(1, length(x_prev))];

%check if transformed testpoint is in last camera's sensor
points_in_last = [];
for i = 1:size(test_point_prev,2);
        %transform testpoint
        pt_img_last = H_to_last*test_point_prev(:,i);
        pt_img_last =  pt_img_last./ pt_img_last(3);
        % check if transformed point exceeds sensor range 
        if ( pt_img_last(1)>=0) && ( pt_img_last(1)<=2*K_previous(1,3))&& (pt_img_last(2)>=0)&&(pt_img_last(2)<=2*K_previous(2,3))
            points_in_last = [points_in_last, test_point_prev(:,i)];
        end
end


%create testarray in last camera
[x_last y_last] = meshgrid(1:16:2*K_last(1,3), 1:16:2*K_last(2,3));
x_last = x_last(:)';
y_last = y_last(:)';
test_point_last = [x_last;y_last;ones(1, length(x_last))];

%check if transformed testpoint is in previous camera's sensor
points_in_prev = [];
for i = 1:size(test_point_last, 2);
        %transform testpoint
        pt_img_previous = H_to_previous*test_point_last(:,i);
        pt_img_previous =  pt_img_previous./ pt_img_previous(3);
        % check if transformed point exceeds sensor range 
        if ( pt_img_previous(1)>=0) && ( pt_img_previous(1)<=2*K_last(1,3))&& (pt_img_previous(2)>=0)&&(pt_img_previous(2)<=2*K_last(2,3))
        points_in_prev = [points_in_prev, test_point_last(:,i)];
        end
end


%plot
figure
subplot(1,2,1)
hold on
plot(points_in_last(1,:), points_in_last(2,:), 'oy')
plot(img_previous(1,:), img_previous(2,:), '.b')
grid minor
axis square
axis ([0 2*K_previous(1,3) 0 2*K_previous(1,3)])
title(['CAM ', num2str(camnumber-1)])
hold off

subplot(1,2,2)
hold on
plot(points_in_prev(1,:), points_in_prev(2,:), 'om')
plot(img_last(1,:), img_last(2,:), '.b')
grid minor
axis square
axis ([0 2*K_last(1,3) 0 2*K_last(1,3)])
title(['CAM ', num2str(camnumber)])
hold off

end
