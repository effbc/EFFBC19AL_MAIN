page 60106 "MSPT Posted Order Details"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Posted Order Details

    Editable = false;
    PageType = List;
    SourceTable = "Posted MSPT Order Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("MSPT Header Code"; Rec."MSPT Header Code")
                {
                    ApplicationArea = All;
                }
                field("MSPT Code"; Rec."MSPT Code")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Calulation Period"; Rec."Calulation Period")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

