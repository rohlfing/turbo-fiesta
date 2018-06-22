library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity clk_control is
  port(clk      : in  std_logic; -- Clock
       reset    : in  std_logic; -- Reset pin
       pc_clk   : out std_logic; -- Clock for PC
       alu_clk  : out std_logic; -- Clock for ALU computation
       im_clk   : out std_logic; -- Clock to enable instruction mem write
       st_clk   : out std_logic);-- Clock to enable stack push
end clk_control;

architecture behavioral of clk_control is
  -- Internal signals
  -- Signal count Counts 0 through 7 to determine which sub-clock is high
  signal count     : unsigned(2 downto 0) := "000";
  -- Once while reset is high, rst_clock is toggled to reset the PC 
  signal rst_count : unsigned(2 downto 0) := "000";
  -- Internal copy of pc_clk to apply alt clock during reset
  signal s_pc_clk  : std_logic;

begin
  with count select s_pc_clk <=
    '1' when "000",
    '1' when "001",
    '1' when "010",
    '0' when others;

  -- assign pc_clk with clk for reset or normal operation
  pc_clk <= s_pc_clk when   '0' = reset     else
            '1'      when "001" = rst_count else
            '0';

  with count select alu_clk <=
    '1' when "011",
    '0' when others;

  with count select im_clk <=
    '1' when "100",
    '1' when "101",
    '0' when others;

  with count select st_clk <=
    '1' when "110",
    '1' when "111",
    '0' when others;

  counting_proc: process(clk)
  begin
    if(rising_edge(clk))
    then
      if (reset = '1')
      then
        count <= "000";
        if (rst_count < to_unsigned(4, 3))
        then
          rst_count <= rst_count + to_unsigned(1, 3);
        else
          rst_count <= rst_count;
        end if;
      else
        rst_count <= "000";
        count <= count + to_unsigned(1, 3);
      end if;
    end if;
  end process;

end behavioral;
