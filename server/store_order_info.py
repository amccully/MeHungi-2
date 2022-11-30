import pandas

from csv import writer

def store_order_info(order):
    from order import Order
    from restaurant import restaurant_list, name_dict
    rest_encoding = restaurant_list.index(name_dict[order.restName])
     # if open past midnight, will cause neg number error (UCSD doesn't have any that are open that long)
    row = [rest_encoding, order.orderTime, order.day, order.numInLine, order.finishedTime - order.orderTime]
    with open('orders.csv', 'a') as f_object:
 
        # Pass this file object to csv.writer()
        # and get a writer object
        writer_object = writer(f_object)
    
        # Pass the list as an argument into
        # the writerow()
        writer_object.writerow(row)
    
        # Close the file object
        f_object.close()

    return
     