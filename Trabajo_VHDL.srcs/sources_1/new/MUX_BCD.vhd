LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_BCD IS
    PORT (
        bcd0    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD0
        bcd1    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD1
        bcd2    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD2
        bcd3    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD3
        clk     : IN std_logic;                    -- Reloj para el contador
        reset   : IN std_logic;                    -- Reset para el contador
        bcd_out : OUT std_logic_vector(3 DOWNTO 0)  -- Salida del MUX
    );
END ENTITY MUX_BCD;

ARCHITECTURE behavior OF MUX_BCD IS

    -- Señal para la salida del contador
    SIGNAL sel_cnt : std_logic_vector(3 DOWNTO 0);

    -- Componente del ContadorAnillo
    COMPONENT ContadorAnillo
        PORT (
            clk   : IN  std_logic;              -- Señal de reloj
            reset : IN  std_logic;              -- Señal de reset
            sel   : OUT std_logic_vector(3 DOWNTO 0) -- Salida del contador anillo
        );
    END COMPONENT;

BEGIN

    -- Instanciación del ContadorAnillo
    contador_inst : ContadorAnillo
        PORT MAP (
            clk => clk,
            reset => reset,
            sel => sel_cnt  -- Conectamos la salida del contador al señal de selección
        );

    -- MUX para seleccionar las entradas BCD
    PROCESS(bcd0, bcd1, bcd2, bcd3, sel_cnt)
    BEGIN
        CASE sel_cnt IS
            WHEN "1110" => bcd_out <= bcd0;   -- Seleccionar BCD0
            WHEN "1101" => bcd_out <= bcd1;   -- Seleccionar BCD1
            WHEN "1011" => bcd_out <= bcd2;   -- Seleccionar BCD2
            WHEN "0111" => bcd_out <= bcd3;   -- Seleccionar BCD3
            WHEN OTHERS => bcd_out <= "0000"; -- Valor por defecto
        END CASE;
    END PROCESS;

END ARCHITECTURE behavior;