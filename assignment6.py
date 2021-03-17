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
#*****************************up to here is from previous assignment to get cleaned data***************

#will groupby daily_vaccination and find their sum, then will show data related to the date asked in the question 
Total_Vaccination=Finaldf.groupby("date").daily_vaccinations.sum()
print(Total_Vaccination.loc["1/6/2021"])