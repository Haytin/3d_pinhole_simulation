function[img_dist] = distort(img, radial_coeffs, tangential_coeffs)

    % SET DISTORTION PARAMETERS
        k1 = radial_coeffs(1) ;
        k2 = radial_coeffs(2);
            % -> sets radial distortion coeffs.
            
        p1 = tangential_coeffs(1);     
        p2 = tangential_coeffs(2);   
            % -> sets tangential distortion coeffs.
  
    % CALCULATE DISTORTED COORDINATES

            % -> sets image center in pixel coordinates 

        r = sqrt((img(1,:)).^2 + (img(2,:)).^2);
            % -> radius for each ideal point in pixel coordinates

        img_dist = ones(3,size(img,2));
        
        img_dist(1,:) = img(1,:) + img(1,:).*((k1*r.^2 +k2*r.^4))...
                            + p1*(r + 2*img(1,:).^2) + 2*p2*img(1,:).*img(2,:) ;                      
        img_dist(2,:) = img(2,:) + img(2,:).*((k1*r.^2 + k2*r.^4) )...
                           + 2*p1*img(1,:).*img(2,:) + p2*(r + 2*img(2,:).^2) ;               


