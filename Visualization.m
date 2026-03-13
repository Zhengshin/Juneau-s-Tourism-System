%% Sustainable Tourism Model Multidimensional Visualization Analysis
grid on

% Tourist Number - Satisfaction Relationship
subplot(2,2,3)
plot(N/1e3, Satisfaction/1e3, 'g-', 'LineWidth', 2)
hold on
plot(optimal.N/1e3, Satisfaction(idx)/1e3, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
xlabel('Number of Tourists (thousands)'), ylabel('Resident Satisfaction (per mille)')
title(sprintf('Tourist-Satisfaction Relationship\nOptimal Satisfaction: %.1fK', Satisfaction(idx)/1e3))
grid on

% Tourist Number - Comprehensive Benefit Relationship
subplot(2,2,4)
plot(N/1e3, Z/1e6, 'k-', 'LineWidth', 2)
hold on
plot(optimal.N/1e3, optimal.Z/1e6, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
xlabel('Number of Tourists (thousands)'), ylabel('Comprehensive Benefit Z (million USD)')
title(sprintf('Tourist-Comprehensive Benefit Relationship\nMax Z Value: %.1fM @%.1fK',...
    optimal.Z/1e6, optimal.N/1e3))
grid on

%% 3D Visualization Analysis
figure('Position', [200 200 800 600], 'Name', '3D Parameter Space Analysis')

% Generate grid data
[tax_mesh, N_mesh] = meshgrid(linspace(0, 0.08, 50), linspace(0, params.N_max, 50));
Z_mesh = zeros(size(tax_mesh));

% 3D space calculation
for i = 1:numel(tax_mesh)
    t = tax_mesh(i) * params.sigma1;
    n = N_mesh(i);
    
    R = t * n;
    E = params.sigma2*n + params.kappa*n - params.beta1*alpha(1)*R;
    S = (params.epsilon*params.lambda - params.eta)*n + params.beta3*alpha(2)*R;
    Z_mesh(i) = R - c1*E + c2*S;
end

% Plot 3D surface
surf(tax_mesh*100, N_mesh/1e3, Z_mesh/1e6, 'EdgeColor', 'none')
xlabel('Tax Rate (%)'), ylabel('Number of Tourists (thousands)'), zlabel('Comprehensive Benefit Z (million USD)')
title('3D Parameter Space Analysis')
colormap(jet)
colorbar
view(-45, 30)

% Mark optimal point
hold on
plot3(optimal.tax_rate*100, optimal.N/1e3, optimal.Z/1e6,...
    'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r')
text(optimal.tax_rate*100, optimal.N/1e3, optimal.Z/1e6,...
    sprintf(' Optimal Point: %.1f%%, %.1fK, %.1fM',...
    optimal.tax_rate*100, optimal.N/1e3, optimal.Z/1e6),...
    'Color', 'w', 'FontWeight', 'bold')

%% Results Report
fprintf('\n============ Comprehensive Optimization Results ============\n')
fprintf('Optimal Tax Rate: \t\t%.1f%% (Corresponding Tax: %.1f USD/person)\n',...
    optimal.tax_rate*100, optimal.T)
fprintf('Optimal Number of Tourists: \t%.1f thousand/day\n', optimal.N/1e3)
fprintf('Maximum Comprehensive Benefit Z: \t%.1f million USD\n', optimal.Z/1e6)
fprintf('----------------------------------------\n')
fprintf('Corresponding Net Profit: \t%.1f million USD\n', NetProfit(idx)/1e6)
fprintf('Corresponding Satisfaction: \t%.1f per mille\n', Satisfaction(idx)/1e3)
fprintf('============================================================\n')