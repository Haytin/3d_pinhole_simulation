function[K_dlt, Rt_dlt] = dlt(object, img)

% DLT: RECOVERS THE PROJECTION MATRIX, BY USING THE DIRECT LINEAR
% TRANSFORMATION ALOGORITHM

    % PARAMETERS
        % sign_scalefactor = 1/-1
        % -> sets the sign of the scale factor. Note: The Computation of
        % the proj. matrix 'P' can only determined up to the abs. value. The
        % correct sign has to be identified and set by the user.
%-------------------------------------------------------------------------
    % 1) SET SIGN PARAMTER
        sign = 1;
        
        % -> cut off all object coordinates out of sensor range
 
    % 2) NORMALIZE IMAGE POINTS
            % NOTE: normalization means: using a transformation matrix T to
            % rescale and translate image coordinates, so that the centroid
            % lays in the origin of the image CS, respec. the average 
            % coordinate is [1,1,1]^T.
        
        img_average = sum(img,2)/size(img,2);
            % -> finds the average image coordinates
        u_av = img_average(1);
        v_av = img_average(2);
        n = size(img,2);
             
        sig2u =  (1/n)*(sum( (img(1,:)-u_av).^2 ) );
        su = sqrt(2)/sig2u;
        sig2v = (1/n)*(sum( (img(2,:)-v_av).^2 ) );
        sv = sqrt(2)/sig2v;
        t_u = -su*u_av;
        t_v = -sv*v_av;   
        T = [su 0  t_u; 0 sv t_v; 0 0 1];
        img = T*img;


%--------------------------------------------------------------------------

    % 3) NORMALIZE WORLD POINTS
            % NOTE: normalization means: using a transformation matrix T to
            % rescale and translate object coordinates, so that the centroid
            % lays in the origin of the world CS, respec. the average 
            % coordinate is [1,1,1,1]^T.
        
        obj_pt_average = sum(object,2)/size(object,2);
            % -> finds the avera image coordinates        
        x_av = obj_pt_average(1);
        y_av = obj_pt_average(2);
        z_av = obj_pt_average(3);
        n = size(object,2);

        sig2x =  (1/n)*(sum( (object(1,:)-x_av).^2 ) );
        sx = sqrt((3))/sig2x;
        
        sig2y = (1/n)*(sum( (object(2,:)-y_av).^2 ) );
        sy = sqrt((3))/sig2y;
    
        sig2z = (1/n)*(sum( (object(3,:)-z_av).^2 ) );
        sz = sqrt((3))/sig2z;
        
        tx = -sx*x_av;
        ty = -sy*y_av;
        tz = -sz*z_av;
           

       U = [sx 0 0 tx; 0 sy 0 ty; 0 0 sz tz; 0 0 0 1];
            % -> generates normalizing matrix 
        object  = U*object;

%------------------------------------------------------------------------
    % 4) COMPUTE THE MATRIX G
            % -> EQN: G*P = 0

     G = zeros(2*size(object,2),12);

     for i = 1:(size(object,2))
        G(1+(i-1)*2,:) = [object(1,i) object(2,i) object(3,i) 1 0 0 0 0 -object(1,i)*img(1,i) -object(2,i)*img(1,i) -object(3,i)*img(1,i) -img(1,i)];
        G(2*i,:) = [0 0 0 0 -object(1,i) -object(2,i) -object(3,i) -1 object(1,i)*img(2,i) object(2,i)*img(2,i) object(3,i)*img(2,i) img(2,i)];
     end
     
% -------------------------------------------------------------------------
%         [M D V] = svd(G);
%         P = V(:,end);
%             % -> p is the last column of V
% 
%         P = [P(1:4,1)'; P(5:8,1)'; P(9:12,1)'];
%         
%         P_dlt = inv(T)*P*U;
%             % -> undo normalization matrices     

      % 5) USE THE EIGENVECTOR WITH THE LEAST EIGENVALUE
        [Vec Val] = eig(G'*G);
        [row col] = find(min(sum(Val)));
        P = Vec(:,col);       

        %use nonlinear optimization 
         options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt');
         x = lsqnonlin(@dlt_costfun, P , [],[], options, img, object);
         P = [x(1:4,1)'; x(5:8,1)'; x(9:12,1)'];         
         P_dlt = inv(T)*P*U;

%--------------------------------------------------------------------------



% 6) GET INTRINSIC PARAMETERS
        A = P_dlt(:,1:3)*P_dlt(:,1:3)';
        compensate_factor = (1/A(3,3));
            % -> gets the quadratic factor to normalize K
        A = A.*compensate_factor;
            % -> compensate with founded factor 
        s = sqrt(compensate_factor);
        s = s * sign;
            % -> set correct sign
        P_dlt = P_dlt*s;
 
        
        x_0 = A(3,1);
        y_0 = A(3,2);
        a_y = sqrt(A(2,2)-y_0^2);
        skew = (A(1,2)-x_0*y_0)/a_y;
        a_x = sqrt(A(1,1)-x_0^2-skew^2);
        
        K_dlt = [a_x 0 x_0;...
                0 a_y y_0;...
                0 0 1];
        
% -------------------------------------------------------------------------
     % 7) GET EXTRINSIC PARAMETERS

        
         R_dlt = inv(K_dlt) * P_dlt(:,1:3);
         t_dlt = inv(K_dlt) * P_dlt(:,end) ;
         
         
         Rt_dlt = [R_dlt t_dlt];
         
%--------------------------------------------------------------------------


  


