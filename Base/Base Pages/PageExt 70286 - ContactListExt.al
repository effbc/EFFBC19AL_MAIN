pageextension 70286 ContactListExt extends 5052
{
    layout
    {
        addfirst(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Govt./Private"; Rec."Govt./Private")
            {
                ApplicationArea = All;

            }
            field("Domestic/Foreign"; Rec."Domestic/Foreign")
            {
                ApplicationArea = All;

            }
            field("Product Type"; Rec."Product Type")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        //Cont.SETRANGE(Cont."No.",'>CONT001656');
        Rec.SETFILTER("No.", '>CONT001720');
    end;

    var
        myInt: Integer;
}