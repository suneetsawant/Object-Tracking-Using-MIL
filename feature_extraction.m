function [features] = feature_extraction(input_image,feature_size,index_i,index_j)
% function [features] = feature_extraction(input_image,feature_size)

    [h,w] = size(input_image);
    
    % Compute integral image
    I = integralImage(input_image);
   
   hs = feature_size;
   ly = h-hs-1;
   lx = w-hs-1;
   k =1;
%    index_i = randperm(lx);
%    index_j = randperm(ly);
   for i=1:lx/2
       for j=1:ly/2
        % left top corner = x1,y1 ; right top corner= x2,y1
     % left bottom = x1,y2;    right bottom = x2,y2   
            x1 = index_i(i);
            y1 = index_j(j); 
            x2 = x1 + hs;      y2 = y1 + hs; 
            
            step = (hs/3);
      % Compute  horizontal features 
     m1_top_x = x1 + step ;       m1_top_y = y1;
     m1_bottom_x = m1_top_x;      m1_bottom_y = y2;
      
     m2_top_x = m1_top_x + step;  m2_top_y = y1;
     m2_bottom_x = m2_top_x ;     m2_bottom_y = y2;
    
     left_area = I(m1_bottom_y,m1_bottom_x) + I(y1,x1) - I(m1_top_y,m1_top_x) - I(y2,x1) ; 
     middle_area = I(m2_bottom_y,m2_bottom_x) + I(m1_top_y,m1_top_x) - I(m2_top_y,m2_top_x) - I(m1_bottom_y,m1_bottom_x);
     right_area = I(y2,x2) + I(m2_top_y,m2_top_x) - I(y1,x2) - I(m2_bottom_y,m2_bottom_x);
     
          Hx = (left_area + right_area - middle_area )/hs^2;

     % Compute vertical features
     
     m1_top_x = x1  ;      m1_top_y = y1+step;
     m1_bottom_x = x2;      m1_bottom_y = m1_top_y;
      
     m2_top_x = x1;        m2_top_y = m1_top_y + step;
     m2_bottom_x =x2 ;     m2_bottom_y = m2_top_y;
     
     top_area = I(m1_bottom_y,m1_bottom_x) + I(y1,x1) - I(m1_top_y,m1_top_x) - I(y1,x2) ; 
     middle_area =  I(m2_bottom_y,m2_bottom_x) + I(m1_top_y,m1_top_x) - I(m2_top_y,m2_top_x) - I(m1_bottom_y,m1_bottom_x);
     down_area = I(y2,x2) + I(m2_top_y,m2_top_x) - I(y2,x1) - I(m2_bottom_y,m2_bottom_x);
     
     Hy = (top_area -middle_area + down_area)/hs^2;
     
     features(k) = Hx ;
     features(k+1)= Hy;
     
%      rect(:,m) = [i,j];
     k = k + 2;
       end
   end
end