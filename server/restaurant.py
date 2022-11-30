import uuid
import pandas as pd
# import joblib
import pickle
from sklearn.ensemble import GradientBoostingRegressor
import datetime
# from restaurant_list import restaurant_list

class Restaurant:

    def __repr__(self):
      return self.name

    def __init__(self, name: str, description: str, openHour: int, openMinute: int,
    closeHour: int, closeMinute: int, latitude: float, longitude: float, money: int, menuItems: list):
        self.id = str(uuid.uuid4())
        self.name = name
        self.description = description
        self.openHour = openHour
        self.openMinute = openMinute
        self.closeHour = closeHour
        self.closeMinute = closeMinute
        self.latitude = latitude
        self.longitude = longitude
        self.waitTime = 0 
        self.orders = []
        self.money = money
        self.menuItems = menuItems

    def to_dic(self):
        return {"id": self.id, "name": self.name, "description": self.description,
         "openHour": self.openHour, "openMinute": self.openMinute, "closeHour": self.closeHour,
         "closeMinute": self.closeMinute, "latitude": self.latitude, "longitude": self.longitude,
         "waitTime" : self.find_wait(), "money": self.money, "menuItems": self.menuItems, "numInLine": len(self.orders)}

    def orders_wait_time(self):
        count = 0
        for order in self.orders:
            count += order.completion_time
        return count
        
    def create_order_ids_list(self):
      order_id_list = []
      for order in self.orders:
        order_id_list.append(order.orderId)
      return order_id_list

    def orders_to_string_list(self):
      orders = []
      for order in self.orders:
        orders.append(order.items)
      return orders

    def find_wait(self):
        from CSV_file_maker_unblocked import my_gbm
        
        # model: GradientBoostingRegressor = pickle.load(open('Wait_Time_Calculator.sav', 'rb'))
        curr_time = datetime.datetime.now()
        curr_day = curr_time.weekday()
        input_data = [restaurant_list.index(name_dict[self.name]), curr_time.hour * 60 + curr_time.minute, curr_day, len(self.orders)]
        input_df = pd.DataFrame(columns=["Rest Num", "Time (Min)", "Day (Encoding)", "Orders"])
        input_df.loc[0] = input_data
        wait = my_gbm.predict(input_df)
        return round(wait[0])

restaurant_list = [ Restaurant("Burger King", "trash fastfood burger place", 7, 0, 23, 59, 32.880010937246595, -117.23584745233543, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                   Restaurant("Panda Express","human trough", 9, 0, 17, 0, 32.87974893295122, -117.23639722612094, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Subway", "pay 10 dollars for a sandwhich you could've made better",
                  7, 0, 19, 0, 32.87958268075439, -117.23581169641686, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Jamba Juice", "pay 10 dollars for a smoothie",
                 9, 0, 19, 0, 32.88003219036016, -117.23682997774515, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Dirty Birds", "Frat food", 10,
                                0, 21, 30, 32.88011776711401, -117.23672354981419, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Curry Up Now", "who?", 10,
                                0, 22, 0, 32.879988992613555, -117.23619591435616, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Rubio's", "fast food but expensive", 10,
                                0, 20, 0, 32.88067347599053, -117.23547401849824, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Starbucks", "Milkshakes with cocoa beans in them", 7,
                                0, 21, 0, 32.88002940880099, -117.2364259192577, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Yogurt World", "Offers do-it-yourself frozen yogurt. Flavors from chocolate to green coconut and toppings from chocolate chips to lychee.",
                 0, 0, 10, 0, 32.87914905478985, -117.23589951722849, 1, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                Restaurant("Croutons", "salad",
                 10, 0, 15, 0, 32.87863895176272, -117.23577683841106, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Taco Villa", "An authentic taco shop serving all your favorite Mexican food dishes right on campus.",
                 8, 0, 20, 0, 32.87699515125575, -117.24010419541086, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Caroline's", "Offers healthy and creative California-style cuisine featuring a diverse menu of hot and cold breakfast items, sandwiches, salads, soups, espresso drinks, baked goods, and desserts.",
                 8, 0, 15, 0, 32.86462979107682, -117.25417260500511, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Lemongrass", "Serves natural chicken, salmon and tofu with a healthy Asian fusion flair.",
                 9, 0, 19, 45, 32.87985600620295, -117.23605256267507, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Santorini", "Offers fare from around the Aegean, the Mediterranean, and beyond...",
                 7, 0, 22, 0, 32.87981730820367, -117.23568992793975, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Seed + Sprout", "Brings offers fresh delicious healthy macro bowls.",
                 8, 0, 19, 0, 32.88004010264586, -117.23591028452954, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Sixty-Four North", "American Restaurant",
                 11, 0, 15, 0, 32.87502820408019, -117.24208557246205, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Blue Pepper", "Basic setting for classic Pan-Asian soups & sandwiches inside the UCSD Student Center.",
                 10, 0, 20, 0, 32.877593682800196, -117.24040069145455, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Izakaya Underbelly", "Ramen Restaurant",
                 11, 0, 21, 0, 32.87748784945499, -117.23975470281339, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Roots", "Vegan Food",
                 9, 0, 21, 0, 32.8790510066365, -117.24250879653977, 3, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Bistro", "Sleek eatery on the UCSD campus featuring a diverse lineup of Asian dishes, including sushi.",
                 11, 0, 19, 0, 32.88854071639332, -117.2421477283473, 3, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
                 Restaurant("Canyon Vista", "Spacious UC-San Diego/Revelle College dining hall with counter-order burgers, sandwiches & pasta.",
                 7, 0, 21, 0, 32.88494027794204, -117.23343119591438, 2, ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"])
                  ]


rest_dict = {}

# # Use list of restaurants to populate dictionary

# temp = 0

for restaurant in restaurant_list:
  rest_dict[restaurant.id] = restaurant

ids_list = []

for restaurant in restaurant_list:
   ids_list.append(restaurant.id)

name_dict = {}

for restaurant in restaurant_list:
  name_dict[restaurant.name] = restaurant