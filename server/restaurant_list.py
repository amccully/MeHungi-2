from restaurant import Restaurant


# Initialize Restaurants and group them in a list

restaurant_list = [ Restaurant("Burger King", "trash fastfood burger place", 7, 0, 23, 59, 32.880010937246595, -117.23584745233543),
                   Restaurant("Panda Express","human trough", 9, 0, 17, 0, 32.87974893295122, -117.23639722612094),
                 Restaurant("Subway", "pay 10 dollars for a sandwhich you could've made better",
                  7, 0, 19, 0, 32.87958268075439, -117.23581169641686),
                Restaurant("Jamba Juice", "pay 10 dollars for a smoothie",
                 9, 0, 19, 0, 32.88003219036016, -117.23682997774515),
                Restaurant("Dirty Birds", "Frat food", 10,
                                0, 21, 30, 32.88011776711401, -117.23672354981419),
                Restaurant("Curry Up Now", "who?", 10,
                                0, 22, 0, 32.879988992613555, -117.23619591435616),
                Restaurant("Rubio's", "fast food but expensive", 10,
                                0, 20, 0, 32.88067347599053, -117.23547401849824),
                Restaurant("Starbucks", "Milkshakes with cocoa beans in them", 7,
                                0, 21, 0, 32.88002940880099, -117.2364259192577),
                Restaurant("Yogurt World", "Offers do-it-yourself frozen yogurt. Flavors from chocolate to green coconut and toppings from chocolate chips to lychee.",
                 0, 0, 10, 0, 32.87914905478985, -117.23589951722849),
                Restaurant("Croutons", "salad",
                 10, 0, 15, 0, 32.87863895176272, -117.23577683841106),
                 Restaurant("Taco Villa", "An authentic taco shop serving all your favorite Mexican food dishes right on campus.",
                 8, 0, 20, 0, 32.87699515125575, -117.24010419541086),
                 Restaurant("Caroline's Seaside Cafe", "Offers healthy and creative California-style cuisine featuring a diverse menu of hot and cold breakfast items, sandwiches, salads, soups, espresso drinks, baked goods, and desserts.",
                 8, 0, 15, 0, 32.86462979107682, -117.25417260500511),
                 Restaurant("Lemongrass Farm Fresh Plates", "Serves natural chicken, salmon and tofu with a healthy Asian fusion flair.",
                 9, 0, 19, 45, 32.87985600620295, -117.23605256267507),
                 Restaurant("Santorini Greek Island Grill", "Offers fare from around the Aegean, the Mediterranean, and beyond...",
                 7, 0, 22, 0, 32.87981730820367, -117.23568992793975),
                 Restaurant("Seed + Sprout", "Brings offers fresh delicious healthy macro bowls.",
                 8, 0, 19, 0, 32.88004010264586, -117.23591028452954)
                  ]


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