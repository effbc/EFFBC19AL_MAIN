/*pageextension 70229 StructureOrderLineDetailsExt extends "Structure Order Line Details"
{
   //object id 16306

    layout
    {



        modify(Control1)
        {



            ShowCaption = false;
        }



        addafter("Name 2")
        {
            field("Third Party Name"; rec."Third Party Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        Rec.SETFILTER("Structure Code", 'PUR_FR_GST');
        Rec.SETFILTER("Calculation Value", '>%1', 0);
        IF FINDFIRST THEN BEGIN
            ERROR('Please Pick the LCY tick Mark');
        END;

    end;



}*/

