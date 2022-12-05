pageextension 70065 GetReceiptLinestExt extends "Get Receipt Lines"
{


    layout
    {


        /* modify("Control1")
         {



             ShowCaption = false;
         }*/



        addfirst("Control1")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor No.")
        {
            /* field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                ApplicationArea = All;
            } */
        }
        addafter("Job No.")
        {
            field("Item QC Status"; Inwardstatus)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        //added by vishnu priya on 06-01-2020
        IDS.RESET;
        IDS.SETFILTER("Receipt No.", Rec."Document No.");
        IDS.SETFILTER("Item No.", Rec."No.");
        IF IDS.FINDSET THEN
            Inwardstatus := 'IN IDS'
        ELSE BEGIN
            IRH.RESET;
            IRH.SETFILTER("Receipt No.", Rec."Document No.");
            IRH.SETFILTER(Status, FORMAT(0));
            IRH.SETFILTER("Source Type", FORMAT(0));
            IRH.SETFILTER("Item No.", Rec."No.");
            IF IRH.FINDSET THEN
                Inwardstatus := 'IN IR'
            ELSE
                Inwardstatus := 'Completed';
        END;
        // end by vishnu priya on 06-01-2020
    end;



    var
        Inwardstatus: Text;
        IRH: Record "Inspection Receipt Header";
        IDS: Record "Inspection Datasheet Header";




}

