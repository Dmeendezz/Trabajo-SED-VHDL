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
    SIGNAL plazas : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Vector que representa las plazas ocupadas
BEGIN
    PROCESS(reset, plaza_1, plaza_2, plaza_3, plaza_4)
    BEGIN
        IF reset = '1' THEN
            plazas_ocupadas <= 0; -- Inicializa a 0 si el reset está activo
            plazas <= "0000"; -- Inicializa las plazas como libres
        ELSE
            -- Concatenamos las señales de las plazas para formar un STD_LOGIC_VECTOR
            plazas <= plaza_1 & plaza_2 & plaza_3 & plaza_4;
            
            -- Contamos las plazas ocupadas sumando los valores de cada bit en el vector
            plazas_ocupadas <= TO_INTEGER(unsigned(plazas)); 
        END IF;
        
        -- Convertimos el número de plazas libres en BCD
        CASE plazas_ocupadas IS
            WHEN 0 => plazas_libres <= "0100";  -- 4 plazas libres
            WHEN 1 => plazas_libres <= "0011";  -- 3 plazas libres
            WHEN 2 => plazas_libres <= "0010";  -- 2 plazas libres
            WHEN 3 => plazas_libres <= "0001";  -- 1 plaza libre
            WHEN 4 => plazas_libres <= "0000";  -- 0 plazas libres
            WHEN OTHERS => plazas_libres <= "0000"; -- En caso de error, todas las plazas están ocupadas
        END CASE;
    END PROCESS;
END ARCHITECTURE behavior;