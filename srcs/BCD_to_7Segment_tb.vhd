LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BCD_to_7Segment_tb IS
-- No ports needed for testbench
END ENTITY BCD_to_7Segment_tb;

ARCHITECTURE behavior OF BCD_to_7Segment_tb IS

    -- Señales para conectar con el componente bajo prueba (BCD_to_7Segment)
    SIGNAL bcd    : std_logic_vector(3 DOWNTO 0);
    SIGNAL seg    : std_logic_vector(6 DOWNTO 0);
    
    COMPONENT BCD_to_7Segment
    PORT(
        bcd    : IN  std_logic_vector(3 DOWNTO 0); -- Entrada BCD de 4 bits
        seg    : OUT std_logic_vector(6 DOWNTO 0)  -- Salida para los 7 segmentos
    );
    END COMPONENT;
BEGIN

    -- Instanciación del componente BCD_to_7Segment
    uut: BCD_to_7Segment
        PORT MAP (
            bcd => bcd,
            seg => seg
        );

    -- Estímulos (procesos) para las entradas
    stim_proc: PROCESS
    BEGIN
        -- Inicialización
        bcd <= "0000"; -- Valor de BCD para el 0
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0001"; -- Valor de BCD para el 1
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0010"; -- Valor de BCD para el 2
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0011"; -- Valor de BCD para el 3
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0100"; -- Valor de BCD para el 4
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0101"; -- Valor de BCD para el 5
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0110"; -- Valor de BCD para el 6
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "0111"; -- Valor de BCD para el 7
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "1000"; -- Valor de BCD para el 8
        WAIT FOR 10 ns; -- Esperar 10 ns
        bcd <= "1001"; -- Valor de BCD para el 9
        WAIT FOR 10 ns; -- Esperar 10 ns

        -- Comprobar valores no definidos (otros)
        bcd <= "1111"; -- Valor no válido (otros)
        WAIT FOR 10 ns;

        -- Fin de la simulación
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;

