SET @row_number:=0; 
SET @country_median:='';
CREATE TABLE country_vaccination_stats2

SELECT 
    country_median, AVG(daily_vaccination) AS median
FROM
    (SELECT 
        @row_number:=CASE
                WHEN @country_median = country THEN @row_number + 1
                ELSE 1
            END AS count_of_group,
            @country_median:=country AS country_median,
            country,
            daily_vaccination,
            (SELECT 
                    COUNT(*)
                FROM
                    country_vaccination_stats
                WHERE
                    a.country = country) AS total_of_group
    FROM
        (SELECT 
        country, daily_vaccination
    FROM
        country_vaccination_stats
    ORDER BY country , daily_vaccination) AS a) AS b
WHERE
    count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY country_median

/* Now that we have median value for each country, we will replace NaN values with median
Also for countries which dont have any observation we will add "0"*/

/* We will save the final result in a new column called "Final_daily_vaccination" */

SELECT country_median, daily_vaccination,COALESCE(daily_vaccination,country_median,0) AS Final_daily_vaccination
FROM country_vaccination_stats2
WHERE daily_vaccination IS NULL
