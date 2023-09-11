---
title: 2023 NCCC170 Annual Meeting
summary: University of Wisconsin - Madison
authors: 
  - aaronrendahl
  - nicholaskeuler
  - "Philip Dixon"
  - "Samuel Fernandes"
  - jaradniemi
  - carlagoad
  - "John Stevens"
  - clarkkogan
  - "Steven Moen"
  - "Dan Runcie"
  - jpiaskowski
author_notes:
  - "Program Chair"
  - "Site Host"
date: "2023-06-15"
date_end: "2023-06-16"
all_day: true
location: University of Wisconsin - Madison
address:
  street: 133 Service Memorial Institute (SMI)
  city: Madison
  region: WI
  postcode: "53703"
share: false
profile: false
---

**Thursday, June 15, 2023**

{{< schedule >}}

{{< time "9:00a" >}}
Introduction and Welcome <br> 
**From Biometry to Statistics Collaboration at UW-Madison** <br>
*Brian Yandell, Director, Biometry Program, University of Wisconsin-Madison*
{{< /time >}}

{{< time "9:15a" >}}
{{< talk "Estimating Genetic Gain -- Why the Right Type of BLUP Matters"
"Philip Dixon, Iowa State University" >}}
Plant breeding is one of many reasons for the huge increase in corn yields from 1920 to now.  However, there are many confounding factors, including changes in weather, increased fertilization, better weed control, and growing corn at a higher density (# plants / acre).  Don Duvick, of Pioneer Hy-Bred / Corteva, popularized the eRa study design to estimate the contribution due to plant breeding.  Seeds from genotypes released in different years are planted in the same year and site, at the same density, and with the same amounts of fertilization and weed control.  Any observed differences among the genotypes can then be attributed to genetic gain.  An extension of this design is to plant genotypes at both the current density, e.g., 35,000 seeds per acre, and the density when released, e.g., 20,000 seeds per acre or 25,000 seeds per acre. 
Duvick used a two-stage analysis: estimate the mean yield (or other trait) for each genotype after accounting for the experimental design, then regress the mean yield on year of release.  The slope estimates the genetic gain per year.  Recent analyses (numerous published papers) have replaced the genotype means with the genotype BLUP.  Duvick modeled genotypes as a fixed effect; recent practice has been to model them as a random effect.
I show that this change, when used in a two-stage analysis, systematically underestimates genetic gain.  A one-stage analysis, including the year of release, a random effect for genotypes, and the experimental design, provides unbiased estimates of the genetic gain.  The various analyses are illustrated using simulated data and a study of root traits. 
{{< /talk >}}{{< /time >}}

{{< time "9:50a" >}}
{{< talk "Improving Genomic Prediction with Synthetic Traits"
"Samuel Fernandes, University of Arkansas" >}} 
Genomic prediction has been one of the essential tools for modern breeding programs, especially for traits that are expensive, labor-intensive, or low-throughput to phenotype. However, phenotypic information is still needed to train prediction models, and the quality of these predictions is bounded by the quality of the phenotypic data set (i.e., heritability). One option to improve prediction accuracy in low heritability traits is to incorporate traits with higher heritabilities into a multivariate prediction model. When the correlated trait is assessed with higher throughput than the trait of interest, using multi-trait models becomes very advantageous. Therefore, we hypothesized that incorporating high-heritable synthetic traits (ratios of leaf reflectance spectra) in multi-trait genomic prediction models could help predict traits of low-throughput phenotyping. We conducted an experiment where we phenotyped a biomass sorghum diversity panel of 836 lines in two locations in Illinois. We measured specific leaf area (SLA), leaf nitrogen content (N), and leaf-level reflectance (350-2500 nm). Additionally, we used previously developed partial least squares regression (PLSR) models on the reflectance data to create two new traits, predicted SLA (PLSR_SLA) and predicted N (PLSR_N). To create the synthetic traits, we obtained all possible pairwise ratio wavelengths and calculated their co-heritability with each of the four traits of interest (SLA, N, PLSR_SLA, and PLSR_N). We generated a heatmap in each case and highlighted the top 1% highest co-heritability. Different regions were highlighted in the heatmap, and we selected the wavelength ratio with the highest co-heritability from each area. To further reduce the number of synthetic traits, we used hierarchical clustering based on Euclidean distance, which allowed us to identify three subgroups for N and PLSR_N and 2 for SLA and PLSR_SLA. The wavelength ratio with the highest co-heritability was used for each subset as a synthetic trait. We evaluated three genomic prediction scenarios i) univariate biological traits (N and SLA), ii) univariate predicted traits (PLSR_N and PLSR_SLA), iii) Multi-trait GS of SLA, N, PLSR_SLA, or PLSR_N along with the synthetic traits. We utilized a five-fold cross-validation for single and multi-trait models. For the latter, we evaluated a CV1 scheme, where 80% of the target trait and 80% of the synthetic trait were used to train the prediction model, and a CV2, where 80% of the target trait and 100% of the synthetic trait were used to train the prediction model. To reduce bias, we used individuals from one location as the training set and the other location as validation. Prediction accuracies ranged from 0.41 for N to 0.66 in PLSR_N combined with synthetic traits. The combination of PLSR_N or PLSR_SLA predictions with synthetic traits resulted in higher prediction accuracy than the single model for either N or SLA. As hypothesized, the use of synthetic traits in multivariate models increased prediction accuracy and could be a good option for traits of low heritability.
{{< /talk >}}{{< /time >}}

{{< time "10:25a" >}} Break {{< /time >}}

{{< time "10:40a" >}}
{{< talk "Gaussian Processes with Functional Inputs with Applications to the Water Erosion Prediction Project Computer Model"
"{{% mention jaradniemi %}}, Iowa State University" >}}
The USDA's Water Erosion Prediction Project (WEPP) computer model utilizes weather, watershed topography, soil type, and land use to estimate water runoff, soil movement, and soil loss. We are constructing Gaussian Process (GP) emulators of this computer model to enable calibration, optimal design, and as a surrogate for WEPP itself. The inputs to this model include a variety of functionals: slope (or elevation) as a function of distance, soil characteristics as function of distance and depth, and precipitation as a function of time. Building a GP emulator requires distances for each of these different types of functions. We build a weighted L2-norm for slope and, incorporated into a GP, we refer to this approach as Automatic Dynamic Relevance Determination. We compare several forms of weight functions including asymmetric Gaussian and Laplace functions as well as B-splines. We observed similar out-of-sample predictive performance amongst all these methods and improvement over Automatic Relevance Determination. Utilizing Bayesian inference, we additionally obtain uncertainty over the weight functions that provide insight into the mechanistic process driving soil loss. 
{{< /talk >}}{{< /time >}}

{{< time "11:15a" >}}
{{< talk "Discussion: Online Teaching Panel"
"{{% mention carlagoad %}}, Oklahoma State University <br> {{% mention nicholaskeuler %}}, University of Wisconsin, Madison" >}}
We will lead a panel discussion on the challenges and advantages of teaching online. Topics may include course formats (fully or partially online, synchronous or asynchronous), pros and cons of the technologies available, effectively communicating with students, managing the course, adjusting assessments (e.g., exams, homework, quizzes, discussion posts, projects, etc.), and maintaining academic integrity.
{{< /talk >}}{{< /time >}}

{{< time "12:15a" >}} Lunch {{< /time >}}

{{< time "1:30p" >}}
{{< talk "Applied Statistics with ChatGPT: Boons and Banes"
"John Stevens, Utah State University" >}} 
When ChatGPT was first launched in November 2022, it opened an era of widely-accessible AI chatbots that have the potential to drastically change how interdisciplinary statisticians train students, collaborate with researchers in various fields, and approach their own statistical research questions. We outline some issues to consider when using ChatGPT in these capacities, and demonstrate the kinds of opportunities and pitfalls this technology presents. Depending on how we use (or ignore) them, these AI chatbots can either empower or frustrate our objectives in professional activities ranging from assigning homework to designing studies to writing research presentations. 
{{< /talk >}}{{< /time >}}

{{< time "2:05p" >}}
{{< talk "Bayesian Risk-based Surveillance Models for Pathogen Detection in Aquaculture"
"{{% mention clarkkogan %}}, Washington State University" >}}
In this discussion, we will focus on a Bayesian model for the assessment of pathogen risk in aquaculture. This model combines information about site-specific historical disease testing, test characteristic and information on biosecurity measures to estimate current probability of disease absence. The discussion will focus on a proposed model form as well as the utility of aggregating expert information on the impact of biosecurity practices in the absence of hard data. This discussion aims to stimulate discussion of practical and methodological considerations that will support a disease testing sample size dependent on biosecurity measures.
{{< /talk >}}{{< /time >}}

{{< time "2:40p" >}} Break {{< /time >}}

{{< time "2:55p" >}}
{{< talk "A Look Into Two Statistical Consulting Projects"
"Steven Moen, University of Wisconsin, Madison" >}}
In this talk, I'll discuss how I used statistics to assist two scientists studying Soil Science and Geography, respectively. For the client in Soil Science, I will explain how we selected a suitable class of models for studying drivers of soil thickness in the continental United States. For the client in Geography, I will explain how we are working to determine how water depth and permafrost depth have changed over time using repeated measurements of arctic pond sites.
{{< /talk >}}{{< /time >}}

{{< time "3:30p" >}}
{{< talk "Discussion: Why do we teach ANOVA for factorials?"
"Dan Runcie, University of California, Davis" >}}
In experimentation, the power of manipulating two (or more) factors simultaneously has been recognized for at least a century and the analysis of such experiments is considered among the most basic analyses in biostatistics. I’m sure this topic has been studied in every possible way in the literature and in practice. However, as I’ve refined how I teach this topic to graduate students at UC Davis and discuss such experiments with collaborators I’ve found the way most textbooks describe two-factor experiments to be non-intuitive and focused on mathematically precise answers to the wrong questions. What am I missing? Do you start by estimating main effects and interactions? In what context is a “main effect” actually interesting? Instead, I favor talking about two-factor experiments as estimating a collection of “simple effects” or “subgroup effects” and then comparing them to look for consistency or heterogeneity. This approach is no more difficult, rarely much less powerful, produces more descriptive results, and I think provides a more unified perspective through which to view both simple and complex experiments. I would like feedback on this “treatment effect variability”-first perspective, both in the context of factorials and blocked designs.
{{< /talk >}}{{< /time >}}

{{< time "4:30p" >}} Conclusion {{< /time >}}

{{< /schedule >}}

**Friday, June 16, 2023**

{{< schedule >}}

{{< time "8:45a" >}}
{{< talk "Discussion: Reproducibility in the Agricultural Sciences"
"Julia Piaskowski, University of Idaho" >}}
An open discussion on research reproducibility. The National Academy of Sciences defines research reproducibility as “obtaining consistent results using the same data and code as the original study.” The American Society for Cell Biology defines this further: ‘analytical replication’ is obtaining the same results of the original data through reanalysis; ‘direct replication’ is reproducing results by using same experimental design and conditions; and ‘systemic replication’ is reproducing findings using different experimental conditions (e.g. a different organism). Are these definitions sufficient? How do you see these things manifested in your work or that of others? And what can or should we do about failings in research reproducibility?
{{< /talk >}}{{< /time >}}

{{< time "9:35a" >}} Break {{< /time >}}

{{< time "9:45a" >}}
{{< talk "Business Meeting" >}} 

*Announcements:*

1. Welcome and introduction of Chris Hamilton, NCRA Assistant Director & NIMSS System Admin
2. Preparation of 2022-2023 annual report:
    * Review recent changes in report format
    * Request information on papers, presentations, awards, etc.
    * Present Google docs file to expedite reporting
    * Reminder of deadlines

*Old Business:*

3. Refresher/review of objectives for the current 2021-2026 project as per NIMSS. See https://www.nimss.org/projects/18798.
4. Update on the upcoming new NCCC170 website, with demonstration and feedback. Group discussion led by Jarad Niemi, Iowa State University.
5.  Update from Walt Stroup regarding progress on on-going efforts towards publishing the second edition of his CRC textbook on Generalized Linear Mixed Models, with emphasis on updated materials and applications. Request for people interested in reviewing working drafts of the updated textbook.

*New Business:*

6. Planning for future NCCC170 annual meetings: Location, dates.
    * 2024: 	Potential venue: Puerto Rico (local host Raul Macchiavelli, UPR)
    Dates TBD. Program chair TBD.
    * 2025: 	???
7. Group picture

{{< /talk >}}{{< /time >}}

{{< time "11:00a" >}} Break / Walk to Greenhouse (0.4 mi)  {{< /time >}}

{{< time "11:15a" >}} **Tour of the D.C. Smith Greenhouse** {{< /time >}}

{{< time "12:15p" >}} Lunch {{< /time >}}

{{< /schedule >}}
