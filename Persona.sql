-- Insertar un TipoPersona (tppr)
INSERT INTO tppr (tppr__id, tpprdscr, tpprdtcr, tpprdtup)
VALUES (1, 'Administrador', NOW(), NOW());

-- Insertar un Perfil (prfl)
INSERT INTO prfl (prfl__id, prflnmbr, prfldscr, prflpdre, prflobsr, prflcdgo)
VALUES (1, 'Admin', 'Perfil de administrador', NULL, NULL, 'ADM'),
       (2, 'Cliente', 'Perfil de cliente', NULL, NULL, 'CLI');

-- Insertar una Persona (prsn)
INSERT INTO prsn (
    prsncdla, prsnnmbr, prsnapll, prsnfcin, prsnfcfn, prsnsexo, prsnmail, prsnlogn, prsnpass, prsnactv, prsntelf, prsndire, tppr__id, prfl__id
) VALUES (
    '1234567890',           -- cedula
    'Juan',                 -- nombre
    'Pérez',                -- apellido
    NULL,                   -- fechaInicio
    NULL,                   -- fechaFin
    'M',                    -- sexo
    'juan@ejemplo.com',     -- mail
    'juan',                 -- login
    '1234',                 -- password
    1,                      -- activo
    '0999999999',           -- telefono
    'Calle Falsa 123',      -- direccion
    1,                      -- tppr__id (ID de TipoPersona)
    1                       -- prfl__id (ID de Perfil)
);
