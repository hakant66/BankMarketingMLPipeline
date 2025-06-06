🧠 Overview
The script performs a binary classification task using PySpark's MLlib. It builds a machine learning pipeline to predict whether a bank customer will subscribe to a term deposit, based on historical marketing data.

🔍1. Dataset Ingestion and Schema Inference
df = spark.read.csv(file_path, header=True, inferSchema=True, sep=';')
Reads the dataset from the file.
Treats the first row as headers (header=True).
Automatically detects column data types (inferSchema=True).
Uses semicolon ; as the delimiter (UCI’s original format).
Result: A Spark DataFrame with the following columns:
age (int)
job (string)
marital (string)
education (string)
default (string)
balance (int)
housing (string)
loan (string)
contact (string)
day, month, duration, campaign, pdays, previous
poutcome (string)
y (string: “yes” or “no”) ← target variable

🧹 2. Data Preprocessing Pipeline
A. Feature Classification
The code splits columns into:
Categorical features: require encoding
Numeric features: used directly

B. Encoding Categorical Features
Each categorical column is:
Indexed using StringIndexer
Converts strings like "admin." → 0, "technician" → 1, etc.
One-hot encoded using OneHotEncoder
Converts index values into a binary vector.

Example:
StringIndexer(inputCol="job", outputCol="job_index")
OneHotEncoder(inputCol="job_index", outputCol="job_vec")
This is repeated for all categorical columns (job, education, etc.).

C. Label Transformation
StringIndexer(inputCol="y", outputCol="label")
Converts the y column (yes / no) into a binary numeric column:
yes → 1.0
no → 0.0

D. Feature Assembly
VectorAssembler(inputCols=all_feature_columns, outputCol="features")
Combines all encoded categorical vectors and numeric columns into a single feature vector.
Required input format for MLlib models.

🧠 3. Model Training & Evaluation
A. Train-Test Split
train_data, test_data = df.randomSplit([0.8, 0.2], seed=42)
80% for training
20% for testing

B. Pipeline and Model
lr = LogisticRegression(featuresCol="features", labelCol="label")
pipeline = Pipeline(stages=[...])
LogisticRegression is used to predict the likelihood of a customer subscribing to a term deposit.
The full pipeline includes:
Indexing → One-hot encoding → Label indexing → Feature assembly → Logistic regression

C. Model Fitting
model = pipeline.fit(train_data)
Fits the entire pipeline on training data, including all preprocessing and model training.

D. Prediction
predictions = model.transform(test_data)
Applies the pipeline to the test data.
Produces a DataFrame that includes:
features
label
rawPrediction
probability (vector: [prob_no, prob_yes])
prediction (0 or 1)

E. Evaluation
evaluator = BinaryClassificationEvaluator(labelCol="label")
auc = evaluator.evaluate(predictions)
Calculates AUC (Area Under Curve) using ROC (Receiver Operating Characteristic).

AUC ≈ 0.91 means the model is performing well in distinguishing between positive and negative classes.

📊 4. Saving Output Results
A. Save AUC to File
with open("output/model_auc.txt", "w") as f:
    f.write(f"Model AUC: {auc}")
B. Extract Probability and Plot ROC
probability[1] → prob_class_yes
A UDF extracts this from the Spark ML Vector.
toPandas() converts the selected columns into a Pandas DataFrame.

C. Plotting the ROC Curve
plt.plot(FPR, TPR)
Calculates TPR and FPR using cumulative sums of actual labels.
Saves the ROC curve as a PNG image: output/roc_curve.png

✅ What the Script Achieves
Goal	Achieved by
Load and preprocess marketing data	PySpark DataFrame, StringIndexer, OneHotEncoder
Predict subscription likelihood	LogisticRegression with a full ML pipeline
Evaluate model	BinaryClassificationEvaluator (AUC metric)
Visualize performance	ROC curve using matplotlib
Export results	AUC saved to .txt, ROC to .png


📈 Final Output
✅ model_auc.txt: Model performance summary
✅ roc_curve.png: A visual showing how well the model distinguishes "yes" vs. "no"

This indicates a strong model for predicting term deposit subscription likelihood.
#   B a n k M a r k e t i n g M L P i p e l i n e 
 
 
