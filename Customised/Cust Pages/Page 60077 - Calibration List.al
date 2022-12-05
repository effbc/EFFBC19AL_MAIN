page 60077 "Calibration List"
{
    // version B2B1.0

    CardPageID = "Calibration Card";
    Editable = false;
    PageType = List;
    SourceTable = "Calibration Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                }
                field("Calibration Next Due Date"; Rec."Calibration Next Due Date")
                {
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Current Status"; Rec."Current Status")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Inspection Party"; Rec."Inspection Party")
                {
                    ApplicationArea = All;
                }
                field(Agency; Rec.Agency)
                {
                    ApplicationArea = All;
                }
                field("Purpose of Instrument"; Rec."Purpose of Instrument")
                {
                    ApplicationArea = All;
                }
                field("Usage Type"; Rec."Usage Type")
                {
                    ApplicationArea = All;
                }
                field("Least Count"; Rec."Least Count")
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
            }

        }

    }

    actions
    {
        area(Processing)
        {

        }

    }
}

