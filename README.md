# Dataset Creation Process for PAWsitive Connection 🐾

## Project Background

I began by searching for a well-structured relational database with multiple tables to use as an SQL project, but it felt like looking for a needle in a haystack. The closest match was a dataset called **Chinook**, with about 11 tables—but the data was sparse, and I wanted to make an impact with robust, realistic analysis. So, I decided, with ChatGPT’s encouragement, to create my own relational database from scratch.

After a _lightbulb moment_, I landed on a pet adoption center theme. I also wanted a memorable name, so I consulted ChatGPT, which suggested the playful title: **PAWsitive Connection**. And with that, my fictional pet adoption center was born.

## Dataset Concept and Assumptions[www.facebook.com]

- **Location**: California—home of sunshine, diversity, and a wide range of adoptable pets.
- **Center Start Date**: Operations began in 2017.
- **Data Collection Start**: The center started keeping detailed records in 2020.
- **Dataset Timeframe**: Data collected until December 2023.

## Table Creation and Data Generation Logic

Creating each table was like piecing together a puzzle, and I used various tools to bring the data to life—Mockaroo for random values, ChatGPT for brainstorming, and even a bit of Python (more on that later!). Here’s the breakdown of each table:

### 1. Customers Table

- **Attributes**: `customer_id`, `full_name`, `date_of_birth`, `state`, `city`, `pet_preferences`
- **Generation Logic**: I used Mockaroo to generate random names and cities within California. I added a weighted preference for dogs and cats (no offense to turtles and snakes).

### 2. Species Table

- **Attributes**: `species_id`, `species`
- **Generation Logic**: I included a menagerie of popular pets like cats, dogs, and some more “unique” options like lizards and snakes (for the exotic pet enthusiasts).

### 3. Subspecies Table

- **Attributes**: `subspecies_id`, `species_id`, `subspecies_name`
- **Generation Logic**: I picked the top 10 subspecies for common pets like cats and dogs, with a few for other species to keep things interesting.

### 4. Pets Table

- **Attributes**: `pet_id`, `species_id`, `subspecies_id`, `gender`, `pet_name`, `age_dec_2023`, `year_of_birth`, `arrival_date`, `aggressiveness`, `adopted_status`
- **Generation Logic**:
  - **Names**: I generated a list of 750 names for each gender (thank you, ChatGPT) and then added some randomness for a touch of realism.
  - **Age**: Using Python, I created weighted age buckets for each species based on life expectancy, ensuring the ages lined up with the year of birth.
  - **Arrival Date**: Pets had to be at least a couple of months old before arriving at the center, with dates randomized between the center’s opening in 2017 and December 2023.
  - **Aggressiveness**: Randomly assigned, but thoughtfully weighted by species (because not all pets are equally... assertive).

### 5. Adoptions Table

- **Attributes**: `adoption_id`, `customer_id`, `pet_id`, `adoption_date`, `adoption_event_id`
- **Data Generation Challenge**: Assigning pets based on customer preferences, which, as it turns out, wasn’t straightforward. Preferences mattered, but I also wanted some customers to settle for their second choice (as happens in real life).
- Here’s where Python saved the day. Even though I’m just getting comfortable with Python, I teamed up with ChatGPT to write logic for assigning pets based on customer preferences and pet compatibility. The result? A Python-driven, preference-based pet assignment process that factors in multiple pets and pet compatibility. _High-five, Python!_

### 6. Adoption Events Table

- **Attributes**: `adoption_event_id`, `event_name`, `event_date`, `location`
- **Generation Logic**: Four annual events hosted in different cities each year, using unique event names brainstormed by ChatGPT.

### 7. Traits and Pet_Traits Tables

- **Traits Table Attributes**: `trait_id`, `trait_name`
- **Pet_Traits Table Attributes**: `pet_id`, `trait_id`
- **Generation Logic**: Each pet has 2-3 traits, but we couldn’t let pets be “lazy” and “active” at the same time! With ChatGPT, I created weighted probabilities for compatible traits, focusing on species characteristics.

### 8. Health Records Table

- **Attributes**: `health_record_id`, `pet_id`, `checkup_date`, `health_status`, `vaccination_status`
- **Data Generation Logic**:
  - **Checkup Frequency**: Based on the pet’s age and health condition, with more frequent checkups for the youngest and oldest pets.
  - **Vaccination Status**: Up-to-date on arrival and adoption, because a responsible center ensures pets are healthy before going to new homes.

### 9. Feedback Table

- **Attributes**: `feedback_id`, `customer_id`, `feedback_date`, `adoption_process_rating`, `staff_interact_rating`, `adoption_support_rating`, `pet_condition_rating`, `overall_rating`, `follow_up_required`
- **Generation Logic**:
  - **Ratings**: Randomly generated, with a formula for pet condition ratings that considers pet health and aggressiveness.
  - **Follow-Up**: Set to “yes” more often if overall rating is low, for that extra customer care touch.

---

This dataset took a good bit of brainstorming, coding, and creative problem-solving, using tools like Mockaroo, ChatGPT, and even a dose of Python magic. For someone still learning Python, this project pushed my skills, but with persistence and some clever assistance, it came together!
