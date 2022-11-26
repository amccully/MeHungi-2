import uuid
import pandas as pd
import joblib
from sklearn.ensemble import GradientBoostingRegressor
import datetime
from restaurant_list import restaurant_list

class Restaurant:


    def __init__(self, name: str, description: str, openHour: int, openMinute: int,
    closeHour: int, closeMinute: int, latitude: float, longitude: float):
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

    def to_dic(self):
        return {"id": self.id, "name": self.name, "description": self.description,
         "open hour": self.openHour, "open minute": self.openMinute, "close hour": self.closeHour,
         "close minute": self.closeMinute, "latitude": self.latitude, "longitude": self.longitude,
         "waitTime" : self.find_wait()}

    def orders_wait_time(self):
        count = 0
        for order in self.orders:
            count += order.completion_time
        return count
        
    def find_wait(self):
        model = joblib.load('Wait_Time_Calculator')
        curr_time = datetime.datetime.now()
        curr_day = curr_time.weekday()
        input_data = [restaurant_list.index(self.name), curr_time.hour * 60 + curr_time.minute, curr_day, len(self.orders)]
        input_df = pd.DataFrame(columns=["Rest Num", "Time (Min)", "Day (Encoding)", "Orders"])
        input_df.loc[len(input)] = input_data
        wait = model.predict(input_df)
        return round(wait[0])

    