from flask import Flask, render_template, jsonify, redirect
import pymongo
from IPython import get_ipython
import scrape_mars


app = Flask(__name__)

  

 
# setup mongo connection
app.config["MONGO_URI"] = "mongodb://localhost:27017/mars_app"
mongo = PyMongo(app)

 

@app.route("/")
def index():
    # write a statement that finds all the items in the db and sets it to a variable
    data = mars_collection.find_one()

    news_title = data['news_data']['news_title']
    news_text = data['news_data']['news_p']
    featured_image_url = data['featured_image_url']
    mars_weather = data['mars_weather']
    table = data['table']
    title1 = data['hemisphere_urls'][0]['title']
    image_ur11 = data['hemisphere_urls'][0]['img_url']
    title2 = data['hemisphere_urls'][1]['title']
    image_ur12 = data['hemisphere_urls'][1]['img_url']
    title3 = data['hemisphere_urls'][2]['title']
    image_ur13 = data['hemisphere_urls'][2]['img_url']
    title4 = data['hemisphere_urls'][3]['title']
    image_ur14= data['hemisphere_urls'][3]['img_url']
    

    print(data)

    # render an index.html template and pass it the data you retrieved from the database
    return render_template("index.html", news_title=news_title,\
                                         news_text=news_text,\
                                         featured_image_url=featured_image_url,\
                                         mars_weather=mars_weather,\
                                         table=table,\
                                         title1=title1,\
                                         image_ur11= image_url1,\
                                         title2=title2,\
                                         image_ur2= image_url2,\
                                         title3=title3,\
                                         image_ur3= image_url3,\
                                         title4=title4,\
                                         image_ur4= image_url4)

 
@app.route('/scrape')
def scrape():
    scrape_results = scrape_mars.scrape()
    mars_collection.replace_one({}, scrape_results, upsert=True)
    return redirect('http://localhost:5000/', code=302)

if __name__ == '__main__':
    app.run()
 
 
















