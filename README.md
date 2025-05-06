# Bank Marketing ML Pipeline (PySpark)

This project demonstrates a full **machine learning pipeline using PySpark MLlib** on the UCI **Bank Marketing dataset**. It predicts whether a bank client will subscribe to a term deposit based on personal and campaign-related attributes.

---

## 📁 Dataset: `bank-full.csv`

- **Source:** [UCI ML Repository](https://archive.ics.uci.edu/ml/datasets/Bank+Marketing)
- **Format:** Semicolon-separated (`;`) CSV file
- **Rows:** 45,000+
- **Target Variable:** `y` (`yes` or `no`)

Each row represents a marketing contact made by a Portuguese banking institution.

---

## 🔄 ML Pipeline Steps

### 1. **Load and Inspect**
- Reads the dataset using Spark.
- Infers schema and prints column types.

### 2. **Preprocessing**
- **Categorical features** are indexed and one-hot encoded:
  - `job`, `marital`, `education`, `default`, `housing`, `loan`, `contact`, `month`, `poutcome`
- **Numeric features** are used directly:
  - `age`, `balance`, `day`, `duration`, `campaign`, `pdays`, `previous`
- **Target (`y`)** is indexed to create a binary `label`.

### 3. **Vectorization**
- Combines all features into a single vector using `VectorAssembler`.

### 4. **Model Training**
- Trains a **Logistic Regression** model using Spark MLlib.
- Splits the data into training and testing sets (80/20).

### 5. **Evaluation**
- Uses **BinaryClassificationEvaluator** to compute **AUC** (Area Under the ROC Curve).
- AUC is printed and saved to a text file.

---

## 📊 Outputs

| File | Description |
|------|-------------|
| `output/model_auc.txt` | AUC score of the model |
| `output/roc_curve.png` | ROC Curve visual showing model performance |

---

## ⚙ Requirements

- Apache Spark 3.4.x
- Python 3.11 (driver and worker)
- PySpark
- pandas
- matplotlib

Use this command to install dependencies:

```bash
pip install pyspark==3.4.1 pandas matplotlib py4j==0.10.9.7
```

---

## ▶️ How to Run

Use the provided `.bat` launcher to run the script with the correct environment:

```
run_bank_ml.bat
```

Or manually:

```bash
python BankMarketingMLWithCategorical.py
```

Make sure to update paths as needed inside the script.

---

## 📈 Result

```
Model AUC (Area Under ROC Curve): ~0.9130
```

This indicates a strong model for predicting term deposit subscription likelihood.
