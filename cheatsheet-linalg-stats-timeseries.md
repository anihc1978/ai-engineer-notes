# Cheat Sheet: Linear Algebra · Statistics · Time-Series Vocabulary

> **AI Engineer Notes** — Part of the `ai-engineer-notes` collection.
> Combines core concepts from linear algebra, statistics, and time-series analysis to help you navigate data science and mathematical modelling.

---

## 1. Linear Algebra Essentials

Linear algebra is the language of data representation.

| Term | Definition |
|---|---|
| **Vector** | A list of numbers representing a point in space or a movement (direction + magnitude). |
| **Matrix** | A grid of numbers representing a linear transformation or a dataset (rows = observations, cols = features). |
| **Span** | The set of all possible linear combinations of a set of vectors — the space they can "reach". |
| **Linear Transformation** | A function that maps vectors to other vectors while keeping grid lines parallel and evenly spaced; represented by matrix multiplication. |
| **Determinant** | A scalar indicating how much a transformation scales areas/volumes. If det(A) = 0, the transformation collapses space into a lower dimension (matrix is singular). |
| **Eigenvalue / Eigenvector** | An eigenvector is a vector only scaled (not rotated) by a transformation; the eigenvalue is the scaling factor. Core of PCA. |
| **Rank** | The number of linearly independent rows/columns — the dimensionality of the column space (output of the transformation). |
| **Null Space (Kernel)** | The set of all vectors mapped to the zero vector by a transformation; dim(Null Space) = n - rank. |
| **Dot Product** | a · b = ||a|| ||b|| cos(theta); measures similarity/projection. Foundation of cosine similarity. |
| **Norm** | Length of a vector: L1 (Manhattan), L2 (Euclidean). Used in regularisation (Lasso, Ridge). |
| **Orthogonality** | Two vectors are orthogonal when their dot product = 0 (no shared direction). |
| **SVD** | Singular Value Decomposition: A = U * S * V^T. Used in recommender systems, dimensionality reduction, and LSA. |

---

## 2. Statistics Foundations

Statistics quantifies uncertainty and relationships within data.

| Term | Definition |
|---|---|
| **Mean (mu)** | Arithmetic average. Sensitive to outliers. |
| **Median** | Middle value; more robust to outliers than mean. |
| **Variance (sigma^2)** | Average squared distance from the mean; measures spread. |
| **Standard Deviation (sigma)** | sqrt(variance); expressed in the same units as the data. |
| **Standard Error (SE)** | SD of a sampling distribution: SE = sigma / sqrt(n). Measures estimation precision. |
| **Covariance** | Measures how two variables change together. Positive = move together; negative = move apart. |
| **Correlation (r)** | Standardised covariance in [-1, 1]; measures strength and direction of a linear relationship. |
| **p-value** | Probability of observing results at least as extreme, assuming H0 is true. Common threshold: 0.05. |
| **Confidence Interval** | A range likely to contain the true population parameter with a given probability (e.g., 95% CI). |
| **Normal Distribution** | Symmetric bell curve; fully described by mu and sigma. Central Limit Theorem makes it ubiquitous. |
| **Heteroscedasticity** | Non-constant variance of residuals across levels of an independent variable. Violates OLS assumptions. |
| **Bias-Variance Trade-off** | High bias = underfitting; high variance = overfitting. Good models minimise both. |
| **MLE** | Maximum Likelihood Estimation: find parameters theta that maximise P(data | theta). |
| **Bayes Theorem** | P(A|B) = P(B|A)*P(A) / P(B). Foundation of Bayesian inference. |
| **Cross-Entropy Loss** | -sum(y * log(y_hat)). Standard loss for classifiers. |
| **MSE / RMSE / MAE** | Mean Squared Error, Root MSE, Mean Absolute Error — regression loss metrics. |

---

## 3. Time-Series Vocabulary

Time-series analysis deals with data points indexed in temporal order.

| Term | Definition |
|---|---|
| **Stationarity** | Mean, variance, and autocorrelation structure do not change over time. Required by ARIMA and many classical models. |
| **Trend** | Long-term increase or decrease in the data. |
| **Seasonality** | Predictable patterns repeating over a fixed period (daily, weekly, annual). |
| **Cyclicality** | Long, irregular fluctuations not of fixed period (e.g., business cycles). |
| **Lag (k)** | Value k steps back in time: Y_{t-k}. Lag 1 = yesterday's value. |
| **Autocorrelation (ACF)** | Correlation of a time series with its own lagged values. Used to diagnose AR order. |
| **Partial Autocorrelation (PACF)** | ACF after removing the effect of shorter lags. Used to diagnose MA order. |
| **White Noise** | IID random sequence: mean 0, constant variance, zero autocorrelation at all lags. Irreducible forecast error. |
| **Differencing** | Y'_t = Y_t - Y_{t-d}. Removes trends (d=1) or seasonality (d=s) to achieve stationarity. |
| **Smoothing / Moving Average (MA)** | Average over a sliding window; removes short-term noise and highlights trend. |
| **Exponential Smoothing (ETS)** | Weighted average giving exponentially decreasing weights to older observations. |
| **ARIMA(p, d, q)** | AutoRegressive Integrated Moving Average: p AR lags, d differences, q MA terms. |
| **SARIMA** | Seasonal ARIMA; adds seasonal AR, I, MA orders (P, D, Q) and period m. |
| **Forecast Horizon (h)** | Number of future steps being predicted. Short-horizon vs. long-horizon. |
| **WMAPE** | Weighted Mean Absolute Percentage Error: sum(|actual - forecast|) / sum(actual). M5 competition primary metric. |
| **Naive Forecast** | Simplest baseline: use the last observed value as the forecast for all horizons. |
| **Seasonal-Naive Forecast** | Use the value from the same period in the previous season as the forecast. |

---

## 4. Quick Reference Table

| Concept | Domain | One-liner |
|---|---|---|
| Vector | Linear Algebra | Ordered list of numbers; direction + magnitude in space. |
| Matrix | Linear Algebra | Grid of numbers; represents a linear transformation or dataset. |
| Determinant | Linear Algebra | Scales areas/volumes; = 0 means singular/non-invertible. |
| Eigenvalue | Linear Algebra | Scaling factor of an eigenvector under a transformation. |
| Null Space | Linear Algebra | All inputs that map to zero; dimension = n - rank. |
| Mean | Statistics | Sum / n; sensitive to outliers. |
| Standard Error | Statistics | SD of the sampling distribution; SE = sigma/sqrt(n). |
| Heteroscedasticity | Statistics | Non-constant error variance; violates OLS. |
| p-value | Statistics | Probability of data given H0; <= 0.05 means reject H0 (typical). |
| Autoregression | Time-Series | Predict Y_t from its own past values Y_{t-1}, Y_{t-2}, ... |
| Stationarity | Time-Series | Constant mean/variance over time; required by ARIMA. |
| WMAPE | Time-Series | M5 error metric; weights errors by actual volume. |

---

## 5. Naive Forecasting on M5 — First Draft

### Background

The **M5 Accuracy Competition** (Makridakis et al., 2022) used daily unit-sales data for 3,049 Walmart items across 10 stores in 3 US states. The target: predict 28 days ahead. The official ranking metric is **WRMSSE** (Weighted Root Mean Squared Scaled Error) aggregated across 12 hierarchical levels, but **WMAPE** is widely used for fast sanity-checking.

```
WMAPE = sum(|actual - forecast|) / sum(actual)
```

### Baseline Methods

#### 5.1 Last-Value Naive (LVN)

> **Rule:** Forecast = last observed value: y_hat_{t+h} = y_t for all h >= 1

- Assumes no trend and no seasonality.
- Optimal if the series is a **random walk** (e.g., many financial prices).
- Weakness on M5: misses weekly seasonality — inflated errors on weekends / holidays.

#### 5.2 Seasonal-Naive (SNaive, m = 7)

> **Rule:** Forecast = value from the same day of the previous week: y_hat_{t+h} = y_{t+h-m}, m = 7

- Preserves weekly seasonal pattern.
- Completely ignores trend and cross-item information.
- Much stronger baseline than LVN on retail data.

### Indicative WMAPE Benchmarks (M5, item-level, h = 1-28)

| Model | WMAPE (approx.) | Notes |
|---|---|---|
| **Last-Value Naive** | ~0.75 - 0.90 | Very high errors; ignores seasonality |
| **Seasonal-Naive (m=7)** | ~0.55 - 0.65 | Captures weekly pattern; no trend |
| LightGBM (top-5 M5 solutions) | ~0.40 - 0.50 | Gradient boosting + feature engineering |
| DeepAR / TFT (deep learning) | ~0.42 - 0.52 | Sequence models; higher training cost |

> **Interpretation:** Seasonal-Naive cuts WMAPE by ~25-30% vs. Last-Value Naive purely by capturing the weekly cycle, illustrating why seasonality modelling is the lowest-hanging fruit in retail forecasting.

### Python Sketch

```python
import numpy as np
import pandas as pd

def last_value_naive(train: pd.Series, h: int = 28) -> np.ndarray:
    """Forecast = last observed value repeated h times."""
    return np.full(h, train.iloc[-1])

def seasonal_naive(train: pd.Series, m: int = 7, h: int = 28) -> np.ndarray:
    """Forecast = value from the same weekday in the previous cycle."""
    tail = train.iloc[-m:].values          # last full season
    reps = (h // m) + 1
    return np.tile(tail, reps)[:h]

def wmape(actual: np.ndarray, forecast: np.ndarray) -> float:
    """Weighted Mean Absolute Percentage Error."""
    return np.sum(np.abs(actual - forecast)) / np.sum(actual)

# --- Example usage (single series) ---
# train = sales["FOODS_3_090_CA_1"]           # pandas Series, sorted by date
# test  = sales["FOODS_3_090_CA_1"].iloc[-28:]

# lvn_fcst  = last_value_naive(train, h=28)
# sn_fcst   = seasonal_naive(train, m=7, h=28)

# print("LVN WMAPE  :", wmape(test.values, lvn_fcst))
# print("SNaive WMAPE:", wmape(test.values, sn_fcst))
```

### Key Take-aways

1. **Naive baselines are not trivial** — they encode real information (last price, last week's sales) and are hard to beat on very short horizons.
2. **Seasonal-Naive is the correct starting point** for any dataset with known periodicity. Always beat it before claiming a model adds value.
3. **WMAPE favours high-volume items** — zero-sales items contribute 0 regardless of forecast quality, which can mask problems in slow-moving SKUs.
4. **M5 uses WRMSSE, not WMAPE** for the official leaderboard; WMAPE is used here as an intuitive first-pass metric.

---

*Last updated: 2026-05-11 | Repository: ai-engineer-notes*
