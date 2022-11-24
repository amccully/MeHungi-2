from restaurant import Restaurant


# Initialize Restaurants and group them in a list
# 32.881398208652115, longitude: -117.23520934672317

restaurant_list = [ Restaurant("Burger King", "trash fastfood burger place", 0, 0, 10, 0, 32.881398208652115, -117.23520934672317),
                   Restaurant("Panda Express","human trough", 0, 0, 10, 0, 32.881398208662115, -117.23520934671317),
                 Restaurant("Subway", "pay 10 dollars for a sandwhich you could've made better", 0,
                                0, 10, 0, 32.881398208650115, -117.23520934672417)]

restaurant_dict = {}

# Use list of restaurants to populate dictionary

for restaurant in restaurant_list:
  restaurant_dict[restaurant.id] = restaurant.to_dic()