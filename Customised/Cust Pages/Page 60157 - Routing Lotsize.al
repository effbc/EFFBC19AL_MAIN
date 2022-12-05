page 60157 "Routing Lotsize"
{
    PageType = Worksheet;
    SourceTable = "Routing Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Routing No."; Rec."Routing No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        RoutingHeader.SETRANGE("No.", Rec."Routing No.");
        IF RoutingHeader.FINDFIRST THEN BEGIN
            RoutingHeader.Status := RoutingHeader.Status::Certified;
            RoutingHeader.MODIFY;
        END;
    end;

    var
        RoutingHeader: Record "Routing Header";
}

