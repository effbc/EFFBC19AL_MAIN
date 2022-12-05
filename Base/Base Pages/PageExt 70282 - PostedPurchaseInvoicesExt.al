pageextension 70282 PostedPurchaseInvoicesExt extends 146
{
    layout
    {
        addfirst(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("Order Address Code")
        {
            /* field("Form Code"; "Form Code")
             {
                 ApplicationArea = All;

             }

             field(Structure; Structure)
             {
                 ApplicationArea = All;

             }
             field("Form No."; "Form No.")
             {
                 ApplicationArea = All;

             }*/

            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;

            }
            field("Vendor Excise Invoice No."; Rec."Vendor Excise Invoice No.")
            {
                ApplicationArea = All;

            }
            field("Vend. Excise Inv. Date"; Rec."Vend. Excise Inv. Date")
            {
                ApplicationArea = All;

            }
            field("Actual Invoiced Date"; Rec."Actual Invoiced Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Ship-to Country/Region Code")
        {
            /* field("Amount to Vendor"; "Amount to Vendor")
             {
                 ApplicationArea = All;

             }*/
        }
        addafter("Shipment Method Code")
        {
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;

            }
            field("Excise Claimed Date"; Rec."Excise Claimed Date")
            {
                Caption = 'GST Claimed Date';
                ApplicationArea = All;
            }
            field(RCM_Paid_Date; Rec.RCM_Paid_Date)
            {
                ApplicationArea = All;

            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        /* pih.RESET;
        pih.SETFILTER("No.", '<> %1', '');
        IF pih.FINDLAST THEN BEGIN
            //  id :=0;
            REPEAT
                id := pih.ADDLINK('https://app.powerbi.com/view?r=eyJrIjoiODUyOWNkYWYtZGY4Yy00YjI2LWE5MTYtMTk3N2U0NDgxZjJmIiwidCI6IjZhZDY1ZDZkLWZkODctNDQ5OC04ZTkyLTUzNGM3YTA3ZjlmOCIsImMiOjEwfQ%3D%3D', 'Receipts List');
            UNTIL pih.NEXT = 0;
            id := pih.ADDLINK('', '');
        END; */
    end;

    var
        pih: Record "Purch. Inv. Header";
        id: Char;
}