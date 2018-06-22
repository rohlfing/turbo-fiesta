add_force {/top_level/CLK100MHZ} -radix hex {1 0ns} {0 5000ps} -repeat_every 10000ps
add_force {/top_level/reset} -radix hex {1 0ns}
run 80 ns
add_force {/top_level/reset} -radix hex {0 0ns}
run 80 ns