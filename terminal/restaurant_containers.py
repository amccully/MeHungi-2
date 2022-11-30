import requests
from restaurant import Restaurant

BASE = "http://127.0.0.1:5000/"


# get all restaurant IDs 

response = requests.get(BASE + "IDs")

idsList = response.json()['ids']

# print(response.json())

# print()

# print(idsList)
rest_list = []
name_dict = {}
id_dict = {}
# Create List 
for id in idsList:
    # Parse JSON into an object with attributes corresponding to dict keys.
    response = requests.get(BASE + "restaurant/" + id)
    rest_JSON = response.json() 
    rest = Restaurant(rest_JSON["name"], rest_JSON["description"], rest_JSON["openHour"], rest_JSON["openMinute"],
    rest_JSON['closeHour'], rest_JSON['closeMinute'], rest_JSON['latitude'], rest_JSON['longitude'], rest_JSON['money'])
    # print(rest.name + ": " + rest.description + "\nWait Time: " +  str(rest.waitTime))
    # print()
    rest.id = id
    rest_list.append(rest)
    name_dict[rest.name] = rest
    id_dict[id] = rest