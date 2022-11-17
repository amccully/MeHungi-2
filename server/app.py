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
        return {restaurant_dict[id]}


api.add_resource(Restaurant, "/restaurant/<int:id>")

api.add_resource(IDs, "/IDs")

if __name__ == "__main__":
    app.run(debug=True)
