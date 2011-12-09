//ceil of the log base 2
function integer clog2;
    input [31:0] depth;
    integer i;
    begin
        i = depth;      
        for(clog2 = 0; i > 0; clog2 = clog2 + 1)
            i = i >> 1;
    end
endfunction
