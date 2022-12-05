pageextension 70160 PurchaseQuoteSubformExt extends "Purchase Quote Subform"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Num: Code[20];
            begin
                PurchaseHeader.SETRANGE("No.", Rec."Document No.");
                IF PurchaseHeader.FINDFIRST THEN
                    Num := PurchaseHeader."Buy-from Vendor No.";
                ItemVend.SETRANGE("Vendor No.", Num);
                ItemVend.SETRANGE("Item No.", Rec."No.");
                IF NOT ItemVend.FINDFIRST THEN
                    ERROR('%1 is not the correct item number', Rec."No.");
            end;
        }
    }
    actions
    {

    }

    var
        ItemVend: Record "Item Vendor";
        PurchaseHeader: Record "Purchase Header";

    procedure StrOrderLineDetailsPage();
    begin
    end;





    procedure "---B2B---"();
    begin
    end;


    procedure OpenAttachments();
    var
        Attachment: Record Attachments;
    begin
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", DATABASE::"Purchase Header");
        Attachment.SETRANGE("Document No.", Rec."Document No.");
        Attachment.SETRANGE("Document Type", Rec."Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", Attachment);
    end;
}

