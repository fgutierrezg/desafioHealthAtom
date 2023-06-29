--Creando tabla responsables, para identificar personas a las distintas acciones
CREATE TABLE responsables(`id` INT NOT NULL AUTO_INCREMENT , `nombre` VARCHAR(100) NOT NULL , PRIMARY KEY (`id`));

--Agregando el id del responsable para recompensas por muertes

ALTER TABLE muertes
ADD COLUMN id_responsable INT,
ADD FOREIGN KEY (id_responsable) REFERENCES responsables(id);

--Agregando el id del responsable, junto con un nuevo registro de fecha de avistamiento, el cual se llenará automaticamente, evitando así error humanno en los ingresos
ALTER TABLE avistamientos
ADD COLUMN fecha_ingreso_avistamiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN id_responsable INT,
ADD FOREIGN KEY (id_responsable) REFERENCES responsables(id);

--Agregando el id del responsable para cotrolar los movimientos de recursos
ALTER TABLE movimientos_recursos
ADD COLUMN id_responsable INT,
ADD FOREIGN KEY (id_responsable) REFERENCES responsables(id);
