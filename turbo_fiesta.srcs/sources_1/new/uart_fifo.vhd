library IEEE;
library xil_defaultlib;
use IEEE.STD_LOGIC_1164.ALL;
use xil_defaultlib.array2D.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_fifo is
    generic(
        constant DATA_WIDTH   : positive := 8;
        constant FIFO_DEPTH   : positive := 8;    
        constant COUNT_AMOUNT : positive := 868);
    port ( clk_in       : in STD_LOGIC;   
           en_in        : in STD_LOGIC;
           data_in      : in STD_LOGIC_VECTOR (7 downto 0);
           UART_clk_out : out std_logic;
           UART_out     : out STD_LOGIC);
end uart_fifo;

architecture Behavioral of uart_fifo is

signal en_last :STD_LOGIC := '0';
signal reading : std_logic := '0';

signal FIFO_data : array8_bit(FIFO_DEPTH - 1 downto 0);
signal FIFO_counter : integer := -1;

signal output_byte : std_logic_vector(10 downto 0) := "11000000000";
signal output_num : integer := 0;

signal UART_clk : std_logic:= '1';
signal count : integer := 0;

begin
    everytihing : process(clk_in, en_in, en_last, FIFO_counter)
    begin
        --UART_out <= '1';
        if(rising_edge(clk_in)) then
            --FIFO WRITE
            if((en_last = '0') AND (en_in = '1'))then
                FIFO_data(FIFO_counter+1) <= data_in;
                FIFO_counter <= FIFO_counter + 1;
            --UART OUT
            elsif(reading = '1') then
                if(output_num = 11) then
                    output_num <= 0;
                    reading <= '0';
                else
                   if(UART_clk = '1')then
                       UART_out <= output_byte( output_num);
                       output_num <= output_num +1;
                   end if;
                end if;
            --FIFO READ
            elsif(FIFO_counter>= 0)then
                output_byte(8 downto 1) <= FIFO_data(0);
            
                for i in 1 to FIFO_DEPTH-1 loop
                    FIFO_data(i-1) <= FIFO_data(i);
                end loop;
                        
                FIFO_counter <= FIFO_counter - 1;
                reading <= '1';
            end if;
            en_last <= en_in;
        end if;        
    end process;
    
    
    counter : process(clk_in, count)
        begin
        if(rising_edge(clk_in))then
            if(count = COUNT_AMOUNT)then
                count <= 0;
                UART_clk <= '1';
            else
                count <= count +1;
                if((en_last /= '0') OR (en_in /= '1')) then
                    UART_clk <= '0'; 
                end if;
            end if;
        end if;
    end process;


end Behavioral;
