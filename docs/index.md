# Curating the GNET Insights Dataset

**Author**: Scott Johnson
**Published**: June 1, 2024

## I. Introduction

The [GNET Insights Dataset](https://github.com/vortexegg/gnet-insights-dataset) is a collection of insight blog posts published by the Global Network on Extremism and Technology on the [GNET Research blog](https://gnet-research.org). The purpose of this dataset is to provide researchers with a source of data for conducting information studies such as textual analysis on the publication practices and topical trends within the intersecting fields of technology and terrorism & violent extremism.

The GNET Insights dataset was collected by [Scott Johnson](https://github.com/vortexegg) by scraping insight posts from the [GNET Research blog](https://gnet-research.org). The original GNET insight articles are solicited, commissioned, edited, and published by The Global Network on Extremism and Technology (GNET), led by the [International Centre for the Study of Radicalisation](https://icsr.info) (ICSR) at the Department of War Studies at King’s College London and backed by the [Global Internet Forum to Counter Terrorism](https://gifct.org) (GIFCT). The contents of each insight post are the original work of the attributed authors.

The purpose of this project is to create a rich dataset of texts, authorship, and publication information that can be used to better understand trends in the research published by GNET. The field of terrorism studies, and particularly the intersection of the study of terrorism and technology platforms, is in need of ongoing library and information studies to assess trends within this research domain. GNET is a rapid research blog that produces topical research on the technology and terrorism landscape from a diverse range of global authors and is thus ripe for text mining and other data analysis to gain this understanding.

## II. About the dataset

The data and related code for the GNET Insights dataset can be found on the [gnet-insights-dataset](https://github.com/vortexegg/gnet-insights-dataset) GitHub repository. The dataset itself is compiled in a [CSV file](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insights.csv). The dataset can be accessed by either cloning the repository or simply downloading the raw CSV file.

### Data dictionary

The GNET insights dataset includes the following fields:

| field name     | data type         | description                                                                                                                                                                                                          |
| -------------- | ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `insight_url`  | text              | The original URL of the insight post on [gnet-research.org](https://gnet-research.org). Serves as a canonical identifier for the post.                                                                               |
| `title`        | text              | The title of the insight post.                                                                                                                                                                                       |
| `author_names` | list-value (text) | A list of one or more names of the authors who contributed to writing the insight post.                                                                                                                              |
| `author_urls`  | list-value (text) | A list of one or more URLs to an author page on [gnet-research.org](https://gnet-research.org) showing other insights written by the same author. Should correspond 1:1 with `author_names`.                         |
| `pub_date`     | date              | The publication date of the insight, in `YYYY-MM-DD` format.                                                                                                                                                         |
| `categories`   | list-value (text) | A list of one or more post categories under which the insight is classified on [gnet-research.org](https://gnet-research.org). With few exceptions, this is typically just the category "Insights".                  |
| `insight_text` | text              | The full text of the insight post in plain text format, stripped of the original HTML formatting. Hyperlinks in the original post text have been removed, leaving only the text contained within the anchor element. |
| `insight_urls` | list-value (text) | A list of zero or more URLs that were cited as hyperlinks in the body of the original post text.                                                                                                                     |
| `tags`         | list-value (text) | A list of zero or more descriptive tags that were applied to the insight post.                                                                                                                                       |

All list-value fields are constructed using the following syntax: `"['value one', 'value two',...]"`

### Data cleaning

Due to the formatting of the list-value fields, data cleaning may be necessary to process these fields before they can be used in data analysis.

In particular, for use in the R programming language, it is recommended to convert list-value fields into R vectors, by stripping the enclosing brackets and single quotes and splitting the string into a vector. This is useful for converting the data into a [tidy data format](https://tidyr.tidyverse.org/articles/tidy-data.html) for use with [tidyverse](https://www.tidyverse.org) R packages, which stipulates: "3. Each value is a cell; each cell is a single value." Vectorized list-value fields can be converted into a tidy data format by using the [tidyr](https://tidyr.tidyverse.org) package's `unnest_longer` function.

For Python, the list-value fields are already stored in a format compatible with deserialization using the Python pickle module.

### Data collection

This dataset was collected by scraping the [GNET Research blog](https://gnet-research.org) using a Python script written with the [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) web scraping library. The scraping script is located at [gnet_insight_scraper.ipynb](https://github.com/vortexegg/gnet-insights-dataset/blob/main/gnet_insight_scraper.ipynb). The significant choices made in scraping this dataset include:

1. Only including insight posts (GNET publishes other kinds of resources including full-length reports, research digests, etc.).
2. Extracting specific metadata about each insight post from the scrapped web page, which forms the metadata elements listed in the data dictionary (see above).

## III. Expected usage

The main use case envisioned for the GNET Insights Dataset is for various communities to conduct topic and publication trend analysis of public research at the intersection of technology and terrorism & violent extremism.

This dataset may be of primary use to GNET itself, as the publisher and editor of the GNET Research blog, and for GNET's funders, GIFCT. These organizations can use the dataset to assess and adjust ongoing trends in the publication of insights, make changes in editorial decisions and solicitation of posts, and join this dataset together with other data such as web page view analytics to gain a better understanding of readership interests. A second important set of users are extremism studies researchers (who make up the primary authorship of the blog) as well as practitioners such as trust & safety professionals who are working on applying these insights to inform their day-to-day work. This dataset could help them keep abreast of important and emerging trends, and to both adjust their plans for what topics to write about or for what under-covered research topics should be requested through GIFCT. Finally, the general readership of GNET, which includes tech company and government policy-makers as well as civil society, would also benefit from seeing summary trends and having the ability to visualize and orient themselves within the overall topical landscape of technology and terrorism & violent extremism.

While GNET insights are written in part for a general audience, and this dataset can be utilized for gaining a general topical orientation, any users of this dataset will be well-served by possessing general knowledge and grounding in the study of terrorism and violent extremism. In particular, it is recommended to approach this data from a critical terrorism studies lens that understands the critical questions of power and ethics behind the essentially contested concepts and definitions of "terrorism" and "extremism", which are necessarily embroiled in political questions about the construction of power and the delegitimation of violence. Before engaging with this data it is crucial to understand that analyzing topics related to these subjects involves exposure to hateful narratives and depictions of racially and ethnically motivated violence. Users should take appropriate [researcher safety precautions](https://voxpol.eu/wp-content/uploads/2024/01/Online-Extremism-and-Terrorism-Researchers-Security-Safety-Resilience.pdf) before and during engaging with this challenging subject matter.

## IV. Dataset summary analysis and examples

The following computational analysis is meant to give an overview of major patterns within the GNET insights dataset and to provide examples of how text analysis might be used to understand topical trends in GNET insights. The analyses performed cover overall statistics about insight publishing and publication dates, authorship and author publication trends, insight tags and tag trends, as well as a demonstration of using text analysis for evaluating frequently used keywords and bigrams, and an illustrative example of comparing topics across tags and within particular insights.

The R script used to conduct the computational analysis can be [found here](https://github.com/vortexegg/gnet-insights-dataset/blob/main/analyze_gnet.R).

### Overall insight stats and publication dates 

The dataset contains a total of 615 insight posts. These posts cover a range of publication dates from December 31st, 2019 to May 5th, 2024. This end date is the date when the dataset was last updated by scraping the GNET Research website.

***Summary statistics: Insights published per year***

| Max | Median | Mean  | Min |
| --- | ------ | ----- | --- |
| 152 | 130    | 102.5 | 7   |

The discrepancy between the median and minimum number of insights per year is due to there only being seven insights published in 2019, all on December 31st (2024 also has fewer than average insights but this year is still ongoing).

***Summary statistics: Insights published per month***

| Max | Median | Mean | Min |
| --- | ------ | ---- | --- |
| 21  | 12     | 11   | 3   |

Trends in the number of insights published each month are best represented through a visualization. As can be seen, there is a wide variability in the rate of publication from month to month, with extended periods of high and low rates of publication.

![](assets/fig1.png "Insights published each month")
*Fig. 1: Insights published each month*

### Authors and author publication trends

The dataset contains insights that have been published by 453 different authors.

***Summary statistics: Contributions by multiple authors per insight***

| Max | Median | Mean | Min |
| --- | ------ | ---- | --- |
| 6   | 1      | 1    | 1   |

While some insights have multiple authors who all contributed to writing the insight, on average insights are typically written by a single author.

***Summary statistics: Multiple insights per author***

| Max | Median | Mean | Min |
| --- | ------ | ---- | --- |
| 21  | 1      | 2    | 1   |

Conversely, several authors have written or contributed to more than one insight. We see that the maximum number of insights for a single author is twenty-one, while the average is between 1-2 insights. The discrepancy between these stats implies that there is a long tail of single-insight contributors. Visualizing this distribution, we can see that the majority of authors have contributed only a single insight, several more authors have contributed between two to five insights, and a small number of authors have contributed six or more insights.

![](assets/fig2.png "Distribution of insights per author")
*Fig. 2: Distribution of insights per author*

There are seventeen authors who have contributed to six or more insights. Here we can see the top contributing authors and the number of insights per author:

![](assets/fig3.png "Insights by top contributing authors")
*Fig. 3: Insights by top contributing authors*

For the top ten authors, we can visualize trends in how they have contributed insights over GNET's publication timespan. Of interest, we can see that the top contributing authors have all had runs of consistent publications that each drop off after a certain point. Notably, most top authors have dropped off from writing sometime in 2023, while two top authors have continued consistently publishing into 2024 (these also happen to be the two top contributors of all time).

![](assets/fig4.png "Insights by top contributing authors over time")
*Fig. 4: Insights by top contributing authors over time*

### Insight tags and tag trends

The dataset contains insights that have been applied with a mix of 87 different tags.

***Summary statistics: Insights per tag***

| Max | Median | Mean | Min |
| --- | ------ | ---- | --- |
| 197 | 10     | 18   | 2   |

As with the authors, there is a wide discrepancy between the maximum and median number of tags, implying a long tail of insights with only a small number of tags. Visualizing the distribution of insights per tag, we can see that most tags have been applied to approximately twenty or fewer insights. A small number of tags have been applied to anywhere between twenty-one to several hundred insights.

![](assets/fig5.png "Distribution of insights per tag")
*Fig. 5: Distribution of insights per tag*

There are twenty-two tags that have been applied to twenty-one or more insights. Here we can see the top tags and the number of insights they have been applied to. The most frequently applied tags are "Far-Right", "Social Media", "Islamic State", "Propaganda", and "Radicalisation". This combination of tags lends a key insight into the nature of the problem of digital extremism as it is carried out on social media platforms (or at least, what GNET insight authors choose to publish about it).

![](assets/fig6.png "Top tags applied to GNET insights")
*Fig. 6: Top tags applied to GNET insights*

For the top ten tags, we can visualize trends in how these tags have been applied to insights over GNET's publication timespan. There are a few interesting patterns revealed by this plot. From 2019 to 2021 there was a larger relative focus on insights tagged with "Social Media" and "Islamic State". This changes substantially in early 2021, leading to an increasing focus on "Far-Right" insights and, eventually, insights about "Gender"-related issues of extremism. Then in early 2024, there is another shift. Tags that were consistently used from 2021 entirely fall off, including "Gender", "Telegram", and "QAnon", while the "Far-Right" tag drastically shrinks while "Islamic State" comes back into prominence.

![](assets/fig7.png "Top tags applied to GNET insights by month and year")
*Fig. 7: Top tags applied to GNET insights by month and year*

### Demonstration of text analysis for topical trends

Apart from summary statistics, this section demonstrates the value of one of the key uses of the GNET Insights Dataset—the application of text analysis techniques to insight post texts to understand trends in topics, mentioned keywords, etc. This demonstration only scratches the surface of what is possible, by visualizing the most frequently used words and bigrams in the text corpus, as well as trends in how the most frequently used bigrams have changed over time.

Here we see a plot of the top most used words in the GNET insight texts and their frequency of use:

![](assets/fig10.png "Top most used words in GNET insights")
*Fig. 10: Top most used words in GNET insights*

While this is interesting, visualizing the top most used bigrams is much more revealing of the general topics discussed throughout the GNET insight texts. The two most used bigrams, "far right" and "social media", followed by "islamic state" and "right wing", are indeed reflective of the overall GNET Research blog and also align with the most commonly used tags. But we also see other important concepts that contextualize topics at the intersection of technology and terrorism, such as "covid 19" (a major driver of extremist conspiracy narratives), or "tech companies" and "content moderation" (a primary site for responding to the harms of online extremism).

![](assets/fig11.png "Top most used bigrams in GNET insights")
*Fig. 11: Top most used bigrams in GNET insights*

Visualizing changes in the most frequent bigrams year-over-year also reveals interesting changes in the research landscape. For example, in 2019, a frequently used bigram is "iron march", referring to a now-defunct neo-nazi web forum (and thus less topically relevant today). On the other hand, at the bottom of 2024, we see the bigram "gaming spaces", which reflects an emerging focus in the collective response to online extremism focusing on the exploitation of gaming platforms by extremist actors.

![](assets/fig12.png "Top bigrams in GNET insights, compared by year")
*Fig. 12: Top bigrams in GNET insights, compared by year*

### Example comparing topics across tags and within particular insights

To provide a further example, we can compare the most frequently used bigrams across specific tags. In particular, the top tags include several tags related to various extremist or terrorist groups or ideologies: Far-Right, Islamic State, Incel, and QAnon. Here we visualize the most frequently used bigrams within the set of insights tagged with each of these four movements, to give a comparison of how they are discussed. Of note, both Far-Right and QAnon tagged insights make frequent discussion of conspiracy theories, though the Far-Right tag focuses on white supremacism and neo-nazis, while QAnon focuses instead on the "deep state" and Donald Trump. In contrast, the Islamic State tag discusses various jihadist groups and IS supporters, while the Incel tag discusses issues of male supremacism, online forums, and mass violence.

![](assets/fig13.png "Top bigrams in GNET insights across group or ideology tags")
*Fig. 13: Top bigrams in GNET insights across group or ideology tags*

It is also illustrative to compare these frequent bigrams to example titles of insight articles associated with each tag. Here we can see the most recent four articles from each tag, which gives further color into the nature of these topics.

![](assets/fig14.png "Recent insight titles for top groups or ideology tags")
*Fig. 14: Recent insight titles for top groups or ideology tags*

Zooming further into one particular article, [Preparing for the Boogaloo: How Far-Right Communities Rallied on Discord for the Unite the Right Rally](https://gnet-research.org/2024/03/25/preparing-for-the-boogaloo-how-far-right-communities-rallied-on-discord-for-the-unite-the-right-rally/) from March 25, 2024, we see this article is tagged with the common "Far-Right" and "Social Media" tags, as well as the tag "Boogaloo" (a far-right term). This article discusses how far-right, alt-right, and white nationalist/white supremacist groups used the social media and gaming adjacent platform, Discord, to plan the _Unite the Right_ rally in Charlottesville in 2017, as well as to network with other neo-nazi groups and disseminate far-right conspiracy theory narratives. Comparing this article to the top bigrams for the "Far-Right" tag (fig. 13) we see that all of these concepts are represented in the frequently used bigrams for this tag. Similarly, we see many of these concepts match with the top bigrams used in insights from 2024 (fig. 12). This demonstrates how even a simplified textual analysis of insight posts can model the overall topics discussed on the GNET Research blog.

## V. Ethical concerns and limitations

Before proceeding with the use of this dataset, potential users should be informed of several ethical concerns and limitations. As mentioned before, terrorism and extremism are essentially contested concepts, and so users of this dataset must take appropriate care to treat the subjects of the insight reports with a critical and ethical lens. These insights discuss real groups and people, both extremist actors as well as victim communities. It is necessary for any data analysis conducted on this dataset, and communication thereof to treat those subjects with appropriate care for privacy, sensitivity, and respect for fundamental human rights.

Another concern relates to the epistemic limitations of the data. A frequent question in this field is, "What can this tell us about the prevalence of the problem of terrorism on various digital platforms?" This dataset can tell us about what has been researched about this problem, but the quantification of references to specific topics or entities within the insights data is not necessarily indicative of the prevalence of particular issues in the real world. It should also be noted that this dataset is a collection of data about high-level short-form public research reports. This is not an open-source terrorism database, a collection of secondary data about terrorist activity, or even a collection of peer-reviewed academic articles. Users should not be confused about what types of claims they can and cannot make from this data.

A final limitation relates to data permissions and reuse. While the GNET website and insight posts are publicly available, this dataset has not been commissioned or licensed under an agreed-upon data-reuse policy with GNET or GIFCT. GNET does not stipulate any data reuse terms on its website, and similarly, permission to use the content of these articles presumably is held in part by GNET and the original authors. Data licensing and reuse terms should be sought and clarified depending on the intended use and reuse of the data contained in this dataset.

## VI. Future Work

There is a variety of future work that the curator of this dataset might engage in to make the data and associated analyses even more useful. First, the frequent bigram text analysis conducted in this project only scratches the surface of what is possible with computational linguistics. Other potential text analyses that could add to the value of the dataset include topic modeling and named entity recognition. These techniques could be used, for example, to analyze references to specific geographic areas, extremist groups and ideologies, particular technologies and tech platforms, and trends in these entities and topics over time. Another under-researched aspect of this dataset is the URLs cited within the text of the insight posts. This might include an analysis of the frequently cited domains, or even text analysis of the linked pages themselves. Expanding beyond this dataset, there is an opportunity to combine this data with other datasets that would enrich the types of analyses that can be conducted. As mentioned above, GNET themselves may consider combining this dataset with website page analytics. Other sources of data may include demographic and geographic data about the insight authors (e.g. to see the global geographic coverage of authorship), or to match topics or named entities against one of the many open-source terrorism databases of terrorist activity, such as START's [Global Terrorism Database](https://www.start.umd.edu/gtd/).

Besides these analysis opportunities, several outstanding administrative aspects of this project should be completed to make it a more functional and useful dataset. First, as mentioned above, the dataset curator should seek to establish a partnership with GNET to clarify and articulate data licensing or data reuse policies, so that downstream users of the dataset are provided with sufficient clarity on what and how they can use this data for derived works. Second, scraping and compiling the dataset is currently a manual process (which involves running the scraper script and performing some manual formatting to produce the official dataset CSV file). This process could easily be automated to occur regularly so that the dataset will be kept up to date with any recently published insights.
