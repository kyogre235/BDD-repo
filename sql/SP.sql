
--Procedimiento #1
--procedimiento que agrega la participacion de un atleta si el evento no se solapa con otros en los que ya este
CREATE OR REPLACE PROCEDURE registrar_participacion_atleta(
  p_idolimpicoa BIGINT,
  p_idevento BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
  -- Verificar si el atleta ya está participando en un evento en la misma fecha
  IF EXISTS (
    SELECT 1
    FROM participaratleta pa
    JOIN evento e1 ON pa.idevento = e1.idevento
    JOIN evento e2 ON e2.idevento = p_idevento
    WHERE pa.idolimpicoa = p_idolimpicoa AND e1.fecha = e2.fecha
  ) THEN
    RAISE EXCEPTION 'El atleta ya está participando en un evento en la misma fecha.';
  END IF;
  
  -- Insertar la nueva participación
  INSERT INTO participaratleta (idevento, idolimpicoa)
  VALUES (p_idevento, p_idolimpicoa);
END;
$$;

--Procedimiento #2
--procedimiento que agrega o actualiza un patrocinador para una disciplina dada
CREATE OR REPLACE PROCEDURE asignar_patrocinador_disciplina(
  p_iddisciplina BIGINT,
  p_patrocinadorviejo VARCHAR(50),
  p_patrocinadornuevo VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
  -- Verificar si ya existe una entrada de patrocinador para la disciplina
  IF EXISTS (
    SELECT 1 FROM patrocinador WHERE iddisciplina = p_iddisciplina AND patrocinador.patrocinador = p_patrocinadorviejo
  ) THEN
    -- Actualizar patrocinador existente
    UPDATE patrocinador
    SET patrocinador = p_patrocinadornuevo
    WHERE iddisciplina = p_iddisciplina;
  ELSE
    -- Insertar nuevo patrocinador
    INSERT INTO patrocinador (iddisciplina, patrocinador)
    VALUES (p_iddisciplina, p_patrocinadornuevo);
  END IF;
END;
$$;

--Procedimiento #3
CREATE OR REPLACE PROCEDURE actualizar_disciplina_localidad(
    p_iddisciplina BIGINT,
    p_idlocalidad BIGINT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_disciplina_existente BIGINT;
    v_localidad_existente BIGINT;
BEGIN
    -- Verificar si la disciplina existe
    SELECT COUNT(*) INTO v_disciplina_existente
    FROM disciplina
    WHERE iddisciplina = p_iddisciplina;
    
    IF v_disciplina_existente = 0 THEN
        RAISE EXCEPTION 'La disciplina con ID % no existe.', p_iddisciplina;
    END IF;

    -- Verificar si la localidad existe
    SELECT COUNT(*) INTO v_localidad_existente
    FROM localidad
    WHERE idlocalidad = p_idlocalidad;
    
    IF v_localidad_existente = 0 THEN
        RAISE EXCEPTION 'La localidad con ID % no existe.', p_idlocalidad;
    END IF;

    -- Actualizar la relación en la tabla de disciplinas
    UPDATE disciplina
    SET idlocalidad = p_idlocalidad
    WHERE iddisciplina = p_iddisciplina;

END;
$$;


