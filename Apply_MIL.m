function [prob_y_given_x] = Apply_MIL(x,h,no_of_classifiers)

h_best = zeros(no_of_classifiers,size(x,2));
prob_y_given_x = zeros(size(x,2),1);

for k = 1:size(h,2)

m = h(1,k);
for i=1:size(x,2)
    prob_f_given_y1 = normpdf(x(m,i),h(2,k),h(3,k));
    prob_f_given_y0 = normpdf(x(m,i),h(4,k),h(5,k));
    h_best(m,i) = log(1e-5*ones(size(x,1),1)+prob_f_given_y1) - log(1e-5*ones(size(x,1),1)+prob_f_given_y0);    
end
end
for j = 1:size(x,2)
    prob_y_given_x(j,1) = 1/(1+e^(-sum(h_best(:,j))));
end
end


