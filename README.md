# NYC-Traffic-Accidents-Analysis

## Project Overview
This project involves a comprehensive analysis of traffic accidents in New York City (NYC). The dataset contains motor vehicle collisions reported by the NYPD from January 2021 to April 2023. The main objective is to uncover insights and trends from the accident data, using SQL for data cleaning and analysis, and Excel for data visualization. The final output includes a detailed dashboard showcasing key metrics and findings. 

### Dashboard Link : [NYC Traffic Accidents Analysis Excel Dashboard](https://drive.google.com/drive/folders/1vsNtdN6lHWo5NR1Q-4vFH1t7uWye_Czr?usp=drive_link)

![Screenshot (2)](https://github.com/mridul-bhalla/NYC-Traffic-Accidents-Analysis/assets/158173545/26618411-80a0-460f-8592-6e8b170e5272)


### Final Report : [NYC Traffic Accidents Analysis Report](https://github.com/mridul-bhalla/NYC-Traffic-Accidents-Analysis#:~:text=NYC%20Traffic%20Accidents%20Analysis.pdf)


## Table of Contents
- [Project Overview](#project-overview)
- [Data Source](#data-source)
- [Tools](#tools)
- [Project Approach and Methodology](#project-approach-and-methodology)
- [Data Cleaning in SQL](#data-cleaning-in-sql)
- [Data Analysis in SQL](#data-analysis-in-sql)
- [Data Visualisation in Excel](#data-visualisation-in-excel)
- [Key Findings](#key-findings)
- [Key Recommendations](#key-recommendations)
- [Conclusion](#conclusion)


## Data Source
The dataset used in this project is sourced from Maven Analytics Website. It includes details about each traffic accident, such as location, time, contributing factors, and the number of people injured or killed etc. The datafile is uploaded in the Files section of this repository.
Additionaly, the link for the dataset on Maven Analytics Website: 
[Maven Analytics - NYC Traffic Accidents Analysis](https://mavenanalytics.io/data-playground?order=date_added%2Cdesc&page=10&pageSize=5)



## Tools 
1. MySQL - For Data Cleaning & Analysis
2. MS Excel - For Data Visualisation




## Project Approach and Methodology

#### 1. Understanding the Problem Statement and the Dataset
- Defining the goals of the analysis.
- Getting familiar with the dataset structure and variables.


#### 2. Preparing the Dataset
- Cleaning the data using SQL.
- Adding new columns as needed for analysis.


#### 3. Data Analysis in SQL
- Performing detailed data analysis using SQL queries to answer specific questions.
- Identifying trends, patterns, and correlations.


#### 4. Data Visualization in Excel
- Creating a comprehensive dashboard using Excel.
- Using various charts and graphs to visualize the data.


#### 5. Gaining Insights
- Deriving key insights from the data analysis and visualizations.


#### 6. Providing Recommendations
- Suggesting actionable recommendations based on the insights.




## Data Cleaning in SQL

MySQL Workbench was used for this step in the project. When the data was imported in MySQL, 216097 records got loaded. A table duplicate was created to perform the further data cleaning. We checked for duplicates and missing values and treated them. The same can be understood with the "Data Loading" and "Data Cleaning" files attached in the Files section of this repository. We further created a few new columns to enhance the analysis and get more insights. Let's understand these new columns below:
#### 1. *"day of the week"* (categorical) column 
- We used the DAYNAME() function for the same
  
#### 2. *"month"* (categorical) column
- We used the MONTHNAME() function for the same
  
#### 3. *"time category"* (categorical) column
- We created 6 time categories: Early Morning (3:00AM - 5:59AM), Morning (6:00AM - 11:59AM), Afternoon (12:00PM - 5:59PM), Evening (6:00PM - 8:59PM), Night (9:00PM - 11:59PM), Late Night (12:00AM - 2:59AM)
<img width="640" alt="Screenshot 2024-06-20 at 7 48 54 PM" src="https://github.com/mridul-bhalla/NYC-Traffic-Accidents-Analysis/assets/158173545/d8cec620-2fc4-49cb-b411-9129b86357bc">

#### 4. *"Season"* Column
- We created 4 categories for season: Spring (Mar, Apr, May), Summer (Jun, July, Aug), Fall (Sept, Oct, Nov), Winter (Dec, Jan, Feb), 
<img width="457" alt="Screenshot 2024-06-20 at 7 57 16 PM" src="https://github.com/mridul-bhalla/NYC-Traffic-Accidents-Analysis/assets/158173545/f8b0165e-953f-4efe-92e7-8f49f2c71988">

#### 5. *"Holiday Indicator"* Column
- We took the dates for the metioned years (2021, 2022, 2023) that are National Holidays in USA.
- The list can be seen below:
- ![Copy of S  NO -5](https://github.com/mridul-bhalla/NYC-Traffic-Accidents-Analysis/assets/158173545/48fd4fc0-da12-4676-a62c-feeaa04dd6b5)

#### 6. *"Collision Severity"* Column
- If the number of persons killed is greater than 0, then accident is considered as fatal
- If the number of persons injured is greater than or equal to 2, then accident is considered as severe
- Else the accident is considered as minor


## Data Analysis in SQL

The data analysis phase involved executing a series of SQL queries to explore and understand the dataset. Key analyses included:

1. Collision Trends Over Time: Analyzing the number of collisions per year, month, and day.
2. Collision Hotspots: Identifying areas with the highest number of collisions using latitude and longitude data.
3. Collision Rate by Borough: Comparing the number of collisions across different NYC boroughs.
4. Common Contributing Factors: Determining the most frequent causes of accidents.
5. Correlation Between Factors and Severity: Exploring the relationship between contributing factors and the severity of collisions.
6. Vehicle Types Involved: Assessing which types of vehicles are most commonly involved in collisions.


## Data Visualisation in Excel

The data visualization phase involved creating a dashboard in Excel to display the key findings. The data used for dashboard was the clean data extracted from MySQL - It contained 216098 records. The dashboard can be accessed using the link provided previously. 

## Key Findings

Our analysis revealed several critical insights into the patterns and trends of traffic collisions in NYC, which are as follows: 

- Collision Trends Over Time
  - Over the years, a decrease in collisions has been observed.
  - There is a noticeable seasonal trend in collisions, with higher numbers occurring during winter months.
  - Maximum Collisions occure between the 5pm - 6pm time window.
  - Accident occurences increase as the week progresses peaking on Friday.
  - Average number of collisions per day is 260.67

- Geographical Insights
  - The highest number of collisions occur in Manhattan, followed by Brooklyn.
  - The top three collision hotspots in NYC are:
      - Latitude: 40.861862, Longitude: 40.861862, num of collisions: 137
      - Latitude: 40.675735, Longitude: -73.896860, num of collisions: 131
      - Latitude: 40.658577, Longitude: -73.890630, num of collisions: 106
  - Top 2 accident prone streets are: Belt Parkway and Broadway 

- Collision Severity and Contributing factors
  - Distracted driving, failure to yield the right way, and following too closely are the top contributing factors to collisions.
  - Pedestrians account for a significant portion of fatalities, while motorists are more frequently injured.
  - Most number of accidents are caused by passenger vehicles followed by transport.
  - 0.544 deaths occur per 1000 collisions.
  - 04.334 injuries occur per 1000 collisions. 

## Key Recommendations

1. Road maintenance activities, such as salting and snow removal, should be increased during the winter months.
2. More stringent traffic regulations and fines should be implemented in Manhattan and Brooklyn.
3. Police patrols and sobriety checkpoints should be increased during peak accident hours like 5pm - 6pm.
4. Stricter penalties should be implemented for distracted driving, and technology solutions, such as speed cameras and mobile phone usage detectors should be introduced.
5. Infrastructure improvements, such as better signage and road designs should be done in the accident prone areas.
6. More visible traffic light signals, pedestrian barriers and crosswalk markings should be installed at major intersections.
7. Focus should be on providing a more robust and efficient public transit system to encourage usage by commuters
8. A task force can be established to review collision data regularly and recommend necessary changes.

## Conclusion

This project provided valuable insights into traffic accidents in NYC, highlighting key trends, hotspots, and contributing factors. The findings and recommendations can aid in developing strategies to improve road safety and reduce the number of accidents.
