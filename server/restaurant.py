import uuid

class Restaurant:

    wait_time = 0

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

    def to_dic(self):
        return {"restaurant": {"id": self.id, "name": self.name, "description": self.description,
         "open hour": self.openHour, "open minute": self.openMinute, "close hour": self.closeHour,
         "close minute": self.closeMinute, "latitude": self.latitude, "longitude": self.longitude,
         "wait time" : self.wait_time}}

    