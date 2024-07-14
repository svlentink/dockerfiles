from waitress import serve
import app
serve(app.flaskapp, host='0.0.0.0', port=80)

