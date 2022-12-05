pageextension 70117 PostedSalesCrMemoSubformExt extends "Posted Sales Cr. Memo Subform"
{
    Editable = true;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addafter(Type)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Invoice Discount Amount")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            /* field("Excise Amount"; "Excise Amount")
             {
                 ApplicationArea = All;
             }
             field("Excise Base Amount"; "Excise Base Amount")
             {
                 Editable = false;
                 ApplicationArea = All;
             }
             field("Amount To Customer"; "Amount To Customer")
             {
                 ApplicationArea = All;
             }
             field("BED Amount"; "BED Amount")
             {
                 ApplicationArea = All;
             }
             field("Tax Amount"; "Tax Amount")
             {
                 ApplicationArea = All;
             }
             field("Tax Base Amount"; "Tax Base Amount")
             {
                 ApplicationArea = All;
             }
             field("Service Tax SBC %"; "Service Tax SBC %")
             {
                 ApplicationArea = All;
             }
             field("Service Tax SBC Amount"; "Service Tax SBC Amount")
             {
                 ApplicationArea = All;
             }
             field("KK Cess%"; "KK Cess%")
             {
                 ApplicationArea = All;
             }
             field("KK Cess Amount"; "KK Cess Amount")
             {
                 ApplicationArea = All;
             }
             field("Service Tax eCess Amount"; "Service Tax eCess Amount")
             {
                 ApplicationArea = All;
             }
             field("Service Tax SHE Cess Amount"; "Service Tax SHE Cess Amount")
             {
                 ApplicationArea = All;
             }*/
        }
    }
    actions
    {


    }

    trigger OnOpenPage()
    begin
        IF USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\VIJAYA'] THEN
            CurrPage.EDITABLE;
    end;

}

