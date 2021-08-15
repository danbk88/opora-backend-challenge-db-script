import * as fs from 'fs';
import * as fastcsv from 'fast-csv'
import * as mysql from 'mysql';

let pool = mysql.createPool({
    connectionLimit: 20,
    host: "localhost",
    user: "root",
    password: "",
    database: "challenge"
});

readCsvToTable('./csv_files/driver_standings.csv', 'driver_standings', '(driverStandingsId, raceId, driverId, points, position, positionText, wins)');
readCsvToTable('./csv_files/drivers.csv', 'drivers', '(driverId, driverRef, number, code, forename, surname, nationality, dob, url)');
readCsvToTable('./csv_files/lap_times.csv', 'lap_times', '(raceId, driverId, lap, position, time, milliseconds)');
readCsvToTable('./csv_files/pit_stops.csv', 'pit_stops', '(raceId, driverId, stop, lap, time, duration, milliseconds)');
readCsvToTable('./csv_files/seasons.csv', 'seasons', '(year, url)');
readCsvToTable('./csv_files/circuits.csv', 'circuits', '(circuitId, circuitRef, name, location, country, lat, lng, alt, url)');
readCsvToTable('./csv_files/races.csv', 'races', '(raceId, year, round, circuitId, name, date, time, url)');

function readCsvToTable(fileRoute, tableName, params){
    let stream = fs.createReadStream(fileRoute);
    let csvData = [];
    let csvStream = fastcsv.parse()
        .on("data", function (data) {
            csvData.push(data);
        })
        .on("end", function () {
            csvData.shift();
            // open the connection
            pool.getConnection(function (err, connection) {
                if (err){
                    // not connected!
                    return err;
                }

                // Use the connection
                let query =
                        `INSERT INTO ${tableName} ${params} VALUES ?`;

                    // save csvData
                    connection.query(query, [csvData], (error, response) => {
                        return console.log(error || response);
                    });
            });
        });
    
    stream.pipe(csvStream);
};
