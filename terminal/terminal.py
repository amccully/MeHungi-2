import random
from api_requests import get_order, update_order, delete_order, check_if_order_exists, rest_list, id_dict, name_dict

def generate_items():
    items = ["Smoothie", "Burger", "Fries", "Milkshake", "Noodles", "Sushi", "Pizza", "Nuggets", "Soda"]
    my_items: list = []
    upper = random.randint(1,3)
    for i in range(0, upper):
        my_items.append(items[random.randint(0,len(items)-1)])
    return my_items




rest = False
# ask for which restaurant you want until you get a real restaurant
while rest == False:
    restName = input("Which Restaurant Do You Want To Access?\n")
    rest = name_dict.get(restName, False)
    if rest == False:
        print("Not a UCSD Restaurant")
    
print("Current Orders:")

orderResponse = get_order(rest.name)

print(str(orderResponse))

orders = orderResponse["orders"]
id_list = orderResponse["ids"]

print(orders)

i = 1
for order in orders:
    print("Order " + str(i) + ": " + str(order))
    i += 1


real_order = False

while real_order == False:
    order_to_delete = int(input("Which Order Do You Want to Delete?\n"))
    print(str(delete_order))
    if order_to_delete > 0 and order_to_delete <= len(id_list): 
    # check_if_order_exists(curr_id, curr_rest)
        print("Deleted")
        delete_order(id_list[order_to_delete- 1], rest.name)
        orderResponse = get_order(rest.name)
        orders = orderResponse["orders"]
        id_list = orderResponse["ids"]
        if len(orders) > 0:
            print("Remaining Orders")
        else:
            print("No More Orders")
        i = 1
        for order in orders:
            print("Order " + str(i) + ": " + str(order))
            i += 1
        real_order = True
    else:
        print("Does Not Exist")



