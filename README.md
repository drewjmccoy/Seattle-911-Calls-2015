
911 Calls in Seattle Throughout 2015
====================================
An Interactive web application whose purpose is to display and better understand all the 911 Calls made in the Seattle area in the year 2015. The contributors include Cole Cansler, Brendan Long, Chris Graham and Drew McCoy.

The Data
--------
The data we are using is from the *data.seattle.gov* website and can be found [here](https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp). We decided to use data from the year 2015 in order to focus our analysis. Prior to beginning the project we had to go through the data and remove any row values. In addition we deleted columns there were not pertinent to our analysis.

Goals
-----
The purpose of our project was to build an easy to use web application that both city officials, and its citizens could use and gain valuable information from. A few of the questions about the data set that we wanted to provide answers to are, where are 911 calls coming from, what types of calls are being made, and how are the rate of calls changing over time. We decided to make a tabbed structure, with each tab providing an answer to one of these questions. 

Code Structure
--------------
We chose to organize our code into multiple different scripts. The server and ui scripts are responsible for managing the shiny application where we are representing our data. The ui script includes multiple shiny widgets that give interactivity to the user. The server file is responsible for taking that input and changing the plots and map based on that input. The graph_scripts file is responsible for generating the plots that are used in the application. Each of the functions in the graph_scripts file takes in data that is modified from the original data set  in the data_wrangling script. The data_wrangling script is responsible for putting the data in a useable format for each of the functions in the graph_scripts file. The data_wrangling_scripts file is a script that holds miscellaneous functions that work with the data.

Leaflet Map
-----------
The map used in the report was generated with the leaflet package. Because we had over ninety thousand data points it was important to group the markers using the marker clustering package that leaflet provides. We wanted to provide the user with the option to subset the data for violent and nonviolent crimes. We provided this option in the sidepanel of the web application. Another feature we added to the leaflet map was an autozoom function. We accomplished this by putting a text input widget in the sidepanel and retrieving lattitude and longitude from the input, using geocode. We then used this data to set the zoom of the leaflet map.

Plotly Graphs
------------
We generated multiple plotly graphs that showed interesting insights of the data. The first few plots looked at the different types of 911 calls that were being made. We found that the most popular 911 calls were made about Disturbances, Suspicious Circumstances and Traffic Related Calls. These categories are quite broad. As a result, we wanted to take a deeper look at some of the broader categories of calls that were being made. We made multiple plots that broke down the larger categories into their descriptions. For example, Disturbances were broken down into Noise, Fight, Juvenile, Gang Related and Other. The other set of graphs we created showed how the number of 911 calls made, changed over time. We made a total of three plots for this section, looking at calls vs month, calls vs day, and calls vs hour. One intruiging outlier we found when manipulating the data to look at calls vs day was that there was over four times the avaergae amount of calls on July 12th.


