names(data)
[1] "id"                     "gender"                 "sexual_orientation"    
[4] "age"                    "involvement_level"      "k10"                   
[7] "ptsd"                   "relationship_status"    "in_school"             
[10] "school_level"           "personal_conflict"      "partner_conflict"      
[13] "positive_support"       "negative_family_comm"   "coping"                
[16] "interpersonal"          "caregiver_relationship" "relationship_tension"  
[19] "inadequacy"             "self_esteem"            "locus_control"         
[22] "self_reliance"          "justify_women"          "justify_men"           
[25] "dv_prevalence_belief"   "need_help_belief"       "service_awareness"     
[28] "advocacy_interest"      "peer_dv_exposure"       "ace_score"             
[31] "unfair_treatment"       "social_stress"          "alcohol_use"           
[34] "tobacco"                "cannabis"               "cocaine"               
[37] "amphetamines"           "inhalants"              "sedatives"             
[40] "hallucinogens"          "opioids"                "other_drug"            
[43] "hits"                   "victim_pvs"             "victim_dcrs"           
[46] "victim_binary"          "perpetrator_pvs"        "perpetrator_dcrs"      
[49] "perpetrator_binary"     "ipv_group"              "ipv_group3"            
> # ============================================
> # AIM 4: Variable 1 - Justification of Violence (Women)
  > # ============================================
> 
  > anova_jw <- aov(justify_women ~ ipv_group3, data = data)
  > summary(anova_jw)
  Df Sum Sq Mean Sq F value  Pr(>F)   
  ipv_group3    2    987   493.4   5.667 0.00454 **
    Residuals   110   9577    87.1                   
  ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  93 observations deleted due to missingness
  > TukeyHSD(anova_jw)
  Tukey multiple comparisons of means
  95% family-wise confidence level
  
  Fit: aov(formula = justify_women ~ ipv_group3, data = data)
  
  $ipv_group3
  diff        lwr       upr     p adj
  Victim Only-No IPV        -1.272727  -9.671686  7.126231 0.9310940
  Bidirectional-No IPV      -7.120482 -12.758445 -1.482519 0.0092752
  Bidirectional-Victim Only -5.847755 -12.960979  1.265470 0.1288885
  
  > 
    > anova_jw_summary <- summary(anova_jw)
  > SS_between <- anova_jw_summary[[1]]["ipv_group3", "Sum Sq"]
  > SS_residual <- anova_jw_summary[[1]]["Residuals", "Sum Sq"]
  > eta2_jw <- SS_between / (SS_between + SS_residual)
  > eta2_jw
  [1] 0.09341903
  > 
    > cohens_d(justify_women ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
0.17      | [-0.58, 0.91]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(justify_women ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |       95% CI
  ------------------------
    0.76      | [0.25, 1.27]
  
  - Estimated using pooled SD.
  Warning message:
    Missing values detected. NAs dropped. 
  > cohens_d(justify_women ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
0.60      | [-0.04, 1.23]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> data %>% group_by(ipv_group3) %>% summarise(mean_jw = mean(justify_women, na.rm = TRUE), sd_jw = sd(justify_women, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_jw sd_jw     n
  <fct>           <dbl> <dbl> <int>
1 No IPV           44    6.73    24
2 Victim Only      42.7  8.73    16
3 Bidirectional    36.9  9.88   100
4 NA               41.8 11.5     66
> 
> model_jw_adj <- lm(justify_women ~ ipv_group3 + age + gender, data = data)
> summary(model_jw_adj)

Call:
lm(formula = justify_women ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-24.0503  -6.3913   0.8464   7.0470  15.9497 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)             45.26967    6.38599   7.089 1.51e-10 ***
ipv_group3Victim Only   -1.19004    3.60505  -0.330  0.74197    
ipv_group3Bidirectional -6.94382    2.40956  -2.882  0.00478 ** 
age                     -0.05315    0.29231  -0.182  0.85607    
genderFemale            -0.53941    1.82873  -0.295  0.76859    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 9.424 on 107 degrees of freedom
  (94 observations deleted due to missingness)
Multiple R-squared:  0.09243,	Adjusted R-squared:  0.0585 
F-statistic: 2.724 on 4 and 107 DF,  p-value: 0.03317

> lm.beta(model_jw_adj)

Call:
lm(formula = justify_women ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.03663002             -0.31804203             -0.01696455 
           genderFemale 
            -0.02753223 

> # ============================================
> # AIM 4 - VARIABLE 2: justify_men
> # ============================================
> 
> # Step 1: ANOVA
> anova_justmen <- aov(justify_men ~ ipv_group3, data = data)
> summary(anova_justmen)
             Df Sum Sq Mean Sq F value Pr(>F)  
ipv_group3    2    920   459.9   3.977 0.0215 *
Residuals   109  12605   115.6                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
94 observations deleted due to missingness
> 
> # Step 2: Tukey post hoc
> TukeyHSD(anova_justmen)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = justify_men ~ ipv_group3, data = data)

$ipv_group3
                               diff       lwr       upr     p adj
Victim Only-No IPV        -2.824786 -12.12524  6.475667 0.7511957
Bidirectional-No IPV      -7.376543 -14.03495 -0.718141 0.0260679
Bidirectional-Victim Only -4.551757 -12.18626  3.082749 0.3358954

> 
> # Step 3: Eta-squared
> SS_between <- summary(anova_justmen)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_justmen)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.068 
> 
> # Step 4: Cohen's d (3 pairwise comparisons)
  > library(effectsize)
  > 
    > # Victim Only vs No IPV
    > subset1 <- data[data$ipv_group3 %in% c("Victim Only", "No IPV"), ]
  > subset1$ipv_group3 <- droplevels(subset1$ipv_group3)
  > cohens_d(justify_men ~ ipv_group3, data = subset1, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
0.29      | [-0.43, 1.01]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Bidirectional vs No IPV
> subset2 <- data[data$ipv_group3 %in% c("Bidirectional", "No IPV"), ]
> subset2$ipv_group3 <- droplevels(subset2$ipv_group3)
> cohens_d(justify_men ~ ipv_group3, data = subset2, pooled_sd = TRUE)
Cohen's d |       95% CI
  ------------------------
    0.69      | [0.17, 1.21]
  
  - Estimated using pooled SD.
  Warning message:
    Missing values detected. NAs dropped. 
  > 
    > # Bidirectional vs Victim Only
    > subset3 <- data[data$ipv_group3 %in% c("Bidirectional", "Victim Only"), ]
  > subset3$ipv_group3 <- droplevels(subset3$ipv_group3)
  > cohens_d(justify_men ~ ipv_group3, data = subset3, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
0.41      | [-0.18, 1.00]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Group means and SDs
> tapply(data$justify_men, data$ipv_group3, function(x) c(mean = mean(x, na.rm=TRUE), sd = sd(x, na.rm=TRUE)))
$`No IPV`
     mean        sd 
45.055556  8.320578 

$`Victim Only`
    mean       sd 
42.23077 11.22611 

$Bidirectional
    mean       sd 
37.67901 11.13309 

> 
> # Step 5: Regression
> library(lm.beta)
> model_justmen <- lm(justify_men ~ ipv_group3 + age + gender, data = data)
> summary(model_justmen)

Call:
lm(formula = justify_men ~ ipv_group3 + age + gender, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-25.302  -7.767   1.833   8.454  18.743 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)             44.03646    6.98394   6.305 6.58e-09 ***
ipv_group3Victim Only   -2.24033    4.00457  -0.559   0.5770    
ipv_group3Bidirectional -7.19239    2.84328  -2.530   0.0129 *  
age                      0.07288    0.32026   0.228   0.8204    
genderFemale            -1.68045    2.11445  -0.795   0.4285    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 10.82 on 107 degrees of freedom
  (94 observations deleted due to missingness)
Multiple R-squared:  0.07368,	Adjusted R-squared:  0.03906 
F-statistic: 2.128 on 4 and 107 DF,  p-value: 0.08233

> lm.beta(model_justmen)

Call:
lm(formula = justify_men ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.06530213             -0.29283551              0.02141579 
           genderFemale 
            -0.07546722 

> # ============================================
> # AIM 4 - VARIABLE 3: dv_prevalence_belief
> # ============================================
> 
> # Step 1: ANOVA
> anova_dvprev <- aov(dv_prevalence_belief ~ ipv_group3, data = data)
> summary(anova_dvprev)
             Df Sum Sq Mean Sq F value Pr(>F)  
ipv_group3    2    533  266.64   4.142 0.0183 *
Residuals   117   7532   64.38                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
86 observations deleted due to missingness
> 
> # Step 2: Tukey post hoc
> TukeyHSD(anova_dvprev)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = dv_prevalence_belief ~ ipv_group3, data = data)

$ipv_group3
                              diff       lwr       upr     p adj
Victim Only-No IPV        4.508772 -2.514596 11.532139 0.2834541
Bidirectional-No IPV      5.830869  1.017247 10.644492 0.0132034
Bidirectional-Victim Only 1.322097 -4.535332  7.179526 0.8538676

> 
> # Step 3: Eta-squared
> SS_between <- summary(anova_dvprev)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_dvprev)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.0661 
> 
> # Step 4: Cohen's d (3 pairwise comparisons)
  > library(effectsize)
  > 
    > # Victim Only vs No IPV
    > subset1 <- data[data$ipv_group3 %in% c("Victim Only", "No IPV"), ]
  > subset1$ipv_group3 <- droplevels(subset1$ipv_group3)
  > cohens_d(dv_prevalence_belief ~ ipv_group3, data = subset1, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
-0.58     | [-1.31, 0.16]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Bidirectional vs No IPV
> subset2 <- data[data$ipv_group3 %in% c("Bidirectional", "No IPV"), ]
> subset2$ipv_group3 <- droplevels(subset2$ipv_group3)
> cohens_d(dv_prevalence_belief ~ ipv_group3, data = subset2, pooled_sd = TRUE)
Cohen's d |         95% CI
  --------------------------
    -0.73     | [-1.23, -0.22]
  
  - Estimated using pooled SD.
  Warning message:
    Missing values detected. NAs dropped. 
  > 
    > # Bidirectional vs Victim Only
    > subset3 <- data[data$ipv_group3 %in% c("Bidirectional", "Victim Only"), ]
  > subset3$ipv_group3 <- droplevels(subset3$ipv_group3)
  > cohens_d(dv_prevalence_belief ~ ipv_group3, data = subset3, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
-0.16     | [-0.77, 0.44]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Group means and SDs
> tapply(data$dv_prevalence_belief, data$ipv_group3, function(x) c(mean = mean(x, na.rm=TRUE), sd = sd(x, na.rm=TRUE)))
$`No IPV`
     mean        sd 
11.157895  7.683049 

$`Victim Only`
     mean        sd 
15.666667  7.958224 

$Bidirectional
     mean        sd 
16.988764  8.099515 

> 
> # Step 5: Regression
> library(lm.beta)
> model_dvprev <- lm(dv_prevalence_belief ~ ipv_group3 + age + gender, data = data)
> summary(model_dvprev)

Call:
lm(formula = dv_prevalence_belief ~ ipv_group3 + age + gender, 
    data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-16.912  -5.179   0.164   4.839  18.513 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)   
(Intercept)               2.2482     5.0973   0.441  0.66000   
ipv_group3Victim Only     4.9282     2.9242   1.685  0.09467 . 
ipv_group3Bidirectional   5.4254     2.0173   2.689  0.00823 **
age                       0.4619     0.2360   1.957  0.05275 . 
genderFemale             -1.4262     1.4883  -0.958  0.33993   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 7.909 on 114 degrees of freedom
  (87 observations deleted due to missingness)
Multiple R-squared:  0.09945,	Adjusted R-squared:  0.06786 
F-statistic: 3.147 on 4 and 114 DF,  p-value: 0.01702

> lm.beta(model_dvprev)

Call:
lm(formula = dv_prevalence_belief ~ ipv_group3 + age + gender, 
    data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA              0.18191584              0.29191520              0.17722177 
           genderFemale 
            -0.08577215 

> # ============================================
> # AIM 4 - VARIABLE 4: need_help_belief
> # ============================================
> 
> # Step 1: ANOVA
> anova_needhelp <- aov(need_help_belief ~ ipv_group3, data = data)
> summary(anova_needhelp)
             Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3    2   4.16   2.079    0.89  0.413
Residuals   126 294.17   2.335               
77 observations deleted due to missingness
> 
> # Step 2: Tukey post hoc
> TukeyHSD(anova_needhelp)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = need_help_belief ~ ipv_group3, data = data)

$ipv_group3
                                diff       lwr       upr     p adj
Victim Only-No IPV        -0.1250000 -1.315689 1.0656886 0.9664114
Bidirectional-No IPV      -0.4395604 -1.300524 0.4214034 0.4489733
Bidirectional-Victim Only -0.3145604 -1.296962 0.6678409 0.7284959

> 
> # Step 3: Eta-squared
> SS_between <- summary(anova_needhelp)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_needhelp)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.0139 
> 
> # Step 4: Cohen's d (3 pairwise comparisons)
  > library(effectsize)
  > 
    > # Victim Only vs No IPV
    > subset1 <- data[data$ipv_group3 %in% c("Victim Only", "No IPV"), ]
  > subset1$ipv_group3 <- droplevels(subset1$ipv_group3)
  > cohens_d(need_help_belief ~ ipv_group3, data = subset1, pooled_sd = TRUE)
  Cohen's d |        95% CI
-------------------------
0.10      | [-0.54, 0.75]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Bidirectional vs No IPV
> subset2 <- data[data$ipv_group3 %in% c("Bidirectional", "No IPV"), ]
> subset2$ipv_
NULL
> # Bidirectional vs No IPV (Cohen's d)
> subset2 <- data[data$ipv_group3 %in% c("Bidirectional", "No IPV"), ]
> subset2$ipv_group3 <- droplevels(subset2$ipv_group3)
> cohens_d(need_help_belief ~ ipv_group3, data = subset2, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
0.29      | [-0.18, 0.76]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Bidirectional vs Victim Only
> subset3 <- data[data$ipv_group3 %in% c("Bidirectional", "Victim Only"), ]
> subset3$ipv_group3 <- droplevels(subset3$ipv_group3)
> cohens_d(need_help_belief ~ ipv_group3, data = subset3, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
  0.19      | [-0.34, 0.72]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Group means and SDs
  > tapply(data$need_help_belief, data$ipv_group3, function(x) c(mean = mean(x, na.rm=TRUE), sd = sd(x, na.rm=TRUE)))
$`No IPV`
mean        sd 
7.0000000 0.8728716 

$`Victim Only`
mean       sd 
6.875000 1.586401 

$Bidirectional
mean       sd 
6.560440 1.634413 

> 
  > # Step 5: Regression
  > library(lm.beta)
> model_needhelp <- lm(need_help_belief ~ ipv_group3 + age + gender, data = data)
> summary(model_needhelp)

Call:
  lm(formula = need_help_belief ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min      1Q  Median      3Q     Max 
-5.1375 -0.6204  0.3322  1.1901  1.8632 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)              6.11141    0.96416   6.339 3.99e-09 ***
  ipv_group3Victim Only   -0.06373    0.50693  -0.126    0.900    
ipv_group3Bidirectional -0.43872    0.36751  -1.194    0.235    
age                      0.04738    0.04448   1.065    0.289    
genderFemale            -0.24666    0.27658  -0.892    0.374    
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.534 on 123 degrees of freedom
(78 observations deleted due to missingness)
Multiple R-squared:  0.02794,	Adjusted R-squared:  -0.003673 
F-statistic: 0.8838 on 4 and 123 DF,  p-value: 0.4758

> lm.beta(model_needhelp)

Call:
  lm(formula = need_help_belief ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA             -0.01381641             -0.13139704              0.09568993 
genderFemale 
-0.07985359 

> str(data$service_awareness)
Factor w/ 2 levels "N","Y": NA NA NA NA 1 1 NA NA NA 1 ...
> table(data$service_awareness, useNA = "ifany")

N    Y <NA> 
  85  102   19 
> # ============================================
> # AIM 4 - VARIABLE 5: service_awareness
  > # ============================================
> 
  > # Cross-tabulation
  > table(data$service_awareness, data$ipv_group3)

No IPV Victim Only Bidirectional
N      7           8            43
Y     17           8            49
> 
  > # Chi-square test
  > chisq.test(table(data$service_awareness, data$ipv_group3))

Pearson's Chi-squared test

data:  table(data$service_awareness, data$ipv_group3)
X-squared = 2.6576, df = 2, p-value = 0.2648

> 
> # Proportions by group (column percentages)
> prop.table(table(data$service_awareness, data$ipv_group3), margin = 2)
   
       No IPV Victim Only Bidirectional
  N 0.2916667   0.5000000     0.4673913
  Y 0.7083333   0.5000000     0.5326087
> 
> # Cramér's V (effect size for chi-square)
> library(effectsize)
> cramers_v(table(data$service_awareness, data$ipv_group3))
Cramer's V (adj.) |       95% CI
--------------------------------
0.07              | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> str(data$advocacy_interest)
 int [1:206] NA NA NA 28 7 31 NA NA NA 23 ...
> table(data$advocacy_interest, useNA = "ifany")

   7    9   11   12   13   16   20   21   22   23   24   25   26   27   28   29   30   31   32   33 
   5    1    1    1    2    1    2    3    1    6    6    6   12    8   33   13   14   22   15    4 
  34   35 <NA> 
   4   11   35 
> # ============================================
> # AIM 4 - VARIABLE 6: advocacy_interest
> # ============================================
> 
> # Step 1: ANOVA
> anova_advocacy <- aov(advocacy_interest ~ ipv_group3, data = data)
> summary(anova_advocacy)
             Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3    2   90.6   45.31   1.854  0.161
Residuals   119 2908.4   24.44               
84 observations deleted due to missingness
> 
> # Step 2: Tukey post hoc
> TukeyHSD(anova_advocacy)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = advocacy_interest ~ ipv_group3, data = data)

$ipv_group3
                                diff       lwr       upr     p adj
Victim Only-No IPV        -1.7203947 -5.701659 2.2608700 0.5622318
Bidirectional-No IPV      -2.3992740 -5.370532 0.5719837 0.1384739
Bidirectional-Victim Only -0.6788793 -3.870585 2.5128263 0.8691297

> 
> # Step 3: Eta-squared
> SS_between <- summary(anova_advocacy)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_advocacy)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.0302 
> 
> # Step 4: Cohen's d (3 pairwise comparisons)
> library(effectsize)
> 
  > # Victim Only vs No IPV
  > subset1 <- data[data$ipv_group3 %in% c("Victim Only", "No IPV"), ]
> subset1$ipv_group3 <- droplevels(subset1$ipv_group3)
> cohens_d(advocacy_interest ~ ipv_group3, data = subset1, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
0.53      | [-0.15, 1.20]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Bidirectional vs No IPV
> subset2 <- data[data$ipv_group3 %in% c("Bidirectional", "No IPV"), ]
> subset2$ipv_group3 <- droplevels(subset2$ipv_group3)
> cohens_d(advocacy_interest ~ ipv_group3, data = subset2, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
  0.47      | [-0.04, 0.97]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Bidirectional vs Victim Only
  > subset3 <- data[data$ipv_group3 %in% c("Bidirectional", "Victim Only"), ]
> subset3$ipv_group3 <- droplevels(subset3$ipv_group3)
> cohens_d(advocacy_interest ~ ipv_group3, data = subset3, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
0.13      | [-0.40, 0.66]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Group means and SDs
> tapply(data$advocacy_interest, data$ipv_group3, function(x) c(mean = mean(x, na.rm=TRUE), sd = sd(x, na.rm=TRUE)))
$`No IPV`
     mean        sd 
30.157895  3.304259 

$`Victim Only`
     mean        sd 
28.437500  3.203514 

$Bidirectional
    mean       sd 
27.75862  5.45375 

> 
> # Step 5: Regression
> library(lm.beta)
> model_advocacy <- lm(advocacy_interest ~ ipv_group3 + age + gender, data = data)
> summary(model_advocacy)

Call:
lm(formula = advocacy_interest ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-21.3269  -1.3112   0.7919   3.1204   7.5683 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)              28.0751     3.2324   8.686 2.79e-14 ***
ipv_group3Victim Only    -1.6008     1.6988  -0.942   0.3480    
ipv_group3Bidirectional  -2.4315     1.2694  -1.915   0.0579 .  
age                       0.1118     0.1485   0.753   0.4532    
genderFemale             -0.5597     0.9221  -0.607   0.5450    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.989 on 116 degrees of freedom
  (85 observations deleted due to missingness)
Multiple R-squared:  0.03723,	Adjusted R-squared:  0.004036 
F-statistic: 1.122 on 4 and 116 DF,  p-value: 0.3498

> lm.beta(model_advocacy)

Call:
lm(formula = advocacy_interest ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.10891934             -0.22145302              0.06953091 
           genderFemale 
            -0.05578329 

> # ============================================
> # AIM 4 - CORRELATIONS
> # ============================================
> library(Hmisc)
> 
> cor_vars <- data[, c("justify_women", "justify_men", "dv_prevalence_belief", "need_help_belief", "advocacy_interest")]
> cor_matrix <- rcorr(as.matrix(cor_vars), type = "pearson")
> cor_matrix
                     justify_women justify_men dv_prevalence_belief need_help_belief
justify_women                 1.00        0.84                -0.19             0.12
justify_men                   0.84        1.00                -0.21             0.18
dv_prevalence_belief         -0.19       -0.21                 1.00            -0.01
need_help_belief              0.12        0.18                -0.01             1.00
advocacy_interest            -0.15       -0.02                 0.13             0.62
                     advocacy_interest
justify_women                    -0.15
justify_men                      -0.02
dv_prevalence_belief              0.13
need_help_belief                  0.62
advocacy_interest                 1.00

n
                     justify_women justify_men dv_prevalence_belief need_help_belief
justify_women                  154         134                  141              149
justify_men                    134         152                  138              149
dv_prevalence_belief           141         138                  166              161
need_help_belief               149         149                  161              178
advocacy_interest              146         142                  156              166
                     advocacy_interest
justify_women                      146
justify_men                        142
dv_prevalence_belief               156
need_help_belief                   166
advocacy_interest                  171

P
                     justify_women justify_men dv_prevalence_belief need_help_belief
justify_women                      0.0000      0.0254               0.1367          
justify_men          0.0000                    0.0126               0.0258          
dv_prevalence_belief 0.0254        0.0126                           0.9106          
need_help_belief     0.1367        0.0258      0.9106                               
advocacy_interest    0.0683        0.8469      0.1198               0.0000          
                     advocacy_interest
justify_women        0.0683           
justify_men          0.8469           
dv_prevalence_belief 0.1198           
need_help_belief     0.0000           
advocacy_interest                     
> 
> # ============================================
> # AIM 4 - MULTINOMIAL LOGISTIC REGRESSION
> # ============================================
> library(nnet)
> 
> model_multi4 <- multinom(ipv_group3 ~ justify_women + justify_men + dv_prevalence_belief + need_help_belief + service_awareness + advocacy_interest + age + gender, data = data)
# weights:  30 (18 variable)
initial  value 87.888983 
iter  10 value 49.185006
iter  20 value 45.288464
iter  30 value 45.222266
final  value 45.221245 
converged
> summary(model_multi4)
Call:
multinom(formula = ipv_group3 ~ justify_women + justify_men + 
    dv_prevalence_belief + need_help_belief + service_awareness + 
    advocacy_interest + age + gender, data = data)

Coefficients:
              (Intercept) justify_women justify_men dv_prevalence_belief need_help_belief
Victim Only      2.022885    0.01269643 -0.04298321           0.09364581        1.4771468
Bidirectional    5.622320   -0.04070401 -0.03719758           0.09852140        0.2302764
              service_awarenessY advocacy_interest        age genderFemale
Victim Only           -0.5477843        -0.3308715 -0.2214521    1.5417069
Bidirectional          0.3968471        -0.1737662  0.0366546    0.5268213

Std. Errors:
              (Intercept) justify_women justify_men dv_prevalence_belief need_help_belief
Victim Only      7.599534    0.11948271  0.11207774           0.07392301        0.9038234
Bidirectional    4.366324    0.07545337  0.06787644           0.04614118        0.3862719
              service_awarenessY advocacy_interest       age genderFemale
Victim Only            1.3199038         0.2015612 0.1979508    1.1587327
Bidirectional          0.8286503         0.1299909 0.1106031    0.7144925

Residual Deviance: 90.44249 
AIC: 126.4425 
> 
> # Z-scores and p-values
> z <- summary(model_multi4)$coefficients / summary(model_multi4)$standard.errors
> p <- (1 - pnorm(abs(z), 0, 1)) * 2
> cat("\nZ-scores:\n")

Z-scores:
> print(round(z, 4))
              (Intercept) justify_women justify_men dv_prevalence_belief need_help_belief
Victim Only        0.2662        0.1063     -0.3835               1.2668           1.6343
Bidirectional      1.2877       -0.5395     -0.5480               2.1352           0.5962
              service_awarenessY advocacy_interest     age genderFemale
Victim Only              -0.4150           -1.6415 -1.1187       1.3305
Bidirectional             0.4789           -1.3368  0.3314       0.7373
> cat("\nP-values:\n")

P-values:
> print(round(p, 4))
              (Intercept) justify_women justify_men dv_prevalence_belief need_help_belief
Victim Only        0.7901        0.9154      0.7013               0.2052           0.1022
Bidirectional      0.1979        0.5896      0.5837               0.0327           0.5511
              service_awarenessY advocacy_interest    age genderFemale
Victim Only               0.6781            0.1007 0.2633       0.1833
Bidirectional             0.6320            0.1813 0.7403       0.4609
> 
> # Odds ratios
> cat("\nOdds Ratios:\n")

Odds Ratios:
> print(round(exp(coef(model_multi4)), 4))
              (Intercept) justify_women justify_men dv_prevalence_belief need_help_belief
Victim Only        7.5601        1.0128      0.9579               1.0982           4.3804
Bidirectional    276.5302        0.9601      0.9635               1.1035           1.2589
              service_awarenessY advocacy_interest    age genderFemale
Victim Only               0.5782            0.7183 0.8014       4.6726
Bidirectional             1.4871            0.8405 1.0373       1.6935
> 
> # Confidence intervals
> cat("\nConfidence Intervals:\n")

Confidence Intervals:
> print(round(exp(confint(model_multi4)), 4))
, , Victim Only

                      2.5 %       97.5 %
(Intercept)          0.0000 2.224655e+07
justify_women        0.8013 1.280000e+00
justify_men          0.7690 1.193300e+00
dv_prevalence_belief 0.9501 1.269400e+00
need_help_belief     0.7450 2.575450e+01
service_awarenessY   0.0435 7.684300e+00
advocacy_interest    0.4839 1.066300e+00
age                  0.5437 1.181200e+00
genderFemale         0.4822 4.527620e+01

, , Bidirectional

                      2.5 %       97.5 %
(Intercept)          0.0531 1440005.0551
justify_women        0.8281       1.1131
justify_men          0.8435       1.1006
dv_prevalence_belief 1.0081       1.2080
need_help_belief     0.5905       2.6841
service_awarenessY   0.2931       7.5457
advocacy_interest    0.6515       1.0844
age                  0.8352       1.2884
genderFemale         0.4175       6.8703

> 
> # Model fit
> library(pscl)
> pR2(model_multi4)
fitting null model for pseudo-r2
# weights:  6 (2 variable)
initial  value 87.888983 
final  value 55.703927 
converged
        llh     llhNull          G2    McFadden        r2ML        r2CU 
-45.2212454 -55.7039266  20.9653624   0.1881857   0.2305406   0.3067449 
> names(data)[grep("prev|dv_|dating|belief", names(data), ignore.case = TRUE)]
[1] "dv_prevalence_belief" "need_help_belief"     "peer_dv_exposure"    
> names(data)[grep("justify", names(data), ignore.case = TRUE)]
[1] "justify_women" "justify_men"  
> range(data$justify_women, na.rm = TRUE)
[1] 12 55
> range(data$justify_men, na.rm = TRUE)
[1] 12 55
> # Check ranges for each variable
> cat("dv_prevalence_belief:\n")
dv_prevalence_belief:
> range(data$dv_prevalence_belief, na.rm = TRUE)
[1]  0 36
> 
> cat("\nneed_help_belief:\n")

need_help_belief:
> range(data$need_help_belief, na.rm = TRUE)
[1] 2 8
> 
> cat("\nservice_awareness:\n")

service_awareness:
> table(data$service_awareness, useNA = "ifany")

   N    Y <NA> 
  85  102   19 
> 
> cat("\nadvocacy_interest:\n")

advocacy_interest:
> range(data$advocacy_interest, na.rm = TRUE)
[1]  7 35
> range(data$peer_dv_exposure, na.rm = TRUE)
[1] 0 6
> # ============================================
> # AIM 4 - VARIABLE 3a: peer_dv_exposure
> # ============================================
> 
> # Step 1: ANOVA
> anova_peerdv <- aov(peer_dv_exposure ~ ipv_group3, data = data)
> summary(anova_peerdv)
             Df Sum Sq Mean Sq F value   Pr(>F)    
ipv_group3    2   78.1   39.06   8.898 0.000255 ***
Residuals   115  504.9    4.39                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
88 observations deleted due to missingness
> 
> # Step 2: Tukey post hoc
> TukeyHSD(anova_peerdv)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = peer_dv_exposure ~ ipv_group3, data = data)

$ipv_group3
                                diff        lwr      upr     p adj
Victim Only-No IPV        -0.4666667 -2.2833551 1.350022 0.8149872
Bidirectional-No IPV       1.6360465  0.4009531 2.871140 0.0059438
Bidirectional-Victim Only  2.1027132  0.5695645 3.635862 0.0042013

> 
> # Step 3: Eta-squared
> SS_between <- summary(anova_peerdv)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_peerdv)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.134 
> 
> # Step 4: Cohen's d (3 pairwise comparisons)
> library(effectsize)
> 
  > # Victim Only vs No IPV
  > subset1 <- data[data$ipv_group3 %in% c("Victim Only", "No IPV"), ]
> subset1$ipv_group3 <- droplevels(subset1$ipv_group3)
> cohens_d(peer_dv_exposure ~ ipv_group3, data = subset1, pooled_sd = TRUE)
Cohen's d |        95% CI
-------------------------
0.25      | [-0.47, 0.97]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Bidirectional vs No IPV
> subset2 <- data[data$ipv_group3 %in% c("Bidirectional", "No IPV"), ]
> subset2$ipv_group3 <- droplevels(subset2$ipv_group3)
> cohens_d(peer_dv_exposure ~ ipv_group3, data = subset2, pooled_sd = TRUE)
Cohen's d |         95% CI
--------------------------
  -0.76     | [-1.26, -0.26]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Bidirectional vs Victim Only
  > subset3 <- data[data$ipv_group3 %in% c("Bidirectional", "Victim Only"), ]
> subset3$ipv_group3 <- droplevels(subset3$ipv_group3)
> cohens_d(peer_dv_exposure ~ ipv_group3, data = subset3, pooled_sd = TRUE)
Cohen's d |         95% CI
--------------------------
-1.00     | [-1.62, -0.38]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> # Group means and SDs
> tapply(data$peer_dv_exposure, data$ipv_group3, function(x) c(mean = mean(x, na.rm=TRUE), sd = sd(x, na.rm=TRUE)))
$`No IPV`
    mean       sd 
1.550000 2.064104 

$`Victim Only`
    mean       sd 
1.083333 1.443376 

$Bidirectional
    mean       sd 
3.186047 2.172077 

> 
> # Step 5: Regression
> library(lm.beta)
> model_peerdv <- lm(peer_dv_exposure ~ ipv_group3 + age + gender, data = data)
> summary(model_peerdv)

Call:
lm(formula = peer_dv_exposure ~ ipv_group3 + age + gender, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-3.9117 -1.4025 -0.2151  1.9129  3.9151 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)   
(Intercept)             -1.45713    1.32657  -1.098   0.2744   
ipv_group3Victim Only   -0.32943    0.75600  -0.436   0.6639   
ipv_group3Bidirectional  1.54084    0.51475   2.993   0.0034 **
age                      0.14298    0.06095   2.346   0.0208 * 
genderFemale             0.25351    0.39018   0.650   0.5172   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.056 on 112 degrees of freedom
  (89 observations deleted due to missingness)
Multiple R-squared:  0.1836,	Adjusted R-squared:  0.1545 
F-statistic: 6.297 on 4 and 112 DF,  p-value: 0.0001314

> lm.beta(model_peerdv)

Call:
lm(formula = peer_dv_exposure ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.04488499              0.30845351              0.20419686 
           genderFemale 
             0.05599945 

> # ============================================
> # AIM 4 - UPDATED CORRELATIONS (with peer_dv_exposure)
> # ============================================
> library(Hmisc)
> 
> cor_vars <- data[, c("justify_women", "justify_men", "peer_dv_exposure", "dv_prevalence_belief", "need_help_belief", "advocacy_interest")]
> cor_matrix <- rcorr(as.matrix(cor_vars), type = "pearson")
> cor_matrix
                     justify_women justify_men peer_dv_exposure dv_prevalence_belief
justify_women                 1.00        0.84            -0.30                -0.19
justify_men                   0.84        1.00            -0.22                -0.21
peer_dv_exposure             -0.30       -0.22             1.00                 0.47
dv_prevalence_belief         -0.19       -0.21             0.47                 1.00
need_help_belief              0.12        0.18            -0.01                -0.01
advocacy_interest            -0.15       -0.02             0.02                 0.13
                     need_help_belief advocacy_interest
justify_women                    0.12             -0.15
justify_men                      0.18             -0.02
peer_dv_exposure                -0.01              0.02
dv_prevalence_belief            -0.01              0.13
need_help_belief                 1.00              0.62
advocacy_interest                0.62              1.00

n
                     justify_women justify_men peer_dv_exposure dv_prevalence_belief
justify_women                  154         134              137                  141
justify_men                    134         152              132                  138
peer_dv_exposure               137         132              157                  143
dv_prevalence_belief           141         138              143                  166
need_help_belief               149         149              152                  161
advocacy_interest              146         142              148                  156
                     need_help_belief advocacy_interest
justify_women                     149               146
justify_men                       149               142
peer_dv_exposure                  152               148
dv_prevalence_belief              161               156
need_help_belief                  178               166
advocacy_interest                 166               171

P
                     justify_women justify_men peer_dv_exposure dv_prevalence_belief
justify_women                      0.0000      0.0004           0.0254              
justify_men          0.0000                    0.0129           0.0126              
peer_dv_exposure     0.0004        0.0129                       0.0000              
dv_prevalence_belief 0.0254        0.0126      0.0000                               
need_help_belief     0.1367        0.0258      0.9077           0.9106              
advocacy_interest    0.0683        0.8469      0.7849           0.1198              
                     need_help_belief advocacy_interest
justify_women        0.1367           0.0683           
justify_men          0.0258           0.8469           
peer_dv_exposure     0.9077           0.7849           
dv_prevalence_belief 0.9106           0.1198           
need_help_belief                      0.0000           
advocacy_interest    0.0000                            
> 
> # ============================================
> # AIM 4 - UPDATED MULTINOMIAL (with peer_dv_exposure)
> # ============================================
> library(nnet)
> 
> model_multi4 <- multinom(ipv_group3 ~ justify_women + justify_men + peer_dv_exposure + dv_prevalence_belief + need_help_belief + service_awareness + advocacy_interest + age + gender, data = data)
# weights:  33 (20 variable)
initial  value 82.395922 
iter  10 value 42.509041
iter  20 value 37.915205
iter  30 value 37.647246
iter  40 value 37.589722
final  value 37.589720 
converged
> summary(model_multi4)
Call:
multinom(formula = ipv_group3 ~ justify_women + justify_men + 
    peer_dv_exposure + dv_prevalence_belief + need_help_belief + 
    service_awareness + advocacy_interest + age + gender, data = data)

Coefficients:
              (Intercept) justify_women justify_men peer_dv_exposure dv_prevalence_belief
Victim Only     -7.927344  -0.008825727  0.11358752       -0.4940337           0.12856450
Bidirectional    6.555425  -0.016850119 -0.05942878        0.2467548           0.06557596
              need_help_belief service_awarenessY advocacy_interest         age genderFemale
Victim Only          1.7823558         -0.5072093       -0.08780727 -0.49423355    0.7490470
Bidirectional        0.1030007          0.3796880       -0.19853402  0.06583548    0.3054196

Std. Errors:
              (Intercept) justify_women justify_men peer_dv_exposure dv_prevalence_belief
Victim Only     10.891093    0.14963492  0.16942472        0.5831537           0.10578153
Bidirectional    4.582123    0.08214187  0.07144475        0.2076975           0.05260416
              need_help_belief service_awarenessY advocacy_interest       age genderFemale
Victim Only          1.2202389          1.6697543         0.2468751 0.3331182     1.350792
Bidirectional        0.3932378          0.8604923         0.1304352 0.1180513     0.737180

Residual Deviance: 75.17944 
AIC: 115.1794 
> 
> # Z-scores and p-values
> z <- summary(model_multi4)$coefficients / summary(model_multi4)$standard.errors
> p <- (1 - pnorm(abs(z), 0, 1)) * 2
> cat("\nZ-scores:\n")

Z-scores:
> print(round(z, 4))
              (Intercept) justify_women justify_men peer_dv_exposure dv_prevalence_belief
Victim Only       -0.7279       -0.0590      0.6704          -0.8472               1.2154
Bidirectional      1.4307       -0.2051     -0.8318           1.1880               1.2466
              need_help_belief service_awarenessY advocacy_interest     age genderFemale
Victim Only             1.4607            -0.3038           -0.3557 -1.4837       0.5545
Bidirectional           0.2619             0.4412           -1.5221  0.5577       0.4143
> cat("\nP-values:\n")

P-values:
> print(round(p, 4))
              (Intercept) justify_women justify_men peer_dv_exposure dv_prevalence_belief
Victim Only        0.4667        0.9530      0.5026           0.3969               0.2242
Bidirectional      0.1525        0.8375      0.4055           0.2348               0.2125
              need_help_belief service_awarenessY advocacy_interest    age genderFemale
Victim Only             0.1441             0.7613            0.7221 0.1379       0.5792
Bidirectional           0.7934             0.6590            0.1280 0.5771       0.6786
> 
> # Odds ratios
> cat("\nOdds Ratios:\n")

Odds Ratios:
> print(round(exp(coef(model_multi4)), 4))
              (Intercept) justify_women justify_men peer_dv_exposure dv_prevalence_belief
Victim Only        0.0004        0.9912      1.1203           0.6102               1.1372
Bidirectional    703.0482        0.9833      0.9423           1.2799               1.0678
              need_help_belief service_awarenessY advocacy_interest    age genderFemale
Victim Only             5.9438             0.6022            0.9159 0.6100       2.1150
Bidirectional           1.1085             1.4618            0.8199 1.0681       1.3572
> 
> # Confidence intervals
> cat("\nConfidence Intervals:\n")

Confidence Intervals:
> print(round(exp(confint(model_multi4)), 4))
, , Victim Only

                      2.5 %      97.5 %
(Intercept)          0.0000 672533.0938
justify_women        0.7393      1.3290
justify_men          0.8037      1.5615
peer_dv_exposure     0.1946      1.9135
dv_prevalence_belief 0.9243      1.3992
need_help_belief     0.5437     64.9735
service_awarenessY   0.0228     15.8862
advocacy_interest    0.5646      1.4860
age                  0.3175      1.1719
genderFemale         0.1498     29.8609

, , Bidirectional

                      2.5 %       97.5 %
(Intercept)          0.0884 5588504.8375
justify_women        0.8371       1.1551
justify_men          0.8192       1.0839
peer_dv_exposure     0.8519       1.9229
dv_prevalence_belief 0.9632       1.1837
need_help_belief     0.5129       2.3958
service_awarenessY   0.2707       7.8949
advocacy_interest    0.6350       1.0588
age                  0.8474       1.3461
genderFemale         0.3200       5.7561

> 
> # Model fit
> library(pscl)
> pR2(model_multi4)
fitting null model for pseudo-r2
# weights:  6 (2 variable)
initial  value 82.395922 
final  value 51.966155 
converged
        llh     llhNull          G2    McFadden        r2ML        r2CU 
-37.5897195 -51.9661552  28.7528713   0.2766500   0.3184404   0.4246623 