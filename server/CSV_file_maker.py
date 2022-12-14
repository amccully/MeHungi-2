#!/usr/bin/env python
# coding: utf-8

# In[13]:


from csv_create import create_row
from restaurant import restaurant_list
import numpy as np
import pandas as pd
import random

from sklearn import tree
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import KFold
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.metrics import r2_score, mean_squared_error
import joblib
import pickle

# import matplotlib.pylab as plt

#df2 = create_row(create_row(restaurant_list[random.randint(0, 14)]), columns = [["Name", "Time", "Day", "Orders", "Wait"]])

create_row(restaurant_list[random.randint(0, 14)])


# In[3]:


df1 = pd.DataFrame(columns=["Name", "Rest Num","Time (Normal)", "Time (Min)", "Day", "Day (Encoding)", "Orders", "Wait"])
# NAME | TIME | DAY | ORDERS | WAIT
#df1.columns = ["Name", "Time", "Day", "Orders", "Wait"]
# create_row(restaurant_list[random.randint(0, 14)])
for i in range(0, 10000):
    df1.loc[i] = create_row(restaurant_list[random.randint(0, 14)])
df1
# In[4]:


X = df1.drop(columns = ['Time (Normal)', 'Wait', 'Name', 'Day'])



# In[5]:


y = df1['Wait']



# In[6]:


cross_valid=KFold(n_splits=10,shuffle=True,random_state=1)

for depth in range (1,10):
    tree_test=tree.DecisionTreeRegressor(max_depth=depth,random_state=1)
    if tree_test.fit(X,y).tree_.max_depth<depth:
        break
    score = np.mean(cross_val_score(tree_test, X, y, 
                                    scoring='neg_mean_squared_error',
                                    cv=cross_valid,n_jobs=1))
    print(depth, score)


# In[6]:


"""GBR=GradientBoostingRegressor()
search_grid={'n_estimators':[2000], 
             'learning_rate':[0.1],
             'max_depth':[1, 4],'subsample':[.5,.75, 1],'random_state':[1]}
search=GridSearchCV(estimator=GBR,param_grid=search_grid,
                   scoring='neg_mean_squared_error', n_jobs=1,
                   cv=cross_valid)"""


# In[7]:


#search.fit(X,y)
#print(search.best_params_)
#print(search.best_score_)


# In[7]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
X_train.shape, X_test.shape, y_train.shape, y_test.shape


# my_gbm = GradientBoostingRegressor(n_estimators=3500,
#                                    learning_rate=0.05,
#                                    max_depth=4,
#                                    no_iter_no_change=15,
#                                    verbose=1)
# my_gbm.fit(X_train, y_train) 

# In[8]:


my_gbm = GradientBoostingRegressor(n_estimators=3500,
                                   learning_rate=0.05,
                                   max_depth=4,
                                   n_iter_no_change=25,
                                   verbose=1, subsample=1)
my_gbm.fit(X_train, y_train) 


# In[9]:


y_train_pred = my_gbm.predict(X_train)
y_test_pred = my_gbm.predict(X_test)
print('R^2 train: %.3f, test: %.3f' % (r2_score(y_train, y_train_pred), r2_score(y_test, y_test_pred)))
print('MSE train: %.3f, test: %.3f' % (mean_squared_error(y_train, y_train_pred), mean_squared_error(y_test, y_test_pred)))


# In[16]:


pickle.dump(my_gbm, open('Wait_Time_Calculator.sav', 'wb'))


# In[11]:


df2 = pd.DataFrame(columns=["Rest Num","Time (Min)", "Day (Encoding)", "Orders"])
# NAME | TIME | DAY | ORDERS | WAIT
#df1.columns = ["Name", "Time", "Day", "Orders", "Wait"]
# create_row(restaurant_list[random.randint(0, 14)])
df2.loc[len(df2)] = [0, 800, 2, 4]
df2


# In[12]:


value = my_gbm.predict(df2)
value[0]


# In[17]:


model = pickle.load(open('Wait_Time_Calculator.sav', 'rb'))


# In[18]:


model.predict(df2)


# In[ ]:

order_df = pd.DataFrame(columns=["Rest Num", "Time (Min)", "Day (Encoding)", "Orders", "Wait"])

order_df.to_csv('orders.csv')
order_df



# %%
