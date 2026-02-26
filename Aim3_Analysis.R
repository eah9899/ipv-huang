> anova_inadequacy <- aov(inadequacy ~ ipv_group3, data = data)
> summary(anova_inadequacy)
Df Sum Sq Mean Sq F value Pr(>F)  
ipv_group3    2    252  125.97   3.604 0.0304 *
  Residuals   114   3985   34.96                 
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
89 observations deleted due to missingness
> # Step 2: Tukey post hoc
  > TukeyHSD(anova_inadequacy)
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = inadequacy ~ ipv_group3, data = data)

$ipv_group3
diff        lwr      upr     p adj
Victim Only-No IPV        3.6428571 -1.2015003 8.487215 0.1789495
Bidirectional-No IPV      3.8501742  0.4163515 7.283997 0.0239230
Bidirectional-Victim Only 0.2073171 -3.8528181 4.267452 0.9919273

> 
  > # Step 3: Eta-squared
  > anova_inadeq_summary <- summary(anova_inadequacy)
> SS_between <- anova_inadeq_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_inadeq_summary[[1]]["Residuals", "Sum Sq"]
> eta2_inadequacy <- SS_between / (SS_between + SS_residual)
> eta2_inadequacy
[1] 0.05946305
> 
  > # Step 4: Cohen's d
  > library(effectsize)
> subset_data1 <- data %>% filter(ipv_group3 %in% c("No IPV", "Victim Only"))
> subset_data2 <- data %>% filter(ipv_group3 %in% c("No IPV", "Bidirectional"))
> subset_data3 <- data %>% filter(ipv_group3 %in% c("Victim Only", "Bidirectional"))
> 
  > cohens_d(inadequacy ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |         95% CI
--------------------------
-0.90     | [-1.60, -0.18]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(inadequacy ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |         95% CI
--------------------------
  -0.64     | [-1.13, -0.15]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cohens_d(inadequacy ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
-0.03     | [-0.60, 0.53]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Means and SDs
> data %>% group_by(ipv_group3) %>% summarise(mean_inadequacy = mean(inadequacy, na.rm = TRUE), sd_inadequacy = sd(inadequacy, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_inadequacy sd_inadequacy     n
  <fct>                   <dbl>         <dbl> <int>
1 No IPV                   20.9          3.18    24
2 Victim Only              24.5          5.10    16
3 Bidirectional            24.7          6.52   100
4 NA                       22.9          5.54    66
> 
> # Step 5: Regression
> model_inadequacy_adj <- lm(inadequacy ~ ipv_group3 + age + gender, data = data)
> summary(model_inadequacy_adj)

Call:
lm(formula = inadequacy ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-12.3318  -4.0321   0.6216   2.7953  27.0902 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)              24.9304     3.9239   6.353 4.78e-09 ***
ipv_group3Victim Only     3.3863     2.0710   1.635   0.1049    
ipv_group3Bidirectional   3.9187     1.4671   2.671   0.0087 ** 
age                      -0.2058     0.1824  -1.128   0.2616    
genderFemale              0.3930     1.1286   0.348   0.7284    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.952 on 111 degrees of freedom
  (90 observations deleted due to missingness)
Multiple R-squared:  0.06978,	Adjusted R-squared:  0.03626 
F-statistic: 2.082 on 4 and 111 DF,  p-value: 0.08796

> lm.beta(model_inadequacy_adj)

Call:
lm(formula = inadequacy ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA              0.18272368              0.29793832             -0.10559575 
           genderFemale 
             0.03223514 

> # ============================================
> # AIM 3: Variable 2 - Locus of Control
> # ============================================
> 
> anova_locus <- aov(locus_control ~ ipv_group3, data = data)
> summary(anova_locus)
             Df Sum Sq Mean Sq F value   Pr(>F)    
ipv_group3    2    557  278.34   8.467 0.000369 ***
Residuals   116   3813   32.87                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
87 observations deleted due to missingness
> TukeyHSD(anova_locus)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = locus_control ~ ipv_group3, data = data)

$ipv_group3
                                diff       lwr       upr     p adj
Victim Only-No IPV         6.4139194  1.610104 11.217735 0.0054978
Bidirectional-No IPV       5.5053221  2.188196  8.822448 0.0004075
Bidirectional-Victim Only -0.9085973 -4.962376  3.145182 0.8557165

> 
> anova_locus_summary <- summary(anova_locus)
> SS_between <- anova_locus_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_locus_summary[[1]]["Residuals", "Sum Sq"]
> eta2_locus <- SS_between / (SS_between + SS_residual)
> eta2_locus
[1] 0.1273885
> 
> cohens_d(locus_control ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |         95% CI
--------------------------
  -1.42     | [-2.18, -0.64]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cohens_d(locus_control ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |         95% CI
--------------------------
-0.93     | [-1.42, -0.44]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(locus_control ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
  0.15      | [-0.43, 0.74]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > data %>% group_by(ipv_group3) %>% summarise(mean_locus = mean(locus_control, na.rm = TRUE), sd_locus = sd(locus_control, na.rm = TRUE), n = n())
# A tibble: 4 × 4
ipv_group3    mean_locus sd_locus     n
<fct>              <dbl>    <dbl> <int>
  1 No IPV              21.0     4.86    24
2 Victim Only         27.5     3.89    16
3 Bidirectional       26.6     6.13   100
4 NA                  26.4     6.55    66
> 
  > model_locus_adj <- lm(locus_control ~ ipv_group3 + age + gender, data = data)
> summary(model_locus_adj)

Call:
  lm(formula = locus_control ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min       1Q   Median       3Q      Max 
-13.6844  -2.8765   0.0583   3.1729  21.3156 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)              29.5134     3.7228   7.928 1.74e-12 ***
  ipv_group3Victim Only     6.2479     1.9790   3.157  0.00204 ** 
  ipv_group3Bidirectional   5.6419     1.3679   4.124 7.13e-05 ***
  age                      -0.4235     0.1724  -2.456  0.01555 *  
  genderFemale              0.6809     1.0536   0.646  0.51939    
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.574 on 113 degrees of freedom
(88 observations deleted due to missingness)
Multiple R-squared:  0.1721,	Adjusted R-squared:  0.1428 
F-statistic: 5.874 on 4 and 113 DF,  p-value: 0.0002483

> lm.beta(model_locus_adj)

Call:
  lm(formula = locus_control ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA              0.32631789              0.42623067             -0.21292148 
genderFemale 
0.05597077 

> # ============================================
> # AIM 3: Variable 3 - Self-Esteem
  > # ============================================
> 
  > anova_esteem <- aov(self_esteem ~ ipv_group3, data = data)
> summary(anova_esteem)
Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3    2   12.9   6.431   0.469  0.627
Residuals   117 1605.6  13.723               
86 observations deleted due to missingness
> TukeyHSD(anova_esteem)
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = self_esteem ~ ipv_group3, data = data)

$ipv_group3
diff       lwr      upr     p adj
Victim Only-No IPV         1.1845238 -1.733755 4.102802 0.6012959
Bidirectional-No IPV       0.5806081 -1.567536 2.728752 0.7974484
Bidirectional-Victim Only -0.6039157 -3.005037 1.797205 0.8219566

> 
  > anova_esteem_summary <- summary(anova_esteem)
> SS_between <- anova_esteem_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_esteem_summary[[1]]["Residuals", "Sum Sq"]
> eta2_esteem <- SS_between / (SS_between + SS_residual)
> eta2_esteem
[1] 0.007946433
> 
  > cohens_d(self_esteem ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
-0.38     | [-1.03, 0.28]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(self_esteem ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
  -0.16     | [-0.63, 0.32]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cohens_d(self_esteem ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
0.16      | [-0.38, 0.69]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> data %>% group_by(ipv_group3) %>% summarise(mean_esteem = mean(self_esteem, na.rm = TRUE), sd_esteem = sd(self_esteem, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_esteem sd_esteem     n
  <fct>               <dbl>     <dbl> <int>
1 No IPV               19.2      2.87    24
2 Victim Only          20.4      3.5     16
3 Bidirectional        19.8      3.91   100
4 NA                   19.8      3.97    66
> 
> model_esteem_adj <- lm(self_esteem ~ ipv_group3 + age + gender, data = data)
> summary(model_esteem_adj)

Call:
lm(formula = self_esteem ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-10.7542  -2.2171  -0.3162   1.5135  11.5938 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)              22.7769     2.3339   9.759   <2e-16 ***
ipv_group3Victim Only     1.2416     1.1899   1.043    0.299    
ipv_group3Bidirectional   0.6361     0.8770   0.725    0.470    
age                      -0.1630     0.1080  -1.508    0.134    
genderFemale             -0.7470     0.6675  -1.119    0.265    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.566 on 114 degrees of freedom
  (87 observations deleted due to missingness)
Multiple R-squared:  0.04147,	Adjusted R-squared:  0.007841 
F-statistic: 1.233 on 4 and 114 DF,  p-value: 0.3008

> lm.beta(model_esteem_adj)

Call:
lm(formula = self_esteem ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA              0.11880456              0.08258529             -0.14020716 
           genderFemale 
            -0.10369539 

> # ============================================
> # AIM 3: Variable 4 - Self-Reliance
> # ============================================
> 
> anova_reliance <- aov(self_reliance ~ ipv_group3, data = data)
> summary(anova_reliance)
             Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3    2     13   6.501   0.286  0.752
Residuals   117   2663  22.762               
86 observations deleted due to missingness
> TukeyHSD(anova_reliance)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = self_reliance ~ ipv_group3, data = data)

$ipv_group3
                                diff       lwr      upr     p adj
Victim Only-No IPV        -1.0454545 -4.837828 2.746919 0.7902328
Bidirectional-No IPV      -0.7803943 -3.496280 1.935491 0.7743585
Bidirectional-Victim Only  0.2650602 -2.912513 3.442633 0.9786186

> 
> anova_reliance_summary <- summary(anova_reliance)
> SS_between <- anova_reliance_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_reliance_summary[[1]]["Residuals", "Sum Sq"]
> eta2_reliance <- SS_between / (SS_between + SS_residual)
> eta2_reliance
[1] 0.004858435
> 
> cohens_d(self_reliance ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
  0.24      | [-0.42, 0.90]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cohens_d(self_reliance ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
0.16      | [-0.31, 0.63]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(self_reliance ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
  -0.05     | [-0.60, 0.50]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > data %>% group_by(ipv_group3) %>% summarise(mean_reliance = mean(self_reliance, na.rm = TRUE), sd_reliance = sd(self_reliance, na.rm = TRUE), n = n())
# A tibble: 4 × 4
ipv_group3    mean_reliance sd_reliance     n
<fct>                 <dbl>       <dbl> <int>
  1 No IPV                 20.0        4.33    24
2 Victim Only            19          4.39    16
3 Bidirectional          19.3        4.94   100
4 NA                     19.8        5.44    66
> 
  > model_reliance_adj <- lm(self_reliance ~ ipv_group3 + age + gender, data = data)
> summary(model_reliance_adj)

Call:
  lm(formula = self_reliance ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min       1Q   Median       3Q      Max 
-12.5452  -3.2591  -0.5021   3.2698   9.1925 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)             20.04385    3.10044   6.465 2.61e-09 ***
  ipv_group3Victim Only   -0.93785    1.62063  -0.579    0.564    
ipv_group3Bidirectional -0.75700    1.16478  -0.650    0.517    
age                      0.01076    0.14467   0.074    0.941    
genderFemale            -0.68383    0.90983  -0.752    0.454    
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.814 on 114 degrees of freedom
(87 observations deleted due to missingness)
Multiple R-squared:  0.01001,	Adjusted R-squared:  -0.02472 
F-statistic: 0.2882 on 4 and 114 DF,  p-value: 0.8851

> lm.beta(model_reliance_adj)

Call:
  lm(formula = self_reliance ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA            -0.065725441            -0.073984928             0.007084649 
genderFemale 
-0.070832644 

> # ============================================
> # AIM 3: Correlation Analysis
  > # ============================================
> 
  > cor_vars3 <- data[, c("inadequacy", "locus_control", "self_esteem", "self_reliance")]
> cor_matrix3 <- rcorr(as.matrix(cor_vars3), type = "pearson")
> cor_matrix3$r
inadequacy locus_control self_esteem self_reliance
inadequacy     1.00000000    0.62445223   0.1846911   -0.08316192
locus_control  0.62445223    1.00000000   0.2251557   -0.01554844
self_esteem    0.18469111    0.22515572   1.0000000    0.40305046
self_reliance -0.08316192   -0.01554844   0.4030505    1.00000000
> cor_matrix3$P
inadequacy locus_control  self_esteem self_reliance
inadequacy            NA   0.000000000 2.273487e-02  3.020124e-01
locus_control 0.00000000            NA 4.580469e-03  8.457662e-01
self_esteem   0.02273487   0.004580469           NA  1.152436e-07
self_reliance 0.30201244   0.845766233 1.152436e-07            NA
> 
  > # ============================================
> # AIM 3: Multinomial Logistic Regression
  > # ============================================
> 
  > model_aim3 <- multinom(ipv_group3 ~ inadequacy + locus_control + self_esteem + self_reliance + age + gender, data = data)
# weights:  24 (14 variable)
initial  value 108.762617 
iter  10 value 74.096368
iter  20 value 70.464971
final  value 70.375026 
converged
> summary(model_aim3)
Call:
  multinom(formula = ipv_group3 ~ inadequacy + locus_control + 
             self_esteem + self_reliance + age + gender, data = data)

Coefficients:
  (Intercept) inadequacy locus_control self_esteem self_reliance        age genderFemale
Victim Only     -6.161056 0.01829456     0.1855235  0.08001257  -0.120726402 0.05009092  0.909369660
Bidirectional   -6.739705 0.06065123     0.1687247 -0.06517050  -0.000996148 0.19093852 -0.001860274

Std. Errors:
  (Intercept) inadequacy locus_control self_esteem self_reliance       age genderFemale
Victim Only      4.638059 0.10726146    0.09966088   0.1354120    0.10488973 0.1512340    0.8557479
Bidirectional    3.457368 0.08545139    0.07559323   0.1087299    0.06843617 0.1090044    0.6123961

Residual Deviance: 140.7501 
AIC: 168.7501 
> 
  > z3 <- summary(model_aim3)$coefficients / summary(model_aim3)$standard.errors
> p3 <- (1 - pnorm(abs(z3), 0, 1)) * 2
> p3
(Intercept) inadequacy locus_control self_esteem self_reliance        age genderFemale
Victim Only    0.18405608  0.8645694    0.06266685   0.5545993     0.2497388 0.74048232    0.2879359
Bidirectional  0.05125075  0.4778439    0.02561441   0.5489197     0.9883865 0.07983242    0.9975763
> 
  > exp(coef(model_aim3))
(Intercept) inadequacy locus_control self_esteem self_reliance      age genderFemale
Victim Only   0.002110025   1.018463      1.203848   1.0833007     0.8862764 1.051367    2.4827571
Bidirectional 0.001182996   1.062528      1.183794   0.9369077     0.9990043 1.210385    0.9981415
> exp(confint(model_aim3))
, , Victim Only

2.5 %    97.5 %
  (Intercept)   2.378838e-07 18.715879
inadequacy    8.253613e-01  1.256743
locus_control 9.902397e-01  1.463536
self_esteem   8.307801e-01  1.412576
self_reliance 7.215840e-01  1.088558
age           7.816703e-01  1.414115
genderFemale  4.640025e-01 13.284591

, , Bidirectional

2.5 %   97.5 %
  (Intercept)   1.349169e-06 1.037291
inadequacy    8.986781e-01 1.256252
locus_control 1.020778e+00 1.372844
self_esteem   7.570869e-01 1.159439
self_reliance 8.736036e-01 1.142406
age           9.775497e-01 1.498678
genderFemale  3.005519e-01 3.314856

> 
  > pR2(model_aim3)
fitting null model for pseudo-r2
# weights:  6 (2 variable)
initial  value 108.762617 
final  value 80.917945 
converged
llh     llhNull          G2    McFadden        r2ML        r2CU 
-70.3750260 -80.9179449  21.0858379   0.1302915   0.1918344   0.2383064 