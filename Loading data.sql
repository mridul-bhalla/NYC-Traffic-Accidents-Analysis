CREATE DATABASE nyc_collisions;

CREATE TABLE collisions (
collision_id INT NOT NULL,
collision_date DATE NOT NULL,
collision_time TIME NOT NULL,
borough TEXT,
street_name TEXT,
cross_street TEXT,
latitude DECIMAL(8, 6),
longitude DECIMAL(9, 6),
contributing_factor TEXT,
vehicle_type TEXT,
persons_injured INT,
persons_killed INT,
pedestrians_injured INT,
pedestrians_killed INT,
cyclists_injured INT,
cyclists_killed INT,
motorists_injured INT,
motorists_killed INT,
PRIMARY KEY (collision_id) );

SELECT * FROM nyc_collisions.collisions;

SELECT COUNT(collision_id) FROM nyc_collisions.collisions;




