import requests
# from restaurant import Restaurant
import random
import uuid
from restaurant_containers import rest_list, name_dict, id_dict, Restaurant

BASE = "http://127.0.0.1:5000/"

def update_order(items: list, name: str, numInLine: int):
    # update orders 
    response = requests.put(BASE + "/restaurant/" + name_dict[name].id + "/orders",
                {"currTime": 5, "items": items, "restName": name, "orderID": str(uuid.uuid4()), "numInLine": numInLine})
    print(response.json())

# delete order
def delete_order(order_id: str, rest_name: str):
    response = requests.delete(BASE + "/restaurant/" + name_dict[rest_name].id + "/orders/" + order_id)

        # get requests

def get_order(name: str):
    response = requests.get(BASE + "restaurant/" + name_dict[name].id + "/orders")
    # print(response.json())
    return response.json()

def check_if_order_exists(order_id: str, rest_name: str):
    response = requests.get(BASE + "restaurant/" + name_dict[rest_name].id + "/orders/" + order_id)
    print(response.json())
