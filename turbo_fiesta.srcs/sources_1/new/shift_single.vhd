library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity shift_single is
  port(clk      : in  std_logic; -- Clock
       w_en_nxt : in  std_logic; -- True if next register will take the value
       Q_prev   : in  std_logic_vector(7 downto 0); -- Value of preceding register
       w_en     : out std_logic; -- True if we will write at the clock cycle
       Q        : out std_logic_vector(7 downto 0));-- Value in internal register
end shift_single;

architecture behavioral of shift_single is
  -- Register to hold current value
  signal r_Q        : std_logic_vector(7 downto 0) := x"3F";
  -- Other internal signals
  signal s_w_en     : std_logic;
  signal s_Q        : std_logic_vector(7 downto 0); -- Output value

begin
  -- Assign output values to internal output signals
  s_Q    <= r_Q;
  s_w_en <= '1' when s_Q = x"00" else '0';

  -- Update the register
  reg_proc: process(clk)
  begin
    if (rising_edge(clk))
    then
      -- If this register is 0, shift a new value in
      if (s_w_en = '1')
      then
        r_Q <= Q_prev;
      -- If this register is not 0 but the next one is, then clear this register
      elsif (w_en_nxt = '1')
      then
        r_Q <= x"00";
      -- If this register and the next are full, maintain the value
      else
        r_Q <= s_Q;
      end if;
    end if;
  end process reg_proc;

  -- Actual real outputs for real this time
  Q    <= s_Q;
  w_en <= s_w_en;
end behavioral;
