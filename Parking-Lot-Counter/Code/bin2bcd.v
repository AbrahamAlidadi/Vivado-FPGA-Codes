`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2021 07:24:34 PM
// Design Name: 
// Module Name: bin2bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bin2bcd(
    input[7:0]bin,
    output[11:0]bcd

    );
    
    wire ad1_to_ad6_s3,ad1_to_ad2_s2,ad1_to_ad2_s1,ad1_to_ad2_s0,
         ad2_to_ad6_s3,ad2_to_ad3_s2,ad2_to_ad3_s1,ad2_to_ad3_s0,
         ad3_to_ad6_s3,ad3_to_ad4_s2,ad3_to_ad4_s1,ad3_to_ad4_s0,
         ad4_to_ad7_s3,ad4_to_ad5_s2,ad4_to_ad5_s1,ad4_to_ad5_s0,
         ad6_to_ad7_s2,ad6_to_ad7_s1,ad6_to_ad7_s0;
    
    assign bcd[11] = 0;
    assign bcd[10] = 0;
    
    add_3 add1(
        .A({1'b0,bin[7],bin[6],bin[5]}),
        .S({ad1_to_ad6_s3,ad1_to_ad2_s2,ad1_to_ad2_s1,ad1_to_ad2_s0})
        );
        
    add_3 add2(
        .A({ad1_to_ad2_s2,ad1_to_ad2_s1,ad1_to_ad2_s0,bin[4]}),
        .S({ad2_to_ad6_s3,ad2_to_ad3_s2,ad2_to_ad3_s1,ad2_to_ad3_s0})
        );
        
    add_3 add3(
        .A({ad2_to_ad3_s2,ad2_to_ad3_s1,ad2_to_ad3_s0,bin[3]}),
        .S({ad3_to_ad6_s3,ad3_to_ad4_s2,ad3_to_ad4_s1,ad3_to_ad4_s0})
        );
        
    add_3 add4(
        .A({ad3_to_ad4_s2,ad3_to_ad4_s1,ad3_to_ad4_s0,bin[2]}),
        .S({ad4_to_ad7_s3,ad4_to_ad5_s2,ad4_to_ad5_s1,ad4_to_ad5_s0})
        );
        
    add_3 add5(
        .A({ad4_to_ad5_s2,ad4_to_ad5_s1,ad4_to_ad5_s0,bin[1]}),
        .S({bcd[4],bcd[3],bcd[2],bcd[1]})
        );
        
    add_3 add6(
        .A({1'b0,ad1_to_ad6_s3,ad2_to_ad6_s3,ad3_to_ad6_s3}),
        .S({bcd[9],ad6_to_ad7_s2,ad6_to_ad7_s1,ad6_to_ad7_s0})
        );
        
    add_3 add7(
        .A({ad6_to_ad7_s2,ad6_to_ad7_s1,ad6_to_ad7_s0,ad4_to_ad7_s3}),
        .S({bcd[8],bcd[7],bcd[6],bcd[5]})
        );
        
    assign bcd[0] = bin[0];        
    assign bcd[11] = 1'b0;
    assign bcd[10] = 1'b0;
    
    
    
    
    
    
    
    
    
    
endmodule
