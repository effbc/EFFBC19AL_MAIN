pageextension 70294 RoutingListExt extends "Routing List"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("xRec.COUNTAPPROX"; xRec.COUNTAPPROX)
            {
                ApplicationArea = All;

            }



            field("Bom Status Running"; "Bom Status Running")
            {
                Style = Favorable;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Bom Status old"; "Bom Status old")
            {
                Style = Unfavorable;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }



    }


    trigger OnAfterGetRecord()
    begin
        Running_bom_flag := FALSE;
        old_bom_flag := FALSE;
        pbh.RESET;
        pbh.SETFILTER("No.", Rec."No.");
        IF pbh.FINDSET THEN
            REPEAT
            BEGIN
                IF pbh."BOM Running Status" = pbh."BOM Running Status"::Running THEN
                    Running_bom_flag := TRUE
                ELSE
                    IF pbh."BOM Running Status" = pbh."BOM Running Status"::Old THEN
                        old_bom_flag := TRUE
                    ELSE BEGIN
                        Running_bom_flag := FALSE;
                        old_bom_flag := FALSE
                    END
            END;
            UNTIL pbh.NEXT = 0;
    end;

    var
        "Bom Status Running": Label 'Running Bom';
        "Bom Status old": Label 'Old Bom';
        Running_bom_flag: Boolean;
        old_bom_flag: Boolean;
        BOM_No_Clr: Boolean;
        pbh: Record "Production BOM Header";
}