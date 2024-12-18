LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ContadorAnillo IS
    PORT (
        clk   : IN  std_logic;            -- Señal de reloj
        reset : IN  std_logic;            -- Señal de reset
        sel   : OUT std_logic_vector(2 DOWNTO 0) -- Salida del contador anillo
    );
END ENTITY ContadorAnillo;

ARCHITECTURE Behavioral OF ContadorAnillo IS
    SIGNAL sel_reg : std_logic_vector(2 DOWNTO 0) := "000"; -- Estado inicial
    SIGNAL counter : integer RANGE 0 TO 100000 := 0;       -- Contador para 1 ms, a frecuencia de reloj 100Mhz
BEGIN

    PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
            sel_reg <= "000";   -- Reinicia al estado inicial
            counter <= 0;       -- Reinicia el contador de ciclos
        ELSIF rising_edge(clk) THEN
            IF counter = 99999 THEN  -- Cuenta hasta 100,000 ciclos (1 ms)
                -- Cambia el estado del contador anillo
                CASE sel_reg IS
                    WHEN "000" => sel_reg <= "001"; -- Activa el display 1
                    WHEN "001" => sel_reg <= "010"; -- Activa el display 2
                    WHEN "010" => sel_reg <= "011"; -- Activa el display 3
                    WHEN "011" => sel_reg <= "100"; -- Activa el display 4
                    WHEN "100" => sel_reg <= "101"; -- Activa el display 5
                    WHEN "101" => sel_reg <= "110"; -- Activa el display 6
                    WHEN "110" => sel_reg <= "111"; -- Activa el display 7
                    WHEN "111" => sel_reg <= "000"; -- Activa el display 0
                    WHEN OTHERS => sel_reg <= "000"; -- Activa el display 0
                END CASE;
                counter <= 0;  -- Reinicia el contador
            ELSE
                counter <= counter + 1;  -- Incrementa el contador
            END IF;
        END IF;
    END PROCESS;

    sel <= sel_reg; -- Asignación de la señal de salida

END ARCHITECTURE Behavioral;

