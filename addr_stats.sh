# admin_level=8
wget -O addr_stats.csv "http://overpass-api.de/api/interpreter?data=%5Bout%3Acsv%28%3A%3Aid%29%5D%3Barea%5B%22name%22%3D%22Gorizia%22%5D%5B%22admin%5Flevel%22%3D%228%22%5D%2D%3E%2Ea%3B%28nwr%5B%22addr%3Ahousenumber%22%5D%28area%2Ea%29%3B%29%3Bout%20center%3B%0A"
