% Sustainable Tourism Optimization Model - Juneau Case Study (Tax Rate Optimization Revised)
% Ensure non-negative net profit and tax rate within 1%-20%

%% Initialization and Parameter Definition
clear; clc; close all;

% System Parameters (key parameters adjusted)
params.sigma1 = 500;     % Average daily spending per tourist (USD)
params.sigma2 = 0.2;    
params.sigma3 = 0.15;   
params.kappa = 0.001;   
params.mu = 0.003;      
params.gamma = 0.0005;   % Reduced tax impact coefficient (original 0.005)
params.u0 = 0.05;       
params.epsilon = 0.002; 
params.lambda = 0.4;    
params.eta = 0.15;      
params.beta = [0.8, 0.7, 0.6]; 

% System Constraints
constraints.N_max = 20000;   % Maximum carrying capacity adjusted to 20,000 people
constraints.E_max = 1.2;     % Slightly relaxed environmental capacity
constraints.S_min = 60;      % Minimum satisfaction unchanged

% Simulation Settings
tspan = [0 50];             % 50-year simulation period
y0 = [15000; 0; 60];        % Initial state [N0, G0, S0]

%% Grid Search Optimization (Tax Rate Mode)
tax_rate_range = 0.01:0.01:0.2;  % Tax rate range 1%-20% (step 1%)
T_values = tax_rate_range * params.sigma1;  % Convert to absolute tax per tourist

alpha_step = 0.25;   
[alpha1, alpha2, alpha3] = meshgrid(0:alpha_step:1, 0:alpha_step:1, 0:alpha_step:1);
valid = (alpha1 + alpha2 + alpha3 == 1) & (alpha1 >=0 & alpha2 >=0 & alpha3 >=0);
alphas = [alpha1(valid), alpha2(valid), alpha3(valid)];

results = zeros(length(tax_rate_range)*size(alphas,1), 7); % [TaxRate, T, α1, α2, α3, Profit, N]

% Parallel Computation for Optimization
parfor idx = 1:length(tax_rate_range)*size(alphas,1)
    i = ceil(idx/size(alphas,1));
    j = mod(idx-1, size(alphas,1))+1;
    
    tax_rate = tax_rate_range(i);
    T = tax_rate * params.sigma1;  % Calculate absolute tax
    alpha = alphas(j,:);
    
    [t, y] = ode45(@(t,y) system_eq(t,y,params,constraints,alpha,T), tspan, y0);
    
    [profit, N_final] = calculate_objective(t, y, params, constraints, alpha, T);
    
    results(idx,:) = [tax_rate, T, alpha, profit, N_final];
end

% Find Optimal Solution (ensure non-negative profit)
valid_results = results(results(:,6)>0, :);
[~, max_idx] = max(valid_results(:,6));
optimal_tax_rate = valid_results(max_idx,1);
optimal_T = valid_results(max_idx,2);
optimal_alpha = valid_results(max_idx,3:5);
optimal_N = valid_results(max_idx,7);

%% Visualization of Results
figure('Position', [100 100 1200 500])

% Tax Rate vs Net Profit
subplot(1,2,1)
scatter(valid_results(:,1)*100, valid_results(:,6)/1e6, 40, valid_results(:,7), 'filled')
hold on
plot(optimal_tax_rate*100, valid_results(max_idx,6)/1e6, 'rp', 'MarkerSize', 12)
xlabel('Tax Rate (% of \sigma_1)')
ylabel('Net Present Value (Million USD)')
title('Tax Rate Optimization')
colorbar
colormap(jet)
grid on
text(optimal_tax_rate*100+0.5, valid_results(max_idx,6)/1e6-3,...
    sprintf('Optimal: %.1f%%',optimal_tax_rate*100),'Color','red')

% Tourist Number vs Net Profit
subplot(1,2,2)
scatter(valid_results(:,7), valid_results(:,6)/1e6, 40, valid_results(:,1)*100, 'filled')
hold on
plot(optimal_N, valid_results(max_idx,6)/1e6, 'rp', 'MarkerSize', 12)
xlabel('Equilibrium Tourist Number (N)')
ylabel('Net Present Value (Million USD)')
title(sprintf('Tax Impact Analysis (Daily Tax: $%d → %.1f%%)',...
    params.sigma1, optimal_tax_rate*100))
colorbar
grid on

%% Output Report
fprintf('\n===== Optimization Report =====\n');
fprintf('Optimal Tax Rate: %.1f%% ($%.0f per tourist)\n',...
    optimal_tax_rate*100, optimal_T);
fprintf('Fund Allocation: Env %.0f%%, Infra %.0f%%, Social %.0f%%\n',...
    optimal_alpha*100);
fprintf('Projected Equilibrium: %.0f tourists/day\n', optimal_N);
fprintf('Long-term NPV: $%.2f Million\n', valid_results(max_idx,6)/1e6);

%% ========== Local Functions ==========

function dydt = system_eq(t, y, params, const, alpha, T)
    N = y(1); G = y(2); S = y(3);
    
    % Environmental Pressure (Nonlinear Model)
    E = params.sigma2*N/(1 + params.beta(1)*alpha(1)*T) + ...
        params.kappa*N - 0.1*G;
    
    % Tourist Dynamics (Improved Growth Rate Model)
    growth_rate = params.u0/(1 + params.gamma*T) - params.mu*G;
    if N > const.N_max
        growth_rate = growth_rate * 0.8;  % Soft constraint instead of hard cutoff
    end
    dNdt = N * growth_rate;
    
    % Glacier Melt Dynamics
    dGdt = params.kappa*N/(1 + 0.5*alpha(1)*T) - 0.01*G;
    
    % Satisfaction Dynamics (Enhanced Stability)
    dSdt = params.epsilon*params.lambda*sqrt(N) - params.eta*N +...
           params.beta(3)*alpha(3)*T*N;
    dSdt = max(dSdt, -0.1*S);  % Prevent rapid decline
    
    dydt = [dNdt; dGdt; dSdt];
end

function [profit, N_final] = calculate_objective(t, y, params, const, alpha, T)
    N = y(:,1); 
    G = y(:,2);
    S = y(:,3);
    
    % Pressure Calculation (with smoothing)
    E = params.sigma2*N./(1 + params.beta(1)*alpha(1)*T) + params.kappa*N;
    I = params.sigma3*N./(1 + params.beta(2)*alpha(2)*T);
    
    % Dynamic Constraint Handling
    penalty = 0;
    E_violation = max(E - const.E_max, 0);
    S_violation = max(const.S_min - S, 0);
    penalty = 1e4*(trapz(t, E_violation) + trapz(t, S_violation));
    
    % Net Present Value Calculation (Enhanced Social Benefit)
    revenue = params.sigma1*N;
    cost = E + I;
    social_benefit = 2.0*S;  % Increased social benefit weight
    discount_factor = exp(-0.02*t);  % 2% discount rate
    
    profit_integrand = (revenue - cost + social_benefit).*discount_factor;
    profit = trapz(t, profit_integrand) - penalty;
    N_final = N(end);
end