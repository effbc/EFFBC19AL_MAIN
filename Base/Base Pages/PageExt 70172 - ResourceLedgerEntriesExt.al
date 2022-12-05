pageextension 70172 ResourceLedgerEntriesExt extends 202
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */

        addafter("Document No.")
        {
            field(Zones; Rec.Zones)
            {
                ApplicationArea = All;
            }
            field(Place; Rec.Place)
            {
                ApplicationArea = All;
            }
            field(Division; Rec.Division)
            {
                ApplicationArea = All;
            }
            field(Station; Rec.Station)
            {
                ApplicationArea = All;
            }
            field("Product type"; Rec."Product type")
            {
                ApplicationArea = All;
            }
            field("Sale order no"; Rec."Sale order no")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("Serial no"; Rec."Serial no")
            {
                ApplicationArea = All;
            }
            field("Work Description"; Rec."Work Description")
            {
                ApplicationArea = All;
            }
            field(State; Rec.State)
            {
                ApplicationArea = All;
            }
            field(District; Rec.District)
            {
                ApplicationArea = All;
            }
            field("Planned Hr's"; Rec."Planned Hr's")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Navigate")
        {
            Promoted = true;
        }
    }
}

