function [img, img_dist, cutoff_cols] = get_images(K, Rt, object, handles)

k1 = str2num(get(handles.edit_k1, 'String'));
k2 = str2num(get(handles.edit_k2, 'String'));
p1 = str2num(get(handles.edit_p1, 'String'));
p2 = str2num(get(handles.edit_p2, 'String'));

if isempty(k1)
    k1 = 0;
end
if isempty(k2)
    k2 = 0;
end
if isempty(p1)
    p1 = 0;
end
if isempty(p2)
    p2 = 0;
end



% get img
P = K*Rt;
img = P*object;
img = img.* repmat(1 ./ img(3,:), 3, 1);


%clipping
    [x1 y1] = find(img(1,:) >= K(1,3)*2);
    [x2 y2] = find(img(1,:) <= 0);
    [x3 y3] = find(img(2,:) >= K(2,3)*2);
    [x4 y4] = find(img(2,:) <= 0);
        % -> find coordinates with values > sensor size

 
    cutoff_cols = [y1 y2 y3 y4];
    cutoff_cols = sort(cutoff_cols);
    cutoff_cols(diff(cutoff_cols)==0) = [];
        % -> build cutoff vector

    img(:,cutoff_cols) = [];  
%     object(:,cutoff_cols') = [];


object_c = Rt*object;
img_n = object_c(1:3,:);
img_n = img_n .*  repmat(1./img_n(3,:), 3, 1);

% get distorted img
img_dist_n = distort(img_n, [k1 k2], [p1 p2]); 
img_dist = K(1:3,1:3)*img_dist_n;
img_dist(:,cutoff_cols) = [];  

end


