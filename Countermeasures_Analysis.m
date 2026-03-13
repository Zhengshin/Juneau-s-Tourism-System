%% Optimization Under Strictly Decreasing Allocation Constraints
clear; clc; close all;

% Fixed parameters
T = 5.3;        % Optimal tax per tourist (USD/person)
N = 7900;       % Optimal number of tourists (persons/day)
R = T * N;      % Total tax revenue

% Model parameters
sigma2 = 0.2; kappa = 0.001; beta1 = 0.8;
epsilon = 0.002; lambda = 0.4; eta = 0.15; beta3 = 0.6;
c1 = 1; c2 = 1; 

% Constraint parameters
min_alpha = 0.10;  % Minimum share for each project
step = 0.01;

%% Generate constrained parameter grid
alpha1_range = linspace(0.34, 0.85, 50); % alpha1 must satisfy alpha1 > alpha2 > alpha3 and alpha3 >= 10%
valid_pairs = [];
for a1 = alpha1_range
    % Compute upper bound of alpha2: alpha2 <= (1 - a1)/2 (since alpha2 > alpha3 and alpha3 = 1-a1-a2)
    a2_max = min(a1 - step, (1 - a1)/2); 
    a2_min = max(min_alpha, 1 - a1 - a1 + step); % Ensure alpha3 < alpha2
    if a2_min > a2_max
        continue
    end
    a2_vals = linspace(a2_min, a2_max, 50);
    
    for a2 = a2_vals
        a3 = 1 - a1 - a2;
        if a3 >= min_alpha && a3 < a2
            valid_pairs = [valid_pairs; a1, a2, a3];
        end
    end
end

%% Calculate comprehensive benefit
Z = zeros(size(valid_pairs,1),1);
for i = 1:size(valid_pairs,1)
    a1 = valid_pairs(i,1);
    a2 = valid_pairs(i,2);
    a3 = valid_pairs(i,3);
    
    % Environmental pressure
    E = sigma2*N + kappa*N - beta1*a1*R;
    
    % Social satisfaction
    S = (epsilon*lambda - eta)*N + beta3*a3*R;
    
    % Comprehensive benefit
    Z(i) = R - c1*E + c2*S;
end

%% Find optimal solution
[maxZ, idx] = max(Z);
opt_alpha = valid_pairs(idx,:);

%% 3D visualization
figure('Position', [200 200 1000 800])
tri = delaunay(valid_pairs(:,1), valid_pairs(:,2));
trisurf(tri, valid_pairs(:,1), valid_pairs(:,2), Z/1e3, 'EdgeColor', 'none')
hold on
scatter3(opt_alpha(1), opt_alpha(2), maxZ/1e3, 200, 'r', 'filled')
xlabel('Environmental Protection \alpha_1'), ylabel('Infrastructure \alpha_2'), zlabel('Comprehensive Benefit Z (thousand USD)')
title('Optimization Under Strictly Decreasing Allocation Constraints')
colormap(jet)
colorbar
view(40,25)

% Mark optimal solution
text(opt_alpha(1)+0.03, opt_alpha(2), maxZ/1e3+5,...
    sprintf('Optimal Allocation:\n\\alpha_1=%.0f%%\n\\alpha_2=%.0f%%\n\\alpha_3=%.0f%%\nZ=%.1fK',...
    opt_alpha*100, maxZ/1e3), 'Color','w', 'FontWeight','bold',...
    'BackgroundColor',[0.2 0.2 0.2])

%% Text output
fprintf('======== Optimal Scheme Under Strictly Decreasing Allocation ========\n');
fprintf('Environmental Investment alpha1 = %.1f%% (beta1 = 0.8)\n', opt_alpha(1)*100);
fprintf('Infrastructure Investment alpha2 = %.1f%% (beta2 = 0.7)\n', opt_alpha(2)*100);
fprintf('Social Projects alpha3 = %.1f%% (beta3 = 0.6)\n', opt_alpha(3)*100);
fprintf('----------------------------------------\n');
fprintf('Environmental efficiency ratio = %.1f (infrastructure) / %.1f (social)\n',...
    beta1/beta2, beta1/beta3);
fprintf('Comprehensive Benefit Z = %.1f thousand USD\n', maxZ/1e3);
fprintf('Environmental Pressure E = %.0f (threshold 5000)\n', sigma2*N + kappa*N - beta1*opt_alpha(1)*R);
fprintf('Satisfaction S = %.1f (minimum 100)\n', (epsilon*lambda - eta)*N + beta3*opt_alpha(3)*R);
fprintf('======================================\n');