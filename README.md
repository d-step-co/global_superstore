## Global Superstore Demo Project
This project was designed as a part of a case study in applying process for Data Engineer role. 
<br />
The purpose of this process is to take a production like source from a sales system and turn it into a data warehouse schema for reporting. 
### Legend
The fictious company Global Superstore is an e-commerce seller of office supplies and equipment, they have sales staff who are responsible for geographical regions and must consider customer returns.
<br />
+ <a href="https://drive.google.com/drive/folders/1rjurPuqOjcsdTEdqKRbqZjr-dwXk7ml9" target="_blank">Source Dataset</a></p>
For this demo project were chosen 3 modern cloud tools:
+ **Google Big Query** - as a data warehouse
+ **dbt Cloud** - as a data modeling and documentation tool
+ **GitHub** - as a project code rerository and presentation tool
### First steps
First my step was a data exploration.<br />
I decided to start with thinking about the structure of data storage layer to avoid issues and rework in the case study process.
<br />
<br />
As a result I've got next ER diagram:
![plot](https://live.staticflickr.com/65535/52016172643_6a2be1ea85_b.jpg)
Yes, it isn't a classical 3NF form and it looks a bit debatable, but I decided stick with this structure as a compromise between strong modeling rules and final usability.

<br />
In the process of shema designing I kept in mine two general aspects:

+ avoid many-to-many relationships
+ don't make dimensional tables just because it says so in the books

<br />
Next my step was a data base initializing and creating of layers and tables in my warehouse.<br />
<a href="https://github.com/d-step-co/global_superstore/blob/main/Init/first_steps.sql" target="_blank">SQL code you could find here</a></p>
Next, I proceeded to the data modeling process.
<br />
You can find all the transformation logic and SQL queries in this repository in the <a href="https://github.com/d-step-co/global_superstore/tree/main/models" target="_blank">models</a> folder.
<br />
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
+ Creating data storage layer
+ Creating data marts layer

It is noteworthy that with this approach, we can load "facts" and "dimensions" tables at the same time.

<br />

In the current implementation data marts layer materialized as view.
<br />
This allows to have access to up-to-date aggregated data at any time.

<br />
<br />

As a result we have next data warehouse structure:

![plot](https://live.staticflickr.com/65535/52017982953_3d7c2e5666_c.jpg)


### Conclusion
This Demo project already done to implement in production.
<br />
If you work as a team you need just two things:
+ chose and enable team plan for **dbt**
+ enable bealing for your **Big Query** account

That's all what you need.

<br />

Job scheduling and data testing for unique keys and for not null key values already available for this project.
<br />

![plot](https://live.staticflickr.com/65535/52017137252_897619c670_o.png)

<br />
If you would like to have access to real data in BigQuery or discuss this demo project, just let me know by email: <p><a href="mailto:d.step.co@gmail.com">d.step.co@gmail.com</a></p>
