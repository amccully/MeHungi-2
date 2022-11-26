from flask import Flask
from flask_restful import Api, Resource, reqparse
from restaurant_list import restaurant_dict, ids_list
from flask_app_wrapper import FlaskAppWrapper

#flask_app = Flask(__name__)

#app = FlaskAppWrapper(flask_app)
app = Flask(__name__)
api = Api(app)

class IDs(Resource):
    def get(self):
        return {"ids": ids_list} 

class Restaurant(Resource):
    def get(self, id):
        return {restaurant_dict[id].to_dict()}

order_put_args = reqparse.RequestParser()

# orderType: str, currTime: int, description: str, items
order_put_args.add_argument("orderType", type=str, help="Put in the Order Type, Bucko")
order_put_args.add_argument("currTime", type=int, help="Put in the Current Time, Bucko")
order_put_args.add_argument("description", type=str, help="Put in the Description, Bucko")
order_put_args.add_argument("items", type=list, help="Put in the Items List, Bucko")

class Restaurant_Orders(Resource):
    def put(self):
        args = order_put_args.parse_args()
        return {"args": args}

api.add_resource(Restaurant, "/restaurant/<string:id>")

api.add_resource(Restaurant_Orders, "/restaurant/<string:id>/orders")

api.add_resource(IDs, "/IDs")

if __name__ == "__main__":
    app.run(debug=True)

