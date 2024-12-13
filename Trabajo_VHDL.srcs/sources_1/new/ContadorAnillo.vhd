LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ContadorAnillo IS
    PORT (
        clk   : IN  std_logic;            -- Señal de reloj
        reset : IN  std_logic;            -- Señal de reset
        sel   : OUT std_logic_vector(3 DOWNTO 0) -- Salida del contador anillo
    );
END ENTITY ContadorAnillo;

ARCHITECTURE Behavioral OF ContadorAnillo IS
    SIGNAL sel_reg : std_logic_vector(3 DOWNTO 0) := "XXXX"; -- Estado inicial
BEGIN

    PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
            sel_reg <= "XXXX"; -- Reinicia al estado "XXXX" cuando se pulsa reset
        ELSIF rising_edge(clk) THEN
            CASE sel_reg IS
                WHEN "1110" => sel_reg <= "1101"; -- Activa el segundo display
                WHEN "1101" => sel_reg <= "1011"; -- Activa el tercer display
                WHEN "1011" => sel_reg <= "0111"; -- Activa el cuarto display
                WHEN "0111" => sel_reg <= "1110"; -- Vuelve al primer display
                WHEN OTHERS => sel_reg <= "1110"; -- Valor por defecto
            END CASE;
        END IF;
    END PROCESS;

    sel <= sel_reg; -- Asignación de la señal de salida

END ARCHITECTURE Behavioral;

