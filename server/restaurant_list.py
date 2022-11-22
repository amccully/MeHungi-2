from restaurant import Restaurant


# Initialize Restaurants and group them in a list

restaurant_list = [ Restaurant("Burger King", "trash fastfood burger place", 0, 0, 10, 0, 111.124754 , 103.1432 ),
                   Restaurant("Panda Express","human trough", 0, 0, 10, 0, 111.124743, 103.143212),
                 Restaurant("Subway", "pay 10 dollars for a sandwhich you could've made better", 0,
                                0, 10, 0, 111.124754, 103.1432)]

restaurant_dict = {}

# Use list of restaurants to populate dictionary

for restaurant in restaurant_list:
  restaurant_dict[restaurant.id] = restaurant.to_dic()