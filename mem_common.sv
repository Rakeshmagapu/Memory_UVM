class mem_common;
`define ADDR_WIDTH $clog2(`DEPTH)
`define DATA_WIDTH 16
`define DEPTH 16

  static int match_count;
  static int miss_match_count;
endclass
