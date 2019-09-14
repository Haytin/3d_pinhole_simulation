function [object] = get_object(object_num, handles)
%GET_OBJECT Summary of this function goes here
%   Detailed explanation goes here

switch object_num
    
    case 2 %landscape
        load('landscape.mat');    
               
    case 3 %sphere
            [x y z] = sphere(10);
            object = [x(:)'; y(:)'; z(:)'; ones(1, length(x(:)))];
    
    case 4 % flat
           [x y]= meshgrid(0:5,0:5);
           object = [x(:)'; y(:)'; zeros(1, length(x(:))); ones(1, length(x(:)))];

    case 5 %pyramid
           load('pyramid.mat');    
  
    case 6 %inv pyramid
           load('ipyramid.mat');
           
    case 7 %angleplane
           load('angleplane.mat');          
              
    case 8 %checkerboard
           [x y]= meshgrid(-5:6, -5:6);
           a = [5 5 0 0];
           b = [0 0 5 5]; 
           z1 = repmat(a,2,3);
           z2 = repmat(b,2,3);
           z = repmat([z1;z2],3,1);
           object = [x(:)'; y(:)'; z(:)' ; ones(1, length(x(:)))];
               
     case 9 %steps
           [x y]= meshgrid(-5:6, -5:6);
           a = [5 5 5 5];
           b = [0 0 0 0]; 
           z1 = repmat(a,6,3);
           z2 = repmat(b,6,3);
           z = repmat([z1;z2],1,1);
           object = [x(:)'; y(:)'; z(:)' ; ones(1, length(x(:)))];
           
    case 10 % 3drand
           [x y]= meshgrid(-5:6, -5:6);
           z = abs(rand(1, length(x(:)))).*2;
           object = [x(:)'; y(:)'; z ; ones(1, length(x(:)))];

end

[object] = set_objectposition(object, handles);


object(1:3,:) = object(1:3,:)./10;
end
