/*pageextension 70228 StructureOrderDetailsExt extends "Structure Order Details"
{
            object id 16303


    layout
    {


        modify("Contro1")
        {



            ShowCaption = false;
        
        }

        addafter("Control 30")
        {
            field("Third Party Name"; "Third Party Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    var
        "Purchase Header": Record "Purchase Header";
        "G|l": Record "General Ledger Setup";
        PURCHASE_LINE: Record "Purchase Line";




}*/

