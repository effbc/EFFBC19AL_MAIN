pageextension 70292 MachineCenterCardExt extends "Machine Center Card"
{
    layout
    {
        addafter("Work Center No.")
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