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
```


```r
library(hdng)
```

Depending on your machine, the installation might take a while because the data is lazy loading (it is a lot of data).

## Search for your variables

Generally, you can use `hdng_names_cats()` to look for specific data. An empty call gives you all available categories, wheras a call with one of the categories gives you a data.frame containing the availability of all variables within the time frame you specified:


```r
hdng_names_cats()
```

```
##  [1] "Beroepen"      "Bedrijvigheid" "Godsdienst"    "District"     
##  [5] "Bevolking"     "Politiek"      "Onderwijs"     "Welvaart"     
##  [9] "Voorzieningen" "Woningen"      "Openheid"
```


```r
hdng_names_cats("Beroepen") %>%
  head()
```

```
## # A tibble: 6 x 12
##   descr main.cat meaning var   `1889` `1899` `1930` `1933` `1935` `1947` `1960`
##   <chr> <chr>    <chr>   <chr>  <int>  <int>  <int>  <int>  <int>  <int>  <int>
## 1 Aard… a        Beroep… aaa1       1      1      1      0      0      0      0
## 2 Aard… a        Beroep… aab1       1      1      1      0      0      0      0
## 3 Aard… a        Beroep… aac1       1      1      1      0      0      0      0
## 4 Aard… a        Beroep… aad3       1      0      0      0      0      0      0
## 5 Aard… a        Beroep… aax1       1      1      1      0      0      0      0
## 6 Aard… a        Beroep… aax2       1      1      1      0      0      0      0
## # … with 1 more variable: `1971` <int>
```

```r
hdng_names_cats("Beroepen", from = 1870 ,to = 1899) %>%
  head()
```

```
## # A tibble: 6 x 6
##   descr                   main.cat meaning  var   `1889` `1899`
##   <chr>                   <chr>    <chr>    <chr>  <int>  <int>
## 1 Aardewerk enz. Pos.A, M a        Beroepen aaa1       1      1
## 2 Aardewerk enz. Pos.B, M a        Beroepen aab1       1      1
## 3 Aardewerk enz. Pos.C, M a        Beroepen aac1       1      1
## 4 Aardewerk enz. Pos.D    a        Beroepen aad3       1      0
## 5 Aardewerk enz., M       a        Beroepen aax1       1      1
## 6 Aardewerk enz., V       a        Beroepen aax2       1      1
```

You can also apply a 'less strict' filter to the data. By default, the query filters the data to variables that are available at least once in the indicated period. You can override this option by specifying `show.only.available = FALSE`.


```r
hdng_names_cats("Welvaart", from = 1880, to = 1940) 
```

```
## # A tibble: 12 x 8
##    descr                      main.cat meaning var   `1889` `1933` `1934` `1935`
##    <chr>                      <chr>    <chr>   <chr>  <int>  <int>  <int>  <int>
##  1 Aantal aansluitingen elec… h        Welvaa… aael       0      0      1      0
##  2 Aantal aansluitingen gas   h        Welvaa… aaga       0      0      1      0
##  3 Aantal aansluitingen tele… h        Welvaa… aate       0      0      0      1
##  4 Aantal aangemelde radio o… h        Welvaa… aaro       0      0      0      1
##  5 Aantal op distributiecent… h        Welvaa… adar       0      0      0      1
##  6 Aantal personenautos       h        Welvaa… aper       0      0      0      1
##  7 Aantal vrachtautos         h        Welvaa… avra       0      0      0      1
##  8 Aantal motorbussen         h        Welvaa… amot       0      0      0      1
##  9 Aantal motorrijtuigen op … h        Welvaa… amtm       0      0      0      1
## 10 Aandeel der gemeente in s… h        Welvaa… agpb       1      0      0      0
## 11 % aangeslagenen Rijksinko… h        Welvaa… prbd       0      1      0      0
## 12 % aangesl. Vermogensbel. … h        Welvaa… pvar       0      0      1      0
```

```r
hdng_names_cats("Welvaart", from = 1880, to = 1940, show.only.available = F) 
```

```
## # A tibble: 23 x 65
##    descr main.cat meaning var   `1880` `1881` `1882` `1883` `1884` `1885` `1886`
##    <chr> <chr>    <chr>   <chr>  <int>  <int>  <int>  <int>  <int>  <int>  <int>
##  1 Aant… h        Welvaa… aael       0      0      0      0      0      0      0
##  2 Aant… h        Welvaa… aaga       0      0      0      0      0      0      0
##  3 Aant… h        Welvaa… aate       0      0      0      0      0      0      0
##  4 Aant… h        Welvaa… aaro       0      0      0      0      0      0      0
##  5 Aant… h        Welvaa… adar       0      0      0      0      0      0      0
##  6 Aant… h        Welvaa… aper       0      0      0      0      0      0      0
##  7 Aant… h        Welvaa… avra       0      0      0      0      0      0      0
##  8 Aant… h        Welvaa… amot       0      0      0      0      0      0      0
##  9 Aant… h        Welvaa… amtm       0      0      0      0      0      0      0
## 10 Aand… h        Welvaa… agpb       0      0      0      0      0      0      0
## # … with 13 more rows, and 54 more variables: `1887` <int>, `1888` <int>,
## #   `1889` <int>, `1890` <int>, `1891` <int>, `1892` <int>, `1893` <int>,
## #   `1894` <int>, `1895` <int>, `1896` <int>, `1897` <int>, `1898` <int>,
## #   `1899` <int>, `1900` <int>, `1901` <int>, `1902` <int>, `1903` <int>,
## #   `1904` <int>, `1905` <int>, `1906` <int>, `1907` <int>, `1908` <int>,
## #   `1909` <int>, `1910` <int>, `1911` <int>, `1912` <int>, `1913` <int>,
## #   `1914` <int>, `1915` <int>, `1916` <int>, `1917` <int>, `1918` <int>,
## #   `1919` <int>, `1920` <int>, `1921` <int>, `1922` <int>, `1923` <int>,
## #   `1924` <int>, `1925` <int>, `1926` <int>, `1927` <int>, `1928` <int>,
## #   `1929` <int>, `1930` <int>, `1931` <int>, `1932` <int>, `1933` <int>,
## #   `1934` <int>, `1935` <int>, `1936` <int>, `1937` <int>, `1938` <int>,
## #   `1939` <int>, `1940` <int>
```


You can also search for a specific term using the function `closest_matches`. By default, it returns variable names. If you want to see names, set `variable.names` to `TRUE`. 


```r
closest_matches("aantal autos", "Welvaart", n = 20)
```

```
##  [1] "avra" "aper" "amot" "ahcg" "aaga" "ahbk" "ahwg" "aate" "aael" "tahe"
## [11] "zofk" "aaro" "amtm" "ahvg" "adar" "gisg" "falw" "agpb" "agpb" "hamt"
```

```r
closest_matches("aantal autos", "Welvaart", variable.names = TRUE)
```

```
##  [1] "Aantal vrachtautos"                 "Aantal personenautos"              
##  [3] "Aantal motorbussen"                 "Aantal ha. cultuurgrond"           
##  [5] "Aantal aansluitingen gas"           "Aantal ha. bebouwde kom"           
##  [7] "Aantal ha. woeste grond"            "Aantal aansluitingen telefoon"     
##  [9] "Aantal aansluitingen electriciteit" "Totaal aantal ha. (excl. kwelders)"
```
## Execute the query

Finally, you enter a number of variable names into `hdng_get_data` to retrieve a data.frame consisting of the actual variables: 



```r
#Example 1
variables <- closest_matches("aantal autos", "Welvaart", n = 3)

hdng_get_data(variables, gemeenten = c("Amsterdam", "Rotterdam",
                                       "Utrecht", "'s Gravenhage"),
              col.names = TRUE)
```

```
## # A tibble: 4 x 8
##   cbsnr naam  acode main.cat  year `Aantal vrachta… `Aantal persone…
##   <dbl> <chr> <dbl> <chr>    <dbl>            <dbl>            <dbl>
## 1   344 UTRE… 10722 h         1935             1108             1892
## 2   363 AMST… 11150 h         1935             3885             9709
## 3   518 'S G… 11434 h         1935             2563             6973
## 4   599 ROTT… 10345 h         1935             2770             4315
## # … with 1 more variable: `Aantal motorbussen` <dbl>
```

```r
#Example 2
hdng_names_cats("Beroepen") -> query

query$var[1:10] -> variables2       #Select only 10 variables

hdng_get_data(variables2, gemeenten = c("Groningen", "Leeuwarden", "Assen", "Zwolle"),
                col.names = TRUE) 
```

```
## # A tibble: 12 x 15
##    cbsnr naam  acode main.cat  year `Aardewerk enz.… `Aardewerk enz.…
##    <dbl> <chr> <dbl> <chr>    <dbl>            <dbl>            <dbl>
##  1    14 GRON… 10426 a         1889               30                1
##  2    14 GRON… 10426 a         1899               11                2
##  3    14 GRON… 10426 a         1930                7                7
##  4    80 LEEU… 11228 a         1889               14                0
##  5    80 LEEU… 11228 a         1899                8                0
##  6    80 LEEU… 11228 a         1930                3                2
##  7   106 ASSEN 10522 a         1889                3                0
##  8   106 ASSEN 10522 a         1899                0                0
##  9   106 ASSEN 10522 a         1930                0                1
## 10   193 ZWOL… 10093 a         1889                7                0
## 11   193 ZWOL… 10093 a         1899                4                1
## 12   193 ZWOL… 10093 a         1930                0                3
## # … with 8 more variables: `Aardewerk enz. Pos.C, M` <dbl>, `Aardewerk enz.
## #   Pos.D` <dbl>, `Aardewerk enz., M` <dbl>, `Aardewerk enz., V` <dbl>,
## #   `Drukkersbedrijven Pos.A, M` <dbl>, `Drukkersbedrijven Pos.B, M` <dbl>,
## #   `Drukkersbedrijven Pos.C, M` <dbl>, `Drukkersbedrijven Pos.D, M` <dbl>
```

## Future work

I plan to include a function that takes as input variable names (or closest matches to them), and as output variable codes, so as not to frustrate the user to always look for variable codes to enter as arguments to `hdng_data_get`. Alternatively, I might start to work on an extract function that takes names, not codes as input. I also want to integrate searches on the basis of province. Let me know if you have any suggestions. Thank you for reading!
