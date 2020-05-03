---
title: "README"
author: "Bas Machielsen"
date: "5/3/2020"
output: 
  html_document: 
    keep_md: yes
---



## Introduction

`hdng` is a package facilitating the use of the [HDNG Database](https://datasets.iisg.amsterdam/dataverse/HDNG?q=&types=files&sort=dateSort&order=desc&page=1), a database containing quantative information in various aspects of Dutch municipalities from about 1800 to the 1980's. This package aids the user in finding their way through the database, allowing them to search for wanted variables, browse within categories, and finally, make a query to extract the wanted data. Below is a short demonstration of the package's functionality. The package consists of three (basic) functions:

  - `hdng_names_cats`: allows the user to browse through categories. An empty function call gives the basic categories, and a function call containing one or more specific categories returns a dataframe with all variables, and times at which they are available. Fully customizable in various aspects (see function documentation).
  
  - `closest_matches`: gives the user the closest matches (according to string distance) of one or more particular searches. This allows the user to quickly find variables of interest without having to browse through categories. Also supports 'within-category' search. The particular kind of string distance can be customized. 
  
  - `hdng_data_get`: function allowing the user to extract the data. It takes as input variable codes, and returns a data.frame as output containing the variables. Many options customizable. 
  
## Demonstration

The package can be installed and loaded via:


```r
devtools::install_github("basm92/hdng")

library(hdng)
```

## Search for your variables


## Execute the query


## Future work

I plan to include a function that takes as input variable names (or closest matches to them), and as output variable codes, so as not to frustrate the user to always look for variable codes to enter as arguments to `hdng_data_get`. Alternatively, I might start to work on an extract function that takes names, not codes as input. I also want to integrate searches on the basis of province. Thank you for reading!
