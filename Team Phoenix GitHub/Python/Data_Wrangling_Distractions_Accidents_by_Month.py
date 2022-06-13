import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from matplotlib import pyplot as plt
from sklearn import metrics
import numpy as np
import datetime
import warnings
warnings.filterwarnings("ignore")
import seaborn as sns
sns.set(style="white", color_codes=True)


#Read in Data and look at the Data 
distract = pd.read_csv('C:/Users/bswil/Desktop/Team Phoenix/Data/distract.csv')
distract.head()
distract.info()

accident = pd.read_csv('C:/Users/bswil/Desktop/Team Phoenix/Data/accident.csv')
accident.head()
accident.info()


#Decoding of the States
states = {1: 'Alabama', 2: 'Alaska', 4: 'Arizona', 5: 'Arkansas', 
          6: 'California', 8: 'Colorado', 9: 'Connecticut', 10: 'Delaware', 
          11: 'District of Columbia', 12: 'Florida', 13: 'Georgia', 15: 'Hawaii', 
          16: 'Idaho', 17: 'Illinois', 18: 'Indiana', 19: 'Iowa', 20: 'Kansas', 
          21: 'Kentucky', 22: 'Louisiana', 23: 'Maine', 24: 'Maryland', 
          25: 'Massachusetts', 26: 'Michigan', 27: 'Minnesota', 
          28: 'Mississippi', 29: 'Missouri', 30: 'Montana', 31: 'Nebraska', 
          32: 'Nevada', 33: 'New Hampshire', 34: 'New Jersey', 35: 'New Mexico', 
          36: 'New York', 37: 'North Carolina', 38: 'North Dakota', 39: 'Ohio', 
          40: 'Oklahoma', 41: 'Oregon', 42: 'Pennsylvania', 43: 'Puerto Rico', 
          44: 'Rhode Island', 45: 'South Carolina', 46: 'South Dakota', 47: 'Tennessee', 
          48: 'Texas', 49: 'Utah', 50: 'Vermont', 51: 'Virginia', 52: 'Virgin Islands', 
          53: 'Washington', 54: 'West Virginia', 55: 'Wisconsin', 56: 'Wyoming'}

distract['state']=distract['STATE'].apply(lambda x: states[x])

#Accidents by State
# Incident by state
distract['state'].value_counts().to_frame()
distract.T
distract2 = distract.set_index('state').T
distract3 = distract2.T

#  Motorists in the crash by persons (not assuming they are all fatalities)
accident["PERSONS"].value_counts()
# Total sum of persons in accidents
accident["PERSONS"].sum()
# Broken Down to Fatalities
accident["FATALS"].value_counts()
# Total Fatalitles
accident["FATALS"].sum()

#Decoding Destractions 
# Reading in the data
FILE = "C:/Users/bswil/Desktop/Team Phoenix/Data/distract.csv"
distractions_data = pd.read_csv(FILE, encoding = "ISO-8859-1")
distractions_data.head

distract = {0: 'Not Distracted', 1: 'Looked But Did Not See',
           3: 'By Other Occupant(s)', 4: 'By a Moving Object in Vehicle',
           5: 'While Talking or Listening to Cellular Phone',
           6: 'While Manipulating Cellular Phone',
           7: 'While Adjusting Audio or Climate Controls',
           9: 'While Using Other Component/Controls Integral to Vehicle',
           10: 'While Using or Reaching For Device/Object Brought Into Vehicle',
           12: 'Distracted by Outside Person, Object or Event',
           13: 'Eating or Drinking',
           14: 'Smoking Related',
           15: 'Other Cellular Phone Related',
           16: 'No Driver Present/Unknown if Driver Present',
           17: 'Distraction/Inattention',
           18: 'Distraction/Careless',
           19: 'Careless/Inattentive',
           92: 'Distraction (Distracted), Details Unknown',
           93: 'Inattention (Inattentive), Details Unknown',
           96: 'Not Reported',
           97: 'Lost In Thought/Day Dreaming',
           98: 'Other Distraction',
           99: 'Unknown if Distracted'}

distractions_data['mdrdstrd'] = distractions_data['MDRDSTRD'].apply(lambda x: distract[x])

distractions_data['mdrdstrd'].value_counts()

distract.head()