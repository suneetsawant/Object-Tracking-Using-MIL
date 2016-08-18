function [h,mu,sigma]= MIL_BOOST(K,M,pos_features,neg_features,mu,sigma)
% mu = zeros(size(pos_features,1),2);
% sigma = ones(size(pos_features,1),2);
gamma = 0.85;
[h_pos,h_neg,mu, sigma] = generate_weak_classifier(pos_features,neg_features,mu,sigma,gamma);

H_pos = zeros(M,size(pos_features,2));
H_neg = zeros(M,size(neg_features,2));
h  = zeros(5,K);
for k = 1: K
    %     for m = 1:M
%     temp =ones(M,1);
%     for inst = 1:size(pos_features,2)
%         %             pij(:,inst) = sigmf(Hij_pos(:,inst) + h_pos(:,inst),[1 0]);
%         %             temp_1 = 1 - pij(:,inst);
%         %             temp = temp .* temp_1;
%         temp = temp .* (ones(M,1)-sigmf(H_pos(:,inst) + h_pos(:,inst),[1 0]));
%     end
   pij = sigmf(H_pos + h_pos,[1 0]);
   temp = 1-pij;
    pi_pos = 1 - prod(temp,2);
    %         pi_pos(m) = 1-temp;
    %         LL_pos(:,k) = -log(realmin+pi_pos(:,k));
    
%     LL_pos = -log(ones(M,1)-temp+realmin);
        LL_pos = log(pi_pos);


    
%     temp = zeros(M,1);
%     for inst = 1:size(neg_features,2)
%         %         pij(:,inst) = sigmf(Hij_neg(:,inst) + h_neg(:,inst),[1 0]);
%         %         temp_1 = 1 - pij(:,inst);
%         %         temp = temp .* temp_1;
%         
%         temp = temp + (-log(realmin+1-sigmf(H_neg(:,inst) + h_neg(:,inst),[1 0])));
%     end
   
%     temp = (-log(realmin+1-sigmf(H_neg+ h_neg,[1 0])));
%     p  =1-sigmf(H_neg+ h_neg,[1 0]);
%         temp2 = ((1-sigmf(H_neg+ h_neg,[1 0])));
% 
%     temp2 = 1-prod(temp2,2);
%     LL_neg = -log(1-temp2); 
     pij = sigmf(H_neg + h_neg,[1 0]);
   temp = 1-pij;
    pi_neg = 1 - prod(temp,2);
    LL_neg = log(realmin+1-pi_neg);
    Total_Log_Likelihood = LL_pos./size(pos_features,2) + LL_neg./size(neg_features,2) ;

    %     end
    
    [~,order] = sort(Total_Log_Likelihood,'descend');
    for i=1:size(order,1)
        if (ismember(order(i),h(1,:))==0)
            m = order(i);
            break;
        end
    end
    %     [mx,m] = max(Total_Log_Likelihood(:,k));
    a = H_pos;
    for i=1:size(pos_features,2)
        %         prob_f_given_y1 = normpdf(pos_features(m,i),mu(m,1),sigma(m,1));
        %         prob_f_given_y0 = normpdf(pos_features(m,i),mu(m,2),sigma(m,2));
        %         h_pos(m,i) = log(1e-5+prob_f_given_y1) - log(1e-5+prob_f_given_y0);
        H_pos(:,i) = H_pos(:,i) + ones(M,1).*h_pos(m,i);
    end
%     a = repmat(h_pos(m,:),M,1);
%     a = sum(a);
    for i=1:size(neg_features,2)
        %         prob_f_given_y1 = normpdf(neg_features(m,i),mu(m,1),sigma(m,1));
        %         prob_f_given_y0 = normpdf(neg_features(m,i),mu(m,2),sigma(m,2));
        %         h_neg(m,i) = log(1e-5+prob_f_given_y1) - log(1e-5+prob_f_given_y0);
        H_neg(:,i) = H_neg(:,i) + ones(M,1)*h_neg(m,i);
    end
    
    h(:,k) = [m,mu(m,1),sigma(m,1),mu(m,2),sigma(m,2)]';
    
end

end