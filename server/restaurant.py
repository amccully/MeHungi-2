import uuid
import random

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
        self.wait_time = random.randrange(1,100)

    def to_dic(self):
        return {"id": self.id, "name": self.name, "description": self.description,
         "openHour": self.openHour, "openMinute": self.openMinute, "closeHour": self.closeHour,
         "closeMinute": self.closeMinute, "latitude": self.latitude, "longitude": self.longitude,
         "waitTime" : self.wait_time}

    