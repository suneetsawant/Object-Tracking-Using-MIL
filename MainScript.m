clc;
clear;

% Read the input videos
% [input_video,~] = mmread('./SampleVideos/david_indoor.avi');
[input_video,~] = mmread('./SampleVideos/Test.mp4');

% [input_video,~] = mmread('./SampleVideos/cars.avi');
% [input_video,~] = mmread('./SampleVideos/footb.avi');


no_of_frames = input_video.nrFramesTotal;
%  frames = zeros(input_video.height,input_video.width,no_of_frames);
% new_frames = zeros(input_video.height,input_video.width,no_of_frames);

pausetime = 1/input_video.rate;
for i=1:no_of_frames
%     frames(:,:,i) = rgb2gray(input_video.frames(i).cdata);
    frames(:,:,i) = double(imresize(rgb2gray(input_video.frames(i).cdata),[200 320]));

end
% output_frame = zeros(size(frames,1)+1,size(frames,2)+1,3,size(frames,3));
% I = imread('barbara.png');
r = 4;
beta = 50;
s = 30;
patch_size = 40;
feature_step_size = 12;
index_i = randperm(patch_size-feature_step_size-1);
index_j = randperm(patch_size-feature_step_size-1);

%% MIL TRACK
for i = 1:150 %no_of_frames
    current_frame = frames(:,:,i);
    
if i==1
    
%  center_location = [190,120];%/david
%  center_location = [150,120];%/david
 center_location = [170,105];%toy

%  center_location = [200,226];%/cars
%  center_location = [205,145];     %/footb

% draw_rectangles(center_location,patch_size,'g');
[pos_bag,neg_bag,pos_patch_centres,neg_patch_centres]=generate_patches(current_frame,r ...
    ,center_location,beta,patch_size,110);

   pos_features = generate_feature(pos_bag,feature_step_size,index_i,index_j);
    neg_features = generate_feature(neg_bag,feature_step_size,index_i,index_j);
%      imshow(current_frame/255);    
%      draw_rectangles(pos_patch_centres,patch_size,'g');
%     draw_rectangles(neg_patch_centres,patch_size,'r');

K = 50;
M = size(pos_features,1);

mu = zeros(size(pos_features,1),2);
sigma = ones(size(pos_features,1),2);
        
% Use MILboost to calculate classifiers  
[h,mu,sigma]= MIL_BOOST(K,M,pos_features, neg_features,mu,sigma);
imshow(current_frame/255);
draw_rectangles(center_location,patch_size,'g');
 f = getframe;              %Capture screen shot
[im,map] = frame2im(f);    %Return associated image data 
if isempty(map)            %Truecolor system
  rgb = im;
else                       %Indexed system
  rgb = ind2rgb(im,map);   %Convert image data
end
 output_frame(:,:,:,i) = rgb;
pause(0.01);
continue;    
end

% Generate test set Xs 
[Test_patches,~,Test_patch_centres,~] = generate_patches(current_frame,s,center_location,beta,patch_size,30);
%    imshow(current_frame/255);    
%      draw_rectangles(Test_patch_centres,patch_size,'g');
%     draw_rectangles(neg_patch_centres,patch_size,'r');
%MIL classifier
xs_features= generate_feature(Test_patches,feature_step_size,index_i,index_j);
% p_Y_given_X = Compute_prob(pos_features,h,M);
% p_Y_given_X1 = Compute_prob(neg_features,h,M);
 p_Y_given_X = Compute_prob(xs_features,h,M);


% find index of max of pYgivenX
[prob,order] = sort(p_Y_given_X,'descend');

 [Max_prob,newLocPatch]= max(p_Y_given_X);
 center_location= [Test_patch_centres(newLocPatch,1),Test_patch_centres(newLocPatch,2)];

% Display Frame
imshow(current_frame/255);
draw_rectangles(center_location,patch_size,'g');
 f = getframe;              %Capture screen shot
[im,map] = frame2im(f);    %Return associated image data 
if isempty(map)            %Truecolor system
  rgb = im;
else                       %Indexed system
  rgb = ind2rgb(im,map);   %Convert image data
end
 output_frame(:,:,:,i) = rgb;
 pause(0.01);
f=getframe(gca);
[X, map] = frame2im(f);


% generate positive, negative bags around new center
[pos_bag,neg_bag,pos_patch_centres,neg_patch_centres]=generate_patches(current_frame,r,center_location,beta,patch_size,50);
imshow(current_frame/255);    
%      draw_rectangles(pos_patch_centres,patch_size,'g');
%     draw_rectangles(neg_patch_centres,patch_size,'r');
% pos_features = generate_feature(pos_bag,feature_step_size,index_i,index_j);
% neg_features = generate_feature(neg_bag,feature_step_size,index_i,index_j);

K = 50;
M = size(pos_features,1);    

% Use MILboost to calculate classifiers    
[h,mu,sigma]= MIL_BOOST(K,M,pos_features, neg_features,mu,sigma);    
fprintf('frame = %d \n' ,i);
end
 writevideo('output',output_frame/max(output_frame(:)),1/pausetime);




