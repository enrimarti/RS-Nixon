
# coding: utf-8

# In[1]:
from math import sqrt
#list1: [(item1,int rating1)...(itemN,ratingN)] of user1
#list2: [(item1,int ratingM)...(itemN,ratingM)] of user2
#returns euclidean distance between user1 and user2
def euc_dist (ratings1_list, ratings2_list):
    shared_items=[]
    for item1 in ratings1_list:
        for item2 in ratings2_list:
            if (item1[0] == item2[0]):
                shared_items.append([item1[1], item2[1]])
    
    n_items = len(shared_items)
    if (n_items == 0): return 0
    
    sum_of_squares =sum([pow(vote[0]-vote[1],2) for vote in shared_items])
    return 1.0 / float( 1 + sqrt(sum_of_squares))

#list1: [(item1,int rating1)...(itemN,ratingN)] of user1
#list2: [(item1,int ratingM)...(itemN,ratingM)] of user2
#returns pearson similarity between user1 and user2
def sim_pearson(ratings1,ratings2):
    ratings_common=[]
    for rate1 in ratings1:
        for rate2 in ratings2:
            if (rate1[0]==rate2[0]):
                ratings_common.append([rate1[1],rate2[1]])

    n=len(ratings_common)
    if (n==0):
        return 0
    
    sum1=float(sum([rate[0] for rate in ratings_common]))
    sum2=float(sum([rate[1] for rate in ratings_common]))
    
    sum1sq=float(sum([pow(rate[0],2) for rate in ratings_common]))
    sum2sq=float(sum([pow(rate[1],2) for rate in ratings_common]))
    
    pSum=float(sum([rate[0]*rate[1] for rate in ratings_common]))
    
    num=pSum-(sum1*sum2/n)
    den=sqrt((sum1sq-pow(sum1,2)/n)*(sum2sq-pow(sum2,2)/n))
    if den==0: return 0
    
    return num/den


#list1: [(item1,int rating1)...(itemN,ratingN)] of user1
#list2: [(item1,int ratingM)...(itemN,ratingM)] of user2
#returns cosine similarity between user1 and user2
def square_rooted(x):
    return sqrt(sum([a*a for a in x]))

def cosine_similarity(ratings1,ratings2):
    
    def square_rooted(x):
    return sqrt(sum([a*a for a in x]))
    
    ratings_common=[]
    for rate1 in ratings1:
        for rate2 in ratings2:
            if (rate1[0]==rate2[0]):
                ratings_common.append([rate1[1],rate2[1]])

    n=len(ratings_common)
    if (n==0):
        return 0
    
    numerator = sum([vote[0]*vote[1] for vote in ratings_common])
    denominator = square_rooted([vote[0] for vote in ratings_common])*square_rooted([vote[1] for vote in ratings_common])
    return round(numerator/float(denominator),3)


def euc_dist2 (ratings1_list, ratings2_list):
    shared_items=[]
    for item1 in ratings1_list:
        for item2 in ratings2_list:
            if (item1[0] == item2[0]):
                shared_items.append([item1[1], item2[1]])
    
    n_items = len(shared_items)
    if (n_items == 0): return 0
    
    sum_of_squares =sum([pow(vote[0]-vote[1],2) for vote in shared_items])
    return sqrt(n_items) / float(sqrt(n_items) + sqrt(sum_of_squares))


