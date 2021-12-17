/* to see the table you can type the following command. */
SELECT * from PoliceKillingsUS;

/* to know the number of people that may get killed without fleeing you can enter the following command.*/
SELECT A.NUM, A.DENOM, cast(A.NUM as float)/cast(A.DENOM as float)
FROM
(SELECT
(SELECT COUNT(flee)
FROM PoliceKillingsUS
WHERE flee='Not fleeing')
as NUM,
(SELECT COUNT(flee)
FROM PoliceKillingsUS)
AS DENOM
)A;

/*You can also have the first five states where Police has killed the most.*/
SELECT state, COUNT(state) AS `ocorrência` FROM PoliceKillingsUSGROUP BY state ORDER BY `ocorrência` DESC LIMIT 5;

/*To get the states where police has killed the least you just change ther ordering factor in the last command*/
SELECT state, COUNT(state) AS `ocorrência` FROM PoliceKillingsUS GROUP BY state ORDER BY `ocorrência` asc LIMIT 5;

/* we can also make multiple queries at once, as one may see below. We have select the average of poverty rate in the state and also what mean of black people in the cities of such a state
and also how many killings by the police was towards black people.
*/
SELECT (
SELECT avg(poverty_rate)
FROM PercentagePeopleBelowPovertyLevel
where Geographicarea = 'CA'
) AS average_of_poverty,
(
SELECT avg(share_black)
FROM ShareRaceByCity
where Geographicarea = 'CA'
) AS average_of_black,(
SELECT COUNT(state)
FROM PoliceKillingsUS
where state = 'CA' AND race = 'B'
) AS number_of_deaths
