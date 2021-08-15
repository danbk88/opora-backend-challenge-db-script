-- get_drivers_of_season_sp: 
DELIMITER //
CREATE PROCEDURE get_drivers_of_season_sp (
season INT
)
BEGIN
-- get_drivers_of_season_sp: 
select d.*, sum(ds.points) points, sum(ds.wins) wins
from races sr join driver_standings ds 
		on ds.raceId = sr.raceId 
		join drivers d
        on ds.driverId = d.driverId
 	where year=season 
    group by d.driverId
    order by sum(ds.wins) DESC;

END //
DELIMITER ;

-- get_all_seasons_top_drivers_sp: 
DELIMITER //
CREATE PROCEDURE get_all_seasons_top_drivers_sp ()
BEGIN
-- get_all_seasons_top_drivers_sp: 

    select * 
    from (
    select sr.year, d.*, sum(ds.points) points, sum(ds.wins) wins, ROW_NUMBER() over (PARTITION BY year Order by  sum(ds.wins) desc) AS rnk
	from races sr join driver_standings ds 
		on ds.raceId = sr.raceId 
		join drivers d
        on ds.driverId = d.driverId
    group by d.driverId, sr.year
    order by year DESC
    ) ranks
    where ranks.rnk <= 3;

END //
DELIMITER ;
-- get_driver_profile
DELIMITER //
CREATE PROCEDURE get_driver_profile_sp (
driverId INT
)
BEGIN
-- get_driver_profile: 
select ds.driverId,  ds.raceId, c.name circuitName, ds.position, ds.points, avg(ps.milliseconds) avgPit, max(ps.milliseconds) maxPit, max(ps.stop) pitsCount, min(ps.milliseconds) minPit ,avg(lt.milliseconds) avgLap, max(lt.milliseconds) maxLap, min(lt.milliseconds) minLap
from drivers d
join driver_standings ds on d.driverId = ds.driverId
join races r on r.raceId = ds.raceId 
join circuits c on r.circuitId = c.circuitId
join pit_stops ps on (ps.raceId = ds.raceId and ps.driverId = ds.driverId)	
join lap_times lt on (lt.raceId = ds.raceId and lt.driverId = ds.driverId)	
where ds.driverId = driverId
group by ds.raceId, ds.driverId, c.name, ds.position, ds.points;

END //
DELIMITER ;

