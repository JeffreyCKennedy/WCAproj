---
title: "Careers Output Doc"
author: "Jeff Kennedy"
date: "23 January 2018"
output:
  html_document:
    keep_md: yes
  pdf_document: default
  word_document: default
---




### Descriptives for Career Facilitator Scales

#### Cronbach alpha and number of items for 7-point scales:
<table class="table table-striped table-hover" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> ScaleNames7 </th>
   <th style="text-align:right;"> alpha_7 </th>
   <th style="text-align:right;"> n_items_7 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> D3_CareerSE </td>
   <td style="text-align:right;"> 0.79 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F13_LifeSat </td>
   <td style="text-align:right;"> 0.89 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F14a_CarSucc </td>
   <td style="text-align:right;"> 0.84 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>
#### Cronbach alpha and number of items for 5-point scales:
<table class="table table-striped table-hover" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> ScaleNames5 </th>
   <th style="text-align:right;"> alpha_vals </th>
   <th style="text-align:right;"> N_items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> C2_WLB </td>
   <td style="text-align:right;"> 0.77 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> D1_PersCirc </td>
   <td style="text-align:right;"> 0.63 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> D2_Abilities </td>
   <td style="text-align:right;"> 0.87 </td>
   <td style="text-align:right;"> 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E1_CultFit </td>
   <td style="text-align:right;"> 0.87 </td>
   <td style="text-align:right;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E2_Network </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E3_Mentor </td>
   <td style="text-align:right;"> 0.87 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E4_CarMgt </td>
   <td style="text-align:right;"> 0.86 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E5_DevAsst </td>
   <td style="text-align:right;"> 0.92 </td>
   <td style="text-align:right;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E6_GeoMob </td>
   <td style="text-align:right;"> 0.80 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F2_MngCar </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F3_Relships </td>
   <td style="text-align:right;"> 0.82 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F4_Mentor </td>
   <td style="text-align:right;"> 0.94 </td>
   <td style="text-align:right;"> 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F5_DevAss </td>
   <td style="text-align:right;"> 0.89 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F6_ProcJust </td>
   <td style="text-align:right;"> 0.75 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F7_DistJust </td>
   <td style="text-align:right;"> 0.81 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F8_Empower </td>
   <td style="text-align:right;"> 0.81 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F9_DevAss </td>
   <td style="text-align:right;"> 0.87 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F10_Turnover </td>
   <td style="text-align:right;"> 0.94 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F11_JobSat </td>
   <td style="text-align:right;"> 0.87 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F12_CareerSat </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
</tbody>
</table>
#### Summary stats for demog vars

```r
skim(responses, Age, Seniority, Educ, TotSal, WkHours, TotDeps) %>% 
    kable()
```

Skim summary statistics  
 n obs: 1050    
 n variables: 247    

Variable type: integer

variable    missing   complete   n      mean   sd     p0   p25   median   p75   p100   hist                                                             
----------  --------  ---------  -----  -----  -----  ---  ----  -------  ----  -----  -----------------------------------------------------------------
Age         52        998        1050   3.05   1.08   1    2     3        4     6      <U+2581><U+2586><U+2581><U+2587><U+2585><U+2581><U+2582><U+2581> 
Educ        122       928        1050   3.49   1.41   1    2     4        4     7      <U+2582><U+2586><U+2586><U+2587><U+2581><U+2583><U+2582><U+2581> 
Seniority   122       928        1050   5.59   2.28   1    4     6        8     8      <U+2581><U+2581><U+2583><U+2583><U+2582><U+2582><U+2582><U+2587> 
TotDeps     34        1016       1050   0.87   1.24   0    0     0        2     20     <U+2587><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581> 
TotSal      123       927        1050   3.75   1.28   1    3     4        5     7      <U+2581><U+2583><U+2587><U+2585><U+2581><U+2587><U+2581><U+2581> 
WkHours     57        993        1050   3.63   1.02   1    3     4        4     6      <U+2581><U+2581><U+2581><U+2583><U+2587><U+2581><U+2582><U+2581> 



The following tables use pairs.panels (first fig) and corPlot from psych package.

![](CareersReport_files/figure-html/correlation_plots-1.png)<!-- -->![](CareersReport_files/figure-html/correlation_plots-2.png)<!-- -->

The package skimr provides tidy one-line summaries of response frequencies.


