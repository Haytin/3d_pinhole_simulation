function [K] = set_intrinsics(intrinsics, handles )

focal_length = str2num(intrinsics{1})*10^-3; % convert to meter
if isempty(focal_length) || focal_length == 0
    focal_length = 16*10^-3;
else 
    focal_length = focal_length(1);  %falls mehrere eingegeben werden
end

sensor_height = str2num(intrinsics{2})*10^-3;
if isempty(sensor_height) || sensor_height ==0
    sensor_height = 11.264 * 10^-3;
else 
    sensor_height = sensor_height(1);
end


sensor_width =  str2num(intrinsics{3})*10^-3;
if isempty(sensor_width) || sensor_width == 0
 sensor_width = 11.264 * 10^-3;
else
sensor_width = sensor_width(1);    
end

x_pitch =  str2num(intrinsics{4})*10^-6;
if isempty(x_pitch)|| x_pitch == 0
    x_pitch = 5.5 * 10^-6;
else
    x_pitch = x_pitch(1);
end
    
    
y_pitch =  str2num(intrinsics{5})*10^-6;
if isempty(y_pitch) || y_pitch == 0
    y_pitch = 5.5 * 10^-6;
else 
    y_pitch = y_pitch(1);
end


skew = str2num(intrinsics{6});
if isempty(skew) || skew == 0
    skew = 0;
else
    skew = skew(1)
end



        p_x = sensor_width/2;      % ->  principal point in x-dim.
        p_y = sensor_height/2;     % ->  principal point in y-dim.

        m_x = 1/x_pitch;           % ->  conversion-factor: x-dim. to Pixelnumber in x 
        m_y = 1/y_pitch;           % ->  conversion-factor: y-dim. to Pixelnumber in y
        a_x = m_x * focal_length; % ->  final coeff. for projection 
        a_y = m_y * focal_length;  % ->  final coeff. for projection 
        x_0 = m_x * p_x;                    % ->  x-translation in pixelnumber           
        y_0 = m_y * p_y;                    % ->  y-translation in pixelnumber  
        skew = 0;
        
        K = [a_x skew x_0 0;...
            0 a_y y_0 0;...
            0 0 1 0];
        % -> build internal camera matrix



end

