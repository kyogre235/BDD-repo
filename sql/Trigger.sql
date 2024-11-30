--Triggers

--Trigger #1
-- verificar que si un evento se hace a la misma hora y en el mismo lugar, se tenga aforo suficiente
CREATE OR REPLACE FUNCTION verificar_aforo_localidad()
RETURNS TRIGGER AS $$
DECLARE
  capacidad_actual INTEGER;
  aforo_maximo INTEGER;
  localidad_evento BIGINT;
BEGIN
  -- Obtener la localidad asociada a la disciplina del evento
  SELECT idlocalidad INTO localidad_evento
  FROM disciplina
  WHERE iddisciplina = NEW.iddisciplina;

  -- Calcular la cantidad total de eventos en la misma localidad y fecha
  SELECT COUNT(*) INTO capacidad_actual
  FROM evento e
  JOIN disciplina d ON e.iddisciplina = d.iddisciplina
  WHERE d.idlocalidad = localidad_evento AND e.fecha = NEW.fecha;

  -- Obtener el aforo máximo de la localidad
  SELECT aforo INTO aforo_maximo
  FROM localidad
  WHERE idlocalidad = localidad_evento;

  -- Comparar con el aforo máximo
  IF capacidad_actual >= aforo_maximo THEN
    RAISE EXCEPTION 'Se ha alcanzado el aforo máximo para esta localidad.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_aforo_localidad
BEFORE INSERT ON evento
FOR EACH ROW
EXECUTE FUNCTION verificar_aforo_localidad();

--Trigger #2
CREATE OR REPLACE FUNCTION verificar_conflicto_eventos()
RETURNS TRIGGER AS $$
DECLARE
    nueva_fecha TIMESTAMP;
    nueva_duracion INTERVAL;
BEGIN
    -- Obtener la fecha y duración del evento que el usuario intenta visitar
    SELECT fecha, duracionmax INTO nueva_fecha, nueva_duracion
    FROM evento
    WHERE idevento = NEW.idevento;
    
    -- Verificar si hay conflicto con otros eventos visitados por el mismo usuario
    IF EXISTS (
        SELECT 1
        FROM visitar v
        JOIN evento e ON v.idevento = e.idevento
        WHERE v.idusuario = NEW.idusuario
        AND (
            nueva_fecha < (e.fecha + e.duracionmax)  -- Nuevo evento comienza antes de que el otro termine
            AND (nueva_fecha + nueva_duracion) > e.fecha  -- Nuevo evento termina después de que el otro comience
        )
    ) THEN
        RAISE EXCEPTION 'El usuario ya está registrado en otro evento al mismo tiempo';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_verificar_conflicto_eventos
BEFORE INSERT ON visitar
FOR EACH ROW
EXECUTE FUNCTION verificar_conflicto_eventos();

--Trigger #3
CREATE OR REPLACE FUNCTION verificar_relacion_medalla()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si la relación existe en la tabla trabajaratleta
    IF NOT EXISTS (
        SELECT 1
        FROM trabajaratleta
        WHERE idolimpicoa = NEW.idolimpicoa
        AND iddisciplina = NEW.iddisciplina
    ) THEN
        -- Lanza un error si no se encuentra la relación
        RAISE EXCEPTION 'No existe una relación válida entre el atleta % y la disciplina % en trabajaratleta', NEW.idolimpicoa, NEW.iddisciplina;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_relacion_medalla
BEFORE INSERT ON medalla
FOR EACH ROW
EXECUTE FUNCTION verificar_relacion_medalla();




