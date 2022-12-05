pageextension 70044 DimensionSetEntriesExt extends "Dimension Set Entries"
{
    // version NAVW17.00

    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }*/




        addafter("Dimension Name")
        {
            field("Dimension Value ID"; Rec."Dimension Value ID")
            {
                HideValue = false;
                ApplicationArea = All;
            }
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = All;
            }
        }
    }



}

