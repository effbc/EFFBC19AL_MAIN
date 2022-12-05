page 60316 "Mat.Iss. Entry Summary Delete"
{
    // version MI1.0


    PageType = List;
    SourceTable = "Mat.Issue Entry Summary";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = All;
                }
                field("Total Reserved Quantity"; Rec."Total Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Total Available Quantity"; Rec."Total Available Quantity")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(USERID; Rec.USERID)
                {
                    ApplicationArea = All;
                }
                field(SalorderNo; SalorderNo)
                {
                    Caption = 'Sales order No';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    trigger OnOpenPage()
    var
        MIEntrySummary: REcord "Mat.Issue Entry Summary";
    begin

        MIEntrySummary.RESET;
        IF MIEntrySummary.FINDFIRST THEN
            MIEntrySummary.DELETEALL;


    end;



    var

        SalorderNo: Code[30];
}

