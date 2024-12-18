LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;  -- Usamos numeric_std para las conversiones

ENTITY contador_plazas_libres IS
    PORT (
        reset : IN STD_LOGIC;                    -- Señal de reset
        plaza_1 : IN STD_LOGIC;                  -- 1 si ocupada, 0 si libre
        plaza_2 : IN STD_LOGIC;                  -- 1 si ocupada, 0 si libre
        plaza_3 : IN STD_LOGIC;                  -- 1 si ocupada, 0 si libre
        plaza_4 : IN STD_LOGIC;                  -- 1 si ocupada, 0 si libre
        plazas_libres : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Salida en BCD del número de plazas libres
    );
END ENTITY contador_plazas_libres;

ARCHITECTURE behavior OF contador_plazas_libres IS
    SIGNAL plazas_ocupadas : INTEGER RANGE 0 TO 4; -- Contador de plazas ocupadas
    SIGNAL plazas_libres_int : INTEGER RANGE 0 TO 4; -- Variable interna para calcular plazas libres
    SIGNAL plaza_entero_1 : INTEGER := 0;
    SIGNAL plaza_entero_2 : INTEGER := 0;
    SIGNAL plaza_entero_3 : INTEGER := 0;
    SIGNAL plaza_entero_4 : INTEGER := 0;
BEGIN
        
    PROCESS(reset, plaza_1, plaza_2, plaza_3, plaza_4)
    BEGIN
        IF reset = '1' THEN
            plazas_ocupadas <= 0; -- Inicializa a 0 si el reset está activo
            plaza_entero_1 <= 0;
            plaza_entero_2 <= 0;
            plaza_entero_3 <= 0;
            plaza_entero_4 <= 0;
        ELSE
            -- Evaluar el estado de las plazas
            CASE plaza_1 IS
                WHEN '0' => plaza_entero_1 <= 0;
                WHEN '1' => plaza_entero_1 <= 1;
                WHEN OTHERS => plaza_entero_1 <= 0;
            END CASE;
            
            CASE plaza_2 IS
                WHEN '0' => plaza_entero_2 <= 0;
                WHEN '1' => plaza_entero_2 <= 1;
                WHEN OTHERS => plaza_entero_2 <= 0;
            END CASE;
            
            CASE plaza_3 IS
                WHEN '0' => plaza_entero_3 <= 0;
                WHEN '1' => plaza_entero_3 <= 1;
                WHEN OTHERS => plaza_entero_3 <= 0;
            END CASE;
            
            CASE plaza_4 IS
                WHEN '0' => plaza_entero_4 <= 0;
                WHEN '1' => plaza_entero_4 <= 1;
                WHEN OTHERS => plaza_entero_4 <= 0;
            END CASE;
            
            -- Calcular el número de plazas ocupadas
            plazas_ocupadas <= plaza_entero_1 + plaza_entero_2 + plaza_entero_3 + plaza_entero_4;
            
            -- Convertir las plazas ocupadas en el número de plazas libres
            plazas_libres_int <= 4 - plazas_ocupadas;
            
            -- Convertir el número de plazas libres en formato BCD
            CASE plazas_libres_int IS
                WHEN 0 => plazas_libres <= "0000";  -- 0 plazas libres
                WHEN 1 => plazas_libres <= "0001";  -- 1 plaza libre
                WHEN 2 => plazas_libres <= "0010";  -- 2 plazas libres
                WHEN 3 => plazas_libres <= "0011";  -- 3 plazas libres
                WHEN 4 => plazas_libres <= "0100";  -- 4 plazas libres
                WHEN OTHERS => plazas_libres <= "0000"; -- Valor por defecto
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE behavior;