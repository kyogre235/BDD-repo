
--Procedimiento #1

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
