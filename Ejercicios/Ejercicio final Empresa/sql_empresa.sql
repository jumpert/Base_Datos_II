-- DB2 SQL script Ejercicio de Empresa

-- Create Storage Groups practicoDB2
CREATE STOGROUP practicoDB2 ON '/home/db2ucu/StorageGroup';

-- Create database practicoDB2
CREATE DATABASE empresa STOGROUP practicoDB2 ON '/home/db2ucu/StorageGroup';

-- Create tablespaces for tables
CREATE TABLESPACE EMPLEADO_TS MANAGED BY SYSTEM USING ('/home/db2ucu/sqllib/TableSpaces/EMPLEADO_TS');
CREATE TABLESPACE DEPARTAMENTO_TS MANAGED BY SYSTEM USING ('/home/db2ucu/sqllib/TableSpaces/DEPARTAMENTO_TS');
CREATE TABLESPACE PROYECTO_TS MANAGED BY SYSTEM USING ('/home/db2ucu/sqllib/TableSpaces/PROYECTO_TS');

-- Create schema empresa
CREATE SCHEMA empresa;

-- Create database empleado
CREATE TABLE IF NOT EXISTS empresa.empleado (
    cod_empleado INTEGER PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) ,
    sueldo INTEGER NOT NULL,
    cod_supervisor INTEGER,
    nom_depto VARCHAR(50),
    FOREIGN KEY (cod_supervisor) REFERENCES empleado(cod_empleado)
    ) 
    IN EMPLEADO_TS;

-- Create table departamento
CREATE TABLE IF NOT EXISTS empresa.departamento (
    nom_depto VARCHAR(50) PRIMARY KEY NOT NULL,
    cod_coord INTEGER, 
    fch_coord DATE,
    FOREIGN KEY (cod_coord) REFERENCES empresa.empleado(cod_empleado)
    )
    IN DEPARTAMENTO_TS;

-- Alter table empleado para colocar la foreign key de departamento
ALTER TABLE empleado ADD FOREIGN KEY (nom_depto) REFERENCES empresa.departamento(nom_depto);

-- Create table ubicaciones
CREATE TABLE IF NOT EXISTS empresa.ubicaciones (
    cod_ubicacion INTEGER NOT NULL,
    nom_depto VARCHAR(50) NOT NULL,
    nom_ubicacion VARCHAR(50) NOT NULL,
    PRIMARY KEY (cod_ubicacion, nom_depto),
    FOREIGN KEY (nom_depto) REFERENCES empresa.departamento(nom_depto)
    )
    IN PROYECTO_TS;

-- Create table proyecto
CREATE TABLE IF NOT EXISTS empresa.proyecto (
    id_proy INTEGER PRIMARY KEY NOT NULL, 
    nom_proy VARCHAR(50) NOT NULL,
    nom_depto VARCHAR(50) NOT NULL,
    FOREIGN KEY (nom_depto) REFERENCES empresa.departamento(nom_depto)
    )
    IN PROYECTO_TS;

-- Create table trabaja_en
CREATE TABLE IF NOT EXISTS empresa.trabaja_en (
    cod_emp INTEGER NOT NULL,
    id_proy INTEGER NOT NULL,
    cant_horas INTEGER NOT NULL,
    PRIMARY KEY (cod_emp, id_proy),
    FOREIGN KEY (cod_emp) REFERENCES empresa.empleado(cod_emp),
    FOREIGN KEY (id_proy) REFERENCES empresa.proyecto(id_proy)
    )
    IN PROYECTO_TS;

-- Create table dependiente
CREATE TABLE IF NOT EXISTS empresa.dependiente (
    cod_emp INT,
    nom_dep VARCHAR(255),
    sexo CHAR(1) CHECK (sexo IN ('F', 'M')),
    fch_nac DATE,
    vinculo VARCHAR(255),
    FOREIGN KEY (cod_emp) REFERENCES empresa.empleado (cod_emp)
    )
    IN EMPLEADO_TS;

