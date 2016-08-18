function[pos_bag,x_pos,y_pos,neg_bag,x_neg,y_neg] = generate_dataset(I,l,r,beta,patch_size,npos,nneg)
   
    [pos_bag,x_pos,y_pos]=crop(I,l,0,r,patch_size,npos,1);   % generate positive patches
    [neg_bag,x_neg,y_neg]=crop(I,l,r,beta,patch_size,nneg,1);% generate negative patches
end