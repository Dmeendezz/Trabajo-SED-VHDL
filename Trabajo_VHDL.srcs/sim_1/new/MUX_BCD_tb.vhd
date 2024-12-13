LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_BCD_tb IS
    -- No tiene puertos ya que es un testbench
END ENTITY MUX_BCD_tb;

ARCHITECTURE behavior OF MUX_BCD_tb IS

    -- Componentes a instanciar
    COMPONENT MUX_BCD
        PORT (
            bcd0    : IN std_logic_vector(3 DOWNTO 0); 
            bcd1    : IN std_logic_vector(3 DOWNTO 0); 
            bcd2    : IN std_logic_vector(3 DOWNTO 0); 
            bcd3    : IN std_logic_vector(3 DOWNTO 0); 
            clk     : IN std_logic;                   
            reset   : IN std_logic;                   
            bcd_out : OUT std_logic_vector(3 DOWNTO 0)  
        );
    END COMPONENT;

    -- Señales
    SIGNAL bcd0    : std_logic_vector(3 DOWNTO 0) := "0001";  -- Ejemplo BCD0
    SIGNAL bcd1    : std_logic_vector(3 DOWNTO 0) := "0010";  -- Ejemplo BCD1
    SIGNAL bcd2    : std_logic_vector(3 DOWNTO 0) := "0100";  -- Ejemplo BCD2
    SIGNAL bcd3    : std_logic_vector(3 DOWNTO 0) := "1000";  -- Ejemplo BCD3
    SIGNAL clk     : std_logic := '0';   
    SIGNAL reset   : std_logic := '0';   
    SIGNAL bcd_out : std_logic_vector(3 DOWNTO 0);

BEGIN

    -- Instanciación del MUX_BCD
    uut: MUX_BCD
        PORT MAP (
            bcd0 => bcd0,
            bcd1 => bcd1,
            bcd2 => bcd2,
            bcd3 => bcd3,
            clk => clk,
            reset => reset,
            bcd_out => bcd_out
        );

    -- Generación de reloj
    CLOCK_GEN : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
    END PROCESS;

    -- Estímulos de entrada
    STIMULUS : PROCESS
    BEGIN
        -- Reset inicial
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        
        wait for 100 ns;
        bcd0 <= "0011";
        wait for 20 ns;
        bcd1 <= "0101";
        wait for 20 ns;
        bcd2 <= "0111";
        wait for 20 ns;
        bcd3 <= "1001";
        
        
        -- Dejar correr para observar cómo cambia la salida
        WAIT FOR 100 ns;
        
        -- Fin de la simulación
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
