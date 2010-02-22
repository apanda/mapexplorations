#!/usr/bin/env python
from geopy import geocoders
import sqlite3

connection = sqlite3.connect('unprocessedtennis.db')
connection2 = sqlite3.connect('tennis.db')

c = connection.cursor()
c2 = connection2.cursor()
google = geocoders.Google('ABQIAAAAQGbzqUyUyFqkuiq-bCdE0xS4Is1OHekFoVwasBc-LoBG9zsjaBRfMrSYNWNPFnfGOUgXZUAcFXEGrw')
yahoo = geocoders.Yahoo('9E7nLOPV34HwxYM0gRxwbasTCb2juFN1IZJh7N8Zz0xJ.RtlGkdwrD.hJ9li.0vjiGGwR234KA--')

c.execute('select courtname, address, city, neighborhood, courts from tenniscourts')
for row in c:
    if str(row[1]) != '' and str(row[2]) != '':
        addr = str.format("{0} in {2} {1} WA", row[1], row[2], row[3])
        print addr
        
        #try:
        #    place, (lat, lng) = google.geocode(addr)
        #    out = str.format("{0}: {1}, {2}", place, lat, lng)
        #    print out
        #except ValueError:
        #    print "valerror"

        try:
            place, (lat, lng) = yahoo.geocode(addr)
            out = str.format("{0}: {1}, {2}", place, lat, lng)
            c2.execute("insert into tenniscourts (courtname, address, city, neighborhood, courts, latitude, longitude) values (?, ?, ?, ?, ?, ?, ?)", (row[0], row[1], row[2], row[3], row[4], lat, lng))
            print out
        except ValueError:
            print "valerror"
connection2.commit()
