## Global Superstore Demo Project
This project was designed as a part of a Case Study in applying process for Data Engineer role in Daniel Wellington company. 
<br />
The purpose of this process is to take a production like source from a sales system and turn it into a data warehouse schema for reporting. 
### Legend
The fictious company Global Superstore is an e-commerce seller of office supplies and equipment, they have sales staff who are responsible for geographical regions and must consider customer returns.
<br />
<a href="https://drive.google.com/drive/folders/1rjurPuqOjcsdTEdqKRbqZjr-dwXk7ml9" target="_blank">Source Dataset</a></p>
<br />
<br />
For this demo project were chosen 3 modern cloud tools:
+ **Google Big Query** - as a Data Warehouse
+ **dbt** - as a data modeling and documentation tool
+ **GitHub** - as a project code rerository and presentation tool
### First steps
First my step was a data exploration.<br />
I decided to start with thinking about the structure of Data Storage layer to avoid issues and rework in the Case Study process.
<br />
<br />
As a result I've got next ER diagram:
![plot](https://live.staticflickr.com/65535/52016172643_6a2be1ea85_b.jpg)
Yes, it isn't a classical 3NF form and it looks a bit debatable, but I decided stick with this structure as a compromise between strong modeling rules and final usability.
<br />
<br />
Next my step was a Data Base initializing and creating of layers and tables in my Warehouse.<br />
<a href="https://github.com/d-step-co/global_superstore/blob/main/Init/first_steps.sql" target="_blank">SQL code you could find here</a></p>
<br />
### Result
As a result of data modeling and data transformation process I've got next dataflow:
<br />
<br />
![plot](https://live.staticflickr.com/65535/52018462050_504f19b6b2_b.jpg)
In my opinion, this is a clean and understandable process.
<br />
Here is 3 clearly steps:
+ Collecting all of the data in a temporary table
+ Creating Data Storage layer
+ Creating Data Marts layer

It is noteworthy that with this approach, we can load "facts" and "dimensions" tables at the same time.
<br />
<br />
As a result we have next Data Warehouse structure:

![plot](https://live.staticflickr.com/65535/52017982953_3d7c2e5666_c.jpg)
