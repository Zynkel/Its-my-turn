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
  PRIMARY KEY (`id`));

/*Unos ALTER TABLE para modificar columnas*/
SHOW CREATE TABLE customer;
ALTER TABLE customer CHANGE id custom_id int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE customer CHANGE identifier1 identifier1 VARCHAR(20) NOT NULL COMMENT 'Identificación del cliente (DNI,NIF,etc)';
ALTER TABLE customer CHANGE identifier2 identifier2 VARCHAR(20) NULL COMMENT 'Segunda identificación del cliente (DNI,NIF,etc) *Opcional*';

/*Tabla Center */
CREATE TABLE IF NOT EXISTS center (
    center_id INT NOT NULL COMMENT 'Identificación del centro',
    center_code VARCHAR(20)  ,
    name VARCHAR(100),
    
    PRIMARY KEY (center_id)
);

ALTER TABLE center MODIFY center_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

/*Tabla Location */
CREATE TABLE IF NOT EXISTS location (
  loc_id INT NOT NULL COMMENT 'Identificación de localización (PK)',
  loc_code VARCHAR(20) NOT NULL COMMENT 'Código de la localización',
  loc_name VARCHAR(100) NOT NULL,
  loc_description VARCHAR(500),
  loc_type VARCHAR(30) NOT NULL,
  center_id_pk INT NOT NULL,

  PRIMARY KEY (loc_id, center_id_pk),
  INDEX `fk_loc_center_indx` (`center_id_pk` ASC) VISIBLE,
  CONSTRAINT fk_loc_center
    FOREIGN KEY (center_id_pk) 
      REFERENCES center (center_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

ALTER TABLE location MODIFY loc_id INT NOT NULL COMMENT 'Identificación de localizacion (PK)' AUTO_INCREMENT;

/*Tabla Service */
CREATE TABLE IF NOT EXISTS service (
  serv_id INT NOT NULL COMMENT 'Id del servicio' AUTO_INCREMENT,
  serv_code VARCHAR(25) NOT NULL COMMENT 'Código del servicio',
  serv_name VARCHAR(200) NOT NULL,
  center_id_pk INT NOT NULL,

  PRIMARY KEY (serv_id, center_id_pk),
  INDEX fk_serv_center_indx (center_id_pk ASC) VISIBLE,
  CONSTRAINT fk_serv_center
    FOREIGN KEY (center_id_pk)
      REFERENCES center (center_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

/*Tabla Device */
CREATE TABLE IF NOT EXISTS device (
  dev_id INT NOT NULL AUTO_INCREMENT COMMENT 'ID dispositivo',
  dev_ip VARCHAR(15) NOT NULL COMMENT 'Dirección IP del dispositivo',
  dev_name VARCHAR(100) NOT NULL COMMENT 'Nombre del dispositivo',
  dev_type VARCHAR(20) NOT NULL,
  calling_devices VARCHAR(25),
  printing_device INT,
  loc_id_pk INT NOT NULL,
  configuration VARCHAR(75) NOT NULL,

  PRIMARY KEY(dev_id, loc_id_pk),
  INDEX fk_device_loc_idx (loc_id_pk) VISIBLE,
  CONSTRAINT fk_dev_loc
    FOREIGN KEY (loc_id_pk)
      REFERENCES location (loc_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
  );


/*Tabla Queue*/
  CREATE TABLE IF NOT EXISTS queue (
    queue_id INT NOT NULL AUTO_INCREMENT COMMENT 'ID de la cola',
    queue_code VARCHAR(25) NOT NULL,
    queue_name VARCHAR(200) NOT NULL,
    queue_type INT NOT NULL,
    queue_ticket_type INT NOT NULL,
    queue_created DATETIME NOT NULL,
    queue_modified DATETIME NOT NULL,
    serv_id_pk INT NOT NULL,

    PRIMARY KEY (queue_id, serv_id_pk),
    INDEX fk_queue_serv_indx (serv_id_pk) VISIBLE,
    CONSTRAINT fk_queue_serv
      FOREIGN KEY (serv_id_pk)
        REFERENCES service (serv_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
  );
