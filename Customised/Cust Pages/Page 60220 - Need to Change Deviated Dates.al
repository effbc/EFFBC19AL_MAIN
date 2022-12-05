page 60220 "Need to Change Deviated Dates"
{
    PageType = Worksheet;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order), Type = CONST(Item), "Location Code" = CONST('STR'), "Outstanding Quantity" = FILTER(> 0));

    layout
    {
        area(content)
        {
            field("COUNT"; COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Deviated Receipt Date"; "Deviated Receipt Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //SETFILTER("Deviated Receipt Date"=<format(TODAY))
        SETRANGE("Deviated Receipt Date", DMY2Date(01, 04, 11), TODAY - 1);
    end;

    var
        x: Integer;
}

