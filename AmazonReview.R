library("tm")
library("rJava")
library("wordcloud")
library("textir")
library("RWeka")
library("qdap")
library("maptpx")
library("openNLP")
library("httr")
library("XML")
library("dplyr")

source(file.choose())  #    Select amazon reviews extraction code.R
source(file.choose())  #    Select text_functions.R

url= "https://www.amazon.com/TWININGS-Assorted-Tea-Herbal-Count/product-reviews/B00XA99ZKY/ref=cm_cr_arp_d_paging_btm_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2"
text  = amazon.in(url,20)
head(text)
Doc.id=seq(1:length(text))            # Assign Document no for each Document 
calib=data.frame(Doc.id,text)         # Create a dataframe for text documents with document ID

stpw = readLines(file.choose())      # Select stopwords.txt file
stpw1 = stopwords('english')         # tm package stop word list
comn  = unique(c(stpw, stpw1))       # Union of two list
stopwords = unique(c(gsub("'","",comn),comn)) # final stop word lsit with and without punctuation
head (stopwords)

test = text.clean(text)                         # basic HTML Cleaning etc
head(test)                                      # print top documents
test  =  removeWords(test,stopwords)            # removing stopwords created above
head(test)                                      # print top documents

clean_text = test


x1 = VCorpus(VectorSource(test))          # Create the corpus
x1 = n.gram(x1,"bi",2)                   # Encoding bi-gram with atleast frequency 2 as uni-gram
x1 = VCorpus(VectorSource(x1))  
dtm1 = custom.dtm(x1,"tf")               # Document Term Frequency 
dtm2 = custom.dtm(x1,"tfidf")            # Term Frequency Inverse Document Frequency Scheme
