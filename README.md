# Starter folder

## Overview

This repository consists of a reproduction of the paper, "Why Does Education Reduce Crime" by Brian Bell, Rui Costa and Stephen Machin.

## Data

This repository consists of only the raw data that we used for the our reproduction. The complete raw data, full text of the paper, appendix and reproduction package can be found at this website, https://www.journals.uchicago.edu/doi/full/10.1086/717895#_i38.
To access the complete paper, you will need to log in through your institution, purchase a subscription, or purchase the article alone. 

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from the reproduction package provided by the original authors.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to install packages, simulate, download, clean, and test the data, as well as the code for the replication of figures. 

## Statement on LLM usage

ChatGPT 3.5 was used to understand how to display multiple figures in a panel view, to show as one figure. It was also used to make the abstract short and concise. The entire chat history is available in other/llms/usage.txt.
