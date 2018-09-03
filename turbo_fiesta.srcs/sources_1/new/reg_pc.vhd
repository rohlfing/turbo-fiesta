library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_pc is
  port ( clk     : in  std_logic;
         reset   : in  std_logic;
         -- Register inputs
         i_state : in  std_logic_vector (19 downto 0);
         i_addr  : in  std_logic_vector (11 downto 0);
         i_flags : in  std_logic_vector (15 downto 0);
         i_sp    : in  std_logic_vector (15 downto 0);
         -- Register outputs
         o_state : out std_logic_vector (19 downto 0);
         o_addr  : out std_logic_vector (11 downto 0);
         o_flags : out std_logic_vector (15 downto 0);
         o_sp    : out std_logic_vector (15 downto 0));
end reg_pc;

architecture Behavioral of reg_pc is
  signal r_state : std_logic_vector(19 downto 0) := x"00000";
  signal r_addr  : std_logic_vector(11 downto 0) := x"000";
  signal r_flags : std_logic_vector(15 downto 0) := x"0000";
  signal r_sp    : std_logic_vector(15 downto 0) := x"0000";
begin

-- Set outputs
o_state <= r_state;
o_addr  <= r_addr;
o_flags <= r_flags;
o_sp    <= r_sp;

-- Register process    
reg_process: process(clk)
begin
  if (rising_edge(clk)) then
    if (reset = '0') then
      r_state <= i_state;
      r_addr  <= i_addr;
      r_flags <= i_flags;
      r_sp    <= i_sp;
    else
      r_state <= x"00000";
      r_addr  <= x"000";
      r_flags <= x"0000";
      r_sp    <= x"0000";
    end if;
  end if;
end process;

end Behavioral;
