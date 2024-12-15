library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO is
    Port (
        clk       : in STD_LOGIC;               
        reset     : in STD_LOGIC;               
        enable    : in STD_LOGIC;               
        count_out : out INTEGER range 0 to 35999 
    );
end CONTADORTIEMPO;

architecture Behavioral of CONTADORTIEMPO is
    
    signal enable_100ms : STD_LOGIC;        

    -- CONTADOR INTERNO
    signal count : INTEGER range 0 to 35999 := 0; 

   
    component strobe_generator
        Port (
            clk         : in std_logic;       
            reset       : in std_logic;      
            enable_100ms : out std_logic     
        );
    end component;

begin
    
    strobe_inst: strobe_generator
        Port map (
            clk         => clk,            
            reset       => reset,          
            enable_100ms => enable_100ms   
        );

    
    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0;  
        elsif rising_edge(clk) then  
            if enable = '0' then
                count <= 0; 
            elsif enable_100ms = '1' then 
                if count = 35999 then
                    count <= 0;        
                else
                    count <= count + 1; 
                end if;
            end if;
        end if;
    end process;

  
    count_out <= count;

end Behavioral;



