from csv_create import create_row
import random
import pandas as pd
from restaurant import restaurant_list

df1 = pd.DataFrame(columns=["Name", "Rest Num","Time (Normal)", "Time (Min)", "Day", "Day (Encoding)", "Orders", "Wait"])
    # NAME | TIME | DAY | ORDERS | WAIT
    #df1.columns = ["Name", "Time", "Day", "Orders", "Wait"]
    # create_row(restaurant_list[random.randint(0, 14)])
for i in range(0, 10000):
    df1.loc[i] = create_row(restaurant_list[random.randint(0, len(restaurant_list) - 1)])

df1.to_csv('learning_data.csv')