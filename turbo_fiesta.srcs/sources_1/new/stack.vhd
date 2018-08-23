library IEEE;
library xil_defaultlib;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use xil_defaultlib.array2D.all;

entity stack is
  port(clk       : in  std_logic; -- Clock
       w_enable  : in  std_logic; -- Write enable (high for only one clock cycle)
       alu_flags : in  std_logic_vector(15 downto 0); -- Flags from ALU (bitfield in alu_ex.vhd)
       w_bot     : in    signed(31 downto 0);  -- Data to write onto stack
       w_top     : in    signed(31 downto 0);  -- Data to write higher onto stack (optional)
       prev_sp   : in  unsigned(15 downto 0);
       curr_sp   : out unsigned(15 downto 0);
       top       : out   signed(31 downto 0);  -- Data on top of stack
       mid       : out   signed(31 downto 0);  -- Data 1 below top value
       bot       : out   signed(31 downto 0)); -- Data 2 below top value
end stack;

architecture behavioral of stack is

COMPONENT blk_mem_gen_0
  PORT (
    clka  : IN STD_LOGIC;
    ena   : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    clkb  : IN STD_LOGIC;
    enb   : IN STD_LOGIC;
    web   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END COMPONENT;

  -- integers
  signal i_n_pop   : integer;
  signal i_n_push  : integer;
  signal i_prev_sp : integer;
  signal i_temp_sp : integer;
  signal i_curr_sp : integer;

  -- Addresses before bounds checking
  signal s_temp_a  : signed(15 downto 0);
  signal s_temp_b  : signed(15 downto 0);

  -- Flags
  signal underflow : std_logic; -- Set if stack size is less than 3
  signal aligned   : std_logic; -- Set if address of bottom popped value is even (aligned with port A)

  -- Memory interface signals
  signal s_wea   : std_logic_vector( 7 downto 0);
  signal s_addra : std_logic_vector( 9 downto 0);
  signal s_dina  :           signed(63 downto 0);
  signal s_douta : std_logic_vector(63 downto 0);
  signal s_web   : std_logic_vector( 7 downto 0);
  signal s_addrb : std_logic_vector( 9 downto 0);
  signal s_dinb  :           signed(63 downto 0);
  signal s_doutb : std_logic_vector(63 downto 0);
      
begin

  -- Outputs
  curr_sp <= to_unsigned(i_curr_sp, 16);

  -- Get integers; compute current stack pointer
  i_n_push  <= to_integer(unsigned(alu_flags( 9 downto  8)));
  i_n_pop   <= to_integer(unsigned(alu_flags(11 downto 10)));
  i_prev_sp <= to_integer(prev_sp);
  i_temp_sp <= i_prev_sp - i_n_pop;
  i_curr_sp <= (i_temp_sp + i_n_push) when i_temp_sp > 0 else i_n_push;

  -- Set reusable flags
  underflow <= '1' when i_curr_sp < 3 else '0';
  aligned   <= '1' when (i_curr_sp mod 2) = 1 else '0';

  -- Compute addresses. If base address would be negative, set to bottom of stack
  s_temp_a  <= to_signed(i_curr_sp - 3, 16);
  s_addra   <= std_logic_vector(s_temp_a(10 downto 1)) when underflow = '0' else
               "0000000000";
  s_temp_b  <= to_signed(i_curr_sp - 1, 16);
  s_addrb   <= std_logic_vector(s_temp_b(10 downto 1)) when underflow = '0' else
               "0000000001";

  -- Set the write data and byte enables
  -- Write to bottom of stack only if stack was previously empty
  s_dina(31 downto  0) <= w_bot;
  s_wea ( 3 downto  0) <= x"0"  when w_enable = '0'                    else
                          x"F"  when i_curr_sp = i_n_push              else
                          x"0";
  -- Write to word 1 on certain underflows or if pushing 2 while aligned
  s_dina(63 downto 32) <= w_top when i_curr_sp = 2 and i_n_push = 2    else
                          w_bot;
  s_wea ( 7 downto  4) <= x"0"  when w_enable = '0'                    else
                          x"F"  when i_curr_sp = 2 and i_n_push > 0    else
                          x"F"  when aligned = '1' and i_n_push = 2    else
                          x"0";
  -- Write to word 2 for aligned push or unaligned push 2
  s_dinb(31 downto  0) <= w_top when aligned = '1' and i_n_push = 2    else
                          w_bot;
  s_web ( 3 downto  0) <= x"0"  when underflow = '1' or w_enable = '0' else
                          x"F"  when i_n_push = 2                      else
                          x"F"  when aligned = '1' and i_n_push = 1    else
                          x"0";
  -- Write to word 3 for unaligned push (but never when underflowed)
  s_dinb(63 downto 32) <= w_top when aligned = '0' and i_n_push = 2    else
                          w_bot;
  s_web ( 7 downto  4) <= x"0"  when underflow = '1' or w_enable = '0' else
                          x"F"  when aligned = '0' and i_n_push > 0    else
                          x"0";

  -- Map memory output to 'popped' stack values
  -- Top -- Direct read from input cases
  top <= w_top when i_n_push = 2 else
         w_bot when i_n_push = 1 else
         -- Underflow cases
         x"00000000" when i_curr_sp = 0 else
         signed(s_douta(31 downto  0)) when i_curr_sp = 1 else 
         signed(s_douta(63 downto 32)) when i_curr_sp = 2 else
         -- Normal read cases
         signed(s_doutb(31 downto  0)) when aligned = '1' else 
         signed(s_doutb(63 downto 32));

  -- Mid -- Direct read from input cases
  mid <= w_bot when i_n_push = 2 else
         -- Underflow cases
         x"00000000" when i_curr_sp < 2 else
         signed(s_douta(31 downto  0)) when i_curr_sp = 2 else
         -- Normal read cases
         signed(s_douta(63 downto 32)) when aligned = '1' else 
         signed(s_doutb(31 downto  0));

  -- Bot -- Underflow cases
  bot <= x"00000000" when underflow = '1' else
         -- Normal read cases
         signed(s_douta(31 downto  0)) when aligned = '1' else 
         signed(s_douta(63 downto 32));

  -- Block memory IP core holding the "stack"
  stack_mem : blk_mem_gen_0
    PORT MAP (
      clka  => clk,
      ena   => '1',
      wea   => s_wea,
      addra => s_addra,
      dina  => std_logic_vector(s_dina),
      douta => s_douta,
      clkb  => clk,
      enb   => '1',
      web   => s_web,
      addrb => s_addrb,
      dinb  => std_logic_vector(s_dinb),
      doutb => s_doutb);
end behavioral;
