# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("RColorBrewer")
# install.packages("scales")
# install.packages("tidytext")
# install.packages("cowplot")

library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(tidytext)
library(cowplot)

gnet_df <- read.csv("~/Code/572_data_science/gnet-insights-dataset/gnet_insights.csv")

# Data cleaning

# Convert nested list-value fields into R vectors for later unnesting.
gnet_df <- gnet_df %>%
  mutate(author_names = str_replace(author_names, "^\\[", "")) %>% # Process author names
  mutate(author_names = str_replace(author_names, "\\]$", "")) %>%
  mutate(author_names = str_replace(author_names, "^'", "")) %>%
  mutate(author_names = str_replace(author_names, "'$", "")) %>%
  mutate(author_names = str_split(author_names, "', '")) %>% 
  mutate(author_urls = str_replace(author_urls, "^\\[", "")) %>% # Process author URLS
  mutate(author_urls = str_replace(author_urls, "\\]$", "")) %>%
  mutate(author_urls = str_replace(author_urls, "^'", "")) %>%
  mutate(author_urls = str_replace(author_urls, "'$", "")) %>%
  mutate(author_urls = str_split(author_urls, "', '")) %>% 
  mutate(categories = str_replace(categories, "^\\[", "")) %>% # Process categories
  mutate(categories = str_replace(categories, "\\]$", "")) %>%
  mutate(categories = str_replace(categories, "^'", "")) %>%
  mutate(categories = str_replace(categories, "'$", "")) %>%
  mutate(categories = str_split(categories, "', '")) %>% 
  mutate(insight_urls = str_replace(insight_urls, "^\\[", "")) %>% # Process insight URLS
  mutate(insight_urls = str_replace(insight_urls, "\\]$", "")) %>%
  mutate(insight_urls = str_replace(insight_urls, "^'", "")) %>%
  mutate(insight_urls = str_replace(insight_urls, "'$", "")) %>%
  mutate(insight_urls = str_split(insight_urls, "', '")) %>%
  mutate(tags = str_replace(tags, "^\\[", "")) %>% # Process tags
  mutate(tags = str_replace(tags, "\\]$", "")) %>%
  mutate(tags = str_replace(tags, "^'", "")) %>%
  mutate(tags = str_replace(tags, "'$", "")) %>%
  mutate(tags = str_split(tags, "', '"))

## Split out year, month, and date from the pub_date field, to simplify some analyses
gnet_df <- gnet_df %>% 
  mutate(year = str_extract(pub_date, "^[0-9]{4}")) %>% 
  mutate(month = str_match(pub_date, "^[0-9]{4}-([0-9]{2})")[,2]) %>% 
  mutate(day = str_match(pub_date, "^[0-9]{4}-[0-9]{2}-([0-9]{2})")[,2])

# 1. Analysis of total insight stats and publication dates

# Get the count of total insights in the dataset
total_insights <- gnet_df %>% count()
total_insights
# There are 615 total insights

# Get the range of publication dates of the insights covered by this dataset.
# First select the publication date and mutate it with the as.Date function,
# and get the latest and earliest date.
total_insights_date_range <- gnet_df %>% 
  select(pub_date) %>% 
  mutate(date = as.Date(pub_date)) %>% 
  summarize(latest = max(date), earliest = min(date))
# Latest published insight: 2024-05-09
# Earliest published insight: 2019-12-31
# May 9, 2024 was the date when the dataset was last update by scraping the GNET website

# Get the count of insights per year
insights_per_year <- gnet_df %>% 
  group_by(year) %>% 
  summarize(n = n())

# Summary stats of insights per year
insight_year_stats <- insights_per_year %>% 
  summarize(max = max(n), median = median(n), mean = mean(n), min = min(n))
# Max insights per year: 152
# Median: 130
# Mean: 102.5
# Min: 7

# Analyzing outlier years by filtering to include only years with less than 1/2 the mean # of insights
insight_years_outliers <- insights_per_year %>% 
  filter(n < insight_year_stats$mean / 2)
# The outlier years are 2024 and 2019.
# 2024 is the present year which is still ongoing, so that makes ssense.
# 2019 has only 7 insights, why is that?

# Filter to only insights in 2019 and see when they were published during the year.
insight_years_2019_insights <- gnet_df %>% 
  filter(year == 2019) %>% 
  group_by(month, day) %>% 
  count()
# We can see that all 7 insights published in 2019 were published on the same day, December 31.

## Get the number of insights published per month.
# We use the lubridate floor_date function to "round" down the date to the month level for grouping by month.
insight_months <- gnet_df %>% 
  group_by(month = lubridate::floor_date(as.Date(pub_date), "month")) %>%
  summarize(n = n())

# Summary stats of insights published per month
insight_month_stats <- insight_months %>% 
  summarize(max = max(n), median = round(median(n)), mean = round(mean(n)), min = min(n))
# Max insights per month: 21
# Median: 12
# Mean: 11
# Min: 3

# We can best see the outliers and trends in monthly publishing with a visualization
ggplot(insight_months, aes(x=month, y=n)) +
  geom_point(color="black") +
  geom_line(color="tomato2") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.8, hjust = 1)) +
  labs(title = "# insights published each month",
       y = "# insights",
       x = "date") +
  scale_x_date(date_labels = "%Y-%m",date_breaks = "2 month")

# 2. Analysis of authors and author publication counts

# Unnesting the list-value authors field to conduct further analyses
long_authors_urls_df <- gnet_df %>% 
  unnest_longer(author_names)

# Get the count of distinct authors who have published GNET insights
distinct_authors <- long_authors_urls_df %>% 
  distinct(author_names) %>% 
  count()
distinct_authors
# There are 453 distinct authors in the dataset

# Some insights are co-written by more than one author. What are the statistics for that?
# Get the count of authors per insight
authors_per_insight <- long_authors_urls_df %>% 
  group_by(insight_url) %>%
  summarize(n = n())

# Summary statistics of authors per insight
authors_per_insight_stats <- authors_per_insight %>% 
  summarize(max(n), median(n), round(mean(n)), min(n))
# Max authors per insight: 6
# Median: 1
# Mean (rounded): 1
# Min: 1

# Some authors have also contributed to writing more than one insight.
# Get the count of insights per author
insights_per_author <- long_authors_urls_df %>% 
  group_by(author_names) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

# Summary stats of insights per author
author_counts_stats <- insights_per_author %>% 
  summarize(max = max(n), median = median(n), mean = round(mean(n)), min = min(n))
# Max insights per author: 21
# Median: 1
# Mean: 2
# Min: 1

# There is quite a difference between the max insights per author and the median,
# which makes it sound like there may be a long tail of contributors with ony one insight.
# What does this look like?

# Plot the number of insights per author to see the distribution
ggplot(insights_per_author, aes(x=reorder(author_names, n, decreasing=TRUE), y=n)) +
  geom_col(fill="tomato2") +
  labs(title = "Distribution of # of insights per author",
       x= "authors",
       y= "# insights per author") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
  ) +
  scale_y_continuous(limits = c(0, 21), breaks = breaks_pretty(n = 10))
# As expected there is a long tail of authors with one insight, and a few more with 2-5 insights
# before we see a small number of authors with 6 or more insights, up to 21 for a single author.

## Get the top most contributing authors (6 or more insights)
top_authors <- insights_per_author %>% 
  filter(n >= 6)

# How many are there?
count_top_authors <- top_authors %>% count()
count_top_authors
# There are 17 authors who have written 6 or more insights

# Plot these authors along with how many insights they've written
ggplot(top_authors, aes(x=n, y=reorder(author_names,n))) +
  geom_col(fill = "darkolivegreen4") +
  labs(title = "# insights by top contributing authors",
       x = "# insights per author",
       y = "top authors")

# For the top 10 authors let's see how they've contributed various insights over the timespan of the dataset

# Get the counts of the top authors by filtering authors against the top insights per author list
# and then group by month using the floor_date technique
top_author_insights_by_month <- long_authors_urls_df %>% 
  filter(author_names %in% top_authors$author_names[1:10]) %>% 
  group_by(month = lubridate::floor_date(as.Date(pub_date), "month"), author_names) %>%
  summarize(n = n())

# Plot the top insight authors and their insight counts per month over the publication timeline.
ggplot(top_author_insights_by_month, aes(x=month, y=n, fill=author_names)) +
  geom_area(position = "stack") +
  scale_fill_brewer(palette = "Spectral", name = "Tag") +
  labs(title = "# of Insights per month for top GNET authors",
       y = "total insights by all top authors each month") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  scale_x_date(date_labels = "%Y-%m",date_breaks = "2 month")
# Of interest, we can see that most of the top contributing authors have dropped off from
# writing new insights sometime in 2023 (or in one case, in 2022), while two top authors
# have consistently continued publishing into 2024 (these also happen to be the two
# top contributors of all time).

# Analysis of tags

# Unnest the list-value tags field for further analysis
long_tags <- gnet_df %>% 
  unnest_longer(tags)

# Get the count of distinct tags
distinct_tags <- long_tags %>% 
  distinct(tags) %>% 
  count()
distinct_tags
# There are 87 distinct tags across all insights

# How frequently are individual tags applied to insights?
# Get the count of insights per tag
tag_counts <- long_tags %>% 
  group_by(tags) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

# Summary stats of the count of insights per tag
tag_counts_summary <- tag_counts %>% 
  summarize(max = max(n), median = median(n), mean = round(mean(n)), min = min(n))
# Max # of insights associated with a single tag: 197
# Median: 10
# Mean: 18
# Min: 2

# Like with the authors, there is also a large difference between the tag with
# the max number of insights and those with the median number of insights. Let's graph this to see
# what the distribution looks like
ggplot(tag_counts, aes(x=reorder(tags, n, decreasing=TRUE), y=n)) +
  geom_col(fill="tomato2") +
  labs(title = "Distribution of # of insights per tag",
       x= "tags",
       y= "# insights per tag") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_y_continuous(breaks = breaks_pretty(n = 20))
# We can see that most tags have ~20 or fewer insights associated with them, while
# a small number of tags have up to hundreds of associated insights

# Investigate the top most used tags (> 20 insights)
top_tags <- tag_counts %>% 
  filter(n > 20)

# How many are there?
count_top_tags <- top_tags %>% count()
count_top_tags
# There are 22 tags that have been applied to 21 or more insights

# Plot the top tags most used tags and how many insights they are applied to
ggplot(top_tags, aes(x=n, y=reorder(tags, n))) +
  geom_col(fill = "tomato2") +
  labs(title = "Top tags applied to GNET Insights",
       x = "# insights with tag",
       y = "tag")

# Now let's visualize how the top tags are used on a monthly basis.
# As before, filter the tags from the top set of tags by insights per tag,
# then group by month using the floor_date technique.
top_tags_per_month <- long_tags %>% 
  filter(tags %in% top_tags$tags[1:10]) %>% 
  group_by(month = lubridate::floor_date(as.Date(pub_date), "month"), tags) %>%
  summarize(n = n())

# Plot the top tags per month as a stacked area chart to show the relative changes in usage over time
ggplot(top_tags_per_month, aes(x=month, y=n, fill=reorder(tags,n, decreasing=TRUE), group=tags)) +
  geom_area(position = 'stack') +
  scale_fill_brewer(palette = "Spectral", name = "Tag") +
  labs(title = "Top tags applied to GNET insights by month and year",
       y = "Total # of insights for all top tags each month")
# There are some interesting patterns or regimes shown by this chart.
# From 2019 through 2021 There was a larger focus on 'Social media' and 'Islamic State'
# From 2021 through 2024, there was an increasing focus on 'Far-Right' and, eventually, 'Gender' tags
# Then from 2024, consistently used tags related to Telegram, QAnon fell off, the tag for Gender fell off, and the Far-Right tag decline while Islamic State came back into dominance.

# Analysis of the URLs cited inside the text of each insight

# Unnesting the urls for further analysis
urls_long <- gnet_df %>% 
  unnest(insight_urls)

# Count of distinct URLs in insights
distinct_urls <- urls_long %>% 
  distinct(insight_urls) %>% 
  count()
distinct_urls
# There are 9403 distinct URLs across cited across all insights

# How frequently are individual urls used?
# Analyze the distribution of how frequently URLs are cited by grouping by URLs.
# We also filter out several distinct URLs with bad or irrelevant values.
dist_urls <- urls_long %>% 
  group_by(insight_urls) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  filter(insight_urls != "about:blank", insight_urls != "")

# Summary stats of the citation counts of URLs used across all insights
url_counts_summary <- dist_urls %>% 
  summarize(max = max(n), median = median(n), mean = round(mean(n)), min = min(n))
# Max cited URL count: 23
# Median: 1
# Mean: 1
# Min: 1

# Plotting the distribution of the citation counts of all URLs across the dataset
ggplot(dist_urls, aes(x=reorder(insight_urls, n, decreasing=TRUE), y=n)) +
  geom_col(fill="tomato2") +
  labs(title = "Distribution of citations of URLs in insight text",
       x= "URLs",
       y= "# citations per URL") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
  ) +
  scale_y_continuous(breaks = breaks_pretty(n = 20))
# We can see that the vast majority the 9000+ URLs are cited only a single time. On the other end
# two URLs are cited over twenty times, a link to a report by RUSE and Brookings: 'Terrorist Definitions and Designations Lists', 
# and a link to Monash University's Global Peace and Security Centre

# It's also interesting to look at what domains have been cited from the most frequently cited URLs.
# Mutate the URLs to extract the domain name portion using a regular expression.
domains <- urls_long %>% 
  mutate(domain = str_match(insight_urls, "^http[s]?://([^/]*)")[,2])

# Group by the domains and filter to get the top most cited domains and their counts
top_domains <- domains %>% 
  group_by(domain) %>% 
  summarise(total = n()) %>% 
  slice_max(total, n = 20)

# Visualize the top most cited domains and counts
ggplot(top_domains, aes(x = total, y = reorder(domain, total))) + 
  geom_col(fill = "darkolivegreen4") +
  labs(title = "Top most cited domains in GNET insights",
       x = "# of citations in insights",
       y = "domain name")

# Finally, we will zoom in and do some example text analysis to demonstrate
# what might be done with the textual component of this dataset.

# Unnest the tokens of the insight text into a tidy text format 
tidy_gnet <- gnet_df %>% 
  unnest_tokens(word, insight_text)

# Load a set of stopwords and add additional common words that we want to remove
stopwords = get_stopwords(language = "en", source = "snowball")
stopwords <- stopwords %>% add_row(word = c("also",
                                            "can",
                                            "may",
                                            "however",
                                            "one",
                                            "within",
                                            "like",
                                            "fig"))

# Get the top most used words in the text by filtering out the stop words,
# and then counting and slicing.
top_words <- tidy_gnet %>% 
  anti_join(stopwords) %>% 
  count(word, sort=TRUE) %>% 
  slice_max(n, n = 20) %>%
  mutate(word = reorder(word, n))

# Plot the top most used words
ggplot(top_words, aes(x=n, y=word)) +
  geom_col(fill = "darkolivegreen4") +
  labs(title="Top most used words in GNET insights",
       x="frequency",
       y="word")

# Next we evaluate the commonly used bigrams in the insight texts.
# This is done by unnesting the tokens into bigrams, and then we use a trick to
# remove stopwords from each bigram by seperating bigrams into two word columns
# and filtering each column against the stopwords list before reuniting them.
tidy_gnet_bigrams <- gnet_df %>% 
  unnest_tokens(word, insight_text, token = "ngrams", n = 2) %>% 
  separate(word, c("word1", "word2"), sep = " ") %>% 
  filter(!word1 %in% stopwords$word) %>%
  filter(!word2 %in% stopwords$word) %>% 
  unite(word, word1, word2, sep = " ")

# Get the top most used bigrams and their usage counts
top_bigrams <- tidy_gnet_bigrams %>% 
  count(word, sort=TRUE) %>% 
  slice_max(n, n = 20) %>%
  mutate(word = reorder(word, n))

# Plot the top most used bigrams and their counts
ggplot(top_bigrams, aes(x=n, y=word)) +
  geom_col(fill = "darkolivegreen4") +
  labs(title="Top most used bigrams in GNET insights",
       x="frequency",
       y="bigram")

# Analyze trends in how the top most used bigrams have changed each year.
# Count the uses of each bigram by year, and then arrange and group them by year
# in order for them to be plotted in separate plot facets
top_bigrams_by_year <- tidy_gnet_bigrams %>% 
  count(word, year, sort=TRUE) %>% 
  arrange(desc(n)) %>% 
  group_by(year) %>% 
  slice(1:10)

# Plot the top used bigrams for each year using facet_wrapping to separate out
# each year in its own subplot. We use "free" scales mode to only display the
# bigrams that are relevant for each year.
ggplot(top_bigrams_by_year, aes(x = n, y = reorder(word, n), fill = year)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ year, ncol = 2, scales = "free") +
  labs(title="Top bigrams used in GNET insights, compared by year",
       x="frequency of bigrams",
       y="bigram for each year")

## Last, we analyze the bigrams that represent what the insight texts are about
# by computing the term-frequency inverse document-frequency of the bigrams
bigram_tf_idf <- tidy_gnet_bigrams %>%
  count(year, insight_url, word) %>%
  bind_tf_idf(word, insight_url, n) %>%
  arrange(-tf_idf)

# Get the top tf-idf bigrams into a format that can be displayed for each year
# by first filtering out bigrams with term frequency of 1,
# next grouping by year, slicing out the top 10 tf-idf bigrams, and ungrouping
# and then turning each bigram into a unique factor.
bigram_tf_top <- bigram_tf_idf %>%
  filter(!near(tf, 1)) %>%
  group_by(year) %>%
  slice_max(tf_idf, n = 10, with_ties = FALSE) %>%
  ungroup() %>%
  mutate(word = factor(word, levels = rev(unique(word)))) 

# Finally we plot each year as a separate subplot with a free scale, as before.
ggplot(bigram_tf_top, aes(x = tf_idf, y = word, fill = year)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ year, ncol = 2, scales = "free") +
  labs(title="Top TF-IDF bigrams used in GNET insights, compared by year",
       x="frequency of TF-IDF bigrams",
       y="TF-IDF bigram for each year")
