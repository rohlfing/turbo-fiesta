library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_fetch is
  port ( clk       : in  std_logic;
         reset     : in  std_logic;
         -- Register inputs
         i_state   : in  std_logic_vector (19 downto 0);
         i_inst    : in  std_logic_vector ( 7 downto 0);
         i_top     : in  std_logic_vector (31 downto 0);
         i_mid     : in  std_logic_vector (31 downto 0);
         i_bot     : in  std_logic_vector (31 downto 0);
         i_flags   : in  std_logic_vector (15 downto 0);
         i_sp      : in  std_logic_vector (15 downto 0);
         -- Register outputs
         o_state   : out std_logic_vector (19 downto 0);
         o_inst    : out std_logic_vector ( 7 downto 0);
         o_top     : out std_logic_vector (31 downto 0);
         o_mid     : out std_logic_vector (31 downto 0);
         o_bot     : out std_logic_vector (31 downto 0);
         o_flags   : out std_logic_vector (15 downto 0);
         o_sp      : out std_logic_vector (15 downto 0));
end reg_fetch;

architecture Behavioral of reg_fetch is
  signal r_state   : std_logic_vector (19 downto 0) := x"00000";
  signal r_inst    : std_logic_vector ( 7 downto 0) := x"20";
  signal r_top     : std_logic_vector (31 downto 0) := x"00000000";
  signal r_mid     : std_logic_vector (31 downto 0) := x"00000000";
  signal r_bot     : std_logic_vector (31 downto 0) := x"00000000";
  signal r_flags   : std_logic_vector (15 downto 0) := x"0000";
  signal r_sp      : std_logic_vector (15 downto 0) := x"0000";
begin

-- Set outputs
o_state <= r_state;
o_inst  <= r_inst;
o_top   <= r_top;
o_mid   <= r_mid;
o_bot   <= r_bot;
o_flags <= r_flags;
o_sp    <= r_sp;

-- Register process    
reg_process: process(clk)
begin
  if (rising_edge(clk)) then
    if (reset = '0') then
      r_state <= i_state;
      r_inst  <= i_inst;
      r_top   <= i_top;
      r_mid   <= i_mid;
      r_bot   <= i_bot;
      r_flags <= i_flags;
      r_sp    <= i_sp;
    else
      r_state <= x"00000";
      -- Non-zero intentional. x20 is NOP
      r_inst  <= x"20";
      r_top   <= x"00000000";
      r_mid   <= x"00000000";
      r_bot   <= x"00000000";
      r_flags <= x"0000";
      r_sp    <= x"0000";
    end if;
  end if;
end process;

end Behavioral;
