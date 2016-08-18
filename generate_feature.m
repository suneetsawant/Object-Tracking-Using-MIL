function [feature_values] = generate_feature(bag,feature_size,index_i,index_j)
for i=1:size(bag,3)
    feature_values(:,i) = feature_extraction(bag(:,:,i),feature_size,index_i,index_j);
end

end