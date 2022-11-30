from restaurant import Restaurant, restaurant_list


# Initialize Restaurants and group them in a list
# 32.881398208652115, longitude: -117.23520934672317

ids_list = []

for restaurant in restaurant_list:
   ids_list.append(restaurant.id)

restaurant_dict = {}

# # Use list of restaurants to populate dictionary

# temp = 0

for restaurant in restaurant_list:
  restaurant_dict[restaurant.id] = restaurant


  # temp = restaurant.id

# print(restaurant_dict)
# print()
# print(temp)
# print()
# print(restaurant_dict[temp])
