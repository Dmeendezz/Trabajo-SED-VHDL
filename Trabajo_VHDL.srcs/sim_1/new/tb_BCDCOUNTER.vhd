library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_BCDCOUNTER is
end entity tb_BCDCOUNTER;

architecture behavior of tb_BCDCOUNTER is
    -- Declaración de la unidad bajo prueba (UUT)
    component BCDCOUNTER
        generic (
            WIDTH : positive := 4
        );
        port (
            RST_N   : in std_logic;
            CLK     : in std_logic;
            STROBE  : in std_logic;
            COUNT   : out unsigned(WIDTH - 1 downto 0)
        );
    end component;

    -- Señales internas
    signal clk      : std_logic := '0';                  -- Señal de reloj
    signal rst_n    : std_logic := '0';                  -- Reset activo bajo
    signal strobe   : std_logic := '0';                  -- Señal strobe simulada
    signal count    : unsigned(3 downto 0);              -- Salida del contador

    -- Constante para el reloj (100 MHz, periodo 10 ns)
    constant clk_period : time := 10 ns;

    -- Constante para el strobe (cada 100 ms)
    constant strobe_period : time := 100 ms;
begin
    -- Instanciación de la UUT (Unidad bajo prueba)
    uut : BCDCOUNTER
        generic map (
            WIDTH => 4  -- Configuración de contador BCD
        )
        port map (
            RST_N   => rst_n,
            CLK     => clk,
            STROBE  => strobe,
            COUNT   => count
        );

    -- Generación del reloj
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Generación de la señal de strobe simulada
    strobe_process : process
    begin
        strobe <= '0';
        wait for strobe_period;  -- Mantener bajo durante 100 ms
        strobe <= '1';
        wait for clk_period;     -- Generar pulso durante un ciclo de reloj
        strobe <= '0';
        wait;
    end process;

    
end architecture behavior;
