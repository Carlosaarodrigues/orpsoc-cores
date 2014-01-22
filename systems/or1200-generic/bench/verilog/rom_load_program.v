//////////////////////////////////////////////////////////////////////
////                                                              ////
////  ROM                                                         ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback (unneback@opencores.org)             ////
////      - Julius Baxter    (julius@opencores.org)               ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors                                   ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

module rom_load_program
  #(parameter addr_width = 5,
    parameter b3_burst   = 0)
   (
    input 		       wb_clk,
    input 		       wb_rst,
    input [(addr_width+2)-1:2] wb_adr_i,
    input 		       wb_stb_i,
    input 		       wb_cyc_i,
    input [2:0] 	       wb_cti_i,
    input [1:0] 	       wb_bte_i,
    output reg [31:0] 	       wb_dat_o,
    output reg 		       wb_ack_o);
   
   reg [addr_width-1:0] 	    adr;

   always @ (posedge wb_clk or posedge wb_rst)
     if (wb_rst)
       wb_dat_o <= 32'h15000000;
     else
       case (adr)
	 // Zero r0 and jump to 0x00000100
0 : wb_dat_o <=  32'h18000000;
1 : wb_dat_o <=  32'h19a00000;
2 : wb_dat_o <=  32'h18200000;
3 : wb_dat_o <=  32'h1880b000;
4 : wb_dat_o <=  32'h18a09000;
5 : wb_dat_o <=  32'h19609100;
6 : wb_dat_o <=  32'ha84000ff;
7 : wb_dat_o <=  32'hd8040004;
8 : wb_dat_o <=  32'hd8041000;
9 : wb_dat_o <=  32'hd8041003;
10 : wb_dat_o <=  32'ha8c00001;
11 : wb_dat_o <=  32'hd8043004;
12 : wb_dat_o <=  32'ha8600003;
13 : wb_dat_o <=  32'hd8041802;
14 : wb_dat_o <=  32'ha8600000;
15 : wb_dat_o <=  32'hd8041802;
16 : wb_dat_o <=  32'ha8600000;
17 : wb_dat_o <=  32'hd8041802;
18 : wb_dat_o <=  32'ha8600000;
19 : wb_dat_o <=  32'hd8041802;
20 : wb_dat_o <=  32'ha8600001;
21 : wb_dat_o <=  32'hd8041801;
22 : wb_dat_o <=  32'h18c00000;
23 : wb_dat_o <=  32'h18e00001;
24 : wb_dat_o <=  32'ha8e7ffff;
25 : wb_dat_o <=  32'h15000000;
26 : wb_dat_o <=  32'h8c640002;
27 : wb_dat_o <=  32'ha5030001;
28 : wb_dat_o <=  32'he4004000;
29 : wb_dat_o <=  32'h0ffffffc;
30 : wb_dat_o <=  32'h8c640002;
31 : wb_dat_o <=  32'he1013000;
32 : wb_dat_o <=  32'hd8081800;
33 : wb_dat_o <=  32'h9cc60001;
34 : wb_dat_o <=  32'hbc060101;
35 : wb_dat_o <=  32'h10000011;
36 : wb_dat_o <=  32'hbc060104;
37 : wb_dat_o <=  32'h10000008;
38 : wb_dat_o <=  32'he4063800;
39 : wb_dat_o <=  32'h0ffffff2;
40 : wb_dat_o <=  32'h15000000;
41 : wb_dat_o <=  32'hc0000811;
42 : wb_dat_o <=  32'ha8210100;
43 : wb_dat_o <=  32'h44000800;
44 : wb_dat_o <=  32'hd8040004;
45 : wb_dat_o <=  32'h84610100;
46 : wb_dat_o <=  32'hb9430050;
47 : wb_dat_o <=  32'hbc0a1800;
48 : wb_dat_o <=  32'h0c000009;
49 : wb_dat_o <=  32'h15000000;
50 : wb_dat_o <=  32'h03ffffe7;
51 : wb_dat_o <=  32'h15000000;
52 : wb_dat_o <=  32'hbc030018;
53 : wb_dat_o <=  32'h0c00000e;
54 : wb_dat_o <=  32'h15000000;
55 : wb_dat_o <=  32'h03ffffe2;
56 : wb_dat_o <=  32'h15000000;
57 : wb_dat_o <=  32'h15000000;
58 : wb_dat_o <=  32'ha86000ff;
59 : wb_dat_o <=  32'h9d0b0001;
60 : wb_dat_o <=  32'hd8081800;
61 : wb_dat_o <=  32'ha86d0005;
62 : wb_dat_o <=  32'h9d0b0000;
63 : wb_dat_o <=  32'hd8081800;
64 : wb_dat_o <=  32'h0400000d;
65 : wb_dat_o <=  32'h15000000;
66 : wb_dat_o <=  32'h0000008e;
67 : wb_dat_o <=  32'h15000000;
68 : wb_dat_o <=  32'ha86000ff;
69 : wb_dat_o <=  32'h9d0b0001;
70 : wb_dat_o <=  32'hd8081800;
71 : wb_dat_o <=  32'ha86d0003;
72 : wb_dat_o <=  32'h9d0b0000;
73 : wb_dat_o <=  32'hd8081800;
74 : wb_dat_o <=  32'h04000003;
75 : wb_dat_o <=  32'h15000000;
76 : wb_dat_o <=  32'h000000c6;
77 : wb_dat_o <=  32'he1804804;
78 : wb_dat_o <=  32'ha86000c7;
79 : wb_dat_o <=  32'h9d050002;
80 : wb_dat_o <=  32'hd8081800;
81 : wb_dat_o <=  32'ha8600000;
82 : wb_dat_o <=  32'h9d050001;
83 : wb_dat_o <=  32'hd8081800;
84 : wb_dat_o <=  32'ha8600083;
85 : wb_dat_o <=  32'h9d050003;
86 : wb_dat_o <=  32'hd8081800;
87 : wb_dat_o <=  32'ha8600036;
88 : wb_dat_o <=  32'h9d050000;
89 : wb_dat_o <=  32'hd8081800;
90 : wb_dat_o <=  32'ha8600000;
91 : wb_dat_o <=  32'h9d050001;
92 : wb_dat_o <=  32'hd8081800;
93 : wb_dat_o <=  32'ha8600003;
94 : wb_dat_o <=  32'h9d050003;
95 : wb_dat_o <=  32'hd8081800;
96 : wb_dat_o <=  32'h040000ea;
97 : wb_dat_o <=  32'h15000000;
98 : wb_dat_o <=  32'ha8600043;
99 : wb_dat_o <=  32'h9d050000;
100 : wb_dat_o <=  32'hd8081800;
101 : wb_dat_o <=  32'h040000e5;
102 : wb_dat_o <=  32'h15000000;
103 : wb_dat_o <=  32'ha860004f;
104 : wb_dat_o <=  32'h9d050000;
105 : wb_dat_o <=  32'hd8081800;
106 : wb_dat_o <=  32'h040000e0;
107 : wb_dat_o <=  32'h15000000;
108 : wb_dat_o <=  32'ha860004d;
109 : wb_dat_o <=  32'h9d050000;
110 : wb_dat_o <=  32'hd8081800;
111 : wb_dat_o <=  32'h040000db;
112 : wb_dat_o <=  32'h15000000;
113 : wb_dat_o <=  32'ha860004d;
114 : wb_dat_o <=  32'h9d050000;
115 : wb_dat_o <=  32'hd8081800;
116 : wb_dat_o <=  32'h040000d6;
117 : wb_dat_o <=  32'h15000000;
118 : wb_dat_o <=  32'ha8600055;
119 : wb_dat_o <=  32'h9d050000;
120 : wb_dat_o <=  32'hd8081800;
121 : wb_dat_o <=  32'h040000d1;
122 : wb_dat_o <=  32'h15000000;
123 : wb_dat_o <=  32'ha860004e;
124 : wb_dat_o <=  32'h9d050000;
125 : wb_dat_o <=  32'hd8081800;
126 : wb_dat_o <=  32'h040000cc;
127 : wb_dat_o <=  32'h15000000;
128 : wb_dat_o <=  32'ha8600049;
129 : wb_dat_o <=  32'h9d050000;
130 : wb_dat_o <=  32'hd8081800;
131 : wb_dat_o <=  32'h040000c7;
132 : wb_dat_o <=  32'h15000000;
133 : wb_dat_o <=  32'ha8600043;
134 : wb_dat_o <=  32'h9d050000;
135 : wb_dat_o <=  32'hd8081800;
136 : wb_dat_o <=  32'h040000c2;
137 : wb_dat_o <=  32'h15000000;
138 : wb_dat_o <=  32'ha8600041;
139 : wb_dat_o <=  32'h9d050000;
140 : wb_dat_o <=  32'hd8081800;
141 : wb_dat_o <=  32'h040000bd;
142 : wb_dat_o <=  32'h15000000;
143 : wb_dat_o <=  32'ha8600054;
144 : wb_dat_o <=  32'h9d050000;
145 : wb_dat_o <=  32'hd8081800;
146 : wb_dat_o <=  32'h040000b8;
147 : wb_dat_o <=  32'h15000000;
148 : wb_dat_o <=  32'ha8600049;
149 : wb_dat_o <=  32'h9d050000;
150 : wb_dat_o <=  32'hd8081800;
151 : wb_dat_o <=  32'h040000b3;
152 : wb_dat_o <=  32'h15000000;
153 : wb_dat_o <=  32'ha860004f;
154 : wb_dat_o <=  32'h9d050000;
155 : wb_dat_o <=  32'hd8081800;
156 : wb_dat_o <=  32'h040000ae;
157 : wb_dat_o <=  32'h15000000;
158 : wb_dat_o <=  32'ha860004e;
159 : wb_dat_o <=  32'h9d050000;
160 : wb_dat_o <=  32'hd8081800;
161 : wb_dat_o <=  32'h040000a9;
162 : wb_dat_o <=  32'h15000000;
163 : wb_dat_o <=  32'ha8600020;
164 : wb_dat_o <=  32'h9d050000;
165 : wb_dat_o <=  32'hd8081800;
166 : wb_dat_o <=  32'h040000a4;
167 : wb_dat_o <=  32'h15000000;
168 : wb_dat_o <=  32'ha8600050;
169 : wb_dat_o <=  32'h9d050000;
170 : wb_dat_o <=  32'hd8081800;
171 : wb_dat_o <=  32'h0400009f;
172 : wb_dat_o <=  32'h15000000;
173 : wb_dat_o <=  32'ha8600052;
174 : wb_dat_o <=  32'h9d050000;
175 : wb_dat_o <=  32'hd8081800;
176 : wb_dat_o <=  32'h0400009a;
177 : wb_dat_o <=  32'h15000000;
178 : wb_dat_o <=  32'ha860004f;
179 : wb_dat_o <=  32'h9d050000;
180 : wb_dat_o <=  32'hd8081800;
181 : wb_dat_o <=  32'h04000095;
182 : wb_dat_o <=  32'h15000000;
183 : wb_dat_o <=  32'ha8600042;
184 : wb_dat_o <=  32'h9d050000;
185 : wb_dat_o <=  32'hd8081800;
186 : wb_dat_o <=  32'h04000090;
187 : wb_dat_o <=  32'h15000000;
188 : wb_dat_o <=  32'ha860004c;
189 : wb_dat_o <=  32'h9d050000;
190 : wb_dat_o <=  32'hd8081800;
191 : wb_dat_o <=  32'h0400008b;
192 : wb_dat_o <=  32'h15000000;
193 : wb_dat_o <=  32'ha8600045;
194 : wb_dat_o <=  32'h9d050000;
195 : wb_dat_o <=  32'hd8081800;
196 : wb_dat_o <=  32'h04000086;
197 : wb_dat_o <=  32'h15000000;
198 : wb_dat_o <=  32'ha860004d;
199 : wb_dat_o <=  32'h9d050000;
200 : wb_dat_o <=  32'hd8081800;
201 : wb_dat_o <=  32'h04000081;
202 : wb_dat_o <=  32'h15000000;
203 : wb_dat_o <=  32'ha8600020;
204 : wb_dat_o <=  32'h9d050000;
205 : wb_dat_o <=  32'hd8081800;
206 : wb_dat_o <=  32'h44006000;
207 : wb_dat_o <=  32'h15000000;
208 : wb_dat_o <=  32'h0400007a;
209 : wb_dat_o <=  32'h15000000;
210 : wb_dat_o <=  32'ha8600057;
211 : wb_dat_o <=  32'h9d050000;
212 : wb_dat_o <=  32'hd8081800;
213 : wb_dat_o <=  32'h04000075;
214 : wb_dat_o <=  32'h15000000;
215 : wb_dat_o <=  32'ha8600052;
216 : wb_dat_o <=  32'h9d050000;
217 : wb_dat_o <=  32'hd8081800;
218 : wb_dat_o <=  32'h04000070;
219 : wb_dat_o <=  32'h15000000;
220 : wb_dat_o <=  32'ha8600049;
221 : wb_dat_o <=  32'h9d050000;
222 : wb_dat_o <=  32'hd8081800;
223 : wb_dat_o <=  32'h0400006b;
224 : wb_dat_o <=  32'h15000000;
225 : wb_dat_o <=  32'ha8600054;
226 : wb_dat_o <=  32'h9d050000;
227 : wb_dat_o <=  32'hd8081800;
228 : wb_dat_o <=  32'h04000066;
229 : wb_dat_o <=  32'h15000000;
230 : wb_dat_o <=  32'ha8600045;
231 : wb_dat_o <=  32'h9d050000;
232 : wb_dat_o <=  32'hd8081800;
233 : wb_dat_o <=  32'h04000061;
234 : wb_dat_o <=  32'h15000000;
235 : wb_dat_o <=  32'ha8600020;
236 : wb_dat_o <=  32'h9d050000;
237 : wb_dat_o <=  32'hd8081800;
238 : wb_dat_o <=  32'h0400005c;
239 : wb_dat_o <=  32'h15000000;
240 : wb_dat_o <=  32'ha860004d;
241 : wb_dat_o <=  32'h9d050000;
242 : wb_dat_o <=  32'hd8081800;
243 : wb_dat_o <=  32'h04000057;
244 : wb_dat_o <=  32'h15000000;
245 : wb_dat_o <=  32'ha8600045;
246 : wb_dat_o <=  32'h9d050000;
247 : wb_dat_o <=  32'hd8081800;
248 : wb_dat_o <=  32'h04000052;
249 : wb_dat_o <=  32'h15000000;
250 : wb_dat_o <=  32'ha860004d;
251 : wb_dat_o <=  32'h9d050000;
252 : wb_dat_o <=  32'hd8081800;
253 : wb_dat_o <=  32'h0400004d;
254 : wb_dat_o <=  32'h15000000;
255 : wb_dat_o <=  32'ha860004f;
256 : wb_dat_o <=  32'h9d050000;
257 : wb_dat_o <=  32'hd8081800;
258 : wb_dat_o <=  32'h04000048;
259 : wb_dat_o <=  32'h15000000;
260 : wb_dat_o <=  32'ha8600052;
261 : wb_dat_o <=  32'h9d050000;
262 : wb_dat_o <=  32'hd8081800;
263 : wb_dat_o <=  32'h04000043;
264 : wb_dat_o <=  32'h15000000;
265 : wb_dat_o <=  32'ha8600059;
266 : wb_dat_o <=  32'h9d050000;
267 : wb_dat_o <=  32'hd8081800;
268 : wb_dat_o <=  32'h0400003e;
269 : wb_dat_o <=  32'h15000000;
270 : wb_dat_o <=  32'ha860000a;
271 : wb_dat_o <=  32'h9d050000;
272 : wb_dat_o <=  32'hd8081800;
273 : wb_dat_o <=  32'h03ffff18;
274 : wb_dat_o <=  32'h04000038;
275 : wb_dat_o <=  32'h15000000;
276 : wb_dat_o <=  32'ha8600052;
277 : wb_dat_o <=  32'h9d050000;
278 : wb_dat_o <=  32'hd8081800;
279 : wb_dat_o <=  32'h04000033;
280 : wb_dat_o <=  32'h15000000;
281 : wb_dat_o <=  32'ha8600045;
282 : wb_dat_o <=  32'h9d050000;
283 : wb_dat_o <=  32'hd8081800;
284 : wb_dat_o <=  32'h0400002e;
285 : wb_dat_o <=  32'h15000000;
286 : wb_dat_o <=  32'ha8600041;
287 : wb_dat_o <=  32'h9d050000;
288 : wb_dat_o <=  32'hd8081800;
289 : wb_dat_o <=  32'h04000029;
290 : wb_dat_o <=  32'h15000000;
291 : wb_dat_o <=  32'ha8600044;
292 : wb_dat_o <=  32'h9d050000;
293 : wb_dat_o <=  32'hd8081800;
294 : wb_dat_o <=  32'h04000024;
295 : wb_dat_o <=  32'h15000000;
296 : wb_dat_o <=  32'ha8600020;
297 : wb_dat_o <=  32'h9d050000;
298 : wb_dat_o <=  32'hd8081800;
299 : wb_dat_o <=  32'h0400001f;
300 : wb_dat_o <=  32'h15000000;
301 : wb_dat_o <=  32'ha8600046;
302 : wb_dat_o <=  32'h9d050000;
303 : wb_dat_o <=  32'hd8081800;
304 : wb_dat_o <=  32'h0400001a;
305 : wb_dat_o <=  32'h15000000;
306 : wb_dat_o <=  32'ha860004c;
307 : wb_dat_o <=  32'h9d050000;
308 : wb_dat_o <=  32'hd8081800;
309 : wb_dat_o <=  32'h04000015;
310 : wb_dat_o <=  32'h15000000;
311 : wb_dat_o <=  32'ha8600041;
312 : wb_dat_o <=  32'h9d050000;
313 : wb_dat_o <=  32'hd8081800;
314 : wb_dat_o <=  32'h04000010;
315 : wb_dat_o <=  32'h15000000;
316 : wb_dat_o <=  32'ha8600053;
317 : wb_dat_o <=  32'h9d050000;
318 : wb_dat_o <=  32'hd8081800;
319 : wb_dat_o <=  32'h0400000b;
320 : wb_dat_o <=  32'h15000000;
321 : wb_dat_o <=  32'ha8600048;
322 : wb_dat_o <=  32'h9d050000;
323 : wb_dat_o <=  32'hd8081800;
324 : wb_dat_o <=  32'h04000006;
325 : wb_dat_o <=  32'h15000000;
326 : wb_dat_o <=  32'ha860000a;
327 : wb_dat_o <=  32'h9d050000;
328 : wb_dat_o <=  32'hd8081800;
329 : wb_dat_o <=  32'h03fffee0;
330 : wb_dat_o <=  32'ha8800060;
331 : wb_dat_o <=  32'h9d050005;
332 : wb_dat_o <=  32'h8c680000;
333 : wb_dat_o <=  32'he4032000;
334 : wb_dat_o <=  32'h0ffffffd;
335 : wb_dat_o <=  32'h15000000;
336 : wb_dat_o <=  32'h44004800;
337 : wb_dat_o <=  32'h15000000;
	 default:
	   wb_dat_o <= 32'h00000000;
       endcase // case (wb_adr_i)

generate
if(b3_burst) begin : gen_b3_burst
   reg 				    wb_stb_i_r;
   reg 				    new_access_r;   
   reg 				    burst_r;
	 
   wire burst      = wb_cyc_i & (!(wb_cti_i == 3'b000)) & (!(wb_cti_i == 3'b111));
   wire new_access = (wb_stb_i & !wb_stb_i_r);
   wire new_burst  = (burst & !burst_r);

   always @(posedge wb_clk) begin
     new_access_r <= new_access;
     burst_r      <= burst;
     wb_stb_i_r   <= wb_stb_i;
   end
   
   
   always @(posedge wb_clk)
     if (wb_rst)
       adr <= 0;
     else if (new_access)
       // New access, register address, ack a cycle later
       adr <= wb_adr_i[(addr_width+2)-1:2];
     else if (burst) begin
	if (wb_cti_i == 3'b010)
	  case (wb_bte_i)
	    2'b00: adr <= adr + 1;
	    2'b01: adr[1:0] <= adr[1:0] + 1;
	    2'b10: adr[2:0] <= adr[2:0] + 1;
	    2'b11: adr[3:0] <= adr[3:0] + 1;
	  endcase // case (wb_bte_i)
	else
	  adr <= wb_adr_i[(addr_width+2)-1:2];
     end // if (burst)
   
   
   always @(posedge wb_clk)
     if (wb_rst)
       wb_ack_o <= 0;
     else if (wb_ack_o & (!burst | (wb_cti_i == 3'b111)))
       wb_ack_o <= 0;
     else if (wb_stb_i & ((!burst & !new_access & new_access_r) | (burst & burst_r)))
       wb_ack_o <= 1;
     else
       wb_ack_o <= 0;

end 
else begin

    always @(wb_adr_i)
	adr = wb_adr_i;
	
    always @ (posedge wb_clk or posedge wb_rst)
	if (wb_rst)
	    wb_ack_o <= 1'b0;
	else
	    wb_ack_o <= wb_stb_i & wb_cyc_i & !wb_ack_o;
	
end

endgenerate   
endmodule 
