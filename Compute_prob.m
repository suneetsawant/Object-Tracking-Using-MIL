function [prob_y_given_x] = Compute_prob(x,h,K)

h_best = zeros(K,size(x,2));

for k = 1:size(h,2)
    
    m = h(1,k);
    
    prob_f_given_y1 = normpdf(x(m,:),h(2,k),h(3,k));
    prob_f_given_y0 = normpdf(x(m,:),h(4,k),h(5,k));
    h_best(k,:) = log(realmin+prob_f_given_y1) - log(realmin+prob_f_given_y0);
%        h_best(k,:) = log(prob_f_given_y1) - log(prob_f_given_y0);

end
H1 = sum(h_best,1);
prob_y_given_x = sigmf(H1,[1 0]);
% b = mean(H1);
% a= ones(1,size(H1,2))*b;
% a = H1 - a;
% prob_y_given_x1 = sigmf(a,[1 0]);

end


