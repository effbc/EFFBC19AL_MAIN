page 60247 "Change Log Entry"
{
    PageType = List;
    Permissions = TableData "Change Log Entry" = r;
    SourceTable = "Change Log Entry";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ApplicationArea = All;
                }
                field("Field No."; Rec."Field No.")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                }
                field("Type of Change"; Rec."Type of Change")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 No."; Rec."Primary Key Field 1 No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 Caption"; Rec."Primary Key Field 1 Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 Value"; Rec."Primary Key Field 1 Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 No."; Rec."Primary Key Field 2 No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 Caption"; Rec."Primary Key Field 2 Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 Value"; Rec."Primary Key Field 2 Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 No."; Rec."Primary Key Field 3 No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 Caption"; Rec."Primary Key Field 3 Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 Value"; Rec."Primary Key Field 3 Value")
                {
                    ApplicationArea = All;
                }
                field("Record ID"; Rec."Record ID")
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

