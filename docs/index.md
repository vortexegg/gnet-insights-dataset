# Curating the GNET Insights Dataset

## Introduction

The GNET Insights Dataset is a collection of insight blog posts published by the The Global Network on Extremism and Technology on the [GNET Research blog](https://gnet-research.org). The purpose of this dataset is to provide researchers with a source of data for conducting information studies such as textual  analysis on the publication practices and topical trends within the intersecting fields of technology and terrorism & violent extremism.

The GNET Insights dataset was collected by Scott Johnson by scraping insight posts from the [GNET Research blog](https://gnet-research.org). The original GNET insight articles are solicited, commissioned, edited, and published by The Global Network on Extremism and Technology (GNET), led by the [International Centre for the Study of Radicalisation](https://icsr.info) (ICSR) at the Department of War Studies at King’s College London and backed by the [Global Internet Forum to Counter Terrorism](https://gifct.org) (GIFCT). The contents of each insight post are the original work of the attributed authors.

The purpose of this project is to create a rich dataset of texts, authorship, and publication information that can be used to better understand trends in the research published by GNET. The field of terrorism studies, and particularly the intersection of the study of terrorism and technology platforms, is in need of ongoing library and information studies to assess trends within this research domain. GNET is a rapid research blog that produces topical research on the technology and terrorism landscape from a diverse range of global authors, and is thus ripe for text mining and other data analysis to gain this understanding.

## Dataset

*You introduce the dataset that you either analyzed or created, and you include relevant details from your dataset biography, such that the reader can engage and evaluate your project thoroughly and thoughtfully*

The data and related code for the GNET Insights data set can be found on GitHub at the [gnet-insights-dataset](https://github.com/vortexegg/gnet-insights-dataset) repository. The dataset is itself is compiled in a CSV file [gnet_insights.csv](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insights.csv). The dataset can be accessed by either cloning the repository, or simply downloading the raw CSV file.

### Data dictionary

TBD

### Collection

The dataset was collected by scraping the [GNET Research blog](https://gnet-research.org) using a Python script written with the [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) web scraping library. You can find the website scraping script at [gnet_insight_scraper.ipynb](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insight_scraper.ipynb). The significant choices made in scraping this dataset included:

1. Only including insight posts (GNET also publishes other kinds of resources including full-length reports, research digests, and podcast episodes)
2. Extracting specific metadata about each Insight post from the scrapped web page, including the Insight URL, title, authors, author URLs, publication date, post category, full article text, hyperlinks included in the article text, and post tags.

As mentioned above, the original GNET insights were solicited and published by GNET, and the categories and tags associated with each insight article were applied by GNET at time of original publication.

## Usage

*discuss why the data might be useful and who it might be useful for*

### Background knowledge

While GNET insights are written partially for consumption by the general public, in order to make responsible use of the GNET Insights Dataset it is helpful to have a grounding in the study of terrorism and violent extremism and related topics. Furthermore, collections of data about terrorism, and data about the study of terrorism, should be approached from a critical terrorism studies lens that appreciates that definitions of terrorism and who counts as as a terrorist or extremist group or ideology are 'essentially contested' and embroiled in political questions about the construction of power and the deligitimation of violence. Finally, users of this dataset should be aware that the study of terrorist and extremist subjects can be psychologically and morally challenging to researchers. Analyzing these subjects necessarily involves exposure to hateful narratives and imagery and descriptions or depictions of violence that are associated with racially and ideologically motivated extremist subjects. It is critical to have grounding in appropriate handling of these topics in order to mitigate personal harm and protect researcher safety.

### Use cases

The GNET Insights Dataset and any topical trend analysis of this data can provide potential value for a number of audiences. First and foremost the Global Network on Extremism and Technology, as the publisher and editor of the GNET Research blog, and the Global Internet Forum to Counter Terrorism, as the primary funding body of GNET, would both benefit from being better able to assess the impact of the research insights and make more data-driven decisions about solicitation of various authors and topics for future research (including making sure that diverse and relevant topics are discussed and a diverse authorship is represented). This data set can also be joined with a number of other datasets such as website pageview analytics and other data about authors like their global and institutional locations, which would give a more holistic understanding of the value and impact of the blog.

The second set of beneficiaries of this dataset are terrorism studies researchers themselves. By seeing trends in what topics are being written about, this can help researchers better understand if there are either any topics they are overlooking in their own research, or alternatively if there is a saturation of other researchers already publishing about a particular topic (e.g. the impact of generative AI on extremist propaganda) the researchers can focus on a different area.

Finally, the general readership of the blog, including tech company and government policy decision-makers, would also benefit in seeing a summary of topical and authorship trends just as much as they benefit from the actual research insights themselves. One of the primary goals of GNET is to keep these decision-makers abreast of such tends, so being able to visualize trends at the topical and entity level would provide that much more insight.

## Ethical concerns and limitations

*You discuss possible ethical considerations or concerns with your project, as well as limitations that the reader should keep in mind*

Given that terrorism is a contested category, care will need to be taken to ensure that the research subjects studied within the GNET research insights, and analyzed as topics in the dataset, are presented in an appropriate ethical lens. Similarly, a broader use of this dataset will require engagement with the GNET organization in order to establish appropriate data licensing and reuse considerations.

A key question frequently asked about data and studies of the intersection of technology and terrorism is, "What can this tell us about the prevalence of the problem of terrorism on various digital platforms?" It is critical to note that there is epistemic limitation of the GNET Insights Dataset in that it cannot be used as evidence of the scope of the actual landscape of digital extremism and use of technology by terrorists. Rather, this dataset is evidence of the research practices and subject topics that are being reported on by extremism studies researchers, who have chosen to write about specific topics specifically at the nexus of technology and terrorism. Data analyses regarding, for example, the counts of references to specific extremist groups mentioned in the dataset are not indicative of the prevalence or degree of harms of those specific groups online or offline. Likewise, counts of references to specific technologies or tech platforms are not indicative of the scope of the use of those platforms by terrorists, etc. Rather, such analyses would only demonstrate that these groups or tech platforms happen to be frequently written about by GNET researchers (and which frequency may or may not correlate to the degree of real world harms).

Based on the above points about critical terrorism studies and the epistemic limits of a dataset that is secondary research of academic studies, users of this dataset should apply care in making claims about the underlying terrorist and extremist subjects represented by the GNET insights which are contained in the dataset. It is noted that the GNET Insights Dataset is not an open-source terrorism database nor is it a collection of secondary data about terrorist and extremist subjects, but is rather a set of high-level research reports or summaries produced by extremism researchers in a non-peer-reviewed academic blog. Furthermore, users of this dataset should take care in how they communicate information about the terrorist and violent extremist groups and individuals represented in the GNET insight blog posts, in particular related to privacy and human rights concerns regarding human subjects.

## Findings/Results/Summary

*You include 3 data viz/plots, and you sufficiently introduce and describe them in the blog post. You point out any salient details or overall patterns that the reader/viewer should pay attention to and understand*

### Data cleaning

- Convert nested list-value fields into R vectors for later unnesting. Currently stored as pickled python lists exported to CSV, need to `unnest_longer` to analyze multi-value nested list columns

### 1. Analysis of total insight stats and publication dates 

Get the count of total insights in the dataset
There are 615 total insights
- Get the range of publication dates of the - sights covered by this dataset.
- Latest published insight: 2024-05-09
- Earliest published insight: 2019-12-31
- May 9, 2024 was the date when the dataset - s last update by scraping the GNET website
- Max insights per year: 152
- Median: 130
- Mean: 102.5
- Min: 7
- The outlier years are 2024 and 2019.
- 2024 is the present year which is still - going, so that makes ssense.
- 2019 has only 7 insights, why is that?
- We can see that all 7 insights published in - 19 were published on the same day, December - .
-  Get the number of insights published per - nth.
- Max insights per month: 21
- Median: 12
- Mean: 11
- Min: 3
- We can best see the outliers and trends in monthly publishing with a visualization

![](assets/fig1.png)

### 2. Analysis of authors and author publication counts

- Get the count of distinct authors who have - blished GNET insights
- There are 453 distinct authors in the dataset
- Some insights are co-written by more than - e author. What are the statistics for that?
- Max authors per insight: 6
- Median: 1
- Mean (rounded): 1
- Min: 1
- Some authors have also contributed to - iting more than one insight.
- Max insights per author: 21
- Median: 1
- Mean: 2
- Min: 1
- There is quite a difference between the max - sights per author and the median,
- which makes it sound like there may be a - ng tail of contributors with ony one insight.
- What does this look like?
- Plot the number of insights per author to see the distribution

![](assets/fig2.png)

- As expected there is a long tail of authors - th one insight, and a few more with 2-5 - sights
- before we see a small number of authors with - or more insights, up to 21 for a single - thor.
-  Get the top most contributing authors (6 or - re insights)
- There are 17 authors who have written 6 or - re insights
- Plot these authors along with how many insights they've written


![](assets/fig3.png)

- For the top 10 authors let's see how they've - ntributed various insights over the timespan -  the dataset
- Plot the top insight authors and their insight counts per month over the publication timeline.

![](assets/fig4.png)

- Of interest, we can see that most of the top contributing authors have dropped off from
- writing new insights sometime in 2023 (or in one case, in 2022), while two top authors
- have consistently continued publishing into 2024 (these also happen to be the two
- top contributors of all time).

### 3. Analysis of tags

- Get the count of distinct tags
- There are 87 distinct tags across all insights
- How frequently are individual tags applied to insights?
- Max # of insights associated with a single tag: 197
- Median: 10
- Mean: 18
- Min: 2
- Like with the authors, there is also a large difference between the tag with
- the max number of insights and those with the median number of insights. Let's graph this to see
- what the distribution looks like

![](assets/fig5.png)

- We can see that most tags have ~20 or fewer insights associated with them, while
- a small number of tags have up to hundreds of associated insights
- Investigate the top most used tags (> 20 insights)
- There are 22 tags that have been applied to 21 or more insights
- Plot the top tags most used tags and how many insights they are applied to

![](assets/fig6.png)

- Now let's visualize how the top tags are used on a monthly basis.
- Plot the top tags per month as a stacked area chart to show the relative changes in usage over time
- There are some interesting patterns or regimes shown by this chart.
- From 2019 through 2021 There was a larger focus on 'Social media' and 'Islamic State'
- From 2021 through 2024, there was an increasing focus on 'Far-Right' and, eventually, 'Gender' tags
- Then from 2024, consistently used tags related to Telegram, QAnon fell off, the tag for Gender fell off, and the Far-Right tag decline while Islamic State came back into dominance.

![](assets/fig7.png)

### 4. Analysis of the URLs cited inside the text of each insight

- There are 9403 distinct URLs across cited across all insights
- How frequently are individual urls used?
- Analyze the distribution of how frequently URLs are cited by grouping by URLs.
- Max cited URL count: 23
- Median: 1
- Mean: 1
- Min: 1
- Plotting the distribution of the citation counts of all URLs across the dataset

![](assets/fig8.png)

- We can see that the vast majority the 9000+ URLs are cited only a single time. On the other end
- two URLs are cited over twenty times, a link to a report by RUSE and Brookings: 'Terrorist Definitions and Designations Lists', 
- and a link to Monash University's Global Peace and Security Centre
- It's also interesting to look at what domains have been cited from the most frequently cited URLs.
- Visualize the top most cited domains and counts

![](assets/fig9.png)

### 5. Text analysis to demonstrate what might be done with the textual content of this dataset.

- Plot the top most used words

![](assets/fig10.png)

- Next we evaluate the commonly used bigrams in the insight texts.
- Get the top most used bigrams and their usage counts
- Plot the top most used bigrams and their counts

![](assets/fig11.png)

- Analyze trends in how the top most used bigrams have changed each year.
- Plot the top used bigrams for each year

![](assets/fig12.png)

*You zoom in and discuss a specific example or data point from your dataset to illustrate a point or support your findings/results (a specific movie, book, song, NBA player, etc.)*

### 6. Drill into a specific example, by comparing the most frequently occurring bigrams for some of the top tags to see how they differ from each other.

- four top tags related to different groups or ideologies in the tags list:
- Far-Right, Islamic State, Incel, and QAnon.
- Compute bigrams for insights, removing stopwords as before
- Based on experimentation, remove several bigrams that occur frequently across all tags
- Get the top bigrams and their counts for each of the 4 groups' tags.
- Plot the tag bigram counts, faceted by tag.

![](assets/fig13.png)

- Additionally we will show the titles of the most recent insights for these four tags
- Use the gt library to visualize a table showing the insight titles from the different tags

![](assets/fig14.png)

## Future Work

*You address a possible direction for future work. If you had more time and resources, where would you go next with this project?*

**What additional types of data or analyses**

- Demographic and geographic data about authors
- Named entity recognition text analysis
- Analysis of geographic areas, groups, ideologies, technologies discussed

One key challenge that may need to be addressed in order for this dataset to be used more broadly relates to data permissions and re-publication. Despite the GNET website and blog posts being publicly available, I have not obtained explicit permission to scrape and download the full blog data, analyze, or publish on it. GNET does not have any statements about data reuse or licensing on their website that would clarify what is implicitly permitted. Similarly, I have not obtained permission or consent from the individual authors. It is unclear to me whether this type of permission and consent is necessary to obtain as part of conducting bibliometric research on published works. Assuming the permission challenge can be resolved, second related challenge involves identifying a suitable way to host the data in an accessible location online (e.g. in a GitHub repository?) and establishing a sustainable process for extracting new blog posts to add to the dataset as they are published.

I think both of these challenge are within the realm of possibility to be solved through my existing personal and professional relationships within the terrorism studies community and with staff at GNET itself. The first problem could be addressed through discussing with GNET and GIFCT about establishing an agreement for this dataset to be curated and hosted going forward, and if necessary establishing appropriate data licensing and reuse documentation. The second problem of creating a sustainable process for collecting data could potentially be addressed through a technical data sharing project with GNET that involves them sending requisite metadata fields and article text to the dataset owner (or potentially adding the data themselves if the dataset is hosted in an open-source repository).

# Cut content

Test content

![](assets/insights_per_month.png "insights per month")


Solarized dark             |  Solarized Ocean
:-------------------------:|:-------------------------:
![](assets/insights_per_month.png "insights per month")  |  ![](assets/insights_per_month.png "insights per month")


*GNET was funded by GIFCT as an academic research initiative at the intersection of technology and counterterrorism/countering violent extremism. GIFCT leads a cross-sectoral, multistakeholder collaboration to marshal the collective creativity of society to tackle issues related to online extremism and exploitation of digital platforms by terrorists. GNET pulls together topical research from new and established researchers in the extremism studies field in the form of rapid brief insights that are primarily targeted at informing trust & safety professionals and policy-makers at tech companies, governments, and civil society, as well as for other extremism studies researchers and the general public. The GNET Insights Dataset project was conceived as a means of providing researchers with a dataset for conducting information science and bibliometric research about the research topics that are published within this niche intersection of technology and counterterrorism.*

*Besides constructing and curating this dataset, this project aims to engage in presenting summary statistics about authorship and blog tag usage over time, as well as to engage in text mining techniques to identify trends in topics and named entities that occur within the research insights. This dataset and accompanying topical analysis will prove useful both to the publishers and funders of the GNET research blog, as well as the broader community of terrorism studies researchers and the general audience of the blog.*