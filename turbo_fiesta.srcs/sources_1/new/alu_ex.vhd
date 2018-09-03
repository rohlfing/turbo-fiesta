library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Output alu_flags is
--  bit(s) flag
--  0      Direction Change?
--  1      Write to IM?
--  2      Bridge?
--  3      Write to stdout?
--  4      String Mode?
--  5      Push from IM?
--  6      Pop from stdin queue?
--  7      Unused
--  9-8    # values pushed
--  11-10  # values popped
--  13-12  New dy
--  15-14  New dx

entity alu_ex is
  port (inst      : in  std_logic_vector(7 downto 0);
        strmode   : in  std_logic;
        bot       : in  signed(31 downto 0);
        mid       : in  signed(31 downto 0);
        top       : in  signed(31 downto 0);
        stdin     : in  signed(31 downto 0);
        state_in  : in  std_logic_vector(19 downto 0);
        stall     : out std_logic;
        state_out : out std_logic_vector(19 downto 0);
        alu_flags : out std_logic_vector(15 downto 0);
        restop    : out signed(31 downto 0);
        resbot    : out signed(31 downto 0);
        im_addr   : out std_logic_vector(11 downto 0));
end alu_ex;

architecture Behavioral of alu_ex is
  -- Intermediate signals
  signal s_flags   : std_logic_vector(15 downto 0); -- Replaced if string mode is on
  signal s_vertf   : std_logic_vector(15 downto 0); -- Flags if command is '|'
  signal s_horzf   : std_logic_vector(15 downto 0); -- Flags if command is '_'
  signal s_im_addr : std_logic_vector(15 downto 0); -- Zero-padded copy of output
  signal s_zero    : signed(31 downto 0); -- Literally zero
  signal s_one     : signed(31 downto 0); -- Literally one
  signal s_mul_res : signed(63 downto 0); -- Multiplication result. Lower 32 bits used
  signal s_mul_cut : signed(31 downto 0); -- Lower word of multiply result
  signal s_mod_res : signed(31 downto 0); -- Result of modulo operation
  signal s_div_res : signed(31 downto 0); -- Result of division operation
  signal s_remul   : signed(63 downto 0); -- Result of (mid / top) * top
  signal s_not_res : signed(31 downto 0); -- 1 if top = 0x0, 0 else
  signal s_gt_res  : signed(31 downto 0); -- 1 if mid > top
  signal s_restop  : signed(31 downto 0); -- Top result if strmode = '0'
  signal s_resbot  : signed(31 downto 0); -- Bot result if strmode = '0'
  signal s_state   : signed(31 downto 0); -- Zero-padded signed input state
  signal s_stall   : std_logic;

begin

-- IM address only used for 'g' and 'p' instructions
s_im_addr <= std_logic_vector(mid(15 downto 0) + (to_signed(80, 8) * top(7 downto 0)));
im_addr   <= s_im_addr(11 downto 0);
state_out <= state_in                           when strmode = '1' else -- No jumps in string mode
             x"01900"                           when inst = x"2e"  else -- Jump to number print
             x"01e00"                           when inst = x"26"  else -- Jump to number scan
             std_logic_vector(top(19 downto 0)) when inst = x"6a"  else -- Jump to popped state on 'j'
             state_in;                                                  -- Default is no jump

-- Get flags for conditional redirects
with top select s_vertf <=
  x"1401" when x"00000000",
  x"3401" when others;
with top select s_horzf <=
  x"4401" when x"00000000",
  x"C401" when others;

with inst select s_flags <=
  x"0900" when x"2b", -- +
  x"0900" when x"2d", -- -
  x"0900" when x"2a", -- *
  x"0900" when x"2f", -- /
  x"0900" when x"25", -- %
  x"0500" when x"21", -- !
  x"0900" when x"60", -- `
  x"4001" when x"3e", -- >
  x"C001" when x"3c", -- <
  x"3001" when x"5e", -- ^
  x"1001" when x"76", -- v
  -- TODO ADR randomize '?' instruction
  x"C001" when x"3f", -- ?
  s_horzf when x"5f", -- _
  s_vertf when x"7c", -- |
  x"0010" when x"22", -- "
  x"0600" when x"3a", -- :
  x"0A00" when x"5c", -- \
  x"0400" when x"24", -- $
  x"0100" when x"2e", -- . -- Note: this is now a jump
  x"0408" when x"2c", -- ,
  x"0004" when x"23", -- #
  x"0920" when x"67", -- g
  x"0C02" when x"70", -- p
  x"0100" when x"26", -- & -- Note: this is now a jump
  x"0140" when x"7e", -- ~
  x"0001" when x"40", -- @
  x"0000" when x"20", --' '
  x"0400" when x"6a", -- j
  x"0100" when others;-- 0, 1, ..., f

-- Compute the longer result expressions here
s_zero    <= x"00000000";
s_one     <= x"00000001";
s_mul_res <= mid * top;
s_mul_cut <= s_mul_res(31 downto 0);
s_not_res <= s_one when top = s_zero else s_zero;
s_gt_res  <= s_one when mid > top    else s_zero;
s_mod_res <= s_zero when top = s_zero else
             mid mod top;
s_div_res <= s_zero when top = s_zero else
             mid / top;
s_state   <= signed(x"000" & state_in);

-- Set stall if hard math is happening (also freezes program on divide-by-zero)
stall <= s_stall when inst = x"2a" or inst = x"2f" or inst = x"25" else
         '0';
s_stall <= '1' when (s_remul(31 downto 0) + s_mod_res) /= mid else
           '0';
s_remul <= s_div_res * top;

-- Select bottom pushed value (if any values are pushed)
with inst select s_resbot <=
  mid + top   when x"2b", -- +
  mid - top   when x"2d", -- -
  s_mul_cut   when x"2a", -- *
  s_div_res   when x"2f", -- /
  s_mod_res   when x"25", -- % --mid mod top
  s_not_res   when x"21", -- !
  s_gt_res    when x"60", -- `
  top         when x"3a", -- :
  top         when x"5c", -- \
  s_state     when x"2e", -- . -- Pushes current PC state
  top         when x"2c", -- ,
  bot         when x"70", -- p
  s_state     when x"26", -- & -- Pushes current PC state
  stdin       when x"7e", -- ~
  -- Push literal 0, 1, ..., f
  x"00000000" when x"30", -- 0
  x"00000001" when x"31", -- 1
  x"00000002" when x"32", -- 2
  x"00000003" when x"33", -- 3
  x"00000004" when x"34", -- 4
  x"00000005" when x"35", -- 5
  x"00000006" when x"36", -- 6
  x"00000007" when x"37", -- 7
  x"00000008" when x"38", -- 8
  x"00000009" when x"39", -- 9
  x"0000000A" when x"61", -- a
  x"0000000B" when x"62", -- b
  x"0000000C" when x"63", -- c
  x"0000000D" when x"64", -- d
  x"0000000E" when x"65", -- e
  x"0000000F" when x"66", -- f
  s_zero      when others;

-- Select top pushed value (if two values are pushed)
with inst select s_restop <=
  top    when x"3a", -- :
  mid    when x"5c", -- \
  s_zero when others;

-- Actual outputs
alu_flags <= s_flags when strmode = '0' else
             x"0110" when inst /= x"22" else
             x"0000";

-- Push instruction byte when string mode is on
resbot <= s_resbot when strmode = '0' else
          signed(x"000000" & inst);

-- String mode doesn't push top, so this can be unchanged
restop <= s_restop;

end Behavioral;
