function[pos_patch,neg_patch,pos_patch_centres,neg_patch_centres]= generate_patches(image,r,centre,beta,patch_size,scale)

[h,w] = size(image);
siz = patch_size/2;
k= 1;
imshow(image/255);

for i = 1:h
    for j = 1:w
        d = sqrt((i-centre(1))^2+(j-centre(2))^2);
        if (d < r )
            if(i-siz>0 && i+siz<h && j-siz>0 && j+siz<w)
                
                pos_patch(:,:,k) = image(i-siz:i+siz,j-siz:j+siz);
                X = pos_patch(:,:,k);
                X=X-mean(X(:));
                X=X/std(X(:));
                pos_patch(:,:,k)=X;
%                 rectangle('Position', [i-siz j-siz patch_size patch_size] ,'EdgeColor','g');
                pos_patch_centres(k,:) = [i,j];
                k = k+1;
            end
        end
    end
end
k=1;
index_i = randperm(h);
index_j = randperm(w);
for i= 1:scale
    for j=1:scale
        d = sqrt((index_i(i)-centre(1))^2+(index_j(j)-centre(2))^2);
        if( d<beta && d>r)
            
            if(index_i(i)-siz>0 && index_i(i)+siz<h && index_j(j)-siz>0 && index_j(j)+siz<w)
                neg_patch(:,:,k) = image(index_i(i)-siz:index_i(i)+siz,index_j(j)-siz:index_j(j)+siz);
                a = index_i(i);b = index_j(j);
                X = neg_patch(:,:,k);
                X=X-mean(X(:));
                X=X/std(X(:));
                neg_patch(:,:,k)=X;
%                 imshow(neg_patch(:,:,k)/255);
                neg_patch_centres(k,:) = [index_i(i) index_j(j)];
                
%                 hold on;
%                 rectangle('Position', [index_i(i)-siz index_j(j)-siz patch_size patch_size] ,'EdgeColor','r');
                k= k+1;
                
            end
        end
    end
end

end