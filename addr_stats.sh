# scraping Openstreetmap su base ref:ISTAT regionale
# overpass-turbo csv query: http://overpass-turbo.eu/s/13YL

#ISTAT 030 provincia di Udine
wget -O addr_stats.csv "http://overpass-api.de/api/interpreter?data=%5Bout%3Acsv%28%3A%3Atype%2C%22ref%3AISTAT%22%2C%22name%22%2C%3A%3Acount%2C%3A%3Acount%3Anodes%2C%3A%3Acount%3Aways%2C%3A%3Acount%3Arelations%29%5D%3Barea%5B%22ref%3AISTAT%22%7E%22030%22%5D%3Bforeach%2D%3E%2Eregio%7B%2Eregio%20out%3B%28node%5B%22addr%3Ahousenumber%22%5D%28area%2Eregio%29%3Bway%5B%22addr%3Ahousenumber%22%5D%28area%2Eregio%29%3Brelation%5B%22addr%3Ahousenumber%22%5D%28area%2Eregio%29%3B%29%3Bout%20count%3B%7D%0A"

