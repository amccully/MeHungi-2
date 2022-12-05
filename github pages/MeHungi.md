<center> <h1> <b> ECE 196 Project</h1> </b> </center>

<center> <h2> General Problem / Project Description </h2> </center>
<br/>

In short, lines suck. Sometimes you just don't have enough time to spare and have to choose the quickest option regardless of personal preference. In the case of restaurants, often you won't know how long you will have to wait until you actually arrive. 

UCSD has attempted to remedy this by the implentation of Triton2Go, but practically any student who has used it can tell you the innacurracy of the service. We hope to present a solution that takes the frustration out of getting your meals.

![Image](Pics/LongLine.jpg)

<br/>
<center> <h2> App-Server-Terminal Relationship </h2> </center>
<br>

To implement our solution, we need to create three different parts:
1. <b>App:</b> Displays the wait times of and map to different restaurants in the UCSD area. 
2. <b>Server:</b> Store restaurant info and calculate changing wait times as new data comes in.
3. <b>Psuedo-Cash Register:</b> Interface for ordering food and sending out total wait times for each order to the server. 

The App will have to request wait time and restaurant data from the server using RESTful API requests. The Register will have to modify data in the server by supplying wait times at specific times so the server can process and update the data.

<p align="center">
<img src="Pics/Server-Client.png" alt="Server-Client"   class="center">
</p>
 
<br/>
<br/>

<center> <h2> Video: </h2> </center>

<center> <video width="400" height="240" controls>
  <source src="ECE196Project.mp4" type="video/mp4">
</video> </center>



<br/>
<br/>

4-6 Favorite Photos/Schematics/Drawings
Final Presentation You Submitted
Technical Workshop Page
4+ Resources (be descriptive)

<center> <h2> Explanation: </h2> </center>
For a more in-depth explanation of the code, visit: [Image]() 

<center> <h2> Meet the Team! </h2> </center>

| Eric Shults | Aaron McCully |
| ----- | ----- |
| ![image](Pics/Gigachad.jpg) | ![image](Pics/PatrickBateman.jpg) |
| Backend Python Development | Frontend Swift Development |

