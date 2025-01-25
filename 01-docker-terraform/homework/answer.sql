SELECT
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END) AS trips_up_to_1_mile,
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END) AS trips_between_1_and_3_miles,
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END) AS trips_between_3_and_7_miles,
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END) AS trips_between_7_and_10_miles,
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END) AS trips_over_10_miles
FROM green_tripdata
WHERE 
    lpep_pickup_datetime >= '2019-10-01 00:00:00'
    AND lpep_pickup_datetime < '2019-11-01 00:00:00'
    AND lpep_dropoff_datetime >= '2019-10-01 00:00:00'
    AND lpep_dropoff_datetime < '2019-11-01 00:00:00';



SELECT
    DATE(lpep_pickup_datetime) AS trip_date,
    MAX(trip_distance) AS longest_trip
FROM
    green_tripdata
WHERE
    lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
GROUP BY
    trip_date;

SELECT
    trip_distance, DATE(lpep_pickup_datetime)
FROM
    green_tripdata
WHERE
    lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
ORDER BY
    trip_distance DESC
LIMIT 2;


SELECT
    tzl."Zone",
    SUM(gtd.total_amount) AS total_amount
FROM
    green_tripdata gtd
JOIN
    taxi_zone_lookup tzl ON gtd."PULocationID" = tzl."LocationID"
WHERE
    DATE(lpep_pickup_datetime) = '2019-10-18'
GROUP BY
    tzl."Zone"
HAVING
    SUM(gtd.total_amount) > 13000
ORDER BY
    total_amount DESC
LIMIT 3;


SELECT
    tzl."Zone",
    MAX(gtd.tip_amount) AS total_tips
FROM
    green_tripdata gtd
JOIN
    taxi_zone_lookup tzl ON gtd."DOLocationID" = tzl."LocationID"
WHERE
    DATE(lpep_pickup_datetime) BETWEEN '2019-10-01' AND '2019-10-31'
    AND gtd."PULocationID" IN (
        SELECT "LocationID"
        FROM taxi_zone_lookup
        WHERE "Zone" = 'East Harlem North'
    )
GROUP BY
    tzl."Zone"
ORDER BY
    total_tips DESC
LIMIT 3;

