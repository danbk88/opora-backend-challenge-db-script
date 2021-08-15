-- Create drivers table
create table drivers (
    driverId INT NOT NULL,
    driverRef varchar(100) NOT NULL,
    number varchar(3),
    code varchar(3),
    forename varchar(30),
    surname varchar(30),
    nationality varchar(100),
    dob varchar(20),
    url varchar(800),
    
    PRIMARY KEY (driverId)
);

-- Create driver_standings table
create table driver_standings (
    driverStandingsId INT NOT NULL,
    raceId INT NOT NULL,
    driverId INT NOT NULL,
    points INT,
    position INT,
    positionText varchar(3),
    wins INT,

    PRIMARY KEY (driverStandingsId)
);

-- Create circuits table
create table circuits (
    circuitId INT NOT NULL,
    circuitRef varchar(100) NOT NULL,
    name varchar(100),
    location varchar(80),
    country varchar(80),
    lat FLOAT,
    lng FLOAT,
    alt INT,
    url varchar(800),

    PRIMARY KEY (circuitId)
);

-- Create races table
create table races (
    raceId INT NOT NULL,
    year INT,
    round INT,
    circuitId INT NOT NULL,
    name varchar(100),
    date varchar(20),
    time varchar(80),
    url varchar(800) NOT NULL,

    PRIMARY KEY (raceId)
);

-- Create lap_times table
create table lap_times (
    raceId INT NOT NULL,
    driverId INT NOT NULL,
    lap INT,
    position INT,
    time varchar(20),
    milliseconds INT,

    PRIMARY KEY (raceId, driverId, lap)
);

-- Create pit_stops table
create table pit_stops (
    raceId INT NOT NULL,
    driverId INT NOT NULL,
    stop INT,
    lap INT,
    time varchar(20),
    duration varchar(100),
    milliseconds INT,

    PRIMARY KEY (raceId, driverId, lap, stop)
);

-- Create seasons table
create table seasons (
    year INT,
    url varchar(800) NOT NULL
);