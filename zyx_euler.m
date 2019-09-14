function[phi, theta, psi] = zyx_euler(R)

%ZYX_EULER: gets the euler angles for the euler system ZYX.

%--------------------------------------------------------------------------

    if R(3,1) == 1          % special case 1
   phi = pi/4;
   theta = -pi/2;
   psi = atan2d(-R(1,2),R(2,2))-phi;
    elseif R(3,1) == -1     % special case 2
   phi = pi/4;
   theta = pi/2;
   psi = phi - atan2d(-R(1,2),R(2,2));           
    else                    % general case
   phi = atan2d(R(2,1), R(1,1)); 
   theta = atan2d(-R(3,1), cosd(phi)*R(1,1)+sind(phi)*R(2,1));
   psi = atan2d(sind(phi)*R(1,3)-cosd(phi)*R(2,3), -sind(phi)*R(1,2) + cosd(phi)*R(2,2));
     end