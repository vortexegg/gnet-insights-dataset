# GNET Insights Dataset

## Blog post

You can find a blog post describing this dataset and analyzing its key features [here](https://vortexegg.github.io/gnet-insights-dataset/).

## Dataset biography

### Introduction

The GNET Insights Dataset is a collection of the Insight blog posts published on The Global Network on Extremism and Technology's [GNET Research blog](https://gnet-research.org). The purpose of this dataset is to provide researchers with a source of data for conducting bibliometric and information studies data research about publication practices within the intersecting fields of the study of technology, and terrorism and violent extremism.

### Who collected the data?

The GNET Insights dataset was collected by Scott Johnson based on scraping blog posts from the [GNET Research blog](https://gnet-research.org).  The original GNET insight articles are solicited, commissioned, edited, and published by The Global Network on Extremism and Technology (GNET), led by the [International Centre for the Study of Radicalisation](https://icsr.info) (ICSR) at the Department of War Studies at King’s College London and backed by the [Global Internet Forum to Counter Terrorism](https://gifct.org) (GIFCT). The contents of each insight post are the original work of the attributed authors.

### Where can the data be found?

The data and related code for the GNET Insights data set can be found at the [gnet-insights-dataset](https://github.com/vortexegg/gnet-insights-dataset) GitHub repository. The dataset is itself compiled in the CSV file [gnet_insights.csv](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insights.csv). You can access the dataset by either cloning the repository, or simply downloading the raw CSV file.

### How was the data collected?

The dataset was collected by scraping the [GNET Research blog](https://gnet-research.org) using a Python script written with the [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) web scraping library. You can find the website scraping script at [gnet_insight_scraper.ipynb](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insight_scraper.ipynb). The significant choices made in scraping this dataset included:

1. Only including insight posts (GNET also publishes other kinds of resources including full-length reports, research digests, and podcast episodes)
2. Extracting specific metadata about each Insight post from the scrapped web page, including the Insight URL, title, authors, author URLs, publication date, post category, full article text, hyperlinks included in the article text, and post tags.

As mentioned above, the original GNET insights were solicited and published by GNET, and the categories and tags associated with each insight article were applied by GNET at the time of original publication.

### What is the social and historical context of the data?

GNET was funded by GIFCT as an academic research initiative at the intersection of technology and counterterrorism/countering violent extremism. GIFCT leads a cross-sectoral, multistakeholder collaboration to marshal the collective creativity of society to tackle issues related to online extremism and the exploitation of digital platforms by terrorists. GNET pulls together topical research from new and established researchers in the extremism studies field in the form of rapid brief insights that are primarily targeted at informing trust & safety professionals and policy-makers at tech companies, governments, and civil society, as well as for other extremism studies researchers and the general public. The GNET Insights Dataset project was conceived as a means of providing researchers with a dataset for conducting information science and bibliometric research about the research topics that are published within this niche intersection of technology and counterterrorism.

### What background information or domain knowledge is necessary to use this data responsibly?

While GNET insights are written partially for consumption by the general public, in order to make responsible use of the GNET Insights Dataset it is helpful to have a grounding in the study of terrorism and violent extremism and related topics. Furthermore, collections of data about terrorism, and data about the study of terrorism, should be approached from a critical terrorism studies lens that appreciates that definitions of terrorism and who counts as a terrorist or extremist group or ideology are 'essentially contested' and embroiled in political questions about the construction of power and the deligitimation of violence. Finally, users of this dataset should be aware that the study of terrorist and extremist subjects can be psychologically and morally challenging to researchers. Analyzing these subjects necessarily involves exposure to hateful narratives and imagery and descriptions or depictions of violence that are associated with racially and ideologically motivated extremist subjects. It is critical to have a grounding in the appropriate handling of these topics in order to mitigate personal harm and protect researcher safety.

### What are the limitations or problems with the data?

A key question frequently asked about data and studies of the intersection of technology and terrorism is, "What can this tell us about the prevalence of the problem of terrorism on various digital platforms?" It is critical to note that there is an epistemic limitation of the GNET Insights Dataset in that it cannot be used as evidence of the scope of the actual landscape of digital extremism and the use of technology by terrorists. Rather, this dataset is evidence of the research practices and subject topics that are being reported on by extremism studies researchers, who have chosen to write about specific topics specifically at the nexus of technology and terrorism. Data analyses regarding, for example, the counts of references to specific extremist groups mentioned in the dataset are not indicative of the prevalence or degree of harm of those specific groups online or offline. Likewise, counts of references to specific technologies or tech platforms are not indicative of the scope of the use of those platforms by terrorists, etc. Rather, such analyses would only demonstrate that these groups or tech platforms happen to be frequently written about by GNET researchers (and which frequency may or may not correlate to the degree of real-world harms).

### What ethical considerations must be kept in mind when using this data?

Based on the above points about critical terrorism studies and the epistemic limits of a dataset that is secondary research of academic studies, users of this dataset should apply care in making claims about the underlying terrorist and extremist subjects represented by the GNET insights which are contained in the dataset. It is noted that the GNET Insights Dataset is not an open-source terrorism database nor is it a collection of secondary data about terrorist and extremist subjects, but is rather a set of high-level research reports or summaries produced by extremism researchers in a non-peer-reviewed academic blog. Furthermore, users of this dataset should take care in how they communicate information about the terrorist and violent extremist groups and individuals represented in the GNET insight blog posts, in particular, related to privacy and human rights concerns regarding human subjects.

### What other information is essential to understanding and working with this data?

**Versioning**: This dataset was last collected on May 17, 2024. GNET is a research blog that regularly produces new insight blog posts. The creator and curator of this dataset has not yet instituted a plan, process, or schedule by which the dataset hosted at this repository will be updated with the latest published insights. At the present moment, users of the dataset will be able to produce their own updated copy of the data by running the [gnet_insight_scraper.ipynb](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insight_scraper.ipynb) script.

**Licensing**: the GNET Insights Dataset currently exists in an ***unlicensed*** state. The original GNET insights are copyrighted to GNET, and the ownership of the insight posts is retained by the original authors. Use of this dataset does not confer any rights over this material.
