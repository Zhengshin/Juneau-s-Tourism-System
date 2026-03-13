%% Mumbai Sustainable Tourism Model Optimization Analysis (Infrastructure-Limited Case)
clear; clc; close all;

% Base Parameters (Adjusted for Infrastructure-Limited Scenario)
params.sigma1 = 300;     % Average tourist spending (USD/person/day)
params.gamma = 0.05/24;  % Tax suppression coefficient (calibrated so tourists drop to zero at 8% tax)
params.u0 = 0.05;        % Natural tourist growth rate (1/year)
params.sigma2 = 0.25;    % Environmental pressure coefficient (waste/water pollution)
params.beta1 = 0.8;      % Environmental investment efficiency
params.beta2 = 1.05;     % Infrastructure investment efficiency (+50%)
params.beta3 = 0.6;      % Social project efficiency
params.sigma3 = 0.4;     % Per-tourist infrastructure pressure coefficient (relatively high)
params.N_max = 20000;    % Maximum tourist capacity
params.I_max = 2100;     % Infrastructure pressure upper limit
params.epsilon = 0.002;  % Employment conversion coefficient
params.lambda = 0.4;     % Employment satisfaction gain
params.eta = 0.12;       % Congestion loss coefficient (relatively high)

% Weight Coefficients
c1 = 0.3;   % Environmental pressure weight
c2 = 2.0;   % Social satisfaction weight
c3 = 1.5;   % Infrastructure overload penalty weight

% Investment Allocation Ratios
alpha = [0.4, 0.4, 0.2];  % Environmental:Infrastructure:Community = 4:4:2

%% Data Calculation Module
tax_rates = linspace(0, 0.08, 100);  % Tax rate range 0-8%
T = tax_rates * params.sigma1;       % Convert to absolute tax per tourist

% Preallocate arrays
[N, Z, Infrastructure, Penalty] = deal(zeros(size(T)));

for i = 1:length(T)
    % Tourist number calculation (linear model)
    N(i) = min(max(params.N_max*(1 - T(i)/24), 0), params.N_max);
    
    % Economic indicators
    R = T(i) * N(i);  % Total tax revenue
    
    % Environmental pressure
    E = params.sigma2*N(i) - params.beta1*alpha(1)*R;
    
    % Infrastructure pressure
    I = params.sigma3*N(i) - params.beta2*alpha(2)*R;
    Penalty(i) = max(I - params.I_max, 0);  % Overload penalty
    
    % Social satisfaction
    S = (params.epsilon*params.lambda - params.eta)*N(i) + params.beta3*alpha(3)*R;
    
    % Comprehensive benefit (including infrastructure penalty)
    Z(i) = R - c1*E - c3*Penalty(i) + c2*S;
end

% Find optimal values
[Z_max, idx] = max(Z);
optimal = struct(...
    'tax_rate', tax_rates(idx),...
    'T', T(idx),...
    'N', N(idx),...
    'Z', Z_max);

%% Visualization Analysis
figure('Position', [100 100 1200 500])

% Tax Rate vs Comprehensive Benefit
subplot(1,2,1)
plot(tax_rates*100, Z/1e6, 'b-', 'LineWidth', 2)
hold on
plot(optimal.tax_rate*100, optimal.Z/1e6, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
xlabel('Tourist Tax Rate (%)'), ylabel('Comprehensive Benefit Z (Million USD)')
title(sprintf('Tax Rate Optimization\nOptimal: %.1f%%, Z=%.1fM USD',...
    optimal.tax_rate*100, optimal.Z/1e6))
grid on
annotation('textbox', [0.2 0.7 0.2 0.1], 'String',...
    sprintf('Infrastructure Overload\nPenalty: $%.1fM',...
    max(Penalty)/1e6), 'EdgeColor', 'none')

% Tourist Numbers vs Comprehensive Benefit
subplot(1,2,2)
plot(N/1e3, Z/1e6, 'm-', 'LineWidth', 2)
hold on
plot(optimal.N/1e3, optimal.Z/1e6, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
xlabel('Tourist Numbers (Thousand Persons)'), ylabel('Comprehensive Benefit Z (Million USD)')
title(sprintf('Tourist Capacity Optimization\nOptimal: %.1fK Persons', optimal.N/1e3))
grid on

%% Results Report
fprintf('\n============ Mumbai Optimization Report ============\n')
fprintf('Optimal Tax Rate: \t%.1f%% (Tax: $%.1f/Person)\n',...
    optimal.tax_rate*100, optimal.T)
fprintf('Optimal Tourist Numbers: \t%.1fK Persons/Day\n', optimal.N/1e3)
fprintf('Maximum Comprehensive Benefit: \t$%.1f Million\n', optimal.Z/1e6)
fprintf('====================================================\n')