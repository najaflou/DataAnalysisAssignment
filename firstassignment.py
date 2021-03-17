#importing required libraries
import pandas as pd
import numpy as np

#Reading CSV file into a dataframe called df2
df2= pd.read_csv(r"C:\Users\najaf\Downloads\country_vaccination_stats.csv")

#will get a list of name of the countries in this dataframe
CountryList= df2.country.unique()

#Creating an empty dataframe to append results.
Finaldf = pd.DataFrame() 

for cntry in CountryList:
    CountryMinValue= (df2[df2.country ==cntry]).min()["daily_vaccinations"]
    Tempdf= (df2[df2.country ==cntry]).fillna(CountryMinValue)
    Finaldf=Finaldf.append(Tempdf)
