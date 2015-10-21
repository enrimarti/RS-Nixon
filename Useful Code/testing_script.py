
# coding: utf-8

# In[3]:

from average_precision import mapk


# In[10]:

k=5
l1={"ciao","cane","boia"}
l2={"ciao","cane","boia"}

#computes the mean average precision @k
mapk(l1,l2,k)

