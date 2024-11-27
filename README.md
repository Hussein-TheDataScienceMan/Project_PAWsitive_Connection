# PAWsitive Connections

### **Introduction**

Welcome to **PAWsitive Connections**, a project designed to show my SQL skills while solving a meaningful problem: helping more pets get adopted. This fictional adoption center, based in California, serves as the setting for analyzing pet preferences, adoption trends, and other factors that affect adoption rates.

The goal of this project is to dig into the data and uncover useful insights. By using SQL, I explored different angles of the adoption process to find patterns and trends. The ultimate aim? To figure out how to help more pets find their forever homes.

This project is part of my portfolio and focuses on highlighting my ability to work with databases, write complex queries, and present results in a clear and meaningful way.

While this README focuses on showcasing my SQL work, a detailed report (under progress) will address the business problem comprehensively, analyzing insights and presenting strategies based on visualizations and findings.

### **Dataset Overview**

The data for this project was built from scratch to simulate a real-world relational database. It includes key details about customers, pets, adoptions, and more. Each table is designed to capture a specific part of the adoption process, making it easier to analyze different aspects of pet adoption.

Here’s a quick look at the main tables in the dataset:

- **Customers**: Information about the people looking to adopt pets, including their preferences.
- **Pets**: Details about the pets, such as species, age, health, and aggressiveness.
- **Adoptions**: Records of adoptions, linking customers and pets.
- **Adoption Events**: Details about events hosted to promote adoptions.
- **Health Records**: Checkup details to track the health of pets over time.

For a deeper dive into how this dataset was created and structured, check out the [Dataset Creation README](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/633fbbd4266c3298ca73efcd9b7461976a1f4338/PAWsitive%20Connection%20Dataset/PAWSitive%20Connection%20Dataset%20Creation%20README.md).

### **Project Objectives**

The main goal of this project is to explore how SQL can help uncover trends and insights that improve pet adoption rates. To achieve this, I structured the project around answering key business questions such as:

1. **Who are our customers?**
    - What cities do they come from?
    - How do their age and gender affect pet preferences?
2. **What are the adoption trends?**
    - Which pets are adopted the most?
    - How do seasonal or yearly trends affect adoption?
3. **How do pet characteristics influence adoption?**
    - Do traits like age, health, or aggressiveness affect adoption rates?
    - What factors contribute to longer or shorter stays for pets in the center?
4. **Do adoption events make a difference?**
    - How do events impact adoption rates, and which pets benefit the most?

SQL was the key tool for answering these questions. Each query was crafted to focus on a specific aspect of the adoption process, helping to turn raw data into actionable insights.

### **SQL Work Showcase**

This project focuses on using SQL to explore the data and answer critical business questions. Below is the full table of contents for the queries, organized by category. Each query is hyperlinked for easy access, and some highlights are explained in detail to showcase my SQL skills.

---

**Table of Contents for Queries**

1. [**Customer Analysis**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/1.preferences_analysis/)
    - 1.1 Most Popular Pet Preferences by City
    - 1.2 Top Pet Preferences by Age Group
    - 1.3 Most Popular Pet Preferences by Gender
    - 1.4 Top Pet Preferences by Gender within Cities
    - 1.5 Male-to-Female Ratio in Age Groups
    - 1.6 Top Two Pet Preferences by Gender in Age Groups
    - 1.7 Customer Distribution Across Age Segments
    - 1.8 Customer Distribution by City

2. [**Adoption Factors**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/2.adoption_factors/)
    - 2.1 Adoption vs. Non-Adoption Rates by Species
    - 2.2 Alignment Between Customer Preferences and Adopted Pet Species
    - 2.3 Adoption Trends Over Time
    - 2.4 Arrival Trends Over Time

3. [**Aggressiveness Analysis**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/3.aggressiveness_analysis/)
    - 3.1 Distribution of Aggressiveness Levels by Species
    - 3.2 Aggressiveness Levels for Pets with Above-Average Stay Periods
    - 3.3 Aggressiveness Levels for Pets with Below-Average Stay Periods
    - 3.4 Aggressiveness Levels for Adopted Pets
    - 3.5 Aggressiveness Levels for Non-Adopted Pets
    - 3.6 Aggressiveness & Stay Time Analysis

4. [**Age Analysis**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/4.age_analysis/)
    - 4.1 Average Age of Adopted vs. Non-Adopted Pets by Species

5. [**Health Analysis**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/5.health_analysis/)
    - 5.1 Effect of Health Status on Adoption Rates by Species
    - 5.2 Effect of Health Status on Stay Periods by Species

6. [**Adoption Events Analysis**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/6.adoption_events_analysis/)
    - 6.1 Details of Pets Adopted During Adoption Events
    - 6.2 Number of Pets Adopted per Species for Each Event
    - 6.3 Total Number of Adoptions per Event
    - 6.4 Ranking of Events by Total Adoptions
    - 6.5 Percentage of Adoptions Through Events

7. [**Stay Duration Analysis**](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/main/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/7.stay_duration_analysis/)
    - 7.1 Average, Minimum, and Maximum Stay Period per Species for Adopted Pets
    - 7.2 Average, Minimum, and Maximum Stay Period for Unadopted Pets
    - 7.3 Pets with Above-Average Stay Periods by Species
    - 7.4 Pets with Below-Average Stay Periods by Species


---

### **Highlights by Category**

Below are some selected examples from each category. For full details, use the hyperlinks above to navigate to specific queries.

### **1. Customer Analysis: Who Are Our Adopters?**

Understanding the demographics and preferences of customers is the first step in tailoring strategies to improve adoption rates. Here are the key questions explored in this category:

---

- **Query 1: Most Popular Pet Preferences by City**
    - **Purpose**: To identify pet preferences in different cities, helping us target campaigns more effectively.
    - **Snippet**:
        
        This query identifies the most popular pet preferences in each city, calculates their percentage relative to the total preferences, and ranks them to determine the top choice. It uses Common Table Expressions (CTEs), `DENSE_RANK()`, and joins to organize and calculate these insights.
        
        ```sql
        
        WITH ranked_preferences AS (
            SELECT
                city,
                COUNT(pet_preferences) AS preference_count,
                pet_preferences,
                DENSE_RANK() OVER (
                    PARTITION BY city
                    ORDER BY
                        COUNT(pet_preferences) DESC
                ) AS rank
            FROM
                customers
            WHERE
                pet_preferences IS NOT NULL
            GROUP BY
                city,
                pet_preferences
        ),
        city_totals AS (
            SELECT
                city,
                COUNT(pet_preferences) AS total_count
            FROM
                customers
            GROUP BY
                city
        )
        SELECT
            ct.city,
            rp.pet_preferences,
            rp.preference_count,
            ROUND(
                (rp.preference_count * 100.0 / ct.total_count),
                2
            ) AS percentage,
            rp.rank
        FROM
            ranked_preferences rp
            JOIN city_totals ct ON rp.city = ct.city
        WHERE
            rp.rank = 1 -- Show only the top preference per city
        ORDER BY
            rp.pet_preferences,
            percentage DESC;
        ```
        
        ### Visualization of the Results:
        

![Most Popular Pet Preferences by City](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/1.Most_Popular_Pet_Preferences_by_City.png)


**Key Insight**: In 6 out of 10 cities in the dataset, cats are the top pet preference. Dogs are the top preference in 3 cities. Interestingly, Oakland showed an equal preference for both cats and dogs.

---

- **Query 2: Top Pet Preferences by Age Group**
    - **Purpose**: To explore how pet preferences vary across age groups.
    - **Snippet**:
    This query categorizes customers into three age groups based on their date of birth—Young Adults (17–30 years), Middle-Age Adults (31–55 years), and Seniors (56+ years). It then ranks the top three pet preferences within each age group using `DENSE_RANK()`.
    
    ```sql
    WITH age_group AS (
        -- Categorize customers into age groups and associate their pet preferences
        SELECT 
            customer_id,
            date_of_birth,
            DATE_PART('year', AGE('2023-12-31', date_of_birth)),
            CASE
                WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 17 AND 30 THEN 'Young Adult'
                WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 31 AND 55 THEN 'Middle-Age Adult'
                WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) >= 56 THEN 'Senior'
                ELSE 'Other'
            END AS age_category,
            pet_preferences
        FROM 
            customers
    ),
    total_customers AS (
        -- Get the total number of customers for reference (not actively used in this query but included for potential scaling)
        SELECT 
            COUNT(*) AS total
        FROM 
            customers
    ),
    ranked_preferences AS (
        -- Rank pet preferences within each age category
        SELECT 
            age_category,
            COUNT(pet_preferences) AS preference_count,
            pet_preferences,
            DENSE_RANK() OVER (
                PARTITION BY age_category
                ORDER BY COUNT(pet_preferences) DESC
            ) AS rank
        FROM 
            age_group
        WHERE 
            pet_preferences IS NOT NULL
            AND pet_preferences <> 'No Preference'
        GROUP BY 
            age_category,
            pet_preferences
    )
    
    -- Select the top three preferences per age category
    SELECT 
        age_category,
        pet_preferences,
        rank,
        preference_count
    FROM 
        ranked_preferences
    WHERE 
        rank IN (1, 2, 3);
    ```
    
    ### Visualization of the Results:
    
    ![Top Pet Preferences by Age Group](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/2.Top_Pet_Preferences_by_Age_Group.png)
    
    - **Key Insights:**
        - *Young Adults (17–30 years): Most prefer dogs, followed by cats, and exotic or small pets equally taking the third spot.*
        - *Middle-Age Adults (31–55 years): Cats are the top choice, with dogs following very closely. Small pets come third but with a significant gap.*
        - *Seniors (56+ years): Cats are slightly more popular than dogs, with exotic pets unexpectedly appearing as the third preference. This anomaly arises because parts of the data are randomly generated.*

---

- **Query 3: Gender-Based Pet Preferences**
    - **Purpose**: To examine differences in pet preferences between male and female customers.
    - **Snippet**:
    This query identifies the most popular pet preferences for each gender, ranks them to determine the top choices, and calculates their frequency. It uses the `DENSE_RANK()` window function to rank preferences within gender groups, enabling an organized view of the most favored pets. The query filters out null or non-preference entries to ensure accurate insights into gender-based pet preferences.
        
        ```sql
        SELECT 
            gender,
            pet_preferences,
            COUNT(pet_preferences) AS preference_count,
            DENSE_RANK() OVER (
                PARTITION BY gender 
                ORDER BY COUNT(pet_preferences) DESC
            ) AS rank
        FROM 
            customers
        WHERE 
            pet_preferences IS NOT NULL 
            AND pet_preferences <> 'No Preference'
        GROUP BY 
            gender, 
            pet_preferences;
        ```
        
    
    ### Visualization of the Results:
    
    ![Gender-Based Pet Preferences](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/3.Gender-Based_Pet_Preferences.png)
    
    - **Key Insights**:
        - **Males**: Cats are the top preference, followed closely by dogs. Small pets and farm animals come third and fourth, respectively, with aquatic pets being the least preferred.
        - **Females**: Cats slightly lead over dogs, while exotic pets appear as the third preference. However, the higher interest in exotic pets among females may be influenced by the data generation process, making it an anomaly.
        - While both genders show a strong preference for cats and dogs, males display greater interest in small pets and farm animals.

---

- **Query 4: Top Two Pet Preferences by Gender in Age Groups**
    - **Purpose**: To dive deeper into how age and gender intersect in shaping preferences.
    - [Full Query](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/blob/633fbbd4266c3298ca73efcd9b7461976a1f4338/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries/1.preferences_analysis/1.4_gender_preferences_by_city.sql)
        
        ### Visualization of the Results:
        
        ![Top Two Pet Preferences by Gender in Age Groups](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/4.Top_Two_Pet_Preferences_by_Gender_in_Age_Groups.png)
        
    - **Key Insight**:
        - **Middle-Age Adults (31–55 years):**
            
            Females prefer cats slightly more than dogs, making cats the top choice. For males, cats also come first, but the difference between cats and dogs is narrower.
            
        - **Seniors (56+ years):**
            
            Both females and males have a nearly equal preference for cats and dogs, with cats coming first for both genders.
            
        - **Young Adults (17–30 years):**
            
            Both males and females show almost identical preferences for cats and dogs, with cats still taking the lead as the most popular choice.
            
        
        These insights reveal that cats consistently rank as the top preference across all age groups, with preferences between cats and dogs becoming more balanced in younger and older age groups.
        

---

- **Query 5: Distribution of Customers Across Cities**
    - **Purpose**: To identify the geographic spread of customers and focus outreach efforts.
    - **Snippet**:
        
        This query identifies the distribution of customers across different cities by counting the number of customers in each city. The results are sorted in descending order of customer count, highlighting the cities with the largest customer bases. This analysis helps identify key geographic regions for customer concentration, which is useful for targeted marketing and resource allocation strategies.
        
        ```sql
        SELECT
            city,
            COUNT(customer_id) AS number_of_customers
        FROM
            customers
        GROUP BY
            city
        ORDER BY
            number_of_customers DESC
        ```
        
        ### Visualization of the Results:
        
        5. ![Distribution of Customers Across Cities](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/5.Distribution_of_Customers_Across_Cities.png)
        
    - **Key Insights**:
        - **Oakland** has the largest customer base with 167 customers, making it the top city in terms of customer concentration.
        - **Fresno** and **San Diego** follow closely, with 159 and 153 customers, respectively, indicating strong customer representation in these cities.
        - The remaining cities, such as **Long Beach**, **Irvine**, and **Santa Barbara**, show relatively similar customer counts, ranging between 147 and 143 customers.
        - **Bakersfield**, with 122 customers, has the smallest customer base among the cities analyzed.
            
        These insights highlight **Oakland, Fresno, and San Diego** as key hubs for customer presence, which could be prioritized for marketing or operational efforts.
        

### **2. Adoption Factors: Trends and Success Rates**

Adoption trends reveal how often pets find their forever homes and help identify areas where efforts need improvement. This section looks at the data to uncover patterns in adoption rates, seasonal trends, and species-specific challenges.

---

- **Query 1: Adoption vs. Non-Adoption Rates by Species**
    - **Purpose**: To understand which species are most likely to be adopted and which face challenges.
    - **Snippet**:
        
        This query calculates the adoption and non-adoption rates for each species of pet, highlighting species with lower adoption percentages. Using Common Table Expressions (CTEs) to calculate total counts of each species, it retrieves the number and percentage of pets adopted and not adopted for each species. The results are sorted by adoption percentage in ascending order to identify species with the lowest adoption rates.
        
        ```sql
        
        WITH species_totals AS (
            -- Calculate the total count of pets for each species
            SELECT
                s.species_name,
                COUNT(*) AS total_of_species
            FROM
                pets p
                LEFT JOIN species s ON p.species_id = s.species_id
            GROUP BY
                s.species_name
        )
        SELECT
            s.species_name,
            COUNT(*) AS count_per_species,
            COUNT(
                CASE
                    WHEN p.adopted_status = 'Adopted' THEN 1
                END
            ) AS adopted_count,
            COUNT(
                CASE
                    WHEN p.adopted_status = 'Not Adopted' THEN 1
                END
            ) AS not_adopted_count,
            ROUND(
                COUNT(
                    CASE
                        WHEN p.adopted_status = 'Adopted' THEN 1
                    END
                ) * 100.0 / t.total_of_species,
                2
            ) AS adopted_percentage,
            ROUND(
                COUNT(
                    CASE
                        WHEN p.adopted_status = 'Not Adopted' THEN 1
                    END
                ) * 100.0 / t.total_of_species,
                2
            ) AS not_adopted_percentage
        FROM
            pets p
            LEFT JOIN species s ON p.species_id = s.species_id
            JOIN species_totals t ON s.species_name = t.species_name
        GROUP BY
            s.species_name,
            t.total_of_species
        ORDER BY
            adopted_percentage ASC;
        
        -- Sort by lowest adoption percentage to highlight unadopted species
        ```
        
    
    ### Visualization of the Results:
    
    ![Adoption vs. Non-Adoption Rates by Species(1)](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/6.1.Adoption_vs._Non-Adoption_Rates_by_Species.png)

    ![Adoption vs. Non-Adoption Rates by Species(2)](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/6.2.Adoption_vs._Non-Adoption_Rates_by_Species.png)
    
    - **Key Insights**:
       - **Dogs** dominate with the highest total count (699), achieving a notable adoption success rate of **81%**.
        - **Cats** follow closely in numbers (604) and have a high adoption success rate of **93%**, underscoring their popularity.
        - **Guinea Pigs**, with a total of **174**, face adoption challenges with only **44%** adopted, highlighting significant difficulties in rehoming.
        - **Hamsters**, **lizards**, and **rabbits** have 100% adoption rates despite their relatively lower total counts, indicating strong demand for these smaller or exotic pets.
        - **Birds** present moderate challenges, with **33%** adoption success out of **117 total birds**, emphasizing the need for focused efforts on this species.
        - **Fish** have a balanced total of **104**, with a **54%** adoption rate, suggesting a steady interest but room for improvement.
        - **Snakes** show a remarkable 100% adoption rate, reflecting niche interest and effective rehoming efforts.
        - **Parrots** (37% adoption) and **turtles** (26% adoption) show low adoption percentages, with total counts of **35** and **23**, respectively, pointing to their specialized appeal and adoption challenges.

        These insights highlight the dominance of dogs and cats in adoption success, the strong performance of hamsters, lizards, and rabbits, and the challenges faced by species like guinea pigs, birds, parrots, and turtles, necessitating targeted strategies for improvement.
        

---

- **Query 2: Alignment Between Customer Preferences and Adopted Pets**
    - **Purpose**: To see how often customers adopt pets matching their stated preferences.
    - **Snippet**:
        
        This query analyzes the alignment between customer pet preferences and the species of pets they adopt. By joining customer preferences with actual adoptions and pet species data, it calculates the number of matches for each preference-species combination. The query helps identify whether customers adopt pets aligned with their stated preferences or if gaps exist between preferences and actual adoption behavior.
        
        ```sql
        SELECT
            c.pet_preferences,
            s.species_name,
            COUNT(*) AS preference_match_count
        FROM
            adoptions a
            LEFT JOIN customers c ON a.customer_id = c.customer_id
            LEFT JOIN pets p ON a.pet_id = p.pet_id
            LEFT JOIN species s ON p.species_id = s.species_id
        WHERE
            c.pet_preferences IS NOT NULL
            AND c.pet_preferences <> 'No Preference'
        GROUP BY
            c.pet_preferences,
            s.species_name
        ORDER BY
            c.pet_preferences;
        ```
        
        ### Visualization of the Results:
        
        ![Alignment Between Customer Preferences and Adopted Pets](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/7.Alignment_Between_Customer_Preferences_and_Adopted_Pets.png)
        
    - **Key Insights**:
        - **Cats and Dogs Achieve 100% Alignment:**
            - All customers who prefer cats and dogs adopt those species, showing a perfect alignment between stated preferences and actual adoptions.
        - **Small Pets Also Achieve 100% Alignment:**
            - Customers who prefer small pets (e.g., hamsters) adopt only from this category, reflecting high demand satisfaction.
        - **Exotic Pets Show Moderate Alignment:**
            - 54% of exotic pet preferences align with lizards, while 45% align with snakes. Turtles contribute only 1% of exotic pet matches, showing limited adoption interest or availability.
        - **Farm Animals Are Divided:**
            - Rabbits make up 80% of farm animal preference matches, while guinea pigs account for the remaining 20%, indicating a skew toward rabbits.
        - **Aquatic Pets Match 100% Preference:**
            - All stated aquatic pet preferences result in fish adoptions, though the total count is relatively low compared to other categories.
        - **The "No Preference" and "Unknown" Categories:**
            - In the "No Preference" group:
                - Dogs (28%) and cats (19%) are the top matches.
                - Small pets (15%) and aquatic pets (8%) also contribute, reflecting a spread of adoptions across species.
            - In the "Unknown" group:
                - Cats (25%) and dogs (28%) dominate, but small pets (12%) and exotic pets (5%) are also adopted, suggesting flexibility among these adopters.
        
        ### **Overall Observations:**
        
        - Cats, dogs, and small pets achieve full alignment, showing the strongest connection between stated preferences and adoptions.
        - Exotic pets and farm animals show partial alignment, with lizards, snakes, and rabbits leading within their categories.
        - "No Preference" and "Unknown" adopters demonstrate a more flexible approach, diversifying adoption trends across species.

---

- **Query 3: Adoption Trends Over Time**
    - **Purpose**: To analyze yearly growth in adoptions and detect seasonality.
    - **Snippet**:
    This query analyzes adoption trends over time by calculating the number of adoptions for each species, grouped by month. Using the `DATE_TRUNC` function, adoption dates are aggregated at the monthly level to identify patterns or seasonality in adoption rates. The query also includes a breakdown by species, providing insights into how adoption trends differ among species over time.
        
        ```sql
        SELECT
            DATE_TRUNC('month', a.adoption_date) AS adoption_month,
            -- Group by month
            s.species_name,
            COUNT(a.adoption_id) AS monthly_adoption_count
        FROM
            adoptions a
            LEFT JOIN pets p ON a.pet_id = p.pet_id
            LEFT JOIN species s ON p.species_id = s.species_id
        GROUP BY
            adoption_month,
            s.species_name
        ORDER BY
            adoption_month;
        ```
        
        ### Visualization of the Results:
        
        ![Adoption Trends Over Time](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/8.Adoption_Trends_Over_Time.png)
        
    - **Key Insights**:
        - **Steady Growth:** Adoptions have increased consistently since the pet adoption center opened in 2017, with a significant spike starting in **2020** and peaking at **711 adoptions in 2023**.
        - **Cats and Dogs Dominate:** Cats and dogs remain the most adopted species, driving the majority of adoptions over the years.
        - **2020 Surge:** The sharp rise in adoptions in 2020 may reflect increased interest during the COVID-19 pandemic.
        - **Niche Growth:** Smaller species (hamsters, guinea pigs) and exotic pets (lizards, snakes) show steady but lower adoption rates compared to cats and dogs.
        
        This trend highlights the growing impact of the center, with opportunities to promote smaller and exotic species alongside sustaining the success of cats and dogs.
        

---

- **Query 4: Arrival Trends Over Time**
    - **Purpose**: To see how new pets arrive at the center and detect any seasonal patterns.
    - **Snippet**:
    This query analyzes pet arrival trends over time by aggregating the number of pets arriving at the adoption center each month. Using the `DATE_TRUNC` function, it groups arrival dates at the monthly level and provides a breakdown by species to identify patterns or seasonality in pet arrivals.
        
        ```sql
        SELECT
        DATE_TRUNC('month', p.arrival_date) AS arrival_month,
        -- Group by month
        s.species_name,
        COUNT(p.pet_id) AS monthly_arrival_count
        FROM
        pets p
        LEFT JOIN species s ON p.species_id = s.species_id
        GROUP BY
        arrival_month,
        s.species_name
        ORDER BY
        arrival_month;
        ```
        
    
    ### Visualization of the Results:
    
    ![Arrival Trends Over Time](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/9.Arrival_Trends_Over_Time.png)
    
    - **Key Insights**:
        - **Consistent Growth Until 2022:**
            
            Pet arrivals steadily increased each year from the adoption center's opening in **2017**, peaking at **415 arrivals in 2022**.
            
        - **Decline in 2023:**
            
            A noticeable decline in pet arrivals occurred in **2023**, with **269 arrivals**, potentially reflecting reduced community pet intakes, fewer surrenders, or external factors.
            
        - **Cats and Dogs Dominate Arrivals:**
            
            Cats and dogs consistently account for the majority of arrivals each year, aligning with their dominance in adoptions.
            
        - **Gradual Growth in Smaller and Exotic Species:**
            
            Smaller pets (e.g., hamsters, guinea pigs) and exotic species (e.g., lizards, snakes) show a steady increase in arrivals over the years, though their overall contribution remains lower.
            

---

These queries provide a clear picture of adoption dynamics, helping us identify which species need more focus and how to align customer preferences with available pets. Seasonal trends further guide strategies for event planning and resource allocation.

### **3. How Do Pet Characteristics Influence Adoption?**

The characteristics of pets, such as their age, health status, and behavior, play a significant role in their adoption journey. This section explores how these traits impact adoption rates and stay durations, helping to identify opportunities for targeted support.

---

- **Query 1: Effect of Aggressiveness on Stay Time in The Center**
    - **Purpose**: To understand how aggressiveness impacts the duration pets remain at the center.
    - **Snippet**:
    This query examines the effect of **aggressiveness** on the stay time of pets in the adoption center. By analyzing each pet's stay duration (`stay_period_months`) relative to the average stay time for their species, it identifies whether aggressive behavior influences adoption timelines. The query includes additional information such as species type, adoption status, and the deviation from the species' average stay time.
        
        ```sql
        SELECT
            pspr.pet_id,
            species_name,
            stay_period_months,
            avg_stay_period_months,
            stay_period_from_avg,
            p.adopted_status,
            aggressiveness
        FROM
            pet_stay_period_rate pspr
            LEFT JOIN pets p ON pspr.pet_id = p.pet_id
        ```
        
    
    ### Visualization of the Results:
    
    ![Effect of Aggressiveness on Stay Time in the Center](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/10.Effect_of_Aggressiveness_on_Stay_Time_in_The_Center.png)
    
    - **Key Insights**:
        - **Cats, Dogs, Guinea Pigs, Hamsters, and Rabbits**: Aggressiveness levels don’t significantly affect adoption times. These species show consistent stay durations across all levels of aggressiveness.
        - **Fish, Lizards, and Snakes**: Higher aggressiveness correlates with longer stays, reflecting logical adopter preferences for calmer pets in these categories.
        - **Birds, Parrots, and Turtles**: An unexpected trend emerges where lower aggressiveness results in longer stays. This anomaly might suggest adopters prefer assertive pets in these species but is likely due to the randomized data generation method described in the dataset creation process.
        
        These findings highlight that while behavior plays a role in adoption trends for some species, others, like cats and dogs, appear unaffected, with some surprising preferences observed for specific exotic species.
        

---

- **Query 2: Impact of Age on Adoption.**
    - **Purpose**: To determine the average age of pets at the time of adoption by species.
    - **Snippet**:
    This query calculates the average age of pets at the time of adoption and contrasts it with the current average age of non-adopted pets (as of December 31, 2023). By grouping data by species, it highlights potential differences in the age profiles of adopted versus non-adopted pets. Using conditional logic with `CASE`, the query computes age in years and months and averages these values for the two groups.
        
        ```sql
        SELECT
            s.species_name,
            -- Average age of pets at the time of adoption
            ROUND(
                AVG(
                    CASE
                        WHEN p.adopted_status = 'Adopted' THEN DATE_PART('year', AGE(adoption_date, p.year_of_birth)) + DATE_PART('month', AGE(adoption_date, p.year_of_birth)) / 12.0
                    END
                ) :: numeric,
                2
            ) AS avg_age_at_adoption,
            -- Average age of non-adopted pets as of December 31, 2023
            ROUND(
                AVG(
                    CASE
                        WHEN p.adopted_status = 'Not Adopted' THEN DATE_PART('year', AGE('2023-12-31', p.year_of_birth)) + DATE_PART('month', AGE('2023-12-31', p.year_of_birth)) / 12.0
                    END
                ) :: numeric,
                2
            ) AS avg_age_at_collection
        FROM
            pets p
            LEFT JOIN species s ON p.species_id = s.species_id
            LEFT JOIN adoptions a ON p.pet_id = a.pet_id
        GROUP BY
            s.species_name
        ORDER BY
            s.species_name;
        ```
        
    
    ### Visualization of the Results:
    
    ![Impact of Age on Adoption](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/11.Impact_of_Age_on_Adoption.png)
    
    - **Key Insights**:
        - **Turtles** and **parrots** are adopted at the oldest average age, at **26.6 years** and **22.5 years** respectively, reflecting their longer lifespans and slower adoption patterns.
        - **Snakes** are adopted at an average age of **9.7 years**, significantly older than most other species.
        - **Cats** and **dogs** have moderate adoption ages at **7.2 years** and **6.5 years**, likely aligning with common pet adoption practices.
        - Small animals like **hamsters**, **fish**, and **guinea pigs** are adopted at the youngest average ages, at **1.3 years**, **2.0 years**, and **2.8 years** respectively.
        
        This variation may stem from differences in lifespan, owner preferences, or the randomness in the dataset generation method.
        

---

- **Query 3: Correlation Between Health Status and Adoption Rates**
    - **Purpose**: To explore how a pet's health status at their latest checkup impacts their adoption outcomes across various species.
    - **Snippet**:
    This query evaluates the correlation between health status and adoption rates by analyzing the most recent health records of pets. It categorizes pets into "adopted" and "not adopted" groups, segmented by health status (e.g., "Healthy," "Needs Care"). The analysis provides insight into whether health conditions influence adoption likelihood for different species.
    
    ```sql
    WITH latest_health_checkups AS (
        -- Identify the most recent health status for each pet based on the latest checkup date
        SELECT
            hr.pet_id,
            hr.health_status,
            hr.checkup_date,
            ROW_NUMBER() OVER (
                PARTITION BY hr.pet_id
                ORDER BY
                    hr.checkup_date DESC
            ) AS rn
        FROM
            health_records hr
    )
    SELECT
        s.species_name,
        lhc.health_status,
        p.adopted_status,
        COUNT(*) AS pet_count
    FROM
        latest_health_checkups lhc
        LEFT JOIN pets p ON lhc.pet_id = p.pet_id
        LEFT JOIN species s ON p.species_id = s.species_id
    WHERE
        lhc.rn = 1 -- Select only the latest health check for each pet
    GROUP BY
        s.species_name,
        lhc.health_status,
        p.adopted_status
    ORDER BY
        s.species_name,
        lhc.health_status,
        p.adopted_status;
    ```
    
    ### Visualization of the Results:
    
    ![Correlation Between Health Status and Adoption Rates (1)](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/12.1.Correlation_Between_Health_Status_and_Adoption_Rates.png)
    
    ![Correlation Between Health Status and Adoption Rates (2)](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/12.2.Correlation_Between_Health_Status_and_Adoption_Rates.png)
    
    - **Key Comparative Insights**:
        - **Health Status Has Limited Impact on Adoption Rates**:
            - The data shows **minimal effect of health status on adoption percentages**, with a relatively balanced distribution of health categories between adopted and unadopted pets. This might be a result of the dataset's random generation method or suggest external factors (e.g., adopter preferences, species popularity) have a greater influence.
        - **"Under Observation" and "Needs Care" Pets Show Unique Trends**:
            - **Nearly all pets in the "Under Observation" category are adopted**, except for a small percentage in **dogs**. This could be an anomaly in the data but may also indicate that adopters sympathize with sick pets or the center prioritizes efforts to find them homes.
            - Similarly, pets categorized as **"Needs Care"** were frequently adopted, showing that adopters are open to taking in pets with moderate health needs. This mirrors the trend seen for "Under Observation," potentially highlighting adopter compassion or the center's proactive adoption efforts.
        - **"Special Attention" Percentage Remains Steady**:
            - The **"Special Attention"** category exhibits nearly identical proportions between adopted and unadopted pets, suggesting that this specific health status neither significantly attracts nor deters adopters.
        - **Full Adoption for Certain Species**:
            - **Hamsters, lizards, rabbits, and snakes** are fully adopted across all health statuses. This suggests:
                - Strong adopter demand or limited availability of these species.
                - The center might have effective strategies to place these pets, regardless of their health.
            - This trend could also indicate that adopters prioritize these species for reasons unrelated to health, such as ease of care or species-specific appeal.
        
        ### Key Takeaways:
        
        - **Sympathy for Sick Pets**: The high adoption rate of "Under Observation" and "Needs Care" pets could reflect adopter empathy or active efforts by the center to prioritize homes for pets with specific health challenges.
        - **Stable "Special Attention" Trends**: The unchanged proportions for "Special Attention" pets indicate that this category has little influence on adoption outcomes.
        - **Species Drive Demand**: For certain species like **hamsters, lizards, rabbits, and snakes**, adoption success is independent of health, suggesting strong demand or a well-matched adopter pool.
        - **Randomization Effect**: The observed patterns, such as health status having minimal impact on adoption, might be influenced by the data's synthetic generation method

---

These queries provide a detailed view of how pet characteristics affect their adoption journey, enabling data-driven decisions to reduce stay durations and increase adoption success.

### **4. Do Adoption Events Make a Difference?**

Adoption events play a crucial role in promoting pet adoptions. This section evaluates their impact by analyzing adoption rates, species-specific trends, and overall effectiveness.

---

- **Query 1: Percentage of Adoptions During Events**
    - **Purpose**:  To determine the role of adoption events in the adoption process and categorize adoptions based on their association with events.
    - **Snippet**:
    This query examines the relationship between adoptions and organized adoption events by categorizing each record as either **"With Adoption Event"** or **"Without Adoption Event"** based on the presence of an `adoption_event_id`. The analysis highlights the proportion of adoptions occurring through events versus independently, offering insights into the effectiveness and contribution of organized events to overall adoption numbers.
        
        ```sql
        SELECT
            adoption_id,
            adoption_date,
            adoption_event_id,
            CASE
                WHEN adoption_event_id IS NULL THEN 'Without Adoption Event'
                ELSE 'With Adoption Event'
            END as adoption_event_status
        from
            adoptions
        ```
        
        ### Visualization of the Results:
        
        ![Percentage of Adoptions During Events](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/13.Percentage_of_Adoptions_During_Events.png)
        
    - **Key Insights**:
        - **Overall Trend**: Adoption events contribute significantly to adoptions, with event-driven adoptions accounting for **35%-40%** of total adoptions annually, while the majority (60%-65%) occur independently of events.
        - **Peak Year for Event Adoptions**: In **2021**, adoptions through events peaked at **40%**, showing their highest relative contribution.
        - **Stability in Independent Adoptions**: The proportion of adoptions without events remains consistent across years, ranging from **60%-65%**, suggesting a stable baseline of adoptions independent of events.
        - **Fluctuating Event Influence**: The slight variations in event adoption percentages across years might reflect the center's efforts in promoting events or external factors affecting participation.
        
        These findings indicate that while adoption events play an important role, a significant portion of adoptions occurs without them, suggesting a balanced reliance on both event-driven and independent adoption processes.
        

---

- **Query 2: Species Adoption Trends Through Events**
    - **Purpose**: To explore the impact of specific adoption events by identifying pets adopted through these events and providing details about the events.
    - **Snippet**:
        
        This query identifies pets adopted during adoption events, linking their adoption dates with event-specific details such as event name, date, and city. By filtering only for adoptions connected to events, it provides a focused view of the role these events play in facilitating adoptions. The query highlights which species were adopted during these events and allows for an analysis of event effectiveness across different locations and times.
        
        ```sql
        SELECT
            s.species_name,
            a.adoption_date,
            ae.event_name,
            ae.event_date,
            ae.city
        FROM
            adoptions a
            LEFT JOIN pets p ON a.pet_id = p.pet_id
            LEFT JOIN species s ON p.species_id = s.species_id
            LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
        WHERE
            ae.event_name IS NOT NULL;
        
        -- Filter to include only adoptions associated with events
        ```
        
    
    ### Visualization of the Results:
    
    ![Species Adoption Trends Through Events](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/14.Species_Adoption_Trends_Through_Events.png)
    
    - **Key Insights**:
        - **Fall Adoptathon** achieved the highest adoption success overall, with **91 cats** and **78 dogs** adopted, dominating the event.
        - **Dogs and Cats** consistently show high adoption numbers across all events, with cats slightly leading in most cases.
        - Smaller or exotic species, such as **parrots, turtles, and lizards**, show steady but much lower adoption rates, with 1–2 adoptions per event on average.
        - **Furry Friends Fiesta** and **Happy Summer Tails** had similar adoption patterns, with an even distribution among exotic species (e.g., guinea pigs, rabbits, and lizards) compared to other events.
        - **Paws for a Cause** had the lowest overall adoption numbers, yet it still showed strong representation for cats (29) and dogs (19).
        
        This analysis suggests that events like **Fall Adoptathon** effectively attract adopters for the most popular species (dogs and cats), while smaller events show potential for niche or exotic pet adoptions.
        

---

- **Query 3: Total Adoptions per Event**
    - **Purpose**: To evaluate the performance of adoption events by determining the total number of adoptions facilitated through each event and ranking them based on their success.
    - **Snippet**:
        
        This query calculates the total number of adoptions that occurred during each event and ranks the events in descending order based on the adoption count. By grouping the data by event names and dates, it provides insights into which events were the most effective in facilitating adoptions, offering a clear understanding of their impact and popularity.
        
        ```sql
        SELECT
            ae.event_name,
            COUNT(s.species_name) AS count_of_adoptions,
            ae.event_date,
            -- Rank events based on the number of adoptions, in descending order
            ROW_NUMBER() OVER (
                ORDER BY
                    COUNT(s.species_name) DESC
            ) AS event_rank
        FROM
            adoptions a
            LEFT JOIN pets p ON a.pet_id = p.pet_id
            LEFT JOIN species s ON p.species_id = s.species_id
            LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
        WHERE
            ae.event_name IS NOT NULL -- Filter to include only adoptions associated with events
        GROUP BY
            ae.event_name,
            ae.event_date
        ORDER BY
            count_of_adoptions DESC,
            ae.event_name;
        ```
        
        ### Visualization of the Results:
        
       ![Total Adoptions per Event](Business%20Problem%201%20(Increasing_Pet_Adoptions)/Visualizations/pngs_used_in_readme/15.Total_Adoptions_per_Event.png)
        
    - **Key Insight**:
        - **Fall Adoptathon** consistently leads in adoptions, peaking at **104 adoptions in 2023**, showcasing steady growth. Its **September timing**, near the start of fall, might align with increased interest as families settle after summer vacations and prepare for the holiday season, potentially influencing the high engagement.
        - **Furry Friends Fiesta** and **Happy Summer Tails**, held mid-year, demonstrate stable performance, maintaining adoption counts between **40 and 57** in 2023, with gradual increases from previous years.
        - **Paws for a Cause**, held in January, exhibits the lowest adoption numbers, averaging around **5–30 adoptions per year**, likely due to its early-year timing, which might coincide with reduced public interest.
        
        There is a noticeable growth in adoption participation for all events since **2020**, suggesting increased public engagement and the effectiveness of these events in promoting adoptions over time.
        

---

These queries highlight the value of adoption events as a powerful tool for boosting adoption rates and helping more pets find homes. By focusing on high-performing events and tailoring them to specific species, the adoption center can further improve outcomes.

### **Insights and Visualizations**

To support the SQL findings, I created Power BI visualizations that bring the data to life. These charts were used throughout the SQL showcase to help visualize key insights, including:

- **Bar Charts**:
    - *Top Pet Preferences by City*: Displays the most preferred pets across cities.
    - *Adopted vs. Not-Adopted Rates by Species*: Highlights adoption success rates for different species.
    - *Aggressiveness Levels by Species*: Shows the distribution of behavioral traits across all species.
- **Line Charts**:
    - *Yearly Adoption Trend by Species*: Tracks how adoptions have evolved over time for each species.
    - *Monthly Pet Arrivals by Species*: Reveals seasonal patterns in new pet arrivals.
- **Pie Charts**:
    - *Customer Age Segments*: Highlights the percentage of customers in different age groups.

A separate detailed report will fully explore the business problem, providing in-depth analysis of the visualizations and addressing each question with actionable insights and strategies.

### **Usage Instructions**

To explore this project further, you can review the SQL queries, datasets, and visualizations. While the queries are not fully runnable out-of-the-box, the following resources are available for additional exploration:

### **1. Viewing SQL Queries**

- **Query Snippets**: Included in this README to highlight specific insights.
- **Full Queries**: Access the complete SQL scripts via [this GitHub link](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/tree/633fbbd4266c3298ca73efcd9b7461976a1f4338/Business%20Problem%201%20(Increasing_Pet_Adoptions)/SQL%20Queries).
    - Queries are organized by category for easy navigation.

### **2. Exploring the Dataset**

- **Raw Data**: Download the raw data tables in `.csv` format from [this link](https://github.com/Hussein-TheDataScienceMan/Project_PAWsitive_Connection/tree/633fbbd4266c3298ca73efcd9b7461976a1f4338/PAWsitive%20Connection%20Dataset/CSVs).
- **Query Results**: Results from the SQL queries are also available as `.csv` files for easy reference.

### **3. Recreating the Dataset**

- Use the provided PostgreSQL dataset creation scripts to generate the data locally.
- **Steps**:
    1. Set up a PostgreSQL database on your system.
    2. Run the provided SQL script to generate the dataset.
    3. Import the queries and explore the data on your machine.

### **4. Exploring the Visualizations**

- Open the provided Power BI `.pbix` file to view interactive dashboards.
- Use filters and slicers to dive deeper into the insights.

### **Acknowledgments**

This project would not have been possible without the support of various tools and resources that helped bring it to life. I’d like to acknowledge the following:

- **Mockaroo**: For generating realistic sample data to populate the dataset.
- **Python**: For assisting with data generation logic, such as calculating age distributions and assigning customer preferences.
- **PostgreSQL**: For building and managing the relational database.
- **Power BI**: For creating the visualizations that helped uncover trends and insights.
- **Excel**: For quick data exploration and cleanup tasks during the project.
- **VS Code**: For writing and managing SQL queries and Python scripts efficiently.
- **ChatGPT**: For brainstorming ideas, refining queries and wording, and providing guidance throughout the project.

This project reflects a combination of technical skills, creativity, and a passion for problem-solving. Special thanks to everyone who takes the time to explore this work — I hope it sparks inspiration or collaboration opportunities!
