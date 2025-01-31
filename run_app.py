from manage import app
from waitress import serve


serve(app, listen='0.0.0.0:5000', threads=4)
