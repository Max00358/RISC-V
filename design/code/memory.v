`define S_TYPE 7'b0100011

module memory(
	input clock,
	input reset,
	input valid,
	input[6:0] opcode,
	input[2:0] funct3,
	input[31:0] alu_res,
	input[31:0] reg_2,

	output read_write_out,
	output[31:0] mem_res
);
	wire[1:0] access_size;
	wire[31:0] dmemory_mem_res;
	
	assign access_size[1:0] = funct3[1:0];
	assign mem_res[31:0] = dmemory_mem_res[31:0];
		//read_write ? 32'd0 : dmemory_mem_res[31:0];

	reg read_write;
	assign read_write_out = read_write;

	always @(*) begin
		if (!reset && valid && opcode == `S_TYPE) begin
			read_write = 1;
		end else begin
			read_write = 0;
		end
	end


	dmemory dmemory_0(
		.clock(clock),
		.read_write(read_write),
		.access_size(access_size),
		.address(alu_res),
		.data_in(reg_2),
		.data_out(dmemory_mem_res)
	); 

endmodule


