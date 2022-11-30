import random
from api_requests import get_order, update_order, delete_order, rest_list

def generate_items():
    items = ["Smoothie", "Burger", "Fries", "Milkshake", "Noodles", "Sushi", "Pizza", "Nuggets", "Soda"]
    my_items: list = []
    upper = random.randint(1,3)
    for i in range(0, upper):
        my_items.append(items[random.randint(0,len(items)-1)])
    return my_items


curr_rest = "Seed + Sprout"

# for i in range(0, 5):
#     update_order(generate_items(), curr_rest, random.randint(0, 5))

# print()
# get_order(curr_rest)

curr_id = "59462AA3-1751-4B7C-9632-E1946C6B519"
delete_order(curr_id, curr_rest)
get_order(curr_rest)


