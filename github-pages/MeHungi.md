
<style>
      body {
         background-color: "black";
      }
   </style>

<center> <h1> <b> ECE 196 Project </b> </h1> </center>

<center> <h2> General Problem / Project Description </h2> </center>
<br/>

In short, lines suck. Sometimes you just don't have enough time to spare and have to choose the quickest option regardless of personal preference. In the case of restaurants, often you won't know how long you will have to wait until you actually arrive. 

UCSD has attempted to remedy this by the implentation of Triton2Go, but practically any student who has used it can tell you the innacurracy of the service. We hope to present a solution that takes the frustration out of getting your meals.

<p align="center">
<img src="Pics/LongLine.jpg" alt="Long Line"   class="center">
</p>

<center>For more info on the project, visit presentation link:

<a href="https://docs.google.com/presentation/d/10Bnua0HaenmpBti1LrT5zPJ5bk7b7kJZLeNU3m_6Ngo/edit?usp=sharing"> https://docs.google.com/presentation/d/10Bnua0HaenmpBti1LrT5zPJ5bk7b7kJZLeNU3m_6Ngo/edit?usp=sharing</a>.

</center>
<br/>
<center> <h2> App-Server-Terminal Relationship </h2> </center>
<br>

To implement our solution, we need to create three different parts:


<ol>
  <li>
    <b>App:</b> Displays the wait times of and map to different restaurants in the UCSD area. 
  </li>
  <li>
    <b>Server:</b> Store restaurant info and calculate changing wait times as new data comes in.
  </li>
  <li>
    <b>Psuedo-Cash Register:</b> Interface for viewing and deleting food orders from the server. 
  </li>
</ol>  

The App will have to request wait time and restaurant data from the server using RESTful API requests. The Register will have to modify data in the server by supplying wait times at specific times so the server can process and update the data.

<p align="center">
<img src="Pics/Server-Client.png" alt="Server-Client"   class="center">
</p>
 
<br/>
<br/>

<center> <h2> Video: </h2> </center>

<center> <video width="800" height="480" controls>
  <source src="ECE196Project.mp4" type="video/mp4">
</video> </center>



<br/>
<br/>

<center> <h2> Explanation: </h2> </center>
For an in-depth explanation of the code, visit: 

<br/>

<center>

  <a href="https://amccully.github.io/MeHungi-2/github-pages/Explanation.html">https://amccully.github.io/MeHungi-2/Explanation.html</a>

</center>

<center> <h2> Workshop: </h2> </center>

For an overview on our group's techincal workshop, visit:

<center>
 
<a href="https://amccully.github.io/MeHungi-2/github-pages/Workshop.html">https://amccully.github.io/MeHungi-2/github-pages/Workshop.html</a>

</center>

<center> <h2> Resources: </h2> </center>

<br/>
<ol>
  <li>
    "Hacking With Swift" has been an incredibly useful  resource throughout this entire project. Reading the Swift documentation is lengthy and not full of enough examples to properly understand the language, so "Hacking with Swift" has been a great help.
  </li>
  <li>
    <a href="https://www.youtube.com/watch?v=GMppyAPbLYk&t=11s"> This</a> "Tech with Tim" video has helped greatly with the basics of setting up Flask and creating server endpoints. GET, POST, PUT, and DELETE requests are explained well and thoroughly throughout the entire video. He also provides a way of testing ones own server locally, which was great for debugging. 
  </li>
  <li>
    <a href="https://www.youtube.com/watch?v=iBeOvmt-tR0"> This </a> video was a massive help in porting the local server we coded to a third party cloud computing service. Instead of needing to spend several hours completing an AWS certification to understand how to fully instantiate a server on their machines, this video suggested using Amazon Elastic Beanstalk which allowed for full upload with only one zip file.
  </li>
  <li>
  <a href="https://www.youtube.com/watch?v=3CC4N4z3GJc"> This </a>Statquest video along with all the videos that led up to it were the main way we were able to understand the Gradient Boosting algorithm. It was probably around 5 hours worth of content to mostly understand this topic, but everything was presented with great visuals and was well-spoken. There were other resources that helped more with Python setup and sci-kit learn specifics, but as far as conceptual undersanding, this was great.
  </li>
</ol>
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
    <p><img src="Pics/Gigachad.jpg" alt="Gigachad"   class="center" height=150></p>
    <center>Backend Python Development </center>
  </div>
  <div class="column" style="background-color;">
    <h2>Aaron McCully</h2>
    <p><img src="Pics/PatrickBateman.jpg" alt="Patrick Bateman"   class="center" height=150></p>
    <center> Frontend Swift Development </center>
  </div>
</div>

