page 60215 "PCB Cost Details Card"
{
    // version Rev01

    PageType = Card;
    SourceTable = "PCB Cost Details";

    layout
    {
        area(content)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                Lookup = true;
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
            field("PCB Thickness"; Rec."PCB Thickness")
            {
                ApplicationArea = All;
            }
            field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
            {
                ApplicationArea = All;
            }
            field("Min.Quantity"; Rec."Min.Quantity")
            {
                ApplicationArea = All;
            }
            field("Max.Quantity"; Rec."Max.Quantity")
            {
                ApplicationArea = All;
            }
            field("Min.Area"; Rec."Min.Area")
            {
                ApplicationArea = All;
            }
            field("Max.Area"; Rec."Max.Area")
            {
                ApplicationArea = All;
            }
            field(Cost; Rec.Cost)
            {
                ApplicationArea = All;
            }
            field("Area"; Rec.Area)
            {
                ApplicationArea = All;
            }
            field(Date; Rec.Date)
            {
                ApplicationArea = All;
            }
            field("PCB TYPE"; Rec."PCB TYPE")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Order")
            {
                Caption = 'Order';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Newno := '';
                    PurchSetup.GET;
                    PurchaseHeader.INIT;
                    NoSeriesMgt.InitSeries(PurchSetup."Order Nos.", PurchSetup."Order Nos.", TODAY, Newno, series);
                    PurchaseHeader."No." := Newno;
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                    PurchaseHeader."Buy-from Vendor No." := Rec."PCB Thickness";
                    CompanyInfo.GET;
                    PurchaseHeader.Trading := CompanyInfo."Trading Co.";
                    PurchaseHeader.InitRecord;
                    Vend.GET(Rec."PCB Thickness");
                    Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                    Vend.TESTFIELD(Vend."Updated in Cashflow", TRUE);
                    Vend.TESTFIELD("Gen. Bus. Posting Group");
                    PurchaseHeader."Buy-from Vendor Name" := Vend.Name;
                    PurchaseHeader."Buy-from Vendor Name 2" := Vend."Name 2";
                    PurchaseHeader."Buy-from Address" := Vend.Address;
                    PurchaseHeader."Buy-from Address 2" := Vend."Address 2";
                    PurchaseHeader."Buy-from Address 3" := Vend."Address 3";
                    PurchaseHeader."Buy-from City" := Vend.City;
                    PurchaseHeader."Buy-from Post Code" := Vend."Post Code";
                    PurchaseHeader."Buy-from County" := Vend.County;
                    PurchaseHeader."Buy-from Country/Region Code" := Vend."Country/Region Code";
                    PurchaseHeader."Buy-from Contact" := Vend.Contact;
                    PurchaseHeader."Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
                    PurchaseHeader."VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
                    PurchaseHeader."Tax Liable" := Vend."Tax Liable";
                    PurchaseHeader."VAT Country/Region Code" := Vend."Country/Region Code";
                    PurchaseHeader."VAT Registration No." := Vend."VAT Registration No.";
                    PurchaseHeader."Responsibility Center" := UserMgt.GetRespCenter(1, Vend."Responsibility Center");
                   // PurchaseHeader."Excise Bus. Posting Group" := Vend."Excise Bus. Posting Group";
                    PurchaseHeader.State := Vend."State Code";
                    PurchaseHeader."Purchaser Code" := Vend."Purchaser Code";

                    PurchaseHeader.INSERT;
                end;
            }
        }
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    var
        Item: Record Item;
        Vendor: Record Vendor;
        pcb: Record "PCB Cost Details";
        NoSeriesMgt: Codeunit 396;
        PurchaseHeader: Record "Purchase Header";
        Purchaseline: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Newno: Code[20];
        series: Code[10];
        Vend: Record Vendor;
        UserMgt: Codeunit "User Setup Management";
        CompanyInfo: Record "Company Information";
}

