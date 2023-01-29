{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "3333cbb4",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "papermill": {
     "duration": 0.002336,
     "end_time": "2023-01-29T06:02:34.982420",
     "exception": false,
     "start_time": "2023-01-29T06:02:34.980084",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# How to Detect Credit Card Fraud:\n",
    "- Use an Address Verification System (AVS) to verify a cardholder's identity\n",
    "- Verify the IP address of a customer\n",
    "- Be wary of anonymous email addresses\n",
    "- Ship only to the cardholder's billing address\n",
    "- Analyze transaction data\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "#### The aim of this R project is to build a classifier that can detect credit card fraudulent transactions. We will use a variety of machine learning algorithms that will be able to discern fraudulent from non-fraudulent ones. By the end of this machine learning project, you will learn how to implement machine learning algorithms to perform classification."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dc972a7d",
   "metadata": {
    "papermill": {
     "duration": 0.001168,
     "end_time": "2023-01-29T06:02:34.985094",
     "exception": false,
     "start_time": "2023-01-29T06:02:34.983926",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Importing Libraries"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "11c96e14",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-01-29T06:02:34.992524Z",
     "iopub.status.busy": "2023-01-29T06:02:34.990069Z",
     "iopub.status.idle": "2023-01-29T06:02:38.058747Z",
     "shell.execute_reply": "2023-01-29T06:02:38.057057Z"
    },
    "papermill": {
     "duration": 3.075566,
     "end_time": "2023-01-29T06:02:38.061889",
     "exception": false,
     "start_time": "2023-01-29T06:02:34.986323",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Loading required package: ggplot2\n",
      "\n",
      "Loading required package: lattice\n",
      "\n",
      "\n",
      "Attaching package: ‘caret’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:httr’:\n",
      "\n",
      "    progress\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(ranger)  # A fast implementation of Random Forests, particularly suited for high dimensional data. Ensembles of classification, regression, survival and probability prediction trees are supported. \n",
    "library(caret)  # The caret package (short for Classification And REgression Training) contains functions to streamline the model training process for complex regression\n",
    "library(data.table)   # Fast aggregation of large data (e.g. 100GB in RAM), fast ordered joins, fast add/modify/delete of columns by group using no copies at all, list columns, friendly and fast character-separated-value read/write."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.600173,
   "end_time": "2023-01-29T06:02:38.183968",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-01-29T06:02:31.583795",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
