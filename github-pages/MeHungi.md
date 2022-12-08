<head>
   <style>
      body {
         background-color: "black";
      }
   </style>
   <h1>HTML Articles</h1>
</head>

<center> <h1> <b> ECE 196 Project</h1> </b> </center>

<center> <h2> General Problem / Project Description </h2> </center>
<br/>

In short, lines suck. Sometimes you just don't have enough time to spare and have to choose the quickest option regardless of personal preference. In the case of restaurants, often you won't know how long you will have to wait until you actually arrive. 

UCSD has attempted to remedy this by the implentation of Triton2Go, but practically any student who has used it can tell you the innacurracy of the service. We hope to present a solution that takes the frustration out of getting your meals.

<p align="center">
<img src="Pics/LongLine.jpg" alt="Long Line"   class="center">
</p>


<br/>
<center> <h2> App-Server-Terminal Relationship </h2> </center>
<br>

To implement our solution, we need to create three different parts:


<ol>
  <li><b>App:</b> Displays the wait times of and map to different restaurants in the UCSD area. </li>
  <li><b>Server:</b> Store restaurant info and calculate changing wait times as new data comes in.</li>
  <li><b>Psuedo-Cash Register:</b> Interface for viewing and deleting food orders from the server. </li>
</ol>  

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
For an in-depth explanation of the code, visit: 

<br/>

<center>

  <a href="https://amccully.github.io/MeHungi-2/Explanation.html">https://amccully.github.io/MeHungi-2/Explanation.html</a>

</center>

<center> <h2> Workshop: </h2> </center>

For an overview on our group's techincal workshop, visit:

<center>
 
<a href="https://amccully.github.io/MeHungi-2/Workshop.html">https://amccully.github.io/MeHungi-2/Workshop.html</a>

<center> <h2> Resources: </h2> </center>

<br/>

<br/>

<center> <h2> Meet the Team! </h2> </center>

<style>
* {
  box-sizing: border-box;
}

/* Create two equal columns that floats next to each other */
.column {
  float: left;
  width: 50%;
  padding: 10px;
  height: 300px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>

<div class="row">
  <div class="column" style="background-color;">
    <h2>Eric Shults</h2>
    <p><img src="Pics/GigaChad.jpg" alt="GigaChad"   class="center" height=150></p>
    Backend Python Development
  </div>
  <div class="column" style="background-color;">
    <h2>Aaron McCully</h2>
    <p><img src="Pics/PatrickBateman.jpg" alt="Patrick Bateman"   class="center" height=150></p>
    Frontend Swift Development
  </div>
</div>

