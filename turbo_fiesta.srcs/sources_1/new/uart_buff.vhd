library IEEE;
library xil_defaultlib;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use xil_defaultlib.array2D.ALL;

entity uart_buff is
    generic( LOGN : integer := 8;
                N : integer := 256);
    Port ( clk  : in STD_LOGIC;
           w_clk: in std_logic;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           w_en : in STD_LOGIC;
           uart : out STD_LOGIC);
end uart_buff;

architecture Behavioral of uart_buff is

COMPONENT uart_clk_div
  PORT (
    CLK : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END COMPONENT;

COMPONENT uart_bit_ctr
  PORT (
    CLK : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT;

signal baud_clk : std_logic;
signal byte_clk : std_logic;
signal send     : std_logic;
signal w_index  : signed(LOGN-1 downto 0) := x"00";
signal r_index  : signed(LOGN-1 downto 0) := x"00";
signal buff     : array8_bit(N-1 downto 0);
signal bit_count: std_logic_vector(3 downto 0);
-- UART output register
signal r_uart   : std_logic;
-- Next indices
signal new_w_index : signed(LOGN-1 downto 0);
signal new_r_index : signed(LOGN-1 downto 0);

begin

uart <= r_uart;

new_w_index <= w_index + ("0000000"&w_en);
new_r_index <= r_index + x"01";

input_proc: process(w_clk)
begin
  if (rising_edge(w_clk))
  then
    buff(to_integer(unsigned(w_index))) <= data;
    w_index <= new_w_index;
  end if;
end process;

output_proc: process(baud_clk)
begin
  if(rising_edge(baud_clk))
  then
    if (send = '1')
    then
      if (bit_count = x"0")
      then
        r_uart <= '0';
      elsif (unsigned(bit_count) < x"9")
      then
        r_uart <= buff(to_integer(r_index))(to_integer(unsigned(bit_count)) - 1);
      elsif (unsigned(bit_count) = x"9")
      then
        r_uart <= '1';
        r_index <= new_r_index;
      else
        r_uart <= '1';
      end if;
    else
      r_uart <= '1';
    end if;
  end if;
end process;

enable_proc: process(byte_clk)
begin
  if(rising_edge(byte_clk))
  then
    if(w_index - r_index /= 0)
    then
      send <= '1';
    else
      send <= '0';
    end if;
  end if;
end process;

baud_rate_impl: uart_bit_ctr
  PORT MAP (
    CLK => baud_clk,
    THRESH0 => byte_clk,
    Q => bit_count);

bit_counter: uart_clk_div
  PORT MAP (
    CLK => clk,
    THRESH0 => baud_clk,
    Q => open);

end Behavioral;
