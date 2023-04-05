{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/detect-credit-card-fraud-using-r?scriptVersionId=124712061\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown"},{"cell_type":"markdown","source":"# Introduction\n###  The purpose of this project:\n- Every year, fraudulent transactions with credit cards result in billions of dollars in losses. The key to minimizing these losses is the development of effective fraud detection algorithms, and increasingly, these algorithms depend on cutting-edge machine learning methods to help fraud investigators. Nevertheless, because of the non-stationary distributions of the data, the extremely unbalanced classification distributions, and the ongoing streams of transactions, designing fraud detection algorithms is especially difficult. Due to confidentiality concerns, publicly available information are also hard to come by, leaving many questions regarding how to approach this problem in the dark.\n\n###  Some facts you need to know about Credit Card Fraud:\n- A total of 127 million adults in America—or nearly half of the population—have experienced a fraudulent transaction on one of their credit or debit cards. Card fraud has happened more than once to more than one in three people who use credit or debit cards.\n\n- On American credit and debit cards, the typical charge was $62, which translates to around 8 billion in attempted fraudulent transactions. Only around 40% of cardholders have email or text notifications from their bank or credit card issuer activated.\n\n- Only 19% of victims with alerts turned on had to take further action to reverse fraudulent charges, compared to about 81 percent of victims without these warnings.\n\n### How to Detect Credit Card Fraud:\n- Use an Address Verification System (AVS) to verify a cardholder's identity\n- Verify the IP address of a customer\n- Be wary of anonymous email addresses\n- Ship only to the cardholder's billing address\n- Analyze transaction data\n\n\n\n\n#### The aim of this R project is to build a classifier that can detect credit card fraudulent transactions. We will use a variety of machine learning algorithms that will be able to discern fraudulent from non-fraudulent ones. By the end of this machine learning project, you will learn how to implement machine learning algorithms to perform classification.","metadata":{"_uuid":"051d70d956493feee0c6d64651c6a088724dca2a","_execution_state":"idle"}},{"cell_type":"markdown","source":"# Importing Libraries","metadata":{}},{"cell_type":"code","source":"library(ranger)  # A fast implementation of Random Forests, particularly suited for high dimensional data. Ensembles of classification, regression, survival and probability prediction trees are supported. \nlibrary(caret)  # The caret package (short for Classification And REgression Training) contains functions to streamline the model training process for complex regression\nlibrary(data.table)  # Fast aggregation of large data (e.g. 100GB in RAM), fast ordered joins, fast add/modify/delete of columns by group using no copies at all, list columns, friendly and fast character-separated-value read/write.","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:01:59.774878Z","iopub.execute_input":"2023-04-02T07:01:59.777965Z","iopub.status.idle":"2023-04-02T07:02:02.669202Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Importing Datasets","metadata":{}},{"cell_type":"code","source":"creditcard_data <- read.csv(\"/kaggle/input/creditcardfraud/creditcard.csv\")","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:02.670822Z","iopub.execute_input":"2023-04-02T07:02:02.694296Z","iopub.status.idle":"2023-04-02T07:02:48.192059Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Data Exploration\n- we will explore the data that is contained in the creditcard_data dataframe. We will proceed by displaying the creditcard_data using the head() function as well as the tail() function. We will then proceed to explore the other components of this dataframe","metadata":{}},{"cell_type":"code","source":"dim(creditcard_data)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.194159Z","iopub.execute_input":"2023-04-02T07:02:48.195393Z","iopub.status.idle":"2023-04-02T07:02:48.210699Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"head(creditcard_data,6)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.212611Z","iopub.execute_input":"2023-04-02T07:02:48.213708Z","iopub.status.idle":"2023-04-02T07:02:48.252066Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"tail(creditcard_data,6)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.253843Z","iopub.execute_input":"2023-04-02T07:02:48.254935Z","iopub.status.idle":"2023-04-02T07:02:48.2888Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"table(creditcard_data$Class)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.291472Z","iopub.execute_input":"2023-04-02T07:02:48.293099Z","iopub.status.idle":"2023-04-02T07:02:48.319184Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"summary(creditcard_data$Amount)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.321031Z","iopub.execute_input":"2023-04-02T07:02:48.322168Z","iopub.status.idle":"2023-04-02T07:02:48.348366Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"names(creditcard_data)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.350018Z","iopub.execute_input":"2023-04-02T07:02:48.351005Z","iopub.status.idle":"2023-04-02T07:02:48.363356Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"var(creditcard_data$Amount)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.365075Z","iopub.execute_input":"2023-04-02T07:02:48.36614Z","iopub.status.idle":"2023-04-02T07:02:48.383099Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"sd(creditcard_data$Amount)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.38483Z","iopub.execute_input":"2023-04-02T07:02:48.385877Z","iopub.status.idle":"2023-04-02T07:02:48.40052Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Data Manipulation\n- In this section, we will scale our data using the scale() function. We will apply this to the amount component of our credit card_data amount. Scaling is also known as feature standardization. With the help of scaling, the data is structured according to a specified range. Therefore, there are no extreme values in our dataset that might interfere with the functioning of our model.\n","metadata":{"execution":{"iopub.status.busy":"2023-01-29T07:10:32.751173Z","iopub.execute_input":"2023-01-29T07:10:32.753607Z","iopub.status.idle":"2023-01-29T07:10:32.767951Z"}}},{"cell_type":"code","source":"head(creditcard_data)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.402279Z","iopub.execute_input":"2023-04-02T07:02:48.403275Z","iopub.status.idle":"2023-04-02T07:02:48.436452Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"creditcard_data$Amount=scale(creditcard_data$Amount)\nNewData=creditcard_data[,-c(1)]\nhead(NewData)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.438312Z","iopub.execute_input":"2023-04-02T07:02:48.43937Z","iopub.status.idle":"2023-04-02T07:02:48.483053Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Data Modeling\n- After we have standardized our entire dataset, we will split our dataset into a training set as well as a test set with a split ratio of 0.80. This means that 80% of our data will be attributed to the train_data whereas 20% will be attributed to the test data. We will then find the dimensions using the dim() function\n","metadata":{}},{"cell_type":"code","source":"library(caTools)  # Moving Window Statistics, GIF, Base64, ROC AUC, etc\nset.seed(123)\ndata_sample = sample.split(NewData$Class,SplitRatio=0.80)\ntrain_data = subset(NewData,data_sample==TRUE)\ntest_data = subset(NewData,data_sample==FALSE)\ndim(train_data)\ndim(test_data)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.484795Z","iopub.execute_input":"2023-04-02T07:02:48.48589Z","iopub.status.idle":"2023-04-02T07:02:48.692003Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Fitting Logistic Regression Model\n- In this section of the project, we will fit our first model. We will begin with logistic regression. A logistic regression is used for modeling the outcome probability of a class such as a pass/a fail, positive/negative, and in our case – fraud/not fraud. We proceed to implement this model on our test data as follows","metadata":{}},{"cell_type":"code","source":"Logistic_Model = glm(Class~.,test_data,family=binomial())","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:48.693807Z","iopub.execute_input":"2023-04-02T07:02:48.694897Z","iopub.status.idle":"2023-04-02T07:02:50.996731Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"summary(Logistic_Model)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:50.999311Z","iopub.execute_input":"2023-04-02T07:02:51.000826Z","iopub.status.idle":"2023-04-02T07:02:51.312333Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### After we have summarised our model, we will visual it through the following plots:","metadata":{}},{"cell_type":"code","source":"plot(Logistic_Model)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:51.314234Z","iopub.execute_input":"2023-04-02T07:02:51.315412Z","iopub.status.idle":"2023-04-02T07:02:58.190015Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- In order to assess the performance of our model, we will delineate the ROC curve. ROC is also known as Receiver Optimistic Characteristics. For this, we will first import the ROC package and then plot our ROC curve to analyze its performance.","metadata":{}},{"cell_type":"code","source":"Logistic_Model = glm(Class~.,train_data,family=binomial())\nsummary(Logistic_Model)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:02:58.192478Z","iopub.execute_input":"2023-04-02T07:02:58.193986Z","iopub.status.idle":"2023-04-02T07:03:03.005499Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"library(pROC)  # display and analyze ROC curves\nlr.predict <- predict(Logistic_Model,test_data, probability = TRUE)\nauc.gbm = roc(test_data$Class, lr.predict, plot = TRUE, col = \"blue\")","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:03:03.008074Z","iopub.execute_input":"2023-04-02T07:03:03.009617Z","iopub.status.idle":"2023-04-02T07:03:03.239748Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Fitting a Decision Tree Model\n- In this section, we will implement a decision tree algorithm. Decision Trees to plot the outcomes of a decision. These outcomes are basically a consequence through which we can conclude as to what class the object belongs to. We will now implement our decision tree model and will plot it using the rpart.plot() function. We will specifically use the recursive parting to plot the decision tree.","metadata":{}},{"cell_type":"code","source":"library(rpart)  # Recursive partitioning for classification, regression and survival trees.\nlibrary(rpart.plot)\ndecisionTree_model <- rpart(Class ~ . , creditcard_data, method = 'class')\npredicted_val <- predict(decisionTree_model, creditcard_data, type = 'class')\nprobability <- predict(decisionTree_model, creditcard_data, type = 'prob')\n\nrpart.plot(decisionTree_model)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:03:03.241767Z","iopub.execute_input":"2023-04-02T07:03:03.243273Z","iopub.status.idle":"2023-04-02T07:04:50.670651Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Artificial Neural Network(ANN Model)\n- Artificial Neural Networks are a type of machine learning algorithm that is modeled after the human nervous system. The ANN models are able to learn the patterns using the historical data and are able to perform classification on the input data. We import the neural net package that would allow us to implement our ANNs. Then we proceeded to plot it using the plot() function. Now, in the case of Artificial Neural Networks, there is a range of values that is between 1 and 0. We set a threshold as 0.5, that is, values above 0.5 will correspond to 1 and the rest will be 0. We implement this as follows:","metadata":{}},{"cell_type":"code","source":"library(neuralnet) # nn for computation of a given neural network for given covariate vectors (formerly compute)\nANN_model <- neuralnet(Class~.,data=train_data,linear.output=F)\nplot(ANN_model)\n\npredANN=compute(ANN_model,test_data)\nresultANN=predANN$net.result\nresultANN=ifelse(resultANN>0.5,1,0)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:04:50.672395Z","iopub.execute_input":"2023-04-02T07:04:50.673408Z","iopub.status.idle":"2023-04-02T07:07:54.875469Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Gradient Boosting(GBM):\n- Gradient Boosting is a popular machine learning algorithm that is used to perform classification and regression tasks. This model comprises several underlying ensemble models like weak decision trees. These decision trees combine together to form a strong model of gradient boosting. We will implement a gradient descent algorithm in our model as follows:","metadata":{}},{"cell_type":"code","source":"library(gbm, quietly=TRUE)  # An implementation of extensions to Freund and Schapire's AdaBoost algorithm and Friedman's gradient boosting machine.\n\n# Get the time to train the GBM model\nsystem.time(\n       model_gbm <- gbm(Class ~ .\n               , distribution = \"bernoulli\"\n               , data = rbind(train_data, test_data)\n               , n.trees = 500\n               , interaction.depth = 3\n               , n.minobsinnode = 100\n               , shrinkage = 0.01\n               , bag.fraction = 0.5\n               , train.fraction = nrow(train_data) / (nrow(train_data) + nrow(test_data))\n)\n)\n\n# Determine best iteration based on test data\ngbm.iter = gbm.perf(model_gbm, method = \"test\")","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:07:54.878408Z","iopub.execute_input":"2023-04-02T07:07:54.879932Z","iopub.status.idle":"2023-04-02T07:13:19.851539Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Plot the gbm model\n","metadata":{}},{"cell_type":"code","source":"model.influence = relative.influence(model_gbm, n.trees = gbm.iter, sort. = TRUE)\n\nplot(model_gbm)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:13:19.853901Z","iopub.execute_input":"2023-04-02T07:13:19.855255Z","iopub.status.idle":"2023-04-02T07:13:20.00619Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Plot and calculate AUC on test data\n","metadata":{}},{"cell_type":"code","source":"gbm_test = predict(model_gbm, newdata = test_data, n.trees = gbm.iter)\ngbm_auc = roc(test_data$Class, gbm_test, plot = TRUE, col = \"red\")\nprint(gbm_auc)","metadata":{"execution":{"iopub.status.busy":"2023-04-02T07:13:20.009666Z","iopub.execute_input":"2023-04-02T07:13:20.010993Z","iopub.status.idle":"2023-04-02T07:13:20.730141Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Summary\n- We learned how to develop our credit card fraud detection model using machine learning. \n- We used a variety of ML algorithms to implement this model and also plotted the respective performance curves for the models. \n- We learned how data can be analyzed and visualized to discern fraudulent transactions from other types of data.","metadata":{}}]}