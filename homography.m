function[H] = homography(img_base, img_target)

% HOMOGRAPHY: computes the homography matrix between img and img_prim, to 
% satisfy the equation IMG_TARGET = H*IMG_BASE; 

% NOTE: ASSUMPTION OF SAME NUMBER OF POINTS IN BOTH IMAGES

%--------------------------------------------------------------------------
       u_avg = 0;   % -> average x-pixel points
       v_avg = 0;   % -> average y-pixel points
       n = 0;       % -> number of IMG points
       
       t_u = 0;     % -> scaling factor;
       t_v = 0;     % -> scaling factor;
          
     % 1) NORMALIZE IMG POINTS

        average_base = sum(img_base,2)/size(img_base,2);
            % -> finds the average image coordinates
        u_avg = average_base(1);          
        v_avg = average_base(2);        
        n = size(img_base,2);
                   
        sig2u =  (1/n)*(sum( (img_base(1,:)-u_avg).^2 ) );
        su = sqrt(2)/sig2u;
        sig2v = (1/n)*(sum( (img_base(2,:)-v_avg).^2 ) );
        sv = sqrt(2)/sig2v;
        
        % create normalization Matrix T    


        t_u = -su*u_avg;
        t_v = -sv*v_avg;
    
        T_base_norm = [su 0  t_u; 0 sv t_v; 0 0 1];

        img_base = T_base_norm*img_base;
            % -> normalizes IMG points
            
%--------------------------------------------------------------------------
       u_avg = 0;   % -> average x-pixel points
       v_avg = 0;   % -> average y-pixel points
       n = 0;       % -> number of IMG points
       
       t_u = 0;     % -> scaling factor;
       t_v = 0;     % -> scaling factor;

    % 2) NORMALIZE IMG_PRIM POINTS
    
        average_target = sum(img_target,2)/size(img_target,2);
            % -> finds the average image coordinates
        u_avg = average_target(1);
        v_avg = average_target(2);
        n = size(img_target,2);
        
        sig2u =  (1/n)*(sum( (img_target(1,:)-u_avg).^2 ) );
        su = sqrt(2)/sig2u;
        sig2v = (1/n)*(sum( (img_target(2,:)-v_avg).^2 ) );
        sv = sqrt(2)/sig2v;



        t_u = -su*u_avg;
        t_v = -sv*v_avg;
    
        T_target_norm = [su 0  t_u; 0 sv t_v; 0 0 1];
        
        img_target = T_target_norm*img_target;
            % -> normalizes IMG_PRIM points


%-------------------------------------
    % 4) COMPUTE THE MATRIX H

        H = zeros(2*size(img_base,2),9);
        for i = 1:(size(img_base,2))
            H(1+(i-1)*2,:) = [img_base(1,i) img_base(2,i) img_base(3,i) 0 0 0 -img_base(1,i)*img_target(1,i) -img_base(2,i)*img_target(1,i) -img_base(3,i)*img_base(1,i) ];
            H(2*i,:) = [0 0 0  -img_base(1,i) -img_base(2,i) -img_base(3,i) img_base(1,i)*img_target(2,i) img_base(2,i)*img_target(2,i) img_base(3,i)*img_target(2,i) ];
        end        
     
        [Vec Val] = eig(H'*H);
        [row col] = find(min(sum(Val)));
        H = Vec(:,col);
       
        % gold standard
        options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt');
        x = lsqnonlin(@hom_inital_costfun, H , [],[], options, img_base, img_target);
        H = [x(1:3,1)'; x(4:6,1)'; x(7:9,1)'];
        H = inv(T_target_norm)*H*T_base_norm;    
     
  
     
    