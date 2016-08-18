function [patch,x_patch,y_patch] = crop_new(I,center,r,beta,Height,T,step_size)
%center = object center in frame t-1
%r,beta
%Height =height of square patch,
%T=no. of patches
%step =  distance for succesive patches

[Ix,Iy] = size(I);
x_patch = zeros(T,1);
y_patch = zeros(T,1);
patch = zeros(Height,Height,T);   %i,j,patch index
t = 1;
for y=center(2)+r:step_size:center(2)+beta
    for x=center(1)+r:step_size:center(1)+beta
        if(r <sqrt((x-center(1))^2+(y-center(2))^2) && sqrt((x-center(1))^2+(y-center(2))^2)<beta)
            if(x+Height/2<Ix && x-Height/2>0 && y+Height/2<Iy  && y-Height/2>0)
                x_patch(t,1) = x;
                y_patch(t,1) = y;
                temp = I(x-Height/2:x+Height/2,y-Height/2:y+Height/2);
                for i = 1:Height
                    for j = 1:Height
                        patch(i,j,t) = temp(i,j);
                    end
                end
                t = t+1;
            end
        end
        if t == T+1
            break;
        end
    end
    if t == T+1
        break;
    end
end
end


