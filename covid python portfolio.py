#!/usr/bin/env python
# coding: utf-8

# In[2]:


import numpy as np


# In[3]:


import pandas as pd


# In[4]:


import matplotlib.pyplot as plt


# In[5]:


import seaborn as sns


# In[6]:


get_ipython().run_line_magic('matplotlib', 'inline')


# In[7]:


import os


# In[ ]:





# In[8]:


# Reading the data file into the jupyter notebook
df = pd.read_csv('covid.df.csv')


# In[ ]:


type (df)


# In[9]:


df


# In[10]:


df.info()


# In[11]:


df.describe()


# In[12]:


df.columns


# In[13]:


df.shape


# In[14]:


covid_nigeria = df.query("location == 'Nigeria'")


# In[15]:


covid_nigeria


# In[16]:


covid_nigeria.info()


# In[17]:


covid_nigeria.describe()


# In[18]:


covid_nigeria.sample(10)


# In[19]:


high_new_cases = covid_nigeria.new_cases > 1000


# In[20]:


covid_nigeria[high_new_cases]


# In[21]:


covid_nigeria[high_new_cases].info()


# In[22]:


# total cases and total deaths
total_cases = covid_nigeria.new_cases.sum()
total_deaths = covid_nigeria.new_deaths.sum()


# In[23]:


print ('The number of reported cases is {} and the number of reported deaths is {}.'.format(total_cases,total_deaths))


# In[24]:


# Overall death rate (ratio of reported deaths to reported cases)
death_rate = covid_nigeria.new_deaths.sum() / covid_nigeria.new_cases.sum()


# In[25]:


print('The overall reported death rate in Nigeria is {:.0%}.'.format(death_rate))


# In[26]:


# Overall number of tests conducted
total_tests = covid_nigeria.new_tests.sum()


# In[27]:


total_tests


# In[28]:


# Fraction of tests returned to be positive results
positive_rate = total_cases / total_tests


# In[29]:


print('{:.0%} of tests in Nigeria led to a positive diagnosis.'.format(positive_rate))


# In[30]:


high_ratio_df = covid_nigeria[covid_nigeria.new_cases / covid_nigeria.new_tests > positive_rate]


# In[31]:


high_ratio_df


# In[32]:


# days where highest number of cases where reported
covid_nigeria.sort_values('new_cases', ascending=False).head(10)


# ##### Seems like the reported cases on 12th Dec was very high compared to the rest and also the number of cases where at the peak at the beginning of the year 2021

# In[33]:


# days where highest number of deaths where recorded
covid_nigeria.sort_values('new_deaths', ascending=False).head(10)


# In[34]:


covid_nigeria.date = pd.to_datetime(covid_nigeria.date)


# In[35]:


covid_nigeria['year'] = pd.DatetimeIndex(covid_nigeria.date).year
covid_nigeria['month'] = pd.DatetimeIndex(covid_nigeria.date).month
covid_nigeria['weekday'] = pd.DatetimeIndex(covid_nigeria.date).weekday


# In[36]:


covid_nigeria['month_full'] = covid_nigeria['date'].dt.month_name()


# In[37]:


covid_nigeria


# In[40]:


monthly_groups= covid_nigeria.groupby('month')


# In[41]:


# sum of new cases,deaths, and tests in each months of the year
monthly_groups[['new_cases','new_deaths','new_tests']].sum()


# In[42]:


weekly_groups =covid_nigeria.groupby('weekday')


# In[43]:


# sum of new cases,deaths, and tests in each days of the week
weekly_groups[['new_cases','new_deaths','new_tests']].mean()


# In[44]:


covid_nigeria['total_cases'] = (covid_nigeria.new_cases).cumsum()
covid_nigeria['total_deaths'] = (covid_nigeria.new_deaths).cumsum()


# In[45]:


covid_nigeria.set_index('date', inplace=True)


# In[46]:


covid_nigeria


# In[47]:


covid_nigeria.groupby('year').new_cases.sum().plot.bar();


# In[49]:


covid_nigeria.groupby('month').new_cases.sum().plot.line();

