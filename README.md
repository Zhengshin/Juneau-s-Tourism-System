# Juneau Sustainable Tourism System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![MATLAB](https://img.shields.io/badge/MATLAB-R2021a%2B-blue)](https://www.mathworks.com/products/matlab.html)

This repository contains the MATLAB implementation of the **MCM 2025**:

**"Tourists or Icebergs? Dynamic Optimization of Juneau's Tourism System under Feedback Constraints"**

The project develops an **optimization-centered scientific machine learning / AI-for-decision-making framework** for sustainable tourism. It combines **system dynamics**, **feedback-constrained modeling**, **genetic algorithm optimization**, **entropy-weighted city diagnosis**, **sensitivity analysis**, and **data visualization** to support sustainable tourism policy design under overtourism pressure.

This project is especially relevant to AI applications in **optimization**, **statistical modeling**, **scientific machine learning**, **interpretable decision systems**, and **data-driven public policy analysis**.

## Project Overview

Juneau, Alaska faces a sustainable tourism challenge: tourism growth increases economic benefit, but it also intensifies environmental stress, glacier retreat, infrastructure overload, and resident dissatisfaction.

To address this, the project constructs:

- a **dynamic optimization model** for tourist number and tax policy,
- a **feedback-constrained objective function** for comprehensive tourism benefit,
- an **entropy-weighted E/C/I diagnosis system** for city classification,
- and an **adaptive policy application framework** for other overtourism-affected cities.

The framework is then extended to representative cities including **Mumbai**, **Venice**, **Reykjavik**, **Kyoto**, **Athens**, and **Singapore**.

## Why This Project Is Relevant to AI

Although this is not a deep-learning benchmark, it is strongly connected to core AI themes:

- **Optimization**: multi-objective policy optimization under constraints
- **Scientific ML**: mathematical modeling of real-world dynamic systems
- **Interpretable AI**: explicit objective functions, constraints, and rule-based diagnosis
- **Data analysis and visualization**: structured indicators, entropy weighting, sensitivity analysis, and visual outputs
- **Responsible AI / decision support**: balancing economy, environment, infrastructure, and social welfare in a transparent way

This project demonstrates how AI-related methods can support real-world decision-making beyond standard prediction tasks.

## Main Contributions

### 1. Juneau Sustainable Tourism Optimization

A system-dynamics model is built to characterize the interaction among:

- tourist growth,
- glacier retreat,
- environmental stress,
- infrastructure pressure,
- and resident satisfaction.

A multi-objective optimization framework is then used to maximize comprehensive tourism benefit under environmental and social constraints.

### 2. Feedback-Constrained Decision Mechanism

The model explicitly incorporates a closed-loop feedback structure:

- more tourists increase economic returns,
- but also accelerate glacier retreat and environmental pressure,
- which then reduces future attractiveness and suppresses tourism growth.

This captures the dynamic nature of sustainable tourism management.

### 3. Sensitivity Analysis

A perturbation-based sensitivity analysis is conducted to identify the most influential parameters and evaluate the robustness of the optimization results.

### 4. Cross-City Diagnosis and Application

An entropy-weighted diagnosis framework is constructed using three dimensions:

- **E** - Ecological sensitivity
- **I** - Infrastructure carrying capacity
- **C** - Cultural preservation

Cities are classified into dominant, composite, or balanced types, and the optimization framework is adapted accordingly.

## Repository Structure

- `Optimization.m` - Core Juneau / city optimization model
- `Example_Optimization.m` - Example optimization workflow and demonstration script
- `City_Classification.m` - Entropy-weighted E/I/C city diagnosis system
- `Countermeasures_Analysis.m` - Policy recommendation and intervention analysis
- `Visualization.m` - Visualization scripts for plots, radar charts, and parameter-space analysis
- `README.md` - Project documentation
- `LICENSE` - MIT License

## Methodology

The project consists of four methodological layers.

### 1. Dynamic System Modeling

The tourism system is modeled through differential or dynamic equations involving:

- tourist number,
- environmental pressure,
- resident satisfaction,
- infrastructure stress,
- and glacier retreat.

### 2. Objective Optimization

The model maximizes a comprehensive tourism benefit function under constraints such as:

- environmental upper bounds,
- infrastructure capacity,
- minimum resident satisfaction,
- and tax-regulated visitor flow.

A plain-text version of the objective is:

`L(N, tau) = -[sigma1*N*365 - c1*E(N,tau) - c2*I(N,tau) + c3*S(N,tau)] + lambda*Pi(N,tau)`

where:

- `N` is tourist volume
- `tau` is tax rate
- `E` is environmental pressure
- `I` is infrastructure stress
- `S` is resident/social benefit
- `Pi(N,tau)` is a penalty for infeasible solutions

### 3. Entropy-Weighted Classification

A multi-indicator diagnosis model is used to score each city along E/I/C dimensions and determine whether the city is:

- E-dominant
- I-dominant
- C-dominant
- E-I / E-C / I-C composite
- Balanced

### 4. Policy Adaptation

Different city types are assigned different policy adjustments, including:

- environmental investment reinforcement,
- infrastructure-oriented allocation,
- cultural-protection weighting,
- tourist flow control,
- and investment feedback mechanisms.

## How to Run

### Requirements

- **MATLAB R2021a or later**
- No additional toolboxes required

### Clone the repository

```bash
git clone https://github.com/Zhengshin/Juneau-s-Tourism-System.git
cd Juneau-s-Tourism-System
```

### Run the scripts

Open MATLAB and run the scripts depending on the purpose:

- `Example_Optimization.m` - main demonstration workflow
- `Optimization.m` - core optimization model
- `City_Classification.m` - tourism type diagnosis
- `Countermeasures_Analysis.m` - adaptive policy / countermeasure analysis
- `Visualization.m` - figure generation and visualization

## Key Results

### Juneau Optimal Policy

| Metric | Value |
|---|---|
| Optimal tourist number | 3,762 / day |
| Optimal tax rate | 1.6% |
| Optimization objective | Maximum comprehensive tourism benefit |
| Main constraint balance | Environment + infrastructure + resident satisfaction |

### Mumbai Adaptive Optimization

| Metric | Value |
|---|---|
| Diagnosed type | Infrastructure-shortage (I-dominant) |
| Optimal tourist number | 9,898 / day |
| Optimal tax rate | 4.04% |
| Strategy focus | Infrastructure-oriented adjustment |

### City Diagnosis Results

| City | Type | Primary Issue |
|---|---|---|
| Venice (Italy) | E-dominant | Ecological sensitivity |
| Mumbai (India) | I-dominant | Infrastructure shortage |
| Barcelona (Spain) | C-dominant | Cultural preservation |
| Reykjavik (Iceland) | E-I composite | Ecology + Infrastructure |
| Kyoto (Japan) | E-C composite | Ecology + Culture |
| Athens (Greece) | I-C composite | Infrastructure + Culture |
| Singapore | Balanced | All dimensions moderate |

## Strengths

- Integrates **optimization, feedback modeling, diagnosis, and visualization** in one framework
- Addresses a **real-world sustainability problem** with interpretable mathematical structure
- Provides **adaptability across different city types**
- Supports **data-driven and explainable policy recommendations**
- Demonstrates practical relevance to **scientific machine learning and AI-based decision support**

## Limitations

- The model is complex due to multiple variables and objectives
- Some cross-city inputs are stylized or literature-derived rather than collected through one uniform pipeline
- Predictions may be affected by uncertainty and parameter sensitivity
- The current implementation focuses on MATLAB-based research prototyping rather than large-scale ML engineering
