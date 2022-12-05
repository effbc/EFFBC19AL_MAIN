codeunit 90013 TaxArea
{

    trigger OnRun();
    begin
        /*
        Loc.FINDFIRST;
        REPEAT
            TaxareaLoc.Type := TaxareaLoc.Type::Customer;
            State.FINDFIRST;
            REPEAT
                TaxareaLoc."Dispatch / Receiving Location" := Loc.Code;
                TaxareaLoc."Customer / Vendor Location" := State.Code;
                TaxareaLoc."Tax Area Code" := 'SALES CST';
                TaxareaLoc.INSERT;
            UNTIL State.NEXT = 0;
        UNTIL Loc.NEXT = 0;
        */
    end;

    var
        //TaxareaLoc: Record "Tax Area Locations";
        Loc: Record Location;
        State: Record State;
        Taxarea: Record "Tax Area";
}

