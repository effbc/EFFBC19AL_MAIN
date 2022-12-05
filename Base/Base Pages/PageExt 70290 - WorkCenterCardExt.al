pageextension 70290 WorkCenterCardExt extends "Work Center Card"
{
    layout
    {
        addafter("Alternate Work Center")
        {
            field("User Id"; Rec."User Id")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User Id" := USERID;
    end;

    var
        myInt: Integer;
}