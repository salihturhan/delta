module priority_arbiter_4bit (
  input  [3:0] requests,  // 4-bit talep girişi
  input clk,             // Clock sinyali
  output  [3:0] out      // 4-bit izin sinyali çıkışı
);
  reg [3:0] grant=0;      // 4-bit izin sinyali, varsayılan olarak sıfır olarak başlatılıyor.

  always @(posedge clk) begin
    case (requests)
      4'b0001: grant = 4'b0001;  // Talep 0 için öncelik: İzin 0001 olarak ayarlanıyor.
      4'b0010: grant = 4'b0010;  // Talep 1 için öncelik: İzin 0010 olarak ayarlanıyor.
      4'b0100: grant = 4'b0100;  // Talep 2 için öncelik: İzin 0100 olarak ayarlanıyor.
      4'b1000: grant = 4'b1000;  // Talep 3 için öncelik: İzin 1000 olarak ayarlanıyor.
      default:   grant = 4'b0000;  // Varsayılan: Hiçbir talep kabul edilmediğinde izin sıfırlanıyor.
    endcase
  end

  assign out=grant;  // İzin sinyali çıkışa atanıyor.
endmodule

