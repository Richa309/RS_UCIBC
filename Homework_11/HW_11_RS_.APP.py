import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func


from flask import Flask, jsonify


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation"
        f"/api/v1.0/stations"
        f"/api/v1.0/tobs"
        f"/api/v1.0/<start> "
        f"/api/v1.0/<start>/<end>"
    )

@app.route("/api/v1.0/precipitation/dates_temp_last_year")
def dates_temp_last_year():
#Query for the dates and temperature observations from the last year.

    sel = [Measurement.date,
    func.sum(Measurement.tobs)]
    date_temp_12mths = session.query(*sel).\
    filter(Measurement.date.between ('2016-08-23', '2017-08-23')).\
    group_by(Measurement.date).\
    order_by(Measurement.date).all()

   #Convert the query results to a Dictionary using date as the key and tobs as the value.
    all_dates_temp = []
    for Measurement.date in  date_temp_12mths:
        date_dict = {}
        date_dict["Date"] = Measurement.date
        date_dict["Temprature"] = Measurement.tobs
        all_dates_temp.append(date_dict)

    #Return the JSON representation of your dictionary.
    return jsonify(all_dates_temp)


@app.route("/api/v1.0/stations")
def stations():
    """Return a JSON list of stations from the dataset."""
    # Query all stations
    sel2 = [Station.station]
    stations = session.query(*sel2).all()
    # Create a dictionary from the row data and append to a list of all_stations
    all_stations = []
    for Station.station in stations:
        station_dict = {}
        station_dict["Station Name"] = Station.station
        all_stations.append(station_dict)

    return jsonify(all_stations)

@app.route("/api/v1.0/tobs")
def tobs():
    """Return a JSON list of Temperature Observations (tobs) for the previous year."""
    # Query all stations
    sel3 = [Measurement.tobs]
    tob = session.query(*sel3).\
    filter(Measurement.date.between ('2016-08-23', '2017-08-23')).\
    group_by(Measurement.date).\
    order_by(Measurement.date).all()

    # Create a dictionary from the row data and append to a list of all_tobs
    all_tobs = []
    for Measurement.tobs in tob:
        tobs_dict = {}
        tobs_dict["Temperature"] = Measurement.tobs
        all_tobs.append(tobs_dict)

    return jsonify(all_tobs)

@app.route('f"/api/v1.0/<start>/<end>')
@app.route('f"/api/v1.0/<start>/', defaults={'end': None})
def dates():
    """Return a JSON list of the minimum temperature, the average temperature, and the max temperature for a given start or start-end range."""
    # Create temp list
    sel4 = [
    func.min(Measurement.tobs),
    func.max(Measurement.tobs),
    func.avg(Measurement.tobs),]
    temp_analysis = session.query(*sel4).\
    filter(Measurement.date.between ('', '')).\
    filter(Measurement.date >= ('')).all() 
 
# Create a dictionary from the row data and append to a list of all_dates
    all_dates = []
    for Measurement.tobs in  temp_analysis:
        date_dict = {}
        date_dict['TMIN'] = func.min(Measurement.tobs)
        date_dict['TMAX'] = func.max(Measurement.tobs)
        date_dict['TAVG'] = func.avg(Measurement.tobs)
        all_dates.append(date_dict)

    return jsonify(date_dict)


if __name__ == '__main__':
    app.run(debug=True)
