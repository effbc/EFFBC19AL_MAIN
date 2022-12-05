page 60306 "Posted calibration data"
{
    Editable = false;
    PageType = List;
    SourceTable = "Calibration Ledger Entries";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    Style = StrongAccent;
                    StyleExpr = atch_entrno_clr_flg;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        Attachments.RESET;
                        Attachments.SETRANGE("Table ID", 33000929);
                        Attachments.SETRANGE("Document No.", Rec."Entry No");
                        IF Attachments.FINDSET THEN BEGIN
                            IF (Attachments."Attachment Status" = FALSE) THEN
                                MESSAGE('No attachment')
                            ELSE BEGIN
                                PAGE.RUN(PAGE::"ESPL Attachments", Attachments)
                            END;
                        END;
                    end;
                }
                field("Equipment No"; Rec."Equipment No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; Rec."Eqpt. Serial No.")
                {
                    ApplicationArea = All;
                }
                field("IR No"; Rec."IR No")
                {
                    ApplicationArea = All;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field("Item Desc"; Rec."Item Desc")
                {
                    ApplicationArea = All;
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                }
                field("Last Calibration Date"; Rec."Last Calibration Date")
                {
                    ApplicationArea = All;
                }
                field("Calibration Period"; Rec."Calibration Period")
                {
                    ApplicationArea = All;
                }
                field("Next Calibration Due On"; Rec."Next Calibration Due On")
                {
                    ApplicationArea = All;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = All;
                }
                field("MFG. Serial No."; Rec."MFG. Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ApplicationArea = All;
                }
                field("Calibration Party"; Rec."Calibration Party")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field(Transfered_from; Rec.Transfered_from)
                {
                    ApplicationArea = All;
                }
                field("Unit cost(LCY)"; Rec."Unit cost(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Owner of the Equpmnt"; Rec."Owner of the Equpmnt")
                {
                    ApplicationArea = All;
                }
                field("Owner of the Equpmnt_empid"; Rec."Owner of the Equpmnt_empid")
                {
                    ApplicationArea = All;
                }
                field("Owner of the Equpmnt_Dept"; Rec."Owner of the Equpmnt_Dept")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }
                field("Reason for Delay"; Rec."Reason for Delay")
                {
                    ApplicationArea = All;
                }
                field("Delay Days"; Rec."Delay Days")
                {
                    ApplicationArea = All;
                }
                field("Previously Calibrated Times"; Rec."Previously Calibrated Times")
                {
                    ApplicationArea = All;
                }
                field("No of times calibrated"; Rec."Least Count")
                {
                    ApplicationArea = All;
                }
                field("Life time in Yrs"; Rec."Life time in Yrs")
                {
                    ApplicationArea = All;
                }
                field("Master Item"; Rec."Master Item")
                {
                    ApplicationArea = All;
                }
                field("Not an ERP Integrated"; Rec."Not an ERP Integrated")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Attachments)
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Attachments.RESET;
        Attachments.SETRANGE("Table ID", 33000929);
        Attachments.SETRANGE("Document No.", Rec."Entry No");
        IF Attachments.FINDSET THEN BEGIN
            IF (Attachments."Attachment Status" = FALSE) THEN
                atch_entrno_clr_flg := FALSE
            ELSE
                atch_entrno_clr_flg := TRUE;
        END
        ELSE
            atch_entrno_clr_flg := FALSE;
    end;

    trigger OnOpenPage();
    begin
        atch_entrno_clr_flg := FALSE;
    end;

    var
        Attachments: Record Attachments;
        atch_entrno_clr_flg: Boolean;
}

