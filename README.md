# nus_spots
# Oribital-Techno-CAI-PNG
Proposed Level of Achievement:
Project Gemini

Motivation 
A very common struggle amongst students is finding good study locations, and nearby food options. Due to the pandemic, freshmen (and others) may have difficulty finding such places around the school. Why not have a comprehensive app that integrates both makan places and study/chill spots, allowing lost students to know where to head to?

Aim 
We hope to develop a mobile application for NUS students to view and keep track of their favourite study spots and eating places. By doing so, we seek to make finding study and eating spots more convenient for students. 

User Stories
1. As a student who wants to study in school and have lunch, I can easily view the study places near food locations, and vice versa, helping me plan where to go. This also helps me make a decision on whether I want to takeaway or dine in if there are no nearby study spots.
2. As a student who has yet to explore around NUS due to the pandemic, this application helps me pick out the restaurants that are within my budget, together with nearby study areas I can head to after my meals.
3. As a student who gets easily confused by all the transport options, this application provides me with detailed ways to travel to my destined study/dining spots.
4. As a student who wants to try out new food on campus, the review section of this application written by fellow students gives me a better idea of which store fits my taste and budget better. 
5. As a student who needs somewhere to study between my physical lessons, this application is capable of suggesting available study areas and food options near my lesson locations, hence allowing me to fully utilize my free time between each lesson while getting a quick bite. (This will also be helpful for non-freshies as well since their lesson locations might vary between semesters)
6. As a senior student who is already familiar with all the available food/study options on campus, this app allows me to check for real time crowd levels at my desired location, so that I can plan my time and where to go properly. 
Scope of the project 
The Mobile Application provides several options: ‘EAT’, ‘STUDY’ and ‘ALL OPTIONS’. The first 2 options bring the user to a google map interface for users to search for their desired location. The last option displays the full list of food/study spots based on categories.
Currently completed features:
Launch screen of the app shows icon instead of blank white screen
Home screen of the app 
Implemented Google Maps API to access Google Maps within the app
Implemented flutter package to allow app to generate and access user location
Implemented a mock list of available food/study spot options for display purposes 
Implemented a basic search function in Google Maps 
Features to be completed by mid of June:
Detail pages for each study/eat options under the ALL OPTIONS menu
Functionalities for users to perform CRUD operations on each of the detail pages for their comments
Mark out locations on Google Maps by default without any searching done by the user. (Similar to how NUSNextBUS marks out all the bus stops on their map)
Tagging system on locations. (study/food, aircon/outdoor etc)
Search and filter function based on name, category or specific tags.
Improve on the search function in Google Maps 
Features to be completed by mid of July:
Implement “nearby food/study options” for all of the locations.
Obtain location data of all spots and mark them out on Google Maps. (Since some of them, especially study spots might not be found on a typical Google Maps)
Real time crowd levels at the various locations 
Implement route system to show user how to get to their desired location

How are we different from similar apps
NUSMODS 
NusMods allow people to check for available venues and locate them, however, it only shows indoor venues, (such as tutorial rooms and seminal rooms) the website also does not provide real time crowdedness information. NusMods also does not provide information about where to eat on campus.
Google maps
The typical Google maps application is also capable of searching for a desired location. However, our app is more customized for NUS students, where it searches for a lot of locations that cannot be found on Google Maps. On top of that, our app also allows users to choose their target locations based on filtering their specific requirements. 
