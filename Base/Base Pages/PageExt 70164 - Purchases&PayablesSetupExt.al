pageextension 70164 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{


    layout
    {




        addbefore("Background Posting")
        {
            field("Purchase Indent Nos."; Rec."Purchase Indent Nos.")
            {
                ApplicationArea = All;
            }
            field("Enquiry Nos."; Rec."Enquiry Nos.")
            {
                ApplicationArea = All;
            }
            field("RFQ Nos."; Rec."RFQ Nos.")
            {
                ApplicationArea = All;
            }
            field("ICN Nos."; Rec."ICN Nos.")
            {
                ApplicationArea = All;
            }
            group(Weightages)
            {
                Caption = 'Weightages';
                field("Price Weightage"; Rec."Price Weightage")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                }
                field("Quality Weightage"; Rec."Quality Weightage")
                {
                    Caption = 'Quality';
                    ApplicationArea = All;
                }
                field("Delivery Weightage"; Rec."Delivery Weightage")
                {
                    Caption = 'Delivery';
                    ApplicationArea = All;
                }
                field("Payment Terms Weightage"; Rec."Payment Terms Weightage")
                {
                    Caption = 'Payment Terms';
                    ApplicationArea = All;
                }
                field("Default Delivery Rating"; Rec."Default Delivery Rating")
                {
                    ApplicationArea = All;
                }
                field("Default Quality Rating"; Rec."Default Quality Rating")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        temp: Decimal;
        text000: Label 'Total weightage should be equal to hundred';




}

