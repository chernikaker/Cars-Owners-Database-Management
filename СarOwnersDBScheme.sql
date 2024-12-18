USE CarOwnersDB;

CREATE TABLE Country (
    country_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Owner (
    owner_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    address VARCHAR(100),
	phone_number VARCHAR(30) NOT NULL,
    email VARCHAR(30),
    driving_category VARCHAR(10) NOT NULL,
    license_date DATE NOT NULL,
	CHECK (first_name !='' AND last_name != '' AND driving_category !=''),
	CHECK (email LIKE '%@%.%'),
    CHECK (phone_number LIKE '+%(%)%'),
	CHECK (license_date>'1950-01-01' AND license_date<=GETDATE()),
	CHECK (birth_date>'1940-01-01' AND birth_date<=GETDATE())
);


CREATE TABLE Car (
    car_number VARCHAR(10) PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    production_year INT NOT NULL,
    color VARCHAR(30) NOT NULL,
    price MONEY NOT NULL,
    engine_capacity DECIMAL(4, 1) NOT NULL,
    sell_date DATE NOT NULL,
    register_country_id INT NOT NULL,
	owner_id INT NOT NULL,
    mileage INT NOT NULL,
    FOREIGN KEY (register_country_id) REFERENCES Country(country_id),
	FOREIGN KEY (owner_id) REFERENCES Owner(owner_id),
	CHECK (production_year>1950 AND production_year < YEAR(GETDATE())),
	CHECK (engine_capacity > 0.0 AND mileage > 0),
	CHECK (car_number != '' AND brand != '' AND model!='' AND color != ''),
	CHECK (price > 0.0),
	CHECK (sell_date>'1950-01-01' AND sell_date<=GETDATE())
);

