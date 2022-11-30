import datetime

order_lookup = {
    "Hamburger": 5, 
    "Hotdog": 3, 
    "Nachos": 2, 
    "Pizza": 6, 
    "Chicken Sandwich": 5
    }

class Order:

    def __repr__(self):
        return self.restName + " Order :" + str(self.items)

    def __init__(self, restName: str, orderTime: int, items: list, numInLine: int, orderId: str):
        self.restName = restName
        self.orderTime = orderTime
        self.items = items
        self.finishedTime = 830 #None
        self.day = datetime.datetime.now().weekday()
        self.numInLine = numInLine
        self.orderId = orderId
        # lookup table for order to normal wait time

    def find_time(items: list):
        count = 0
        for item in items:
            count += order_lookup.get(item, 0)
        return count



