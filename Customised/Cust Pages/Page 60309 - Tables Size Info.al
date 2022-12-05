page 60309 "Tables Size Info"
{
    PageType = List;
    SourceTable = "Table Information";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = All;
                }
                field("Record Size"; Rec."Record Size")
                {
                    ApplicationArea = All;
                }
                field("Size (KB)"; Rec."Size (KB)")
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

