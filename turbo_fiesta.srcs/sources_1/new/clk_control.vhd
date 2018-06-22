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
  signal count  : unsigned(2 downto 0) := "000";

begin
  with count select pc_clk <=
    '1' when "000",
    '1' when "001",
    '1' when "010",
    '0' when others;

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
      else
        count <= count + to_unsigned(1, 3);
      end if;
    end if;
  end process;

end behavioral;
