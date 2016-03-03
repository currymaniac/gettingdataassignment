# Getting and Cleaning Data - Final Assignment

## Introduction

This repository contains the solution to the final assignment of the Getting and Cleaning Data course on Coursera.

The assignment requires the creation of an R script (**run_analysis.R**), which loads data collected from the accelerometers from the Samsung Galaxy S smartphone. The goal is to merge the training and test datasets (each consisting of three files which must be merged), clean the data, subset to columns that measure the mean and standard deviation of the various features. Finally a 'tidy' summarised dataset is created.

In terms of the summary, I have interpretted this as calculating the average of each measure per person-activity pair (i.e. 180 summarisations / rows)

A full description is of the data is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data used in this assignment can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The summarised dataset can be recreated so long as the data above is in your working directory.

## Files

There are four files in this repository:
* README.md - the file you are currently reading, sets out the contents of the repository
* run_analysis.R - R code which loads the data from both the training and test files, merges and subsets the data. Produces a summarised version of the data (see **summarised_data.txt**)
* CodeBook.md - Markdown file which sets out the data fields contained within **summarised_data.txt**
* summarised_data.txt - A text file containing an export of the summarised data, one row for each person-activity pair. Exported using the R function **write.table()**.