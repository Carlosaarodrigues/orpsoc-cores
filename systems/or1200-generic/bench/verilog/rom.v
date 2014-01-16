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

module rom
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
20 : wb_dat_o <=  32'h18c00000;
21 : wb_dat_o <=  32'h18e00001;
22 : wb_dat_o <=  32'ha8e7ffff;
23 : wb_dat_o <=  32'h15000000;
24 : wb_dat_o <=  32'h8c640002;
25 : wb_dat_o <=  32'he1013000;
26 : wb_dat_o <=  32'hd8081800;
27 : wb_dat_o <=  32'h9cc60001;
28 : wb_dat_o <=  32'hbc060101;
29 : wb_dat_o <=  32'h10000011;
30 : wb_dat_o <=  32'hbc060104;
31 : wb_dat_o <=  32'h10000008;
32 : wb_dat_o <=  32'he4063800;
33 : wb_dat_o <=  32'h0ffffff6;
34 : wb_dat_o <=  32'h15000000;
35 : wb_dat_o <=  32'hc0000811;
36 : wb_dat_o <=  32'ha8210100;
37 : wb_dat_o <=  32'h44000800;
38 : wb_dat_o <=  32'hd8040004;
39 : wb_dat_o <=  32'h84610100;
40 : wb_dat_o <=  32'hb9430050;
41 : wb_dat_o <=  32'hbc0a1800;
42 : wb_dat_o <=  32'h0c000009;
43 : wb_dat_o <=  32'h15000000;
44 : wb_dat_o <=  32'h03ffffeb;
45 : wb_dat_o <=  32'h15000000;
46 : wb_dat_o <=  32'hbc030018;
47 : wb_dat_o <=  32'h0c00000e;
48 : wb_dat_o <=  32'h15000000;
49 : wb_dat_o <=  32'h03ffffe6;
50 : wb_dat_o <=  32'h15000000;
51 : wb_dat_o <=  32'h15000000;
52 : wb_dat_o <=  32'ha86000ff;
53 : wb_dat_o <=  32'h9d0b0001;
54 : wb_dat_o <=  32'hd8081800;
55 : wb_dat_o <=  32'ha86d0005;
56 : wb_dat_o <=  32'h9d0b0000;
57 : wb_dat_o <=  32'hd8081800;
58 : wb_dat_o <=  32'h0400000d;
59 : wb_dat_o <=  32'h15000000;
60 : wb_dat_o <=  32'h0000008e;
61 : wb_dat_o <=  32'h15000000;
62 : wb_dat_o <=  32'ha86000ff;
63 : wb_dat_o <=  32'h9d0b0001;
64 : wb_dat_o <=  32'hd8081800;
65 : wb_dat_o <=  32'ha86d0003;
66 : wb_dat_o <=  32'h9d0b0000;
67 : wb_dat_o <=  32'hd8081800;
68 : wb_dat_o <=  32'h04000003;
69 : wb_dat_o <=  32'h15000000;
70 : wb_dat_o <=  32'h000000c6;
71 : wb_dat_o <=  32'he1804804;
72 : wb_dat_o <=  32'ha86000c7;
73 : wb_dat_o <=  32'h9d050002;
74 : wb_dat_o <=  32'hd8081800;
75 : wb_dat_o <=  32'ha8600000;
76 : wb_dat_o <=  32'h9d050001;
77 : wb_dat_o <=  32'hd8081800;
78 : wb_dat_o <=  32'ha8600083;
79 : wb_dat_o <=  32'h9d050003;
80 : wb_dat_o <=  32'hd8081800;
81 : wb_dat_o <=  32'ha8600036;
82 : wb_dat_o <=  32'h9d050000;
83 : wb_dat_o <=  32'hd8081800;
84 : wb_dat_o <=  32'ha8600000;
85 : wb_dat_o <=  32'h9d050001;
86 : wb_dat_o <=  32'hd8081800;
87 : wb_dat_o <=  32'ha8600003;
88 : wb_dat_o <=  32'h9d050003;
89 : wb_dat_o <=  32'hd8081800;
90 : wb_dat_o <=  32'h040000ea;
91 : wb_dat_o <=  32'h15000000;
92 : wb_dat_o <=  32'ha8600043;
93 : wb_dat_o <=  32'h9d050000;
94 : wb_dat_o <=  32'hd8081800;
95 : wb_dat_o <=  32'h040000e5;
96 : wb_dat_o <=  32'h15000000;
97 : wb_dat_o <=  32'ha860004f;
98 : wb_dat_o <=  32'h9d050000;
99 : wb_dat_o <=  32'hd8081800;
100 : wb_dat_o <=  32'h040000e0;
101 : wb_dat_o <=  32'h15000000;
102 : wb_dat_o <=  32'ha860004d;
103 : wb_dat_o <=  32'h9d050000;
104 : wb_dat_o <=  32'hd8081800;
105 : wb_dat_o <=  32'h040000db;
106 : wb_dat_o <=  32'h15000000;
107 : wb_dat_o <=  32'ha860004d;
108 : wb_dat_o <=  32'h9d050000;
109 : wb_dat_o <=  32'hd8081800;
110 : wb_dat_o <=  32'h040000d6;
111 : wb_dat_o <=  32'h15000000;
112 : wb_dat_o <=  32'ha8600055;
113 : wb_dat_o <=  32'h9d050000;
114 : wb_dat_o <=  32'hd8081800;
115 : wb_dat_o <=  32'h040000d1;
116 : wb_dat_o <=  32'h15000000;
117 : wb_dat_o <=  32'ha860004e;
118 : wb_dat_o <=  32'h9d050000;
119 : wb_dat_o <=  32'hd8081800;
120 : wb_dat_o <=  32'h040000cc;
121 : wb_dat_o <=  32'h15000000;
122 : wb_dat_o <=  32'ha8600049;
123 : wb_dat_o <=  32'h9d050000;
124 : wb_dat_o <=  32'hd8081800;
125 : wb_dat_o <=  32'h040000c7;
126 : wb_dat_o <=  32'h15000000;
127 : wb_dat_o <=  32'ha8600043;
128 : wb_dat_o <=  32'h9d050000;
129 : wb_dat_o <=  32'hd8081800;
130 : wb_dat_o <=  32'h040000c2;
131 : wb_dat_o <=  32'h15000000;
132 : wb_dat_o <=  32'ha8600041;
133 : wb_dat_o <=  32'h9d050000;
134 : wb_dat_o <=  32'hd8081800;
135 : wb_dat_o <=  32'h040000bd;
136 : wb_dat_o <=  32'h15000000;
137 : wb_dat_o <=  32'ha8600054;
138 : wb_dat_o <=  32'h9d050000;
139 : wb_dat_o <=  32'hd8081800;
140 : wb_dat_o <=  32'h040000b8;
141 : wb_dat_o <=  32'h15000000;
142 : wb_dat_o <=  32'ha8600049;
143 : wb_dat_o <=  32'h9d050000;
144 : wb_dat_o <=  32'hd8081800;
145 : wb_dat_o <=  32'h040000b3;
146 : wb_dat_o <=  32'h15000000;
147 : wb_dat_o <=  32'ha860004f;
148 : wb_dat_o <=  32'h9d050000;
149 : wb_dat_o <=  32'hd8081800;
150 : wb_dat_o <=  32'h040000ae;
151 : wb_dat_o <=  32'h15000000;
152 : wb_dat_o <=  32'ha860004e;
153 : wb_dat_o <=  32'h9d050000;
154 : wb_dat_o <=  32'hd8081800;
155 : wb_dat_o <=  32'h040000a9;
156 : wb_dat_o <=  32'h15000000;
157 : wb_dat_o <=  32'ha8600020;
158 : wb_dat_o <=  32'h9d050000;
159 : wb_dat_o <=  32'hd8081800;
160 : wb_dat_o <=  32'h040000a4;
161 : wb_dat_o <=  32'h15000000;
162 : wb_dat_o <=  32'ha8600050;
163 : wb_dat_o <=  32'h9d050000;
164 : wb_dat_o <=  32'hd8081800;
165 : wb_dat_o <=  32'h0400009f;
166 : wb_dat_o <=  32'h15000000;
167 : wb_dat_o <=  32'ha8600052;
168 : wb_dat_o <=  32'h9d050000;
169 : wb_dat_o <=  32'hd8081800;
170 : wb_dat_o <=  32'h0400009a;
171 : wb_dat_o <=  32'h15000000;
172 : wb_dat_o <=  32'ha860004f;
173 : wb_dat_o <=  32'h9d050000;
174 : wb_dat_o <=  32'hd8081800;
175 : wb_dat_o <=  32'h04000095;
176 : wb_dat_o <=  32'h15000000;
177 : wb_dat_o <=  32'ha8600042;
178 : wb_dat_o <=  32'h9d050000;
179 : wb_dat_o <=  32'hd8081800;
180 : wb_dat_o <=  32'h04000090;
181 : wb_dat_o <=  32'h15000000;
182 : wb_dat_o <=  32'ha860004c;
183 : wb_dat_o <=  32'h9d050000;
184 : wb_dat_o <=  32'hd8081800;
185 : wb_dat_o <=  32'h0400008b;
186 : wb_dat_o <=  32'h15000000;
187 : wb_dat_o <=  32'ha8600045;
188 : wb_dat_o <=  32'h9d050000;
189 : wb_dat_o <=  32'hd8081800;
190 : wb_dat_o <=  32'h04000086;
191 : wb_dat_o <=  32'h15000000;
192 : wb_dat_o <=  32'ha860004d;
193 : wb_dat_o <=  32'h9d050000;
194 : wb_dat_o <=  32'hd8081800;
195 : wb_dat_o <=  32'h04000081;
196 : wb_dat_o <=  32'h15000000;
197 : wb_dat_o <=  32'ha8600020;
198 : wb_dat_o <=  32'h9d050000;
199 : wb_dat_o <=  32'hd8081800;
200 : wb_dat_o <=  32'h44006000;
201 : wb_dat_o <=  32'h15000000;
202 : wb_dat_o <=  32'h0400007a;
203 : wb_dat_o <=  32'h15000000;
204 : wb_dat_o <=  32'ha8600057;
205 : wb_dat_o <=  32'h9d050000;
206 : wb_dat_o <=  32'hd8081800;
207 : wb_dat_o <=  32'h04000075;
208 : wb_dat_o <=  32'h15000000;
209 : wb_dat_o <=  32'ha8600052;
210 : wb_dat_o <=  32'h9d050000;
211 : wb_dat_o <=  32'hd8081800;
212 : wb_dat_o <=  32'h04000070;
213 : wb_dat_o <=  32'h15000000;
214 : wb_dat_o <=  32'ha8600049;
215 : wb_dat_o <=  32'h9d050000;
216 : wb_dat_o <=  32'hd8081800;
217 : wb_dat_o <=  32'h0400006b;
218 : wb_dat_o <=  32'h15000000;
219 : wb_dat_o <=  32'ha8600054;
220 : wb_dat_o <=  32'h9d050000;
221 : wb_dat_o <=  32'hd8081800;
222 : wb_dat_o <=  32'h04000066;
223 : wb_dat_o <=  32'h15000000;
224 : wb_dat_o <=  32'ha8600045;
225 : wb_dat_o <=  32'h9d050000;
226 : wb_dat_o <=  32'hd8081800;
227 : wb_dat_o <=  32'h04000061;
228 : wb_dat_o <=  32'h15000000;
229 : wb_dat_o <=  32'ha8600020;
230 : wb_dat_o <=  32'h9d050000;
231 : wb_dat_o <=  32'hd8081800;
232 : wb_dat_o <=  32'h0400005c;
233 : wb_dat_o <=  32'h15000000;
234 : wb_dat_o <=  32'ha860004d;
235 : wb_dat_o <=  32'h9d050000;
236 : wb_dat_o <=  32'hd8081800;
237 : wb_dat_o <=  32'h04000057;
238 : wb_dat_o <=  32'h15000000;
239 : wb_dat_o <=  32'ha8600045;
240 : wb_dat_o <=  32'h9d050000;
241 : wb_dat_o <=  32'hd8081800;
242 : wb_dat_o <=  32'h04000052;
243 : wb_dat_o <=  32'h15000000;
244 : wb_dat_o <=  32'ha860004d;
245 : wb_dat_o <=  32'h9d050000;
246 : wb_dat_o <=  32'hd8081800;
247 : wb_dat_o <=  32'h0400004d;
248 : wb_dat_o <=  32'h15000000;
249 : wb_dat_o <=  32'ha860004f;
250 : wb_dat_o <=  32'h9d050000;
251 : wb_dat_o <=  32'hd8081800;
252 : wb_dat_o <=  32'h04000048;
253 : wb_dat_o <=  32'h15000000;
254 : wb_dat_o <=  32'ha8600052;
255 : wb_dat_o <=  32'h9d050000;
256 : wb_dat_o <=  32'hd8081800;
257 : wb_dat_o <=  32'h04000043;
258 : wb_dat_o <=  32'h15000000;
259 : wb_dat_o <=  32'ha8600059;
260 : wb_dat_o <=  32'h9d050000;
261 : wb_dat_o <=  32'hd8081800;
262 : wb_dat_o <=  32'h0400003e;
263 : wb_dat_o <=  32'h15000000;
264 : wb_dat_o <=  32'ha860000a;
265 : wb_dat_o <=  32'h9d050000;
266 : wb_dat_o <=  32'hd8081800;
267 : wb_dat_o <=  32'h03ffff18;
268 : wb_dat_o <=  32'h04000038;
269 : wb_dat_o <=  32'h15000000;
270 : wb_dat_o <=  32'ha8600052;
271 : wb_dat_o <=  32'h9d050000;
272 : wb_dat_o <=  32'hd8081800;
273 : wb_dat_o <=  32'h04000033;
274 : wb_dat_o <=  32'h15000000;
275 : wb_dat_o <=  32'ha8600045;
276 : wb_dat_o <=  32'h9d050000;
277 : wb_dat_o <=  32'hd8081800;
278 : wb_dat_o <=  32'h0400002e;
279 : wb_dat_o <=  32'h15000000;
280 : wb_dat_o <=  32'ha8600041;
281 : wb_dat_o <=  32'h9d050000;
282 : wb_dat_o <=  32'hd8081800;
283 : wb_dat_o <=  32'h04000029;
284 : wb_dat_o <=  32'h15000000;
285 : wb_dat_o <=  32'ha8600044;
286 : wb_dat_o <=  32'h9d050000;
287 : wb_dat_o <=  32'hd8081800;
288 : wb_dat_o <=  32'h04000024;
289 : wb_dat_o <=  32'h15000000;
290 : wb_dat_o <=  32'ha8600020;
291 : wb_dat_o <=  32'h9d050000;
292 : wb_dat_o <=  32'hd8081800;
293 : wb_dat_o <=  32'h0400001f;
294 : wb_dat_o <=  32'h15000000;
295 : wb_dat_o <=  32'ha8600046;
296 : wb_dat_o <=  32'h9d050000;
297 : wb_dat_o <=  32'hd8081800;
298 : wb_dat_o <=  32'h0400001a;
299 : wb_dat_o <=  32'h15000000;
300 : wb_dat_o <=  32'ha860004c;
301 : wb_dat_o <=  32'h9d050000;
302 : wb_dat_o <=  32'hd8081800;
303 : wb_dat_o <=  32'h04000015;
304 : wb_dat_o <=  32'h15000000;
305 : wb_dat_o <=  32'ha8600041;
306 : wb_dat_o <=  32'h9d050000;
307 : wb_dat_o <=  32'hd8081800;
308 : wb_dat_o <=  32'h04000010;
309 : wb_dat_o <=  32'h15000000;
310 : wb_dat_o <=  32'ha8600053;
311 : wb_dat_o <=  32'h9d050000;
312 : wb_dat_o <=  32'hd8081800;
313 : wb_dat_o <=  32'h0400000b;
314 : wb_dat_o <=  32'h15000000;
315 : wb_dat_o <=  32'ha8600048;
316 : wb_dat_o <=  32'h9d050000;
317 : wb_dat_o <=  32'hd8081800;
318 : wb_dat_o <=  32'h04000006;
319 : wb_dat_o <=  32'h15000000;
320 : wb_dat_o <=  32'ha860000a;
321 : wb_dat_o <=  32'h9d050000;
322 : wb_dat_o <=  32'hd8081800;
323 : wb_dat_o <=  32'h03fffee0;
324 : wb_dat_o <=  32'ha8800060;
325 : wb_dat_o <=  32'h9d050005;
326 : wb_dat_o <=  32'h8c680000;
327 : wb_dat_o <=  32'he4032000;
328 : wb_dat_o <=  32'h0ffffffd;
329 : wb_dat_o <=  32'h15000000;
330 : wb_dat_o <=  32'h44004800;
331 : wb_dat_o <=  32'h15000000;
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
