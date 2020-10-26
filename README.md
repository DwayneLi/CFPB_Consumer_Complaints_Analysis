# CFPB_Consumer_Complaints_Analysis
###  ---- RPI 2020 Datathon Competition

The final report included data analysis and the legislation proposal is shown in the file list or you can [**click**](https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/raw/master/CFPB_Complaints_Final_Report%20Team7.pdf) for final report.

1. Data discription:

    1548394 records x 18 features

2. features:


Features                 |         |  |
|:----------------------:|:----------------------:|:--------------------------:|
| Product                |  Company               | State                      |
| Sub-product            |    Company public response   |   Zipcode            |
| Issue                  | Date received          |Tags                        |
| Sub Issue              |  Complaint ID          | Consumer consent provided? |
| Consumer complaint narrative|  Submitted via    | Date sent to company       |
| Company response to consumer|  Timely responese?| Consumer disputed?         |


3. Data clean
CFPB updated its product and issue list on 2017 and the raw data contains the classification of products and issues before 2017 and after 2017. So we merge the complaints that actually belong to the same category. We also extract the year and month of complaints for the next step analysis.

4. Data Visualization
We combined several dimensions when we explore the data. Following is a screenshot of our visualizfation which from the final report
![Viz of Data](https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/blob/master/Viz%20in%20report.png?raw=true)

5. We focused on credit reporting and debt collection and made legislation proposals based on analysis on them.

6. As for the narrative complaints we applied LDA model to find what people complaint most. Besides, we use the Top2Vec package extract topic under without assign the model number at first. You can download and open the visualization of topics in [here](https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/blob/master/ldavis_prepared_5.html)

![Viz of Data](https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/blob/master/topic_words.png?raw=true)
![Viz of Data](https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/blob/master/Topic_viz.png?raw=true)

Following is the top 4 topics finded by Top2Vec without assign topic number manually and word cloud created by these topics.

<img src="https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/blob/master/topic01.png" width="650" height="400" />

<img src="https://github.com/DwayneLi/CFPB_Consumer_Complaints_Analysis/blob/master/topic23.png" width="650" height="400" />
