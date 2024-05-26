# PCA_Clustering_ARIMA_in_Pharmaceutical_Sector

<p align="center">
  <img width="800" height="500" src="https://www.investywise.com/wp-content/uploads/2020/02/financial-ratios-large.png">
</p>

<br>

## Team

- [Santiago Olver Moreno](https://github.com/SantiOlvera), Data Science and Actuarial Science Double Bachelor Program student at ITAM.

## Objective

The objective of this study is to optimize financial analysis in the pharmaceutical sector by applying Principal Component Analysis (PCA) and Clustering. We aim to identify the principal components that capture the most variability in the financial data, determine the variables that compose them, and form clusters of companies with similar financial characteristics.

<br>

## Methodology

- 1. We obtained financial statements of pharmaceutical companies through Yahoo Finance and calculated various financial ratios.
- 2. We performed an exploratory analysis of the financial ratios.
- 3. We applied PCA to obtain the principal components and determine the contribution of each variable to the 3 chosen components.
- 4. We used K-means clustering on the PCA values and on the original dataframe to identify groups of companies with similar financial profiles.
- 5. We compared the clustering results in both spaces (PCA vs. original) and applied Hierarchical Clustering to validate the findings.
- 6. We analyzed and interpreted the obtained results.

## Usage
- 1. Clone the repository
- 2. Open the Proyecto_Final.Rmd file in RStudio to access the analysis of pharmaceutical companies. Run the code chunks to reproduce the analysis.
- 3. Open the Dashboard.R file in RStudio to access the Shiny app comparing pharmaceutical and communication/entertainment companies. Run the app to explore the comparative analysis interactively.
