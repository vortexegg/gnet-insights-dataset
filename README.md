# GNET Insights Dataset

### Who collected the data?

The GNET Insights dataset was collected by Scott Johnson based on scraping blog posts from the [GNET Research blog](https://gnet-research.org).  The original GNET insight articles are solicited, commissioned, edited, and published by The Global Network on Extremism and Technology (GNET), led by the International Centre for the Study of Radicalisation (ICSR) at the Department of War Studies at King’s College London and backed by the Global Internet Forum to Counter Terrorism (GIFCT). The contents of each insight post are the original work of the attributed authors.

### Where can the data be found?

The data and related code for the GNET Insights data set can be found at the [gnet-insights-dataset](https://github.com/vortexegg/gnet-insights-dataset) Github repository. The dataset is itself is compiled in the CSV file [gnet_insights.csv](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insights.csv). You can access the dataset by either cloning the repository, or simply downloading the raw gnet_insights.csv file.

### How was the data collected?

The dataset was collected by scraping the [GNET Research blog](https://gnet-research.org) using a Python script written with the [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) web scraping library. You can find the website scraping script at [gnet_insight_scraper.ipynb](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insight_scraper.ipynb). The significant choices made in scraping this dataset included:

1. Only including insight posts (GNET also publishes other kinds of resources including full-length reports, research digests, and podcast episodes)
2. Extracting specific metadata about each Insight post from the scrapped web page, including the Insight URL, title, authors, author URLs, publication date, post category, full article text, hyperlinks included in the article text, and post tags.

As mentioned above, the original GNET insights were solicited and published by GNET, and the categories and tags associated with each insight article were applied by GNET at time of original publication.

## Running the scraper

## Data analysis

## Blog post

## About this project
