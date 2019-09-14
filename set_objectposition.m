function [object] = set_objectposition(object, handles )

x_pos = get(handles.edit_xobject,'String');
x_pos = str2num(x_pos);
if isempty(x_pos) 
else
    object(1,:) = object(1,:) + x_pos;
end

y_pos = get(handles.edit_yobject,'String');
y_pos = str2num(y_pos);
if isempty(y_pos) 
else
object(2,:) = object(2,:) + y_pos;
end

z_pos = get(handles.edit_zobject,'String');
z_pos = str2num(z_pos);
if isempty(z_pos)  
else

object(3,:) = object(3,:) + z_pos;
end

end

