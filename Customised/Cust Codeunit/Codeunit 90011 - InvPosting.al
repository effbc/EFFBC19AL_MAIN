codeunit 90011 InvPosting
{

    trigger OnRun();
    begin
        Loc.FINDFIRST;
        REPEAT
            InvPostingSetup.INIT;
            InvPostingSetup."Location Code" := Loc.Code;
            InvPostingSetup."Invt. Posting Group Code" := 'BOI';
            InvPostingSetup."Inventory Account" := '21100';
            InvPostingSetup."WIP Account" := '21500';
            InvPostingSetup.INSERT;
            InvPostingSetup.INIT;
            InvPostingSetup."Location Code" := Loc.Code;
            InvPostingSetup."Invt. Posting Group Code" := 'COMP-UNITS';
            InvPostingSetup."Inventory Account" := '21401';
            InvPostingSetup."WIP Account" := '21500';
            InvPostingSetup.INSERT;
            InvPostingSetup.INIT;
            InvPostingSetup."Location Code" := Loc.Code;
            InvPostingSetup."Invt. Posting Group Code" := 'EDB-FINISH';
            InvPostingSetup."Inventory Account" := '21300';
            InvPostingSetup."WIP Account" := '21500';
            InvPostingSetup.INSERT;
            InvPostingSetup.INIT;
            InvPostingSetup."Location Code" := Loc.Code;
            InvPostingSetup."Invt. Posting Group Code" := 'MPBI-FINIS';
            InvPostingSetup."Inventory Account" := '21200';
            InvPostingSetup."WIP Account" := '21500';
            InvPostingSetup.INSERT;
            InvPostingSetup.INIT;
            InvPostingSetup."Location Code" := Loc.Code;
            InvPostingSetup."Invt. Posting Group Code" := 'RAW- MAT';
            InvPostingSetup."Inventory Account" := '20900';
            InvPostingSetup."WIP Account" := '21500';
            InvPostingSetup.INSERT;
        UNTIL Loc.NEXT = 0;
    end;

    var
        Loc: Record Location;
        InvPostingSetup: Record "Inventory Posting Setup";
        i: Integer;
}

