# PCA_Clustering_ARIMA_in_Pharmaceutical_Sector

<p align="center">
  <img width="800" height="500" src="https://www.investywise.com/wp-content/uploads/2020/02/financial-ratios-large.png">
</p>

<br>

## Team

- [Santiago Olver Moreno](https://github.com/SantiOlvera), Data Science and Actuarial Science Double Bachelor Program student at ITAM.

## Objective

The objective of my study is to optimize financial analysis in the pharmaceutical sector by applying Principal Component Analysis (PCA) and Clustering. I aim to identify the principal components that capture the most variability in the financial data, determine the variables that compose them, and form clusters of companies with similar financial characteristics. Additionally, I leverage PySpark for real-time stock data streaming and analysis with a SARIMAX model and a correlation matrix analysis.

<br>

## Methodology

- 1. I obtained financial statements of pharmaceutical companies through Yahoo Finance and calculated various financial ratios.
- 2. I performed an exploratory analysis of the financial ratios.
- 3. I applied PCA to obtain the principal components and determine the contribution of each variable to the 3 chosen components.
- 4. I used K-means clustering on the PCA values and on the original dataframe to identify groups of companies with similar financial profiles.
- 5. I compared the clustering results in both spaces (PCA vs. original) and applied Hierarchical Clustering to validate the findings.
- 6. I analyzed and interpreted the obtained results.
- 7. I used PySpark for real-time stock data streaming and analysis:
  - Obtained stock price data every 10 seconds through the Yahoo Finance API.
  - Calculated correlation matrices for each group of financially similar companies.
  - Implemented a SARIMAX model using PySpark to predict average, minimum, and maximum stock prices for the next 20 minutes, along with confidence intervals.
  - Continuously updated the model with the latest data, providing real-time predictions.

## Usage
- 1. Clone the repository
- 2. Open the Proyecto_Final.Rmd file in RStudio to access my analysis of pharmaceutical companies. Run the code chunks to reproduce the analysis.
- 3. Open the Dashboard.R file in RStudio to access the Shiny app comparing pharmaceutical and communication/entertainment companies. Run the app to explore the comparative analysis interactively.
- 4. In your terminal, run the following command to access the real-time streaming:  streamlit run Dashboard_Streamlit2.py
 
## Video dashboard streamlit
https://www.dropbox.com/scl/fi/mh6dvviju7q5jlhiaoqhn/Screen-Recording-2024-05-28-at-9.27.57-a.m..mov?rlkey=9nmqf8mm2l3gxuvsfd5vku1xj&st=x7xwdv30&dl=0
