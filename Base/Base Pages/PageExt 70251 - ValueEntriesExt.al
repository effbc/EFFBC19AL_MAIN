pageextension 70251 ValueEntriesExt extends "5802"
{


    layout
    {



        /*modify("Control1")
        {

           
            ShowCaption = false;
        }*/


        addafter("Job Ledger Entry No.")
        {

            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
            field(Inventoriable; Rec.Inventoriable)
            {
                ApplicationArea = All;
            }
        }
        moveafter("Posting Date"; "Item Ledger Entry Type")
        moveafter("Salespers./Purch. Code"; "Source Posting Group")
    }
    actions
    {



        modify("&Navigate")
        {
            Promoted = true;


        }
    }



}

