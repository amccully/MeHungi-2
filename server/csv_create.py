from restaurant import Restaurant
from restaurant_list import restaurant_list
import pandas as pd
import random
import math

def create_row(rest: Restaurant):
    # NAME | TIME | DAY | ORDERS | WAIT
    wait_mean: float
    wait_sd: float
    order_mod: int
    orders = 0

    if rest.name == "Burger King":
        wait_mean = 4
        wait_sd = 2
        order_mod = 2
    elif rest.name == "Panda Express":
        wait_mean = 2
        wait_sd = 1
        order_mod = 1
    elif rest.name == "Subway":
        wait_mean = 4
        wait_sd = 1
        order_mod = 2
    elif rest.name == "Jamba Juice":
        wait_mean = 6
        wait_sd = 2
        order_mod = 3
    elif rest.name == "Dirty Birds":
        wait_mean = 18
        wait_sd = 5
        order_mod = 2
    elif rest.name == "Curry Up Now":
        wait_mean = 4
        wait_sd = 1
        order_mod = 2
    elif rest.name == "Rubio's":
        wait_mean = 6
        wait_sd = 3
        order_mod = 2
    elif rest.name == "Starbucks":
        wait_mean = 4
        wait_sd = 2
        order_mod = 2
    elif rest.name == "Yogurt World":
        wait_mean = 2
        wait_sd = 1
        order_mod = 1
    elif rest.name == "Croutons":
        wait_mean = 12
        wait_sd = 3
        order_mod = 3
    elif rest.name == "Taco Villa":
        wait_mean = 5
        wait_sd = 3
        order_mod = 3
    elif rest.name == "Caroline's Seaside Cafe":
        wait_mean = 15
        wait_sd = 5
        order_mod = 2
    elif rest.name == "Lemongrass Farm Fresh Plates":
        wait_mean = 18
        wait_sd = 6
        order_mod = 4
    elif rest.name == "Santorini Greek Island Grill":
        wait_mean = 8
        wait_sd = 3
        order_mod = 4
    elif rest.name == "Seed and Sprout":
        wait_mean = 11
        wait_sd = 3
        order_mod = 5
    else:
        print("Wrong Input")
        return

    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    curr_day = days[random.randint(0, 6)]

    curr_time = random.randint(60*rest.openHour + rest.openMinute, rest.closeHour*60 + rest.closeMinute)

    if 8*60 < curr_time and curr_time <= 10*60:
        orders = random.gauss(1, 1)
    elif 10*60 < curr_time and curr_time <= 11*60 + 30:
        orders = random.gauss(2, 1)
    elif 11*60 + 30 < curr_time and curr_time <= 13*60 + 30:
        orders = random.gauss(4, 1)
    elif 18*60 + 30 < curr_time and curr_time <= 19*60 + 30:
        orders = random.gauss(3, 1)
    else:
        orders = random.gauss(2, 1)
        
    orders =  0 if orders < 0 else orders
    orders =  8 if orders > 8 else orders
    

    if curr_day == "Sunday" or curr_day == "Saturday":
        wait_mean *= .75
        wait_sd *= .75
    
    wait_mean = wait_mean+(order_mod*orders)

    wait = random.gauss(wait_mean, wait_sd)
    wait = 1 if wait < 0 else ( 15 + wait_mean+orders*order_mod if wait >15 + wait_mean+orders*order_mod else wait)
    hours = math.floor(curr_time/60)
    min = curr_time - 60*hours
    time = str(hours) + ":" +  (str(min) if min >= 10 else ("0" + str(min)))

    return [rest.name, restaurant_list.index(rest), time ,curr_time , curr_day, days.index(curr_day), round(orders), round(wait)]



#df = pd.DataFrame()
# NAME | TIME | DAY | ORDERS | WAIT
#df.columns = ["Name", "Time", "Day", "Orders", "Wait"]

#for i in range(0, 100):
 #   df.loc[len(df)] = create_row(restaurant_list[random.randint(0, 14)])

