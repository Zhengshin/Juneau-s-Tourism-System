# Juneau-s-Tourism-System
# Sustainable Tourism Dynamic Optimization and City Diagnosis

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2021a%2B-blue)](https://www.mathworks.com/products/matlab.html)

This repository contains the complete MATLAB implementation for the **MCM/ICM 2025 paper**:

**"Tourists or Icebergs? Dynamic Optimization of Juneau's Tourism System under Feedback Constraints"**

The project develops a **multi-objective sustainable tourism framework** based on **system dynamics**, **feedback mechanisms**, **genetic algorithm optimization**, and **entropy-weighted city diagnosis**.  
It is designed to balance **economic return**, **environmental stress**, **infrastructure carrying capacity**, and **resident satisfaction** under overtourism pressure.

---

## Abstract

This project studies the sustainable tourism problem in **Juneau, Alaska**, where rapid tourism growth creates feedback effects on glacier retreat, environmental burden, infrastructure overload, and local satisfaction.

To address this, we construct:

- a **dynamic optimization model** for tourist number and tax policy,
- a **feedback-constrained objective function** for comprehensive tourism benefit,
- an **entropy-weighted classification system** for cross-city diagnosis,
- and an **adaptive policy application framework** for different city types.

The framework is then extended to representative cities such as **Mumbai**, **Venice**, **Reykjavik**, **Kyoto**, **Athens**, and **Singapore**.

---

## Main Contributions

### 1. Juneau Sustainable Tourism Optimization
A system-dynamics model is established to characterize the interaction among:

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
A perturbation-based sensitivity analysis is conducted to identify the most influential model parameters and evaluate the robustness of the optimization results.

### 4. Cross-City Diagnosis and Application
An entropy-weighted diagnosis framework is constructed using three dimensions:

- **E** — Ecological sensitivity
- **I** — Infrastructure carrying capacity
- **C** — Cultural preservation

Cities are classified into dominant, composite, or balanced types, and the optimization framework is adapted accordingly.

---

## Repository Structure

```text
.
├── City Classification          # Entropy-weighted city diagnosis system
├── Countermeasures Analysis     # Policy recommendations and intervention strategies
├── Example Optimization         # Example optimization workflows and outputs
├── Optimization                 # Core Juneau / city optimization models
├── Visualization                # Plots, radar charts, 3D surfaces, and figure scripts
├── LICENSE                      # MIT license
└── README.md                    # Project documentation
```

---

## Methodology

The project consists of four methodological layers:

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

---

## How to Run

### Requirements

- **MATLAB R2021a or later**
- No additional toolboxes required

### Clone the repository

```bash
git clone https://github.com/Zhengshin/sustainable-tourism-juneau.git
cd sustainable-tourism-juneau
```

### Run by module

Open MATLAB and run scripts inside the corresponding folders.

#### Optimization

```text
Optimization/
```

#### City classification

```text
City Classification/
```

#### Example workflows

```text
Example Optimization/
```

#### Visualization

```text
Visualization/
```

---

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

---

## Visualization Output

The project generates multiple visualization outputs, including:

- 3D parameter-space analysis
- tax-rate optimization curves
- tourist-number optimization curves
- radar charts for city diagnosis
- sensitivity analysis figures
- tourist flow control illustrations

These visual outputs support both model interpretation and policy communication.

---

## Academic Context

This repository corresponds to the **MCM/ICM 2025** submission and reflects the major components of the paper:

- sustainable tourism modeling,
- feedback-constrained dynamic optimization,
- sensitivity analysis,
- entropy-weighted city diagnosis,
- adaptive countermeasure design.
---
