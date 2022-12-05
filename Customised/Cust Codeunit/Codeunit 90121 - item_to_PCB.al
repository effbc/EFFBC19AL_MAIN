codeunit 90121 item_to_PCB
{

    trigger OnRun();
    begin
        item.RESET;
        item.SETFILTER(item."Product Group Code Cust", 'PCB|CPCB|MPCB');
        IF item.FINDFIRST THEN
            REPEAT
                pcb.INIT;
                pcb."PCB No." := item."No.";
                pcb.Description := item.Description;
                pcb."PCB Thickness" := item."PCB thickness";
                pcb."Copper Clad Thinkness" := item."Copper Clad Thickness";
                pcb."PCB Area" := item."PCB Area";
                pcb.Length := item.Length;
                pcb.Width := item.Width;
                pcb."PCB Shape" := item."PCB Shape";
                pcb."On C-side" := item."On C-Side";
                pcb."On D-side" := item."On D-Side";
                pcb."On S-side" := item."On S-Side";
                pcb.INSERT;
            UNTIL item.NEXT = 0;
    end;

    var
        item: Record Item;
        pcb: Record PCB;
}

