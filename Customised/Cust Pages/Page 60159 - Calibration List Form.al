page 60159 "Calibration List Form"
{
    // version Cal1.0

    CardPageID = Calibration;
    Editable = false;
    PageType = List;
    SourceTable = Calibration;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Equipment No"; Rec."Equipment No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
                field("Lot No"; Rec."MFG. Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Manufacturer)
                {
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; Rec."Eqpt. Serial No.")
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
                field("Posting Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Next Calibration Due On"; Rec."Next Calibration Due On")
                {
                    ApplicationArea = All;
                }
                field("Unit cost(LCY)"; Rec."Unit cost(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                }
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Delay Days"; Rec."Delay Days")
                {
                    ApplicationArea = All;
                }
                field("Reason for Delay"; Rec."Reason for Delay")
                {
                    ApplicationArea = All;
                }
                field("Master Item"; Rec."Master Item")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Owner of the Equpmnt"; Rec."Owner of the Equpmnt")
                {
                    ApplicationArea = All;
                }
                field("Owner of the Equpmnt_Dept"; Rec."Owner of the Equpmnt_Dept")
                {
                    ApplicationArea = All;
                }
                field("Owner of the Equipment name"; Rec."Owner of the Equpmnt_empid")
                {
                    ApplicationArea = All;
                }
                field("Life time in Yrs"; Rec."Life time in Yrs")
                {
                    ApplicationArea = All;
                }
                field(Transfered_from; Rec.Transfered_from)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Calibration Party"; Rec."Calibration Party")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

