function [h_pos, h_neg, mu, sigma]= generate_weak_classifier(pos_features,neg_features,mu,sigma,gamma)
N1= size(pos_features,2);
N2= size(neg_features,2);
% N  =N1 + N2;
h_pos= zeros(size(pos_features,1),size(pos_features,2));
h_neg= zeros(size(neg_features,1),size(neg_features,2));

% gamma = 0.5;
for k = 1:size(pos_features,1)
    
    mu(k,1) = gamma*mu(k,1) + (1-gamma)*(1/N1)*(sum(pos_features(k,:)));
    temp1 = sum((pos_features(k,:)-mu(k,1)).^2);
    sigma(k,1) = gamma*sigma(k,1) + (1-gamma)*(sqrt((1/N1)*temp1));
    
    mu(k,2) = gamma*mu(k,2) + (1-gamma)*(1/N2)*(sum(neg_features(k,:)));
    temp0 = sum((neg_features(k,:)-mu(k,2)).^2);
    sigma(k,2) = gamma*sigma(k,2) + (1-gamma)*(sqrt((1/N2)*temp0));
    
    prob_f_given_y1 = normpdf(pos_features(k,:),mu(k,1),sigma(k,1));
    prob_f_given_y0 = normpdf(pos_features(k,:),mu(k,2),sigma(k,2));
    %     h_pos(k,:) = log(realmin+prob_f_given_y1) - log(realmin+prob_f_given_y0);
    h_pos(k,:) = log(prob_f_given_y1) - log(prob_f_given_y0);
         h_pos(k,:) = h_pos(k,:)/size(pos_features,2);
    
    
    prob_f_given_y1 = normpdf(neg_features(k,:),mu(k,1),sigma(k,1));
    prob_f_given_y0 = normpdf(neg_features(k,:),mu(k,2),sigma(k,2));
    %     h_neg(k,:) = log(realmin+prob_f_given_y1) - log(realmin+prob_f_given_y0);
    h_neg(k,:) = log(prob_f_given_y1) - log(prob_f_given_y0);
         h_neg(k,:) = h_neg(k,:)/size(pos_features,2);
    
end
end