/*Creación de BD */
CREATE DATABASE itsmyturn;

/*Seleccionamos la BD recien creada */
USE itsmyturn;

/*Tabla Customer/Cliente*/
CREATE TABLE IF NOT EXISTS customer (
  custom_id INT NOT NULL AUTO_INCREMENT,
  identifier1 VARCHAR(20) NOT NULL COMMENT 'Identificación del cliente (DNI,NIF,etc)',
  identifier2 VARCHAR(20) NULL COMMENT 'Segunda identificación del cliente (DNI,NIF,etc) *Opcional*',
  firstname VARCHAR(100) NOT NULL,
  middlename VARCHAR(100) NULL COMMENT 'Customer’s middle name.',
  lastname VARCHAR(200) NOT NULL COMMENT 'Customer’s last name.',
  sex INT NULL COMMENT '\nCustomer’s sex, 0 -> male, 1 -> female, 2 -> not specified',
  birthdate DATETIME NOT NULL COMMENT 'Date of birth.',
  contactinfo VARCHAR(500) NULL COMMENT 'A JSON object including contact info like phone numbers, emails and addresses.\n{phone: “4453345”,\nphone2: “4387494”,\nemail: “sdlfkjasldf@gmail.com”}',
  PRIMARY KEY (`id`))

/*Tabla Center */
CREATE TABLE IF NOT EXISTS center (
    center_id INT NOT NULL COMMENT 'Identificación del centro',
    code VARCHAR(20) 
)
