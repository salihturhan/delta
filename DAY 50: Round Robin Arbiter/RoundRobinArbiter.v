module roundrobin_arbiter(
    input clk, rst_n,           // Clock ve reset sinyalleri
    input [3:0] REQ,           // Talep sinyali girişi
    output reg [3:0] GNT       // İzin sinyali çıkışı
);
    reg [2:0] pr_state;         // Önceki durum (priority state)
    reg [2:0] nxt_state;        // Sonraki durum (next state)

    parameter [2:0] Sideal = 3'b000; // İdeal durum parametresi
    parameter [2:0] S0 = 3'b001;    // Durum 0 parametresi
    parameter [2:0] S1 = 3'b010;    // Durum 1 parametresi
    parameter [2:0] S2 = 3'b011;    // Durum 2 parametresi
    parameter [2:0] S3 = 3'b100;    // Durum 3 parametresi

    // Önceki durumun sıfırlanması veya sonraki duruma geçiş
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pr_state <= Sideal; // Başlangıç durumu sıfırlanıyor.
        end else begin
            pr_state <= nxt_state; // Sonraki duruma geçiş yapılıyor.
        end
    end

    // Sonraki durumu belirleyen kombinatorik mantık
    always @(*) begin
        case (pr_state)
            S0: begin
                if (REQ[0])
                    nxt_state = S1; // Talep 0 için S1'e geçiş
                else if (REQ[1])
                    nxt_state = S2; // Talep 1 için S2'ye geçiş
                else if (REQ[2])
                    nxt_state = S3; // Talep 2 için S3'e geçiş
                else
                    nxt_state = Sideal; // Hiçbir talep yok, ideal duruma geri dönülüyor.
            end
            S1: begin
                if (REQ[1])
                    nxt_state = S2; // Talep 1 için S2'ye geçiş
                else if (REQ[2])
                    nxt_state = S3; // Talep 2 için S3'e geçiş
                else if (REQ[0])
                    nxt_state = S0; // Talep 0 için S0'a geçiş
                else
                    nxt_state = Sideal;
            end
            S2: begin
                if (REQ[2])
                    nxt_state = S3; // Talep 2 için S3'e geçiş
                else if (REQ[0])
                    nxt_state = S0; // Talep 0 için S0'a geçiş
                else if (REQ[1])
                    nxt_state = S1; // Talep 1 için S1'e geçiş
                else
                    nxt_state = Sideal;
            end
            S3: begin
                if (REQ[0])
                    nxt_state = S0; // Talep 0 için S0'a geçiş
                else if (REQ[1])
                    nxt_state = S1; // Talep 1 için S1'e geçiş
                else if (REQ[2])
                    nxt_state = S2; // Talep 2 için S2'ye geçiş
                else
                    nxt_state = Sideal;
            end
            default: begin
                if (REQ[0])
                    nxt_state = S0; // Talep 0 için S0'a geçiş
                else if (REQ[1])
                    nxt_state = S1; // Talep 1 için S1'e geçiş
                else if (REQ[2])
                    nxt_state = S2; // Talep 2 için S2'ye geçiş
                else if (REQ[3])
                    nxt_state = S3; // Talep 3 için S3'e geçiş
                else
                    nxt_state = Sideal;
            end
        endcase
    end

    // İzin sinyalinin belirlenmesi
    always @(posedge clk) begin
        GNT <= (pr_state == S0) ? 4'b0001 :   // Durum S0 ise izin sinyali 0001
               (pr_state == S1) ? 4'b0010 :   // Durum S1 ise izin sinyali 0010
               (pr_state == S2) ? 4'b0100 :   // Durum S2 ise izin sinyali 0100
               (pr_state == S3) ? 4'b1000 :   // Durum S3 ise izin sinyali 1000
               4'b0000; // Diğer durumlarda izin sinyali sıfır
    end

endmodule

