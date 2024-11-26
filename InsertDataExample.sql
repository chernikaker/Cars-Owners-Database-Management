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


INSERT INTO Country (name) VALUES
('United States'),
('Germany'),
('Japan');


INSERT INTO Owner (first_name, last_name, birth_date, address, phone_number, email, driving_category, license_date) VALUES
('John', 'Doe', '1985-05-15', '123 Main St, Springfield', '+1(555)123-4567', 'john.doe@example.com', 'B', '2010-06-01'),
('Anna', 'Smith', '1990-09-20', '456 Elm St, Metropolis', '+1(555)987-6543', 'anna.smith@example.com', 'B', '2012-03-15'),
('Michael', 'Johnson', '1975-02-28', '789 Oak St, Gotham', '+1(555)555-5555', 'michael.j@example.com', 'C', '2005-11-20');

-- Вставка записей в таблицу Car
INSERT INTO Car (car_number, brand, model, production_year, color, price, engine_capacity, sell_date, register_country_id, owner_id, mileage) VALUES
('ABC123', 'Ford', 'Mustang', 2020, 'Red', 30000.00, 5.0, '2021-07-01', 1, 1, 15000),
('DEF456', 'BMW', 'X5', 2018, 'Black', 45000.00, 3.0, '2020-01-15', 2, 2, 25000),
('GHI789', 'Toyota', 'Camry', 2019, 'White', 24000.00, 2.5, '2021-05-20', 3, 3, 18000);