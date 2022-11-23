from flask import Flask
from flask_restful import Api, Resource
from restaurant_list import restaurant_dict
from flask_app_wrapper import FlaskAppWrapper

#flask_app = Flask(__name__)

#app = FlaskAppWrapper(flask_app)
app = Flask(__name__)
api = Api(app)

class IDs(Resource):
    def get(self):
        return {"ids": list(restaurant_dict.keys())} 

class Restaurant(Resource):
    def get(self, id):
        return {id : restaurant_dict.get(id, "Uhoh")}


api.add_resource(Restaurant, "/restaurant/<string:id>")

api.add_resource(IDs, "/IDs")

if __name__ == "__main__":
    app.run(debug=True)

