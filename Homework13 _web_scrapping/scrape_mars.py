



from splinter import Browser
from splinter.exceptions import ElementDoesNotExist
from bs4 import BeautifulSoup
import IPython


# # Mac Users

# https://splinter.readthedocs.io/en/latest/drivers/chrome.html
get_ipython().system('which chromedriver')



executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
browser = Browser('chrome', **executable_path, headless=False)


# # NASA Mars News

 


url = 'https://mars.nasa.gov/news/?page=0&per_page=40&order=publish_date+desc%2Ccreated_at+desc&search=&category=19%2C165%2C184%2C204&blank_scope=Latest'
browser.visit(url)


 


#only one item on the page
html = browser.html
soup = BeautifulSoup(html, 'html.parser')

news_data = {}

news_title = soup.find('div', class_='content_title')
news_p = soup.find('div', class_='article_teaser_body')
    
news_title=(news_title.text)
news_p=(news_p.text)
print(news_title)
print(news_p)

news_data["news_title"] = news_title
news_data["news_p"] = news_p

news_data


# # JPL Mars Space Images

 


url = "https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars"
browser.visit(url)

 


# JPL Mars Space featured Image
featured_image_list = []

html = browser.html
soup = BeautifulSoup(html, 'html.parser')


featured_image_url = soup.find('a', class_='button fancybox')['data-fancybox-href']
featured_image_url =('https://www.jpl.nasa.gov'+ featured_image_url)
featured_image_list.append(featured_image_url)
print( featured_image_url)
featured_image_list
 


# # Mars Weather

 


url = "https://twitter.com/marswxreport?lang=en"
browser.visit(url)


 


html = browser.html
soup = BeautifulSoup(html, 'html.parser')

weather_info_list = []

mars_weather = soup.find('p', class_='TweetTextSize')
mars_weather=(mars_weather.text)
weather_info_list.append(mars_weather) 
print(mars_weather)
weather_info_list


# # Mars Facts

 


import pandas as pd


 


url = 'https://space-facts.com/mars/'


 


tables = pd.read_html(url)
tables


 


type(tables)


 


df = tables[0]
df.columns = ['0', 1 ]
df.head()


 


html_table = df.to_html()
html_table


 


html_table.replace('\n', '')


 

df.to_html('table.html')


# # Mars Hemisphere

 


url ='https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
browser.visit(url)


 


for x in range(1):
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')

    
    images = soup.find_all('div', class_='description')

    for image in images:
        # Use Beautiful Soup's find() method to navigate and retrieve attributes
        image_urls = image.find('a')['href']
        image_titles = image.find('h3')
        print('https://astrogeology.usgs.gov' + image_urls)
        print(image_titles.text)


 

url ='https://astrogeology.usgs.gov/search/map/Mars/Viking/cerberus_enhanced'
browser.visit(url)


 


# Hemispere 1
html = browser.html
soup = BeautifulSoup(html, 'html.parser')


image_ur11 = soup.find('img', class_='wide-image')['src']
       
image_url1 = ('https://astrogeology.usgs.gov'+ image_ur11)

title1 = soup.find('div', class_='content')
image_title1 = soup.find('h2')

title1 = image_title1.text

print(title1)
print(image_url1)

data1 = {'title' : title1,
         'img_url' : image_url1}

data1
 


 


url = 'https://astrogeology.usgs.gov/search/map/Mars/Viking/schiaparelli_enhanced'
browser.visit(url)


 


# Hemispere 2
html = browser.html
soup = BeautifulSoup(html, 'html.parser')


image_ur12 = soup.find('img', class_='wide-image')['src']
 
      
image_url2 = ('https://astrogeology.usgs.gov'+ image_ur12)

title2 = soup.find('div', class_='content')
image_title2 = soup.find('h2')


title2 = image_title2.text

print(title2)
print(image_url2)
data2 = {'title' : title2,
         'img_url' : image_url2}

data2
 

 

url = 'https://astrogeology.usgs.gov/search/map/Mars/Viking/syrtis_major_enhanced'
browser.visit(url)


 


# Hemispere 3
html = browser.html
soup = BeautifulSoup(html, 'html.parser')


image_ur13 = soup.find('img', class_='wide-image')['src']
 
image_url3 = ('https://astrogeology.usgs.gov'+ image_ur13)

title3 = soup.find('div', class_='content')
image_title3 = soup.find('h2')

title3 = image_title3.text

print(title3)
print(image_url3)

data3 = {'title' : title3,
         'img_url' : image_url3}

data3


 


url = 'https://astrogeology.usgs.gov/search/map/Mars/Viking/valles_marineris_enhanced'
browser.visit(url)


 


# Hemispere 4
html = browser.html
soup = BeautifulSoup(html, 'html.parser')


image_ur14 = soup.find('img', class_='wide-image')['src']
 
image_url4 = ('https://astrogeology.usgs.gov'+ image_ur14)      
 

title4 = soup.find('div', class_='content')
image_title4 = soup.find('h2')
title4 = image_title4.text

print(title4)
print(image_url4)

data4 = {'title' : title4,
         'img_url' : image_url4}

data4
 

#make a list of all the hemispheres
 


hemisphere_urls =  []
hemisphere_urls.append(data1)
hemisphere_urls.append(data2)
hemisphere_urls.append(data3)
hemisphere_urls.append(data4) 
hemisphere_urls

