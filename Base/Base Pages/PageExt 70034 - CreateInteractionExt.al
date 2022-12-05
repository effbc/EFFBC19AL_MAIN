pageextension 70034 CreateInteractionExt extends "Create Interaction"
{


    layout
    {



        /* modify("Control28")
         {



             ShowCaption = false;
         }
         modify("Control37")
         {


             ShowCaption = false;
         }



         modify("Control47")
         {


             ShowCaption = false
         }*/



        addfirst(InteractionDetails)
        {
            field("OutWard No."; Rec."OutWard No.")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    Rec.TESTFIELD("Information Flow", Rec."Information Flow"::Outbound);
                end;
            }
            field("OutWard Ref No."; Rec."OutWard Ref No.")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    InteractionLogEntry.RESET;
                    InteractionLogEntry.SETRANGE("Contact No.", Rec."Contact No.");
                    InteractionLogEntry.SETFILTER("OutWard No.", '<>%1', '');
                    IF InteractionLogEntry.FINDFIRST THEN
                        IF PAGE.RUNMODAL(0, InteractionLogEntry) = ACTION::LookupOK THEN
                            Rec."OutWard Ref No." := InteractionLogEntry."OutWard No.";
                end;
            }
        }
        addafter("Date")
        {
            field("InWard No."; Rec."InWard No.")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    Rec.TESTFIELD("Information Flow", Rec."Information Flow"::Inbound);
                end;
            }
        }
        addafter("Information Flow")
        {
            field("InWard Ref No."; Rec."InWard Ref No.")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    InteractionLogEntry.RESET;
                    InteractionLogEntry.SETRANGE("Contact No.", Rec."Contact No.");
                    InteractionLogEntry.SETFILTER("InWard No.", '<>%1', '');
                    IF InteractionLogEntry.FINDFIRST THEN
                        IF PAGE.RUNMODAL(0, InteractionLogEntry) = ACTION::LookupOK THEN
                            Rec."InWard Ref No." := InteractionLogEntry."InWard No.";
                end;
            }
        }
    }
    actions
    {



        /* modify(Back)
         {
             InFooterBar = true;
             Promoted = true;
             PromotedCategory = Process;
         }
         modify(Next)
         {
             InFooterBar = true;
             Promoted = true;
             PromotedCategory = Process;
         }*/ //Removed in base page
        modify(Finish)
        {
            InFooterBar = true;
            Promoted = true;
            PromotedCategory = Process;
        }



    }



    var
        InteractionLogEntry: Record "Interaction Log Entry";
    //InteractionLogEntries: Page "Interaction Log Entries";



}

