from flask import Flask
from flask_restful import Api, Resource, reqparse, abort
from restaurant import rest_dict, ids_list
# from flask_app_wrapper import FlaskAppWrapper
from sklearn.ensemble import GradientBoostingRegressor
from order import Order

#flask_app = Flask(__name__)

#app = FlaskAppWrapper(flask_app)
application = Flask(__name__)
api = Api(application)

class IDs(Resource):
    def get(self):
        return {"ids": ids_list} 

class Restaurant(Resource):
    def get(self, id):
        return rest_dict[id].to_dic()

order_put_args = reqparse.RequestParser()

# orderType: str, currTime: int, description: str, items

def abort_if_order_id_exists(order_id, id_list):
    if order_id in id_list:
        abort(404, "Order Does Exists")

def abort_if_order_id_doesnt_exist(order_id, id_list):
    if order_id not in id_list:
        abort(404, "Order Does Not Exist")

order_put_args.add_argument("currTime", type=int, help="Put in the Current Time, Bucko")
order_put_args.add_argument("items", type=str, action='append', help="Put in the Items List, Bucko")
order_put_args.add_argument("restName", type=str, help="Put in the Restaurant Name, Bucko")
order_put_args.add_argument("orderID", type=str, help="Put in the ID, Bucko")
order_put_args.add_argument("numInLine", type=str, help="Put in the number in line, Bucko")

class Restaurant_Orders(Resource):
    def get(self, rest_id):
        return {"orders": rest_dict[rest_id].orders_to_string_list(), "ids": rest_dict[rest_id].create_order_ids_list()}

    def put(self, rest_id):
        print("Rest ID: " + rest_id)
        args = order_put_args.parse_args()
        curr_rest = rest_dict[rest_id]
        order = Order(args["restName"], args["currTime"], args["items"], args["numInLine"], args["orderID"])
        curr_rest.orders.append(order)
        return {"args": curr_rest.orders_to_string_list(), "ids": curr_rest.create_order_ids_list()}
        # return {args['restName']: rest_dict[rest_id].orders_to_string_list()}


    def post(self, rest_id):
        print()
        args = order_put_args.parse_args()
        # tell to add order to csv
        return {"args": args}
    
  

class Restaurant_Orders_Delete(Resource):
      def get(self, rest_id, order_id):
          print("Order Ids List: " + str(rest_dict[rest_id].create_order_ids_list()))
          ids_list = rest_dict[rest_id].create_order_ids_list()
          if order_id in ids_list:
            return {"Order Exists": True}
          else:
              return {"Order Exists": False}

      def delete(self, rest_id, order_id):
        from store_order_info import store_order_info
        rest: Restaurant = rest_dict[rest_id]
        abort_if_order_id_doesnt_exist(order_id, rest.create_order_ids_list())
        # find index 
        my_order: Order
        for order in rest.orders:
            if order.orderId == order_id:
                my_order = order
                break

        store_order_info(my_order)
        rest.orders.remove(my_order)
        return "", 204

api.add_resource(Restaurant, "/restaurant/<string:id>")

api.add_resource(Restaurant_Orders, "/restaurant/<string:rest_id>/orders")

api.add_resource(Restaurant_Orders_Delete, "/restaurant/<string:rest_id>/orders/<string:order_id>")

api.add_resource(IDs, "/IDs")

if __name__ == "__main__":
    application.run(debug=True)

