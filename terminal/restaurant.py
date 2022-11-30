import uuid
import pandas as pd
# import joblib
# import pickle
from sklearn.ensemble import GradientBoostingRegressor
import datetime
# from restaurant_list import restaurant_list

class Restaurant:


    def __init__(self, name: str, description: str, openHour: int, openMinute: int,
    closeHour: int, closeMinute: int, latitude: float, longitude: float, money: int):
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

    
