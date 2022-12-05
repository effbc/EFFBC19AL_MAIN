page 60022 "Competitor's Master"
{
    // version B2B1.0

    CardPageID = "Competetior's Card";
    Editable = false;
    PageType = List;
    SourceTable = "Competitor's Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Competitor's Name"; Rec."Competitor's Name")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Name 2"; Rec."Competitor's Name 2")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Address"; Rec."Competitor's Address")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Address 2"; Rec."Competitor's Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Competitor's Contact"; Rec."Competitor's Contact")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
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

