pageextension 70302 ProductionBOMListExt extends "Production BOM List"
{
    layout
    {
        addafter(Control1)
        {
            grid(control123)   //22-08-2022

            {
                GridLayout = Rows;
                ShowCaption = false;
                group(Control1102152006)
                {
                    ShowCaption = false;
                }
                group(Control1102152011)
                {
                    ShowCaption = false;
                    field("xRec.COUNT"; xRec.COUNT)
                    {

                        Caption = 'BOMs Count';
                        ApplicationArea = All;

                    }
                }
                group(Control1102152013)
                {
                    ShowCaption = false;
                    field(Bom_Status_running; Bom_Status_running)
                    {
                        Style = Favorable;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                }
                group(Control1102152015)
                {
                    ShowCaption = false;
                    field(Bom_Status_old; Bom_Status_old)
                    {
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                }
            }
        }
        addafter(Description)
        {
            field("Low-Level Code"; Rec."Low-Level Code")
            {
                ApplicationArea = All;

            }
            field("Modified User ID"; Rec."Modified User ID")
            {
                ApplicationArea = All;

            }
            field("Bench Mark Time(In Hours)"; Rec."Bench Mark Time(In Hours)")
            {
                ApplicationArea = All;

            }
            field("Stranded BOM"; Rec."Stranded BOM")
            {
                ApplicationArea = All;

            }

            field("BOM Type"; Rec."BOM Type")
            {
                ApplicationArea = All;

            }

            field("Total No. of Fixing Holes"; Rec."Total No. of Fixing Holes")
            {
                ApplicationArea = All;

            }
            field("Total Soldering Points"; Rec."Total Soldering Points")
            {
                ApplicationArea = All;

            }
            field("Total Soldering Points DIP"; Rec."Total Soldering Points DIP")
            {
                ApplicationArea = All;

            }
            field("Total Soldering Points SMD"; Rec."Total Soldering Points SMD")
            {
                ApplicationArea = All;

            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;

            }
        }
        modify(Status)
        {
            trigger OnBeforeValidate()
            begin
                IF (COPYSTR(ProdBOMHeader."No.", 1, 8) <> 'ECMPBPCB') AND (Rec.Status = Rec.Status::Certified) AND NOT (USERID IN ['EFFTRONICS\JHANSI', 'EFFTRONICS\SUJANI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                    ERROR('You dont have permissions to Certify the BOM');
            end;
        }
        addafter("Search Name")
        {
            field(Configuration; Rec.Configuration)
            {
                ApplicationArea = All;

            }
            field("BOM Running Status"; Rec."BOM Running Status")
            {
                ApplicationArea = All;

            }
            field("Inherited From"; Rec."Inherited From")
            {
                ApplicationArea = All;

            }
            field("BOM Category"; Rec."BOM Category")
            {
                ApplicationArea = All;

            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    begin
        Running_bom_flag := FALSE;
        old_bom_flag := FALSE;
        IF Rec."BOM Running Status" = Rec."BOM Running Status"::Running THEN BEGIN
            BOM_No_Clr := TRUE;
            Running_bom_flag := TRUE;
        END
        ELSE
            IF Rec."BOM Running Status" = Rec."BOM Running Status"::Old THEN BEGIN
                BOM_No_Clr := TRUE;
                old_bom_flag := TRUE;
            END
            ELSE BEGIN
                BOM_No_Clr := FALSE;
                Running_bom_flag := FALSE;
                old_bom_flag := FALSE;
            END;
    end;

    var
        ProdBOMHeader: Record "Production BOM Header";
        Bom_Status_running: Label 'Running BOM';
        Bom_Status_old: Label 'Old BOM';
        Running_bom_flag: Boolean;
        old_bom_flag: Boolean;
        BOM_No_Clr: Boolean;
}