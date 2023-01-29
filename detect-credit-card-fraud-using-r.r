{"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/detect-credit-card-fraud-using-r?scriptVersionId=117599624\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown","outputs":[],"execution_count":0},{"cell_type":"markdown","id":"231db0aa","metadata":{"_execution_state":"idle","_uuid":"051d70d956493feee0c6d64651c6a088724dca2a","papermill":{"duration":0.003296,"end_time":"2023-01-29T06:16:20.502298","exception":false,"start_time":"2023-01-29T06:16:20.499002","status":"completed"},"tags":[]},"source":["# How to Detect Credit Card Fraud:\n","- Use an Address Verification System (AVS) to verify a cardholder's identity\n","- Verify the IP address of a customer\n","- Be wary of anonymous email addresses\n","- Ship only to the cardholder's billing address\n","- Analyze transaction data\n","\n","\n","\n","\n","#### The aim of this R project is to build a classifier that can detect credit card fraudulent transactions. We will use a variety of machine learning algorithms that will be able to discern fraudulent from non-fraudulent ones. By the end of this machine learning project, you will learn how to implement machine learning algorithms to perform classification."]},{"cell_type":"markdown","id":"cdceadf1","metadata":{"papermill":{"duration":0.002157,"end_time":"2023-01-29T06:16:20.506915","exception":false,"start_time":"2023-01-29T06:16:20.504758","status":"completed"},"tags":[]},"source":["# Importing Libraries"]},{"cell_type":"code","execution_count":1,"id":"3b43aae8","metadata":{"execution":{"iopub.execute_input":"2023-01-29T06:16:20.514963Z","iopub.status.busy":"2023-01-29T06:16:20.513012Z","iopub.status.idle":"2023-01-29T06:16:23.670807Z","shell.execute_reply":"2023-01-29T06:16:23.669086Z"},"papermill":{"duration":3.164282,"end_time":"2023-01-29T06:16:23.673293","exception":false,"start_time":"2023-01-29T06:16:20.509011","status":"completed"},"tags":[]},"outputs":[{"name":"stderr","output_type":"stream","text":["Loading required package: ggplot2\n","\n","Loading required package: lattice\n","\n","\n","Attaching package: ‘caret’\n","\n","\n","The following object is masked from ‘package:httr’:\n","\n","    progress\n","\n","\n"]}],"source":["library(ranger)  # A fast implementation of Random Forests, particularly suited for high dimensional data. Ensembles of classification, regression, survival and probability prediction trees are supported. \n","library(caret)  # The caret package (short for Classification And REgression Training) contains functions to streamline the model training process for complex regression\n","library(data.table)  # Fast aggregation of large data (e.g. 100GB in RAM), fast ordered joins, fast add/modify/delete of columns by group using no copies at all, list columns, friendly and fast character-separated-value read/write."]},{"cell_type":"markdown","id":"b5869468","metadata":{"papermill":{"duration":0.002462,"end_time":"2023-01-29T06:16:23.678283","exception":false,"start_time":"2023-01-29T06:16:23.675821","status":"completed"},"tags":[]},"source":["# Importing Datasets"]},{"cell_type":"code","execution_count":2,"id":"7c85e858","metadata":{"execution":{"iopub.execute_input":"2023-01-29T06:16:23.71586Z","iopub.status.busy":"2023-01-29T06:16:23.684807Z","iopub.status.idle":"2023-01-29T06:17:06.163398Z","shell.execute_reply":"2023-01-29T06:17:06.161559Z"},"papermill":{"duration":42.485643,"end_time":"2023-01-29T06:17:06.166308","exception":false,"start_time":"2023-01-29T06:16:23.680665","status":"completed"},"tags":[]},"outputs":[],"source":["creditcard_data <- read.csv(\"/kaggle/input/creditcardfraud/creditcard.csv\")"]},{"cell_type":"markdown","id":"f6f8b5b0","metadata":{"papermill":{"duration":0.00294,"end_time":"2023-01-29T06:17:06.172731","exception":false,"start_time":"2023-01-29T06:17:06.169791","status":"completed"},"tags":[]},"source":["# Data Exploration\n","- we will explore the data that is contained in the creditcard_data dataframe. We will proceed by displaying the creditcard_data using the head() function as well as the tail() function. We will then proceed to explore the other components of this dataframe"]},{"cell_type":"code","execution_count":3,"id":"5690af1a","metadata":{"execution":{"iopub.execute_input":"2023-01-29T06:17:06.181315Z","iopub.status.busy":"2023-01-29T06:17:06.179797Z","iopub.status.idle":"2023-01-29T06:17:06.198878Z","shell.execute_reply":"2023-01-29T06:17:06.197306Z"},"papermill":{"duration":0.025783,"end_time":"2023-01-29T06:17:06.20104","exception":false,"start_time":"2023-01-29T06:17:06.175257","status":"completed"},"tags":[]},"outputs":[{"data":{"text/html":["<style>\n",".list-inline {list-style: none; margin:0; padding: 0}\n",".list-inline>li {display: inline-block}\n",".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n","</style>\n","<ol class=list-inline><li>284807</li><li>31</li></ol>\n"],"text/latex":["\\begin{enumerate*}\n","\\item 284807\n","\\item 31\n","\\end{enumerate*}\n"],"text/markdown":["1. 284807\n","2. 31\n","\n","\n"],"text/plain":["[1] 284807     31"]},"metadata":{},"output_type":"display_data"}],"source":["dim(creditcard_data)"]},{"cell_type":"code","execution_count":4,"id":"17e933eb","metadata":{"execution":{"iopub.execute_input":"2023-01-29T06:17:06.209683Z","iopub.status.busy":"2023-01-29T06:17:06.208264Z","iopub.status.idle":"2023-01-29T06:17:06.253712Z","shell.execute_reply":"2023-01-29T06:17:06.2521Z"},"papermill":{"duration":0.052121,"end_time":"2023-01-29T06:17:06.255944","exception":false,"start_time":"2023-01-29T06:17:06.203823","status":"completed"},"tags":[]},"outputs":[{"data":{"text/html":["<table class=\"dataframe\">\n","<caption>A data.frame: 6 × 31</caption>\n","<thead>\n","\t<tr><th></th><th scope=col>Time</th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>⋯</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th><th scope=col>Class</th></tr>\n","\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n","</thead>\n","<tbody>\n","\t<tr><th scope=row>1</th><td>0</td><td>-1.3598071</td><td>-0.07278117</td><td>2.5363467</td><td> 1.3781552</td><td>-0.33832077</td><td> 0.46238778</td><td> 0.23959855</td><td> 0.09869790</td><td> 0.3637870</td><td>⋯</td><td>-0.018306778</td><td> 0.277837576</td><td>-0.11047391</td><td> 0.06692807</td><td> 0.1285394</td><td>-0.1891148</td><td> 0.133558377</td><td>-0.02105305</td><td>149.62</td><td>0</td></tr>\n","\t<tr><th scope=row>2</th><td>0</td><td> 1.1918571</td><td> 0.26615071</td><td>0.1664801</td><td> 0.4481541</td><td> 0.06001765</td><td>-0.08236081</td><td>-0.07880298</td><td> 0.08510165</td><td>-0.2554251</td><td>⋯</td><td>-0.225775248</td><td>-0.638671953</td><td> 0.10128802</td><td>-0.33984648</td><td> 0.1671704</td><td> 0.1258945</td><td>-0.008983099</td><td> 0.01472417</td><td>  2.69</td><td>0</td></tr>\n","\t<tr><th scope=row>3</th><td>1</td><td>-1.3583541</td><td>-1.34016307</td><td>1.7732093</td><td> 0.3797796</td><td>-0.50319813</td><td> 1.80049938</td><td> 0.79146096</td><td> 0.24767579</td><td>-1.5146543</td><td>⋯</td><td> 0.247998153</td><td> 0.771679402</td><td> 0.90941226</td><td>-0.68928096</td><td>-0.3276418</td><td>-0.1390966</td><td>-0.055352794</td><td>-0.05975184</td><td>378.66</td><td>0</td></tr>\n","\t<tr><th scope=row>4</th><td>1</td><td>-0.9662717</td><td>-0.18522601</td><td>1.7929933</td><td>-0.8632913</td><td>-0.01030888</td><td> 1.24720317</td><td> 0.23760894</td><td> 0.37743587</td><td>-1.3870241</td><td>⋯</td><td>-0.108300452</td><td> 0.005273597</td><td>-0.19032052</td><td>-1.17557533</td><td> 0.6473760</td><td>-0.2219288</td><td> 0.062722849</td><td> 0.06145763</td><td>123.50</td><td>0</td></tr>\n","\t<tr><th scope=row>5</th><td>2</td><td>-1.1582331</td><td> 0.87773675</td><td>1.5487178</td><td> 0.4030339</td><td>-0.40719338</td><td> 0.09592146</td><td> 0.59294075</td><td>-0.27053268</td><td> 0.8177393</td><td>⋯</td><td>-0.009430697</td><td> 0.798278495</td><td>-0.13745808</td><td> 0.14126698</td><td>-0.2060096</td><td> 0.5022922</td><td> 0.219422230</td><td> 0.21515315</td><td> 69.99</td><td>0</td></tr>\n","\t<tr><th scope=row>6</th><td>2</td><td>-0.4259659</td><td> 0.96052304</td><td>1.1411093</td><td>-0.1682521</td><td> 0.42098688</td><td>-0.02972755</td><td> 0.47620095</td><td> 0.26031433</td><td>-0.5686714</td><td>⋯</td><td>-0.208253515</td><td>-0.559824796</td><td>-0.02639767</td><td>-0.37142658</td><td>-0.2327938</td><td> 0.1059148</td><td> 0.253844225</td><td> 0.08108026</td><td>  3.67</td><td>0</td></tr>\n","</tbody>\n","</table>\n"],"text/latex":["A data.frame: 6 × 31\n","\\begin{tabular}{r|lllllllllllllllllllll}\n","  & Time & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & ⋯ & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount & Class\\\\\n","  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int>\\\\\n","\\hline\n","\t1 & 0 & -1.3598071 & -0.07278117 & 2.5363467 &  1.3781552 & -0.33832077 &  0.46238778 &  0.23959855 &  0.09869790 &  0.3637870 & ⋯ & -0.018306778 &  0.277837576 & -0.11047391 &  0.06692807 &  0.1285394 & -0.1891148 &  0.133558377 & -0.02105305 & 149.62 & 0\\\\\n","\t2 & 0 &  1.1918571 &  0.26615071 & 0.1664801 &  0.4481541 &  0.06001765 & -0.08236081 & -0.07880298 &  0.08510165 & -0.2554251 & ⋯ & -0.225775248 & -0.638671953 &  0.10128802 & -0.33984648 &  0.1671704 &  0.1258945 & -0.008983099 &  0.01472417 &   2.69 & 0\\\\\n","\t3 & 1 & -1.3583541 & -1.34016307 & 1.7732093 &  0.3797796 & -0.50319813 &  1.80049938 &  0.79146096 &  0.24767579 & -1.5146543 & ⋯ &  0.247998153 &  0.771679402 &  0.90941226 & -0.68928096 & -0.3276418 & -0.1390966 & -0.055352794 & -0.05975184 & 378.66 & 0\\\\\n","\t4 & 1 & -0.9662717 & -0.18522601 & 1.7929933 & -0.8632913 & -0.01030888 &  1.24720317 &  0.23760894 &  0.37743587 & -1.3870241 & ⋯ & -0.108300452 &  0.005273597 & -0.19032052 & -1.17557533 &  0.6473760 & -0.2219288 &  0.062722849 &  0.06145763 & 123.50 & 0\\\\\n","\t5 & 2 & -1.1582331 &  0.87773675 & 1.5487178 &  0.4030339 & -0.40719338 &  0.09592146 &  0.59294075 & -0.27053268 &  0.8177393 & ⋯ & -0.009430697 &  0.798278495 & -0.13745808 &  0.14126698 & -0.2060096 &  0.5022922 &  0.219422230 &  0.21515315 &  69.99 & 0\\\\\n","\t6 & 2 & -0.4259659 &  0.96052304 & 1.1411093 & -0.1682521 &  0.42098688 & -0.02972755 &  0.47620095 &  0.26031433 & -0.5686714 & ⋯ & -0.208253515 & -0.559824796 & -0.02639767 & -0.37142658 & -0.2327938 &  0.1059148 &  0.253844225 &  0.08108026 &   3.67 & 0\\\\\n","\\end{tabular}\n"],"text/markdown":["\n","A data.frame: 6 × 31\n","\n","| <!--/--> | Time &lt;dbl&gt; | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | ⋯ ⋯ | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; | Class &lt;int&gt; |\n","|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n","| 1 | 0 | -1.3598071 | -0.07278117 | 2.5363467 |  1.3781552 | -0.33832077 |  0.46238778 |  0.23959855 |  0.09869790 |  0.3637870 | ⋯ | -0.018306778 |  0.277837576 | -0.11047391 |  0.06692807 |  0.1285394 | -0.1891148 |  0.133558377 | -0.02105305 | 149.62 | 0 |\n","| 2 | 0 |  1.1918571 |  0.26615071 | 0.1664801 |  0.4481541 |  0.06001765 | -0.08236081 | -0.07880298 |  0.08510165 | -0.2554251 | ⋯ | -0.225775248 | -0.638671953 |  0.10128802 | -0.33984648 |  0.1671704 |  0.1258945 | -0.008983099 |  0.01472417 |   2.69 | 0 |\n","| 3 | 1 | -1.3583541 | -1.34016307 | 1.7732093 |  0.3797796 | -0.50319813 |  1.80049938 |  0.79146096 |  0.24767579 | -1.5146543 | ⋯ |  0.247998153 |  0.771679402 |  0.90941226 | -0.68928096 | -0.3276418 | -0.1390966 | -0.055352794 | -0.05975184 | 378.66 | 0 |\n","| 4 | 1 | -0.9662717 | -0.18522601 | 1.7929933 | -0.8632913 | -0.01030888 |  1.24720317 |  0.23760894 |  0.37743587 | -1.3870241 | ⋯ | -0.108300452 |  0.005273597 | -0.19032052 | -1.17557533 |  0.6473760 | -0.2219288 |  0.062722849 |  0.06145763 | 123.50 | 0 |\n","| 5 | 2 | -1.1582331 |  0.87773675 | 1.5487178 |  0.4030339 | -0.40719338 |  0.09592146 |  0.59294075 | -0.27053268 |  0.8177393 | ⋯ | -0.009430697 |  0.798278495 | -0.13745808 |  0.14126698 | -0.2060096 |  0.5022922 |  0.219422230 |  0.21515315 |  69.99 | 0 |\n","| 6 | 2 | -0.4259659 |  0.96052304 | 1.1411093 | -0.1682521 |  0.42098688 | -0.02972755 |  0.47620095 |  0.26031433 | -0.5686714 | ⋯ | -0.208253515 | -0.559824796 | -0.02639767 | -0.37142658 | -0.2327938 |  0.1059148 |  0.253844225 |  0.08108026 |   3.67 | 0 |\n","\n"],"text/plain":["  Time V1         V2          V3        V4         V5          V6         \n","1 0    -1.3598071 -0.07278117 2.5363467  1.3781552 -0.33832077  0.46238778\n","2 0     1.1918571  0.26615071 0.1664801  0.4481541  0.06001765 -0.08236081\n","3 1    -1.3583541 -1.34016307 1.7732093  0.3797796 -0.50319813  1.80049938\n","4 1    -0.9662717 -0.18522601 1.7929933 -0.8632913 -0.01030888  1.24720317\n","5 2    -1.1582331  0.87773675 1.5487178  0.4030339 -0.40719338  0.09592146\n","6 2    -0.4259659  0.96052304 1.1411093 -0.1682521  0.42098688 -0.02972755\n","  V7          V8          V9         ⋯ V21          V22          V23        \n","1  0.23959855  0.09869790  0.3637870 ⋯ -0.018306778  0.277837576 -0.11047391\n","2 -0.07880298  0.08510165 -0.2554251 ⋯ -0.225775248 -0.638671953  0.10128802\n","3  0.79146096  0.24767579 -1.5146543 ⋯  0.247998153  0.771679402  0.90941226\n","4  0.23760894  0.37743587 -1.3870241 ⋯ -0.108300452  0.005273597 -0.19032052\n","5  0.59294075 -0.27053268  0.8177393 ⋯ -0.009430697  0.798278495 -0.13745808\n","6  0.47620095  0.26031433 -0.5686714 ⋯ -0.208253515 -0.559824796 -0.02639767\n","  V24         V25        V26        V27          V28         Amount Class\n","1  0.06692807  0.1285394 -0.1891148  0.133558377 -0.02105305 149.62 0    \n","2 -0.33984648  0.1671704  0.1258945 -0.008983099  0.01472417   2.69 0    \n","3 -0.68928096 -0.3276418 -0.1390966 -0.055352794 -0.05975184 378.66 0    \n","4 -1.17557533  0.6473760 -0.2219288  0.062722849  0.06145763 123.50 0    \n","5  0.14126698 -0.2060096  0.5022922  0.219422230  0.21515315  69.99 0    \n","6 -0.37142658 -0.2327938  0.1059148  0.253844225  0.08108026   3.67 0    "]},"metadata":{},"output_type":"display_data"}],"source":["head(creditcard_data,6)"]}],"metadata":{"kernelspec":{"display_name":"R","language":"R","name":"ir"},"language_info":{"codemirror_mode":"r","file_extension":".r","mimetype":"text/x-r-source","name":"R","pygments_lexer":"r","version":"4.0.5"},"papermill":{"default_parameters":{},"duration":49.552754,"end_time":"2023-01-29T06:17:06.479652","environment_variables":{},"exception":null,"input_path":"__notebook__.ipynb","output_path":"__notebook__.ipynb","parameters":{},"start_time":"2023-01-29T06:16:16.926898","version":"2.4.0"}},"nbformat":4,"nbformat_minor":5}