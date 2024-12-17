library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP_tb is
-- Testbench no tiene puertos
end TOP_tb;

architecture Behavioral of TOP_tb is

    -- Componentes a instanciar
    component TOP
        Port (
            reset       : in std_logic;
            clk         : in std_logic;
            switch1     : in std_logic;
            switch2     : in std_logic;
            switch3     : in std_logic;
            switch4     : in std_logic;
            led1        : out std_logic;
            led2        : out std_logic;
            led3        : out std_logic;
            led4        : out std_logic;
            segmento    : out std_logic_vector(6 downto 0);
            display_sel : out std_logic_vector(7 downto 0);
            salida_contador1: out integer;
            salida_contador2: out integer;
            salida_contador3: out integer;
            salida_contador4: out integer;
            salida_unidades: out std_logic_vector(3 DOWNTO 0);
            salida_decenas:out std_logic_vector(3 DOWNTO 0);
            salida_centenas:out std_logic_vector(3 DOWNTO 0);
            salida_millares:out std_logic_vector(3 DOWNTO 0);
            salida_seleccionada: out integer;
            salida_fsm: out std_logic_vector(1 DOWNTO 0)
        );
    end component;

    -- Señales internas
    signal reset       : std_logic := '0';
    signal clk         : std_logic := '0';
    signal switch1     : std_logic := '0';
    signal switch2     : std_logic := '0';
    signal switch3     : std_logic := '0';
    signal switch4     : std_logic := '0';
    signal led1        : std_logic;
    signal led2        : std_logic;
    signal led3        : std_logic;
    signal led4        : std_logic;
    signal segmento    : std_logic_vector(6 downto 0);
    signal display_sel : std_logic_vector(7 downto 0);
    signal salida_contador1: integer;
    signal salida_contador2: integer;
    signal salida_contador3: integer;
    signal salida_contador4: integer;
    signal salida_unidades: std_logic_vector(3 DOWNTO 0);
    signal salida_decenas: std_logic_vector(3 DOWNTO 0);
    signal salida_centenas: std_logic_vector(3 DOWNTO 0);
    signal salida_millares: std_logic_vector(3 DOWNTO 0);
    signal salida_seleccionada: integer;
    signal salida_fsm: std_logic_vector(1 DOWNTO 0);
begin

    -- Instancia del DUT (Device Under Test)
    uut: TOP
        Port map (
            reset       => reset,
            clk         => clk,
            switch1     => switch1,
            switch2     => switch2,
            switch3     => switch3,
            switch4     => switch4,
            led1        => led1,
            led2        => led2,
            led3        => led3,
            led4        => led4,
            segmento    => segmento,
            display_sel => display_sel,
            salida_contador1 => salida_contador1,
            salida_contador2 => salida_contador2,
            salida_contador3 => salida_contador3,
            salida_contador4 => salida_contador4,
            salida_unidades => salida_unidades,
            salida_decenas => salida_decenas,
            salida_centenas => salida_centenas,
            salida_millares => salida_millares,
            salida_seleccionada => salida_seleccionada,
            salida_fsm => salida_fsm
        );

    -- Generación de reloj con 10 ns de período (100 MHz) --> CAMBIAR EN STROBE la N
    --Reloj periodo 0.01 segundos, N = 10
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ms;
            clk <= '1';
            wait for 5 ms;
        end loop;
    end process;

    -- Estímulos de prueba
    stim_proc: process
    begin
        -- Inicialización
        reset <= '1';
        wait for 200 ms;
        reset <= '0';

        -- Simulación de activación de switches
        switch1 <= '1';
        wait for 300 ms;
        switch2 <= '1';
        wait for 500 ms;
        switch1 <= '0';

        wait for 210 ms;
        switch1 <= '0';
        wait for 500 ms;
        switch2 <= '0';

        switch3 <= '1';
        wait for 5300 ms ;
        switch3 <= '0';
        wait for 400 ms;

        switch4 <= '1';
        wait for 510 ms;
        switch4 <= '0';
        wait for 10 ms;

        wait;
    end process;

end Behavioral;

