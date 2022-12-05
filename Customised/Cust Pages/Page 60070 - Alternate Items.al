page 60070 "Alternate Items"
{
    DataCaptionFields = "Proudct Type", "Item No.";
    PageType = Worksheet;
    SourceTable = "Alternate Items";

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                ShowCaption = false;
                field("Proudct Type"; Rec."Proudct Type")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Alternative Item No."; Rec."Alternative Item No.")
                {
                    ApplicationArea = All;
                }
                field("Alternative Item Description"; Rec."Alternative Item Description")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Priority Order"; Rec."Priority Order")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Process)
            {
                Caption = 'Process';
                action("<Page ESPL Attachments>")
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "ESPL Attachments";
                    RunPageLink = "Table ID" = CONST(60045), "Document No." = FIELD("Item No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Item.GET("Item No.");
        IF NOT SMTPMail.Permission_Checking(USERID, 'BOM_Creation') THEN BEGIN
            IF Item."Product Group Code cust" = 'CPCB' THEN BEGIN
                MESSAGE('You Do not have rights to Check Compound PCB Details');
                CurrPage.CLOSE;
            END;
        END;
    end;

    var
        Item: Record Item;
        SMTPMail: Codeunit "Custom Events";
}

