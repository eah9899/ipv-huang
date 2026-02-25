
R version 4.5.2 (2025-10-31) -- "[Not] Part in a Rumble"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> load("R_environment.RData")
> load("~/IPV Huang/R_environment.RData")
> ls()
[1] "anova_age"          "anova_k10"          "anova_k10_summary"  "anova_ptsd"        
[5] "anova_ptsd_summary" "chi"                "chi_value"          "data"              
[9] "eta2_k10"           "eta2_ptsd"          "k"                  "model_k10_adj"     
[13] "model_ptsd_adj"     "N"                  "SS_between"         "SS_residual"       
[17] "subset_data1"       "subset_data2"       "subset_data3"       "table_gender"      
[21] "table_involvement"  "table_level"        "table_relate"       "table_so"          
[25] "V"                 
> anova_conflict <- aov(personal_conflict ~ ipv_group3, data = data)
> summary(anova_conflict)
Df Sum Sq Mean Sq F value  Pr(>F)   
ipv_group3    2    372  185.77   5.893 0.00363 **
  Residuals   119   3751   31.52                   
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
84 observations deleted due to missingness
> TukeyHSD(anova_conflict)
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = personal_conflict ~ ipv_group3, data = data)

$ipv_group3
diff         lwr       upr     p adj
Victim Only-No IPV        -6.886640 -11.6830661 -2.090213 0.0025587
Bidirectional-No IPV      -2.316039  -5.6804299  1.048352 0.2354954
Bidirectional-Victim Only  4.570601   0.6167803  8.524421 0.0190905

> anova_conflict_summary <- summary(anova_conflict)
> SS_between <- anova_conflict_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_conflict_summary[[1]]["Residuals", "Sum Sq"]
> eta2_conflict <- SS_between / (SS_between + SS_residual)
> eta2_conflict
[1] 0.09011728
> cohens_d(personal_conflict ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Error in cohens_d(personal_conflict ~ ipv_group3, data = subset_data1,  : 
                    could not find function "cohens_d"
                  
                  > library(effectsize)
                  Error in library(effectsize) : there is no package called ‘effectsize’
                  
                  > install.packages("effectsize")
                  also installing the dependencies ‘bayestestR’, ‘insight’, ‘parameters’, ‘performance’, ‘datawizard’
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/bayestestR_0.17.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/insight_1.4.6.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/parameters_0.28.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/performance_0.16.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/datawizard_1.3.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/effectsize_1.0.1.tgz'
                  
                  The downloaded binary packages are in
                  /var/folders/3q/n4rfxbm13n19cd8l884z8n2r0000gn/T//RtmpVimAAV/downloaded_packages
                  > library(effectsize)
                  > cohens_d(personal_conflict ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
                  Cohen's d |       95% CI
------------------------
1.36      | [0.56, 2.13]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(personal_conflict ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.43      | [-0.07, 0.92]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(personal_conflict ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
                  Cohen's d |         95% CI
--------------------------
-0.77     | [-1.36, -0.18]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 

> model_conflict_adj <- lm(personal_conflict ~ ipv_group3 + age + gender, data = data)
> summary(model_conflict_adj)

Call:
lm(formula = personal_conflict ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-14.8090  -3.4433   0.6495   3.6219  12.0259 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)              20.8544     3.0248   6.894 3.09e-10 ***
ipv_group3Victim Only    -6.4812     1.9006  -3.410 0.000897 ***
ipv_group3Bidirectional  -2.2640     1.3391  -1.691 0.093595 .  
age                       0.4932     0.1357   3.633 0.000420 ***
genderFemale             -1.1787     0.9771  -1.206 0.230155    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.262 on 115 degrees of freedom
  (86 observations deleted due to missingness)
Multiple R-squared:  0.1937,	Adjusted R-squared:  0.1657 
F-statistic: 6.907 on 4 and 115 DF,  p-value: 5.098e-05

> library(lm.beta)
Error in library(lm.beta) : there is no package called ‘lm.beta’

> install.packages("lm.beta")
also installing the dependency ‘xtable’
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/xtable_1.8-8.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/lm.beta_1.7-3.tgz'

The downloaded binary packages are in
	/var/folders/3q/n4rfxbm13n19cd8l884z8n2r0000gn/T//RtmpVimAAV/downloaded_packages
> library(lm.beta)
> lm.beta(model_conflict_adj)

Call:
lm(formula = personal_conflict ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA              -0.3511676              -0.1745379               0.3063120 
           genderFemale 
             -0.1018259 

> data %>% group_by(ipv_group3) %>% summarise(mean_conflict = mean(personal_conflict, na.rm = TRUE), sd_conflict = sd(personal_conflict, na.rm = TRUE), n = n())
Error in data %>% group_by(ipv_group3) %>% summarise(mean_conflict = mean(personal_conflict,  : 
  could not find function "%>%"

> library(dplyr)
Error in library(dplyr) : there is no package called ‘dplyr’

> install.packages("dplyr")
also installing the dependencies ‘utf8’, ‘pkgconfig’, ‘withr’, ‘cli’, ‘generics’, ‘glue’, ‘lifecycle’, ‘magrittr’, ‘pillar’, ‘R6’, ‘rlang’, ‘tibble’, ‘tidyselect’, ‘vctrs’
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/utf8_1.2.6.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/pkgconfig_2.0.3.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/withr_3.0.2.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/cli_3.6.5.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/generics_0.1.4.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/glue_1.8.0.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/lifecycle_1.0.5.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/magrittr_2.0.4.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/pillar_1.11.1.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/R6_2.6.1.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/rlang_1.1.7.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/tibble_3.3.1.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/tidyselect_1.2.1.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/vctrs_0.7.1.tgz'
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/dplyr_1.2.0.tgz'

The downloaded binary packages are in
	/var/folders/3q/n4rfxbm13n19cd8l884z8n2r0000gn/T//RtmpVimAAV/downloaded_packages
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union
> data %>% group_by(ipv_group3) %>% summarise(mean_conflict = mean(personal_conflict, na.rm = TRUE), sd_conflict = sd(personal_conflict, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_conflict sd_conflict     n
  <fct>                 <dbl>       <dbl> <int>
1 No IPV                 30.6        3.22    24
2 Victim Only            23.7        6.98    16
3 Bidirectional          28.3        5.79   100
4 NA                     22.5       14.8     66
> names(data)
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
> anova_partner <- aov(partner_conflict ~ ipv_group3, data = data)
> summary(anova_partner)
             Df Sum Sq Mean Sq F value Pr(>F)  
ipv_group3    2    404  201.75   4.674 0.0112 *
Residuals   111   4791   43.16                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
92 observations deleted due to missingness
> TukeyHSD(anova_partner)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = partner_conflict ~ ipv_group3, data = data)

$ipv_group3
                                diff        lwr        upr     p adj
Victim Only-No IPV        -4.9638009 -10.714006  0.7864046 0.1050767
Bidirectional-No IPV      -5.3200280  -9.470672 -1.1693843 0.0081186
Bidirectional-Victim Only -0.3562271  -5.007731  4.2952772 0.9819219

> anova_partner_summary <- summary(anova_partner)
> SS_between <- anova_partner_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_partner_summary[[1]]["Residuals", "Sum Sq"]
> eta2_partner <- SS_between / (SS_between + SS_residual)
> eta2_partner
[1] 0.0776798
> cohens_d(partner_conflict ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |       95% CI
                  ------------------------
                    0.90      | [0.13, 1.65]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(partner_conflict ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
                  Cohen's d |       95% CI
------------------------
0.81      | [0.28, 1.35]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(partner_conflict ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.05      | [-0.53, 0.64]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  
                  > model_partner_adj <- lm(partner_conflict ~ ipv_group3 + age + gender, data = data)
                  > summary(model_partner_adj)
                  
                  Call:
                    lm(formula = partner_conflict ~ ipv_group3 + age + gender, data = data)
                  
                  Residuals:
                    Min      1Q  Median      3Q     Max 
                  -17.526  -3.561   1.429   4.382  11.745 
                  
                  Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
                  (Intercept)              25.9005     4.3596   5.941 3.44e-08 ***
                    ipv_group3Victim Only    -4.6536     2.4203  -1.923  0.05713 .  
                  ipv_group3Bidirectional  -5.4564     1.7462  -3.125  0.00228 ** 
                    age                       0.3176     0.1990   1.596  0.11337    
                  genderFemale             -0.8584     1.2553  -0.684  0.49552    
                  ---
                    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                  
                  Residual standard error: 6.546 on 109 degrees of freedom
                  (92 observations deleted due to missingness)
                  Multiple R-squared:  0.1008,	Adjusted R-squared:  0.06785 
                  F-statistic: 3.056 on 4 and 109 DF,  p-value: 0.0198
                  
                  > lm.beta(model_partner_adj)
                  
                  Call:
                    lm(formula = partner_conflict ~ ipv_group3 + age + gender, data = data)
                  
                  Standardized Coefficients::
                    (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                  NA             -0.21912604             -0.35594179              0.14725865 
                  genderFemale 
                  -0.06259733 
                  
                  > data %>% group_by(ipv_group3) %>% summarise(mean_partner = mean(partner_conflict, na.rm = TRUE), sd_partner = sd(partner_conflict, na.rm = TRUE), n = n())
                  # A tibble: 4 × 4
                  ipv_group3    mean_partner sd_partner     n
                  <fct>                <dbl>      <dbl> <int>
                    1 No IPV                32.1       4.24    24
                  2 Victim Only           27.2       6.90    16
                  3 Bidirectional         26.8       6.88   100
                  4 NA                    35        NA       66
                  > names(data)
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
                  > str(data)
                  'data.frame':	206 obs. of  51 variables:
                    $ id                    : int  135 185 187 133 134 137 203 203 203 123 ...
                  $ gender                : Factor w/ 2 levels "Male","Female": NA NA NA 1 1 1 1 1 1 1 ...
                  $ sexual_orientation    : Factor w/ 3 levels "Heterosexual",..: NA NA NA 1 1 1 1 1 1 1 ...
                  $ age                   : num  NA NA NA 13 13 13 14 14 14 14 ...
                  $ involvement_level     : Factor w/ 3 levels "More","Less",..: NA NA NA 2 2 2 2 2 2 2 ...
                  $ k10                   : int  NA NA NA 30 10 30 NA NA NA 10 ...
                  $ ptsd                  : int  NA NA NA 4 0 0 NA NA NA 0 ...
                  $ relationship_status   : Factor w/ 6 levels "Never","Dating",..: NA NA NA 1 1 1 1 1 1 1 ...
                  $ in_school             : Factor w/ 2 levels "N","Y": NA NA NA 2 2 2 2 2 2 2 ...
                  $ school_level          : Factor w/ 5 levels "Primary","Some High School",..: NA NA NA 1 1 1 2 2 2 2 ...
                  $ personal_conflict     : num  NA NA NA NA NA NA NA NA NA NA ...
                  $ partner_conflict      : int  NA NA NA NA NA NA NA NA NA NA ...
                  $ positive_support      : int  NA NA NA 18 16 17 NA NA NA 16 ...
                  $ negative_family_comm  : int  NA NA NA 28 30 31 NA NA NA NA ...
                  $ coping                : int  NA NA NA 59 68 65 NA NA NA 57 ...
                  $ interpersonal         : int  NA NA NA 27 31 34 NA NA NA 37 ...
                  $ caregiver_relationship: int  NA NA NA 15 20 23 NA NA NA 20 ...
                  $ relationship_tension  : int  NA NA NA NA NA NA NA NA NA NA ...
                  $ inadequacy            : int  NA NA NA 22 19 27 NA NA NA 14 ...
                  $ self_esteem           : int  NA NA NA 13 16 15 NA NA NA 16 ...
                  $ locus_control         : int  NA NA NA 25 17 27 NA NA NA 19 ...
                  $ self_reliance         : int  NA NA NA 13 14 14 NA NA NA 17 ...
                  $ justify_women         : int  NA NA NA 23 55 23 NA NA NA 55 ...
                  $ justify_men           : int  NA NA NA 22 NA 23 NA NA NA 55 ...
                  $ dv_prevalence_belief  : int  NA NA NA 24 0 12 NA NA NA 0 ...
                  $ need_help_belief      : int  NA NA NA 8 2 8 NA NA NA 8 ...
                  $ service_awareness     : Factor w/ 2 levels "N","Y": NA NA NA NA 1 1 NA NA NA 1 ...
                  $ advocacy_interest     : int  NA NA NA 28 7 31 NA NA NA 23 ...
                  $ peer_dv_exposure      : int  NA NA NA 0 0 NA NA NA NA 0 ...
                  $ ace_score             : int  NA NA NA 3 0 5 NA NA NA 0 ...
                  $ unfair_treatment      : int  NA NA NA 13 13 13 NA NA NA 13 ...
                  $ social_stress         : int  NA NA NA 26 17 26 NA NA NA 14 ...
                  $ alcohol_use           : int  NA NA NA 1 NA 1 NA NA NA NA ...
                  $ tobacco               : Factor w/ 2 levels "N","Y": NA NA NA 1 2 1 NA NA NA 1 ...
                  $ cannabis              : Factor w/ 2 levels "N","Y": NA NA NA 1 1 1 NA NA NA 1 ...
                  $ cocaine               : Factor w/ 2 levels "N","Y": NA NA NA 1 1 1 NA NA NA 1 ...
                  $ amphetamines          : Factor w/ 2 levels "N","Y": NA NA NA 1 1 1 NA NA NA 1 ...
                  $ inhalants             : Factor w/ 2 levels "N","Y": NA NA NA 1 1 1 NA NA NA 1 ...
                  $ sedatives             : Factor w/ 2 levels "N","Y": NA NA NA 1 1 1 NA NA NA 1 ...
                  $ hallucinogens         : Factor w/ 2 levels "N","Y": NA NA NA 1 1 1 NA NA NA 1 ...
                  $ opioids               : Factor w/ 2 levels "N","Y": NA NA NA 1 NA 1 NA NA NA 1 ...
                  $ other_drug            : Factor w/ 2 levels "N","Y": NA NA NA 1 NA 1 NA NA NA 1 ...
                  $ hits                  : num  NA NA NA NA NA NA NA NA NA NA ...
                  $ victim_pvs            : int  NA NA NA NA NA NA NA NA NA NA ...
                  $ victim_dcrs           : num  NA NA NA NA NA NA NA NA NA NA ...
                  $ victim_binary         : Factor w/ 2 levels "N","Y": NA NA NA NA NA NA NA NA NA NA ...
                  $ perpetrator_pvs       : int  NA NA NA NA NA NA NA NA NA NA ...
                  $ perpetrator_dcrs      : num  NA NA NA NA NA NA NA NA NA NA ...
                  $ perpetrator_binary    : Factor w/ 2 levels "N","Y": NA NA NA NA NA NA NA NA NA NA ...
                  $ ipv_group             : Factor w/ 4 levels "No IPV","Victim Only",..: NA NA NA NA NA NA NA NA NA NA ...
                  $ ipv_group3            : Factor w/ 3 levels "No IPV","Victim Only",..: NA NA NA NA NA NA NA NA NA NA ...
                  > View(data)
                  > anova_support <- aov(positive_support ~ ipv_group3, data = data)
                  > summary(anova_support)
                  Df Sum Sq Mean Sq F value Pr(>F)
                  ipv_group3    2   21.8   10.90   0.827   0.44
                  Residuals   118 1554.1   13.17               
                  85 observations deleted due to missingness
                  > TukeyHSD(anova_support)
                  Tukey multiple comparisons of means
                  95% family-wise confidence level
                  
                  Fit: aov(formula = positive_support ~ ipv_group3, data = data)
                  
                  $ipv_group3
                  diff       lwr       upr     p adj
                  Victim Only-No IPV        -0.9969697 -3.881373 1.8874333 0.6911368
                  Bidirectional-No IPV      -1.1136364 -3.176706 0.9494338 0.4085219
                  Bidirectional-Victim Only -0.1166667 -2.531262 2.2979287 0.9927750
                  
                  > 
                    > anova_support_summary <- summary(anova_support)
                  > SS_between <- anova_support_summary[[1]]["ipv_group3", "Sum Sq"]
                  > SS_residual <- anova_support_summary[[1]]["Residuals", "Sum Sq"]
                  > eta2_support <- SS_between / (SS_between + SS_residual)
                  > eta2_support
                  [1] 0.01382954
                  > 
                    > cohens_d(positive_support ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
0.31      | [-0.35, 0.97]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(positive_support ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.30      | [-0.17, 0.78]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(positive_support ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
0.03      | [-0.52, 0.58]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> model_support_adj <- lm(positive_support ~ ipv_group3 + age + gender, data = data)
> summary(model_support_adj)

Call:
lm(formula = positive_support ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-12.3445  -1.2186   0.7294   2.0977   5.2096 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)             18.76155    2.34892   7.987 1.17e-12 ***
ipv_group3Victim Only   -0.87948    1.21904  -0.721   0.4721    
ipv_group3Bidirectional -0.93974    0.87277  -1.077   0.2838    
age                     -0.07387    0.10785  -0.685   0.4948    
genderFemale            -1.18473    0.67427  -1.757   0.0816 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.618 on 115 degrees of freedom
  (86 observations deleted due to missingness)
Multiple R-squared:  0.04468,	Adjusted R-squared:  0.01145 
F-statistic: 1.345 on 4 and 115 DF,  p-value: 0.2577

> lm.beta(model_support_adj)

Call:
lm(formula = positive_support ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.08026278             -0.11975631             -0.06320617 
           genderFemale 
            -0.16117653 

> 
> data %>% group_by(ipv_group3) %>% summarise(mean_support = mean(positive_support, na.rm = TRUE), sd_support = sd(positive_support, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_support sd_support     n
  <fct>                <dbl>      <dbl> <int>
1 No IPV                16.9       3.06    24
2 Victim Only           15.9       3.42    16
3 Bidirectional         15.8       3.79   100
4 NA                    15.8       3.39    66
> anova_negfam <- aov(negative_family_comm ~ ipv_group3, data = data)
> summary(anova_negfam)
             Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3    2   45.1   22.55   1.385  0.255
Residuals   111 1807.4   16.28               
92 observations deleted due to missingness
> TukeyHSD(anova_negfam)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = negative_family_comm ~ ipv_group3, data = data)

$ipv_group3
                               diff        lwr      upr     p adj
Victim Only-No IPV        0.3454545 -2.8643199 3.555229 0.9646185
Bidirectional-No IPV      1.4675325 -0.8498169 3.784882 0.2927868
Bidirectional-Victim Only 1.1220779 -1.5833349 3.827491 0.5876868

> 
> anova_negfam_summary <- summary(anova_negfam)
> SS_between <- anova_negfam_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_negfam_summary[[1]]["Residuals", "Sum Sq"]
> eta2_negfam <- SS_between / (SS_between + SS_residual)
> eta2_negfam
[1] 0.02434787
> 
> cohens_d(negative_family_comm ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    -0.10     | [-0.75, 0.56]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(negative_family_comm ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
-0.37     | [-0.85, 0.10]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(negative_family_comm ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    -0.26     | [-0.82, 0.29]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > 
                    > model_negfam_adj <- lm(negative_family_comm ~ ipv_group3 + age + gender, data = data)
                  > summary(model_negfam_adj)
                  
                  Call:
                    lm(formula = negative_family_comm ~ ipv_group3 + age + gender, 
                       data = data)
                  
                  Residuals:
                    Min       1Q   Median       3Q      Max 
                  -12.3769  -2.2607  -0.4271   2.7106  11.2878 
                  
                  Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
                  (Intercept)             30.79406    2.67619  11.507   <2e-16 ***
                    ipv_group3Victim Only    0.54220    1.36008   0.399    0.691    
                  ipv_group3Bidirectional  1.51356    0.98742   1.533    0.128    
                  age                      0.05016    0.12522   0.401    0.690    
                  genderFemale            -1.13462    0.77989  -1.455    0.149    
                  ---
                    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                  
                  Residual standard error: 4.04 on 108 degrees of freedom
                  (93 observations deleted due to missingness)
                  Multiple R-squared:  0.04225,	Adjusted R-squared:  0.006776 
                  F-statistic: 1.191 on 4 and 108 DF,  p-value: 0.319
                  
                  > lm.beta(model_negfam_adj)
                  
                  Call:
                    lm(formula = negative_family_comm ~ ipv_group3 + age + gender, 
                       data = data)
                  
                  Standardized Coefficients::
                    (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                  NA              0.04558928              0.17601533              0.03858546 
                  genderFemale 
                  -0.13858395 
                  
                  > 
                    > data %>% group_by(ipv_group3) %>% summarise(mean_negfam = mean(negative_family_comm, na.rm = TRUE), sd_negfam = sd(negative_family_comm, na.rm = TRUE), n = n())
                  # A tibble: 4 × 4
                  ipv_group3    mean_negfam sd_negfam     n
                  <fct>               <dbl>     <dbl> <int>
                    1 No IPV               31.5      2.65    24
                  2 Victim Only          31.8      4.68    16
                  3 Bidirectional        32.9      4.22   100
                  4 NA                   31.8      4.50    66
                  > anova_coping <- aov(coping ~ ipv_group3, data = data)
                  > summary(anova_coping)
                  Df Sum Sq Mean Sq F value Pr(>F)  
                  ipv_group3    2    620   310.2   3.086 0.0497 *
                    Residuals   110  11058   100.5                 
                  ---
                    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                  93 observations deleted due to missingness
                  > TukeyHSD(anova_coping)
                  Tukey multiple comparisons of means
                  95% family-wise confidence level
                  
                  Fit: aov(formula = coping ~ ipv_group3, data = data)
                  
                  $ipv_group3
                  diff        lwr       upr     p adj
                  Victim Only-No IPV        -8.243590 -16.913857 0.4266775 0.0660365
                  Bidirectional-No IPV      -5.642276 -11.842629 0.5580762 0.0823934
                  Bidirectional-Victim Only  2.601313  -4.509885 9.7125113 0.6608625
                  
                  > 
                    > anova_coping_summary <- summary(anova_coping)
                  > SS_between <- anova_coping_summary[[1]]["ipv_group3", "Sum Sq"]
                  > SS_residual <- anova_coping_summary[[1]]["Residuals", "Sum Sq"]
                  > eta2_coping <- SS_between / (SS_between + SS_residual)
                  > eta2_coping
                  [1] 0.05312357
                  > 
                    > cohens_d(coping ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
                  Cohen's d |       95% CI
------------------------
0.78      | [0.03, 1.51]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(coping ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |       95% CI
                  ------------------------
                    0.57      | [0.05, 1.09]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(coping ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
-0.26     | [-0.85, 0.33]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> model_coping_adj <- lm(coping ~ ipv_group3 + age + gender, data = data)
> summary(model_coping_adj)

Call:
lm(formula = coping ~ ipv_group3 + age + gender, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-28.1784  -4.9915   0.4788   6.6052  19.7725 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)             69.52019    6.76472  10.277   <2e-16 ***
ipv_group3Victim Only   -7.91396    3.72923  -2.122   0.0361 *  
ipv_group3Bidirectional -5.35927    2.67020  -2.007   0.0473 *  
age                     -0.04913    0.30832  -0.159   0.8737    
genderFemale            -1.53441    1.99970  -0.767   0.4446    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 10.13 on 107 degrees of freedom
  (94 observations deleted due to missingness)
Multiple R-squared:  0.05902,	Adjusted R-squared:  0.02384 
F-statistic: 1.678 on 4 and 107 DF,  p-value: 0.1605

> lm.beta(model_coping_adj)

Call:
lm(formula = coping ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.24828525             -0.23485357             -0.01516674 
           genderFemale 
            -0.07309188 

> 
> data %>% group_by(ipv_group3) %>% summarise(mean_coping = mean(coping, na.rm = TRUE), sd_coping = sd(coping, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_coping sd_coping     n
  <fct>               <dbl>     <dbl> <int>
1 No IPV               68.2     10.2     24
2 Victim Only          59.9     11.2     16
3 Bidirectional        62.5      9.81   100
4 NA                   59.8     13.2     66
> anova_interp <- aov(interpersonal ~ ipv_group3, data = data)
> summary(anova_interp)
             Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3    2     91   45.32   0.966  0.384
Residuals   113   5303   46.93               
90 observations deleted due to missingness
> TukeyHSD(anova_interp)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = interpersonal ~ ipv_group3, data = data)

$ipv_group3
                                diff       lwr      upr     p adj
Victim Only-No IPV        -2.0798319 -7.951799 3.792135 0.6782615
Bidirectional-No IPV      -2.5294118 -6.852135 1.793311 0.3496880
Bidirectional-Victim Only -0.4495798 -5.142416 4.243256 0.9718720

> 
> anova_interp_summary <- summary(anova_interp)
> SS_between <- anova_interp_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_interp_summary[[1]]["Residuals", "Sum Sq"]
> eta2_interp <- SS_between / (SS_between + SS_residual)
> eta2_interp
[1] 0.01680568
> 
> cohens_d(interpersonal ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.30      | [-0.41, 1.01]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(interpersonal ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
0.36      | [-0.16, 0.89]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(interpersonal ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.07      | [-0.50, 0.63]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > 
                    > model_interp_adj <- lm(interpersonal ~ ipv_group3 + age + gender, data = data)
                  > summary(model_interp_adj)
                  
                  Call:
                    lm(formula = interpersonal ~ ipv_group3 + age + gender, data = data)
                  
                  Residuals:
                    Min       1Q   Median       3Q      Max 
                  -20.6779  -5.0392   0.0494   4.1872  23.4155 
                  
                  Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
                  (Intercept)              46.6231     4.6195  10.093   <2e-16 ***
                    ipv_group3Victim Only    -2.6065     2.5071  -1.040    0.301    
                  ipv_group3Bidirectional  -2.5859     1.8347  -1.409    0.162    
                  age                      -0.2726     0.2084  -1.308    0.194    
                  genderFemale              1.1840     1.3221   0.896    0.372    
                  ---
                    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                  
                  Residual standard error: 6.871 on 110 degrees of freedom
                  (91 observations deleted due to missingness)
                  Multiple R-squared:  0.03626,	Adjusted R-squared:  0.001214 
                  F-statistic: 1.035 on 4 and 110 DF,  p-value: 0.3927
                  
                  > lm.beta(model_interp_adj)
                  
                  Call:
                    lm(formula = interpersonal ~ ipv_group3 + age + gender, data = data)
                  
                  Standardized Coefficients::
                    (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                  NA             -0.12450462             -0.16762220             -0.12452800 
                  genderFemale 
                  0.08502387 
                  
                  > 
                    > data %>% group_by(ipv_group3) %>% summarise(mean_interp = mean(interpersonal, na.rm = TRUE), sd_interp = sd(interpersonal, na.rm = TRUE), n = n())
                  # A tibble: 4 × 4
                  ipv_group3    mean_interp sd_interp     n
                  <fct>               <dbl>     <dbl> <int>
                    1 No IPV               41.3      7.68    24
                  2 Victim Only          39.2      5.94    16
                  3 Bidirectional        38.8      6.81   100
                  4 NA                   38.7      8.23    66
                  > anova_caregiver <- aov(caregiver_relationship ~ ipv_group3, data = data)
                  > summary(anova_caregiver)
                  Df Sum Sq Mean Sq F value Pr(>F)
                  ipv_group3    2     49   24.64   0.808  0.448
                  Residuals   122   3722   30.51               
                  81 observations deleted due to missingness
                  > TukeyHSD(anova_caregiver)
                  Tukey multiple comparisons of means
                  95% family-wise confidence level
                  
                  Fit: aov(formula = caregiver_relationship ~ ipv_group3, data = data)
                  
                  $ipv_group3
                  diff       lwr      upr     p adj
                  Victim Only-No IPV        -2.3636364 -6.844237 2.116964 0.4253306
                  Bidirectional-No IPV      -0.6782431 -3.798680 2.442194 0.8638375
                  Bidirectional-Victim Only  1.6853933 -2.082685 5.453471 0.5399153
                  
                  > 
                    > anova_caregiver_summary <- summary(anova_caregiver)
                  > SS_between <- anova_caregiver_summary[[1]]["ipv_group3", "Sum Sq"]
                  > SS_residual <- anova_caregiver_summary[[1]]["Residuals", "Sum Sq"]
                  > eta2_caregiver <- SS_between / (SS_between + SS_residual)
                  > eta2_caregiver
                  [1] 0.0130678
                  > 
                    > cohens_d(caregiver_relationship ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
0.45      | [-0.24, 1.12]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(caregiver_relationship ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.12      | [-0.35, 0.59]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(caregiver_relationship ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
                  Cohen's d |        95% CI
-------------------------
-0.31     | [-0.87, 0.26]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> 
> model_caregiver_adj <- lm(caregiver_relationship ~ ipv_group3 + age + gender, data = data)
> summary(model_caregiver_adj)

Call:
lm(formula = caregiver_relationship ~ ipv_group3 + age + gender, 
    data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-12.6484  -3.8569  -0.0612   4.3600  10.1977 

Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
(Intercept)             25.59663    3.55051   7.209 5.62e-11 ***
ipv_group3Victim Only   -2.41803    1.91385  -1.263    0.209    
ipv_group3Bidirectional -0.63747    1.33978  -0.476    0.635    
age                     -0.06554    0.16523  -0.397    0.692    
genderFemale             0.31924    1.03495   0.308    0.758    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.585 on 119 degrees of freedom
  (82 observations deleted due to missingness)
Multiple R-squared:  0.01503,	Adjusted R-squared:  -0.01808 
F-statistic: 0.454 on 4 and 119 DF,  p-value: 0.7693

> lm.beta(model_caregiver_adj)

Call:
lm(formula = caregiver_relationship ~ ipv_group3 + age + gender, 
    data = data)

Standardized Coefficients::
            (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                     NA             -0.13880382             -0.05248468             -0.03662680 
           genderFemale 
             0.02830914 

> 
> data %>% group_by(ipv_group3) %>% summarise(mean_caregiver = mean(caregiver_relationship, na.rm = TRUE), sd_caregiver = sd(caregiver_relationship, na.rm = TRUE), n = n())
# A tibble: 4 × 4
  ipv_group3    mean_caregiver sd_caregiver     n
  <fct>                  <dbl>        <dbl> <int>
1 No IPV                  24.4         5.94    24
2 Victim Only             22           4.06    16
3 Bidirectional           23.7         5.61   100
4 NA                      23.4         5.61    66
> anova_tension <- aov(relationship_tension ~ ipv_group3, data = data)
> summary(anova_tension)
             Df Sum Sq Mean Sq F value Pr(>F)   
ipv_group3    2  12.55   6.275   5.899 0.0035 **
Residuals   135 143.60   1.064                  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
68 observations deleted due to missingness
> TukeyHSD(anova_tension)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = relationship_tension ~ ipv_group3, data = data)

$ipv_group3
                                 diff         lwr      upr     p adj
Victim Only-No IPV         0.83768116  0.02650146 1.648861 0.0412509
Bidirectional-No IPV       0.80434783  0.23912010 1.369576 0.0027800
Bidirectional-Victim Only -0.03333333 -0.71009868 0.643432 0.9925172

> 
> anova_tension_summary <- summary(anova_tension)
> SS_between <- anova_tension_summary[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- anova_tension_summary[[1]]["Residuals", "Sum Sq"]
> eta2_tension <- SS_between / (SS_between + SS_residual)
> eta2_tension
[1] 0.08036568
> 
> cohens_d(relationship_tension ~ ipv_group3, data = subset_data1, pooled_sd = TRUE)
Cohen's d |         95% CI
                  --------------------------
                    -0.97     | [-1.66, -0.28]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > cohens_d(relationship_tension ~ ipv_group3, data = subset_data2, pooled_sd = TRUE)
                  Cohen's d |         95% CI
--------------------------
-0.79     | [-1.25, -0.32]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cohens_d(relationship_tension ~ ipv_group3, data = subset_data3, pooled_sd = TRUE)
Cohen's d |        95% CI
                  -------------------------
                    0.03      | [-0.51, 0.57]
                  
                  - Estimated using pooled SD.
                  Warning message:
                    Missing values detected. NAs dropped. 
                  > 
                    > model_tension_adj <- lm(relationship_tension ~ ipv_group3 + age + gender, data = data)
                  > summary(model_tension_adj)
                  
                  Call:
                    lm(formula = relationship_tension ~ ipv_group3 + age + gender, 
                       data = data)
                  
                  Residuals:
                    Min      1Q  Median      3Q     Max 
                  -1.8318 -0.6227  0.1985  0.5135  2.5388 
                  
                  Coefficients:
                    Estimate Std. Error t value Pr(>|t|)   
                  (Intercept)             -0.55553    0.52918  -1.050  0.29575   
                  ipv_group3Victim Only    0.87862    0.33928   2.590  0.01069 * 
                    ipv_group3Bidirectional  0.78478    0.23657   3.317  0.00118 **
                    age                      0.06286    0.02360   2.663  0.00871 **
                    genderFemale            -0.08809    0.17654  -0.499  0.61864   
                  ---
                    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                  
                  Residual standard error: 1.017 on 131 degrees of freedom
                  (70 observations deleted due to missingness)
                  Multiple R-squared:  0.1291,	Adjusted R-squared:  0.1025 
                  F-statistic: 4.856 on 4 and 131 DF,  p-value: 0.001104
                  
                  > lm.beta(model_tension_adj)
                  
                  Call:
                    lm(formula = relationship_tension ~ ipv_group3 + age + gender, 
                       data = data)
                  
                  Standardized Coefficients::
                    (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
                  NA              0.25730029              0.32919415              0.21782975 
                  genderFemale 
                  -0.04088749 
                  
                  > 
                    > data %>% group_by(ipv_group3) %>% summarise(mean_tension = mean(relationship_tension, na.rm = TRUE), sd_tension = sd(relationship_tension, na.rm = TRUE), n = n())
                  # A tibble: 4 × 4
                  ipv_group3    mean_tension sd_tension     n
                  <fct>                <dbl>      <dbl> <int>
                    1 No IPV               0.696      0.635    24
                  2 Victim Only          1.53       1.13     16
                  3 Bidirectional        1.5        1.09    100
                  4 NA                   1.75       1.71     66
                  > install.packages("nnet")
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/nnet_7.3-20.tgz'
                  Content type 'application/x-gzip' length 126267 bytes (123 KB)
                  ==================================================
                    downloaded 123 KB
                  
                  
                  The downloaded binary packages are in
                  /var/folders/3q/n4rfxbm13n19cd8l884z8n2r0000gn/T//RtmpVimAAV/downloaded_packages
                  > library(nnet)
                  > 
                    > model_aim2 <- multinom(ipv_group3 ~ personal_conflict + partner_conflict + positive_support + negative_family_comm + coping + interpersonal + caregiver_relationship + relationship_tension + age + gender, data = data)
                  # weights:  36 (22 variable)
                  initial  value 81.297309 
                  iter  10 value 47.516158
                  iter  20 value 35.543741
                  iter  30 value 33.725444
                  iter  40 value 33.049370
                  final  value 33.019869 
                  converged
                  > summary(model_aim2)
                  Call:
                    multinom(formula = ipv_group3 ~ personal_conflict + partner_conflict + 
                               positive_support + negative_family_comm + coping + interpersonal + 
                               caregiver_relationship + relationship_tension + age + gender, 
                             data = data)
                  
                  Coefficients:
                    (Intercept) personal_conflict partner_conflict positive_support negative_family_comm
                  Victim Only      14.79841       -0.18121766       -0.1007469       0.24371223          -0.03813435
                  Bidirectional    14.84596        0.05249675       -0.2577039       0.01485673           0.07342264
                  coping interpersonal caregiver_relationship relationship_tension        age
                  Victim Only   -0.08933266   0.090460891            -0.06799907             1.556722 -0.3736381
                  Bidirectional -0.13921378  -0.004909584             0.11652853             1.235961 -0.1706396
                  genderFemale
                  Victim Only      0.5574464
                  Bidirectional   -0.3051716
                  
                  Std. Errors:
                    (Intercept) personal_conflict partner_conflict positive_support negative_family_comm
                  Victim Only     10.646819         0.1554220        0.1869370        0.2941978            0.1772229
                  Bidirectional    7.687426         0.1301388        0.1523802        0.1844403            0.1441038
                  coping interpersonal caregiver_relationship relationship_tension       age
                  Victim Only   0.08543756    0.10920426              0.1719604            0.7600225 0.2583542
                  Bidirectional 0.07115330    0.08041397              0.1256803            0.6448840 0.1838873
                  genderFemale
                  Victim Only       1.426856
                  Bidirectional     1.098162
                  
                  Residual Deviance: 66.03974 
                  AIC: 110.0397 
                  > z <- summary(model_aim2)$coefficients / summary(model_aim2)$standard.errors
                  > p <- (1 - pnorm(abs(z), 0, 1)) * 2
                  > p
                  (Intercept) personal_conflict partner_conflict positive_support negative_family_comm
                  Victim Only    0.16454782         0.2436259        0.5899316        0.4074464            0.8296291
                  Bidirectional  0.05345825         0.6866609        0.0908005        0.9357996            0.6103932
                  coping interpersonal caregiver_relationship relationship_tension       age
                  Victim Only   0.29575036     0.4074643              0.6925223           0.04053480 0.1481144
                  Bidirectional 0.05040241     0.9513163              0.3538319           0.05529343 0.3534295
                  genderFemale
                  Victim Only      0.6960326
                  Bidirectional    0.7810945
                  > exp(coef(model_aim2))
                  (Intercept) personal_conflict partner_conflict positive_support negative_family_comm
                  Victim Only       2672204         0.8342538        0.9041618         1.275977            0.9625836
                  Bidirectional     2802328         1.0538991        0.7728241         1.014968            1.0761853
                  coping interpersonal caregiver_relationship relationship_tension       age
                  Victim Only   0.9145413     1.0946787              0.9342613             4.743246 0.6882260
                  Bidirectional 0.8700420     0.9951024              1.1235896             3.441684 0.8431254
                  genderFemale
                  Victim Only      1.7462078
                  Bidirectional    0.7369969
                  > exp(confint(model_aim2))
                  , , Victim Only
                  
                  2.5 %       97.5 %
                    (Intercept)            0.002313561 3.086442e+15
                  personal_conflict      0.615180705 1.131341e+00
                  partner_conflict       0.626794358 1.304269e+00
                  positive_support       0.716838401 2.271248e+00
                  negative_family_comm   0.680120738 1.362357e+00
                  coping                 0.773532804 1.081254e+00
                  interpersonal          0.883754885 1.355943e+00
                  caregiver_relationship 0.666953282 1.308704e+00
                  relationship_tension   1.069407643 2.103817e+01
                  age                    0.414781647 1.141938e+00
                  genderFemale           0.106550079 2.861792e+01
                  
                  , , Bidirectional
                  
                  2.5 %       97.5 %
                    (Intercept)            0.80162359 9.796424e+12
                  personal_conflict      0.81662887 1.360108e+00
                  partner_conflict       0.57329003 1.041806e+00
                  positive_support       0.70706013 1.456961e+00
                  negative_family_comm   0.81138259 1.427409e+00
                  coping                 0.75678833 1.000244e+00
                  interpersonal          0.85000073 1.164974e+00
                  caregiver_relationship 0.87827079 1.437431e+00
                  relationship_tension   0.97239965 1.218140e+01
                  age                    0.58798609 1.208975e+00
                  genderFemale           0.08564621 6.341955e+00
                  
                  > library(Hmisc)
                  Error in library(Hmisc) : there is no package called ‘Hmisc’
                  
                  > install.packages("Hmisc")
                  also installing the dependencies ‘fs’, ‘rappdirs’, ‘cpp11’, ‘farver’, ‘labeling’, ‘RColorBrewer’, ‘stringi’, ‘backports’, ‘cachem’, ‘memoise’, ‘mime’, ‘sass’, ‘isoband’, ‘S7’, ‘scales’, ‘stringr’, ‘checkmate’, ‘htmlwidgets’, ‘rstudioapi’, ‘digest’, ‘fastmap’, ‘bslib’, ‘evaluate’, ‘fontawesome’, ‘jquerylib’, ‘jsonlite’, ‘tinytex’, ‘xfun’, ‘yaml’, ‘highr’, ‘ggplot2’, ‘gtable’, ‘gridExtra’, ‘data.table’, ‘htmlTable’, ‘viridisLite’, ‘htmltools’, ‘base64enc’, ‘colorspace’, ‘rmarkdown’, ‘knitr’, ‘Formula’
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/fs_1.6.6.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/rappdirs_0.3.4.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/cpp11_0.5.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/farver_2.1.2.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/labeling_0.4.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/RColorBrewer_1.1-3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/stringi_1.8.7.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/backports_1.5.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/cachem_1.1.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/memoise_2.0.1.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/mime_0.13.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/sass_0.4.10.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/isoband_0.3.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/S7_0.2.1.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/scales_1.4.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/stringr_1.6.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/checkmate_2.3.4.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/htmlwidgets_1.6.4.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/rstudioapi_0.18.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/digest_0.6.39.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/fastmap_1.2.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/bslib_0.10.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/evaluate_1.0.5.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/fontawesome_0.5.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/jquerylib_0.1.4.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/jsonlite_2.0.0.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/tinytex_0.58.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/xfun_0.56.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/yaml_2.3.12.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/highr_0.11.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/ggplot2_4.0.2.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/gtable_0.3.6.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/gridExtra_2.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/data.table_1.18.2.1.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/htmlTable_2.4.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/viridisLite_0.4.3.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/htmltools_0.5.9.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/base64enc_0.1-6.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/colorspace_2.1-2.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/rmarkdown_2.30.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/knitr_1.51.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/Formula_1.2-5.tgz'
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/Hmisc_5.2-5.tgz'
                  
                  The downloaded binary packages are in
                  /var/folders/3q/n4rfxbm13n19cd8l884z8n2r0000gn/T//RtmpVimAAV/downloaded_packages
                  > library(Hmisc)
                  
                  Attaching package: ‘Hmisc’
                  
                  The following objects are masked from ‘package:dplyr’:
                    
                    src, summarize
                  
                  The following objects are masked from ‘package:base’:
                    
                    format.pval, units
                  > library(Hmisc)
                  > 
                    > cor_vars <- data[, c("personal_conflict", "partner_conflict", "positive_support", "negative_family_comm", "coping", "interpersonal", "caregiver_relationship", "relationship_tension")]
                  > 
                    > cor_matrix <- rcorr(as.matrix(cor_vars), type = "pearson")
                  > cor_matrix$r
                  personal_conflict partner_conflict positive_support negative_family_comm
                  personal_conflict             1.00000000       0.57467978       0.07092246           0.03885990
                  partner_conflict              0.57467978       1.00000000       0.04828078           0.13354308
                  positive_support              0.07092246       0.04828078       1.00000000           0.25564287
                  negative_family_comm          0.03885990       0.13354308       0.25564287           1.00000000
                  coping                        0.34534500       0.36978451       0.37172701           0.13438625
                  interpersonal                 0.16051405       0.14206415       0.36542471           0.22289456
                  caregiver_relationship        0.12010186       0.10675991       0.41074779           0.07490544
                  relationship_tension         -0.06621360      -0.03827082      -0.12035238           0.16382820
                  coping interpersonal caregiver_relationship relationship_tension
                  personal_conflict       0.3453450    0.16051405             0.12010186          -0.06621360
                  partner_conflict        0.3697845    0.14206415             0.10675991          -0.03827082
                  positive_support        0.3717270    0.36542471             0.41074779          -0.12035238
                  negative_family_comm    0.1343862    0.22289456             0.07490544           0.16382820
                  coping                  1.0000000    0.15632373             0.27351516          -0.10872081
                  interpersonal           0.1563237    1.00000000             0.45815130           0.01601145
                  caregiver_relationship  0.2735152    0.45815130             1.00000000          -0.18753070
                  relationship_tension   -0.1087208    0.01601145            -0.18753070           1.00000000
                  > cor_matrix$P
                  personal_conflict partner_conflict positive_support negative_family_comm
                  personal_conflict                     NA     1.180953e-10     4.636565e-01          0.698182283
                  partner_conflict            1.180953e-10               NA     6.264692e-01          0.189882354
                  positive_support            4.636565e-01     6.264692e-01               NA          0.001277471
                  negative_family_comm        6.981823e-01     1.898824e-01     1.277471e-03                   NA
                  coping                      3.781915e-04     1.527914e-04     3.844350e-06          0.112114802
                  interpersonal               1.002434e-01     1.585566e-01     2.933790e-06          0.007043851
                  caregiver_relationship      2.010688e-01     2.737386e-01     6.233675e-08          0.355863111
                  relationship_tension        4.668306e-01     6.846881e-01     1.866829e-01          0.081557913
                  coping interpersonal caregiver_relationship relationship_tension
                  personal_conflict      3.781915e-04  1.002434e-01           2.010688e-01           0.46683063
                  partner_conflict       1.527914e-04  1.585566e-01           2.737386e-01           0.68468809
                  positive_support       3.844350e-06  2.933790e-06           6.233675e-08           0.18668288
                  negative_family_comm   1.121148e-01  7.043851e-03           3.558631e-01           0.08155791
                  coping                           NA  6.415297e-02           8.021858e-04           0.25168365
                  interpersonal          6.415297e-02            NA           9.897683e-10           0.86395497
                  caregiver_relationship 8.021858e-04  9.897683e-10                     NA           0.03548845
                  relationship_tension   2.516836e-01  8.639550e-01           3.548845e-02                   NA
                  > install.packages("pscl")
                  trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.5/pscl_1.5.9.tgz'
                  Content type 'application/x-gzip' length 3431686 bytes (3.3 MB)
                  ==================================================
                    downloaded 3.3 MB
                  
                  
                  The downloaded binary packages are in
                  /var/folders/3q/n4rfxbm13n19cd8l884z8n2r0000gn/T//RtmpVimAAV/downloaded_packages
                  > library(pscl)
                  Classes and Methods for R originally developed in the
                  Political Science Computational Laboratory
                  Department of Political Science
                  Stanford University (2002-2015),
                  by and under the direction of Simon Jackman.
                  hurdle and zeroinfl functions by Achim Zeileis.
                  > library(pscl)
                  > pR2(model_aim2)
                  fitting null model for pseudo-r2
                  # weights:  6 (2 variable)
                  initial  value 81.297309 
                  final  value 51.636341 
                  converged
                  llh     llhNull          G2    McFadden        r2ML        r2CU 
                  -33.0198687 -51.6363412  37.2329449   0.3605304   0.3953756   0.5255489 
                  > 
                    > 