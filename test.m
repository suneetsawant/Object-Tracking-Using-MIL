I = imread('barbara.png');
[h,w] = size(I);
patch_size = 40;
feature_step_size = 12;
%  index_i = randperm(patch_size-feature_step_size-1);
%  index_j = randperm(patch_size-feature_step_size-1);
% feature_values = feature_extraction(I(41:80,41:80),12,index_i,index_j);
% feature_values = feature_extraction(I(41:80,41:80),3);
a = 1:5;
b=  6:10;
% temp =zeros(1,5);
temp =0;
for i=1:5
    temp = temp + a(i)+b(i);
end
c = a+b;
sum(c);
% r =4;
% beta = 50
% patch_size = 40;
% centre = [h/2,w/2];
% [patches]=generate_patches(I,r,centre,beta,patch_size);
