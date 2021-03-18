SET @row_number:=0; 
SET @country_group:='';

SELECT 
    country_group, AVG(daily_vaccination) AS median
FROM
    (SELECT 
        @row_number:=CASE
                WHEN @country_group = country THEN @row_number + 1
                ELSE 1
            END AS count_of_group,
            @country_group:=country AS country_group,
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
GROUP BY country_group