page 33000260 "Sampling Plan Header"
{
    // version QC1.0

    PageType = Document;
    SourceTable = "Sampling Plan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Standard Reference"; Rec."Standard Reference")
                {
                    ApplicationArea = All;
                }
                field("AQL Percentage"; Rec."AQL Percentage")
                {
                    ApplicationArea = All;
                }
                field("Sampling Type"; Rec."Sampling Type")
                {
                    ApplicationArea = All;
                }
                field("Fixed Quantity"; Rec."Fixed Quantity")
                {
                    ApplicationArea = All;
                }
                field("Lot Percentage"; Rec."Lot Percentage")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000006; "Sampling Line Subform")
            {
                SubPageLink = "Sampling Code" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

