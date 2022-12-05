page 60214 "Blanket Sales Order Subform1"
{
    // version NAVW16.00,NAVIN6.00,SH1.0,Rev01

    AutoSplitKey = true;
    Caption = 'Blanket Sales Order Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = All;

                }
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        /* item.RESET;
                         item.SETFILTER(item."Item Status", '<>In-Active');
                         item.SETFILTER(item.Blocked, 'NO');
                         IF PAGE.RUNMODAL(31, item) = ACTION::LookupOK THEN
                             VALIDATE("No.", item."No.");*/
                        IF Rec.Type = Rec.Type::Item THEN BEGIN
                            item.RESET;
                            item.SETFILTER(item."Item Status", '<>In-Active');
                            item.SETFILTER(item.Blocked, 'NO');
                            IF Rec."No." <> '' THEN
                                item.SETRANGE("No.", Rec."No.");
                            IF PAGE.RUNMODAL(31, item) = ACTION::LookupOK THEN
                                Rec.VALIDATE("No.", item."No.");
                        END                      // copied code by swathi on 25-sep-13
                        ELSE
                            IF Rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                                GLAccount.RESET;
                                IF Rec."No." <> '' THEN
                                    GLAccount.SETRANGE("No.", Rec."No.");
                                IF PAGE.RUNMODAL(18, GLAccount) = ACTION::LookupOK THEN
                                    Rec.VALIDATE("No.", GLAccount."No.");
                            END;                      // copied code by swathi on 25-sep-13
                    end;

                    trigger OnValidate();
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        CrossReferenceNoLookUp;
                        InsertExtendedText(FALSE);
                    end;

                    trigger OnValidate();
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Quantity"; "Prod. Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Prod. Qty"; "Prod. Qty")
                {
                    ApplicationArea = All;
                }
                field("Prod. Due Date"; "Prod. Due Date")
                {
                    ApplicationArea = All;
                }
                /*  field("MRP Price"; "MRP Price")
                  {
                      Visible = false;
                  }
                  field(MRP; MRP)
                  {
                      Visible = false;
                  }
                  field("Abatement %"; "Abatement %")
                  {
                      Visible = false;
                  }
                  field("PIT Structure"; "PIT Structure")
                  {
                      Visible = false;
                  }*/
                field("Price Inclusive of Tax"; "Price Inclusive of Tax")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price Incl. of Tax"; "Unit Price Incl. of Tax")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PriceExists; PriceExists)
                {
                    Caption = 'Sale Price Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        TESTFIELD("Price Inclusive of Tax", FALSE);
                    end;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        TESTFIELD("Price Inclusive of Tax", FALSE);
                    end;
                }
                field(LineDiscExists; LineDiscExists)
                {
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invd. (Base)"; "Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }


    actions
    {
        area(processing)
        {

            group(Action1102152022)
            {
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailbyLoc;
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //CurrPage.SalesLines.PAGE.ItemAvailability(0); //B2b1.0
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //CurrPage.SalesLines.PAGE.ItemAvailability2b1.0
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Allocations;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //CurrPage.SalesLines.PAGE.ItemAvailability(2); //B2b1.0
                        end;
                    }
                }
            }
            group("Unposted Lines")
            {
                Caption = 'Unposted Lines';
                Image = PostedPayableVoucher;
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowOrders;
                    end;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowInvoices;
                    end;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowReturnOrders;
                    end;
                }
                action("Credit Memos")
                {
                    Caption = 'Credit Memos';
                    Image = CreditMemo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowCreditMemos;
                    end;
                }
            }
            group("Posted Lines")
            {
                Caption = 'Posted Lines';
                Image = PostedReceipts;
                action(Shipments)
                {
                    Caption = 'Shipments';
                    Image = Shipment;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowPostedOrders;
                    end;
                }
                action(Invoice)
                {
                    Caption = 'Invoice';
                    Image = Invoice;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowPostedInvoices;
                    end;
                }
                action("Return Receipts")
                {
                    Caption = 'Return Receipts';
                    Image = ReturnReceipt;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowPostedReturnReceipts;
                    end;
                }
                action(Action1102152008)
                {
                    Caption = 'Credit Memos';
                    Image = CreditMemo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowPostedCreditMemos;
                    end;
                }
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //CurrPage.SalesLines.PAGE.ShowDimensions; //B2b1.0
                end;
            }
            action("Co&mments")
            {
                Caption = 'Co&mments';
                Image = Comment;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //CurrPage.SalesLines.PAGE.ShowLineComments; //B2b1.0
                end;
            }
            //B2BUPG
            /*  action("Str&ucture Details")
              {
                  Caption = 'Str&ucture Details';
                  Image = CalculateHierarchy;

                  trigger OnAction();
                  begin
                      ShowStrDetailsForm();
                  end;
              }
              action(Structure)
              {
                  Caption = 'Structure';
                  Image = Hierarchy;

                  trigger OnAction();
                  var
                      //StructureOrderDetail: Record "Structure Order Details";//B2BUpg
                      SalesLine2: Record "Sales Line";
                  begin
                      ShowStrOrderDetailsPITForm;
                  end;
              }
              action("Structure Details")
              {
                  Caption = 'Structure Details';

                  trigger OnAction();
                  begin
                      ShowStrDetailsForm;
                  end;
              }*/
            action("Sc&hedule")
            {
                Caption = 'Sc&hedule';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ShowSchedule;
                end;
            }
            action("Design WorkSheet")
            {
                Caption = 'Design WorkSheet';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ShowSalesOrderWorkSheet;
                end;
            }
            action("CreateProd.Order")
            {
                Caption = 'CreateProd.Order';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                var
                    NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                    NewOrderType2: Option ItemOrder,ProjectOrder;
                begin
                    SalesPlanLine.DELETEALL;
                    Quantity := MakeLines(SalesLineRec);
                    NewStatus2 := NewStatus2::Released;
                    NewOrderType2 := NewOrderType2::ItemOrder;
                    Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::"Blanket Order");
                    Saleshdr.SETFILTER(Saleshdr."No.", "Document No.");
                    IF Saleshdr.FINDFIRST THEN
                        IF Saleshdr."Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            FOR I := 1 TO Quantity
                              DO BEGIN
                                Qty := 1;
                                CreateOrders(Qty);
                            END;
                        END;
                end;
            }
        }

    }

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ShortcutDimCode: array[8] of Code[20];
        CurrentSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SalesPlanLine: Record "Sales Planning Line";
        Text001: Label 'Prod. Order is already created against the Sales Order.';
        item: Record Item;
        SalesLineRec: Record "Sales Line";
        Saleshdr: Record "Sales Header";
        I: Integer;
        Qty: Integer;
        temprec: Record "Production Order";
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        NewOrderType: Option ItemOrder,ProjectOrder;
        GLAccount: Record "G/L Account";


    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        //Rec.ItemAvailability(AvailabilityType); //B2b1.0
    end;


    /*procedure ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;*/


    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices();
    begin
        SalesHeader.GET("Document Type", "Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc();
    begin
        SalesHeader.GET("Document Type", "Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure ShowOrders();
    begin
        CurrentSalesLine := Rec;
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;


    procedure ShowInvoices();
    begin
        CurrentSalesLine := Rec;
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Invoice);
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;


    procedure ShowReturnOrders();
    begin
        CurrentSalesLine := Rec;
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;


    procedure ShowCreditMemos();
    begin
        CurrentSalesLine := Rec;
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Credit Memo");
        SalesLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLine);
    end;


    procedure ShowPostedOrders();
    var
        SaleShptLine: Record "Sales Shipment Line";
    begin
        CurrentSalesLine := Rec;
        SaleShptLine.RESET;
        SaleShptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        SaleShptLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SaleShptLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Shipment Lines", SaleShptLine);
    end;


    procedure ShowPostedInvoices();
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        CurrentSalesLine := Rec;
        SalesInvLine.RESET;
        SalesInvLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        SalesInvLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesInvLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice Lines", SalesInvLine);
    end;


    procedure ShowPostedReturnReceipts();
    var
        ReturnRcptLine: Record "Return Receipt Line";
    begin
        CurrentSalesLine := Rec;
        ReturnRcptLine.RESET;
        ReturnRcptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        ReturnRcptLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        ReturnRcptLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Return Receipt Lines", ReturnRcptLine);
    end;


    procedure ShowPostedCreditMemos();
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        CurrentSalesLine := Rec;
        SalesCrMemoLine.RESET;
        SalesCrMemoLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        SalesCrMemoLine.SETRANGE("Blanket Order No.", CurrentSalesLine."Document No.");
        SalesCrMemoLine.SETRANGE("Blanket Order Line No.", CurrentSalesLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo Lines", SalesCrMemoLine);
    end;


    /*procedure ShowLineComments();
        begin
            Rec.ShowLineComments;
        end;*/

    /*
        procedure ShowStrDetailsForm();
        var
            StrOrderLineDetails: Record "Structure Order Line Details";
            StrOrderLineDetailsForm: Page "Structure Order Line Details";
        begin
            StrOrderLineDetails.RESET;
            StrOrderLineDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
            StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
            StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
            StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
            StrOrderLineDetails.SETRANGE("Item No.", "No.");
            StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
            StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
            StrOrderLineDetailsForm.RUNMODAL;
        end;

    */
    /* procedure ShowStrOrderDetailsPITForm();
     begin
         Rec.ShowStrOrderDetailsPIT;
     end;*/


    procedure "--B2B1.0--"();
    begin
    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
        SalesLine: Record "Sales Line";
    begin
        /*
        //IF ("Tender No." = '')  AND ("Tender Line No." =0) THEN BEGIN
          Schedule.RESET;
          Schedule.SETRANGE("Document Type",Schedule."Document Type" :: "Blanket Order");
          Schedule.SETRANGE("Document No.","Document No.");
          Schedule.SETRANGE("Document Line No.","Line No.");
          //Schedule.SETRANGE("Item No.","No.");
          //Schedule.SETRANGE(Quantity,Quantity);
          Page.RUN(60125,Schedule);
        
        //END ELSE BEGIN
          Schedule.RESET;
          Schedule.SETRANGE("Document Type",Schedule."Document Type" :: Tender);
          Schedule.SETRANGE("Document No.","Tender No.");
          Schedule.SETRANGE("Document Line No.","Tender Line No.");
          //Schedule.SETRANGE("Item No.","No.");
          //Schedule.SETRANGE(Quantity,Quantity);
          Schedule.FILTERGROUP(2);
          Page.RUN(60127,Schedule);
          Schedule.FILTERGROUP(0);
        END;
        */

        IF Type = Type::Item THEN BEGIN
            IF ("Tender No." <> '') AND ("Tender Line No." <> 0) THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                Schedule.SETRANGE("Document No.", "Document No.");
                Schedule.SETRANGE("Document Line No.", "Line No.");
                //Schedule.SETRANGE("Item No.","No.");
                //Schedule.SETRANGE(Quantity,Quantity);
                Schedule.FILTERGROUP(2);
                IF Schedule.FINDFIRST THEN BEGIN
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END ELSE BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Line No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Schedule.INIT;
                            Schedule."Document Type" := Schedule."Document Type"::"Blanket Order";
                            Schedule."Document No." := SalesLine."Document No.";
                            Schedule."Document Line No." := SalesLine."Line No.";
                            Schedule."Line No." := SalesLine."Line No.";
                            Schedule.Type := Schedule.Type::Item;
                            Schedule.VALIDATE("No.", SalesLine."No.");
                            Schedule.Quantity := SalesLine.Quantity;
                            Schedule.VALIDATE("Unit of Measure Code");
                            Schedule."Location Code" := SalesLine."Location Code";
                            //salesLine.CALCFIELDS("Estimated Unit Cost");
                            IF Schedule.INSERT THEN;
                        UNTIL SalesLine.NEXT = 0;
                    COMMIT;
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                    Schedule.SETRANGE("Document No.", "Document No.");
                    Schedule.SETRANGE("Document Line No.", "Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END
            END ELSE BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", "Document No.");
                SalesLine.SETRANGE("Line No.", "Line No.");
                IF SalesLine.FINDSET THEN
                    REPEAT
                        Schedule.INIT;
                        Schedule."Document Type" := Schedule."Document Type"::"Blanket Order";
                        Schedule."Document No." := SalesLine."Document No.";
                        Schedule."Document Line No." := SalesLine."Line No.";
                        Schedule."Line No." := SalesLine."Line No.";
                        Schedule.Type := Schedule.Type::Item;
                        Schedule.VALIDATE("No.", SalesLine."No.");
                        Schedule.Quantity := SalesLine.Quantity;
                        Schedule.VALIDATE("Unit of Measure Code");
                        Schedule."Location Code" := SalesLine."Location Code";
                        Schedule."Estimated Total Unit Price" := Schedule."Estimated Unit Price" * Quantity;
                        //salesLine.CALCFIELDS("Estimated Unit Cost");
                        IF Schedule.INSERT THEN;
                    UNTIL SalesLine.NEXT = 0;
                COMMIT;

                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                Schedule.SETRANGE("Document No.", "Document No.");
                Schedule.SETRANGE("Document Line No.", "Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);
            END
        END ELSE
            IF Type = Type::"G/L Account" THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
                Schedule.SETRANGE("Document No.", "Document No.");
                Schedule.SETRANGE("Document Line No.", "Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);


            END;

    end;


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        ItemDesignWorksheetHeader.RESET;
        IF ItemDesignWorksheetHeader.GET("No.") THEN BEGIN
            DesignWorksheetHeader.INIT;
            DesignWorksheetHeader.TRANSFERFIELDS(ItemDesignWorksheetHeader);
            DesignWorksheetHeader."Document No." := "Document No.";
            DesignWorksheetHeader."Document Line No." := "Line No.";
            DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::"Blanket Order";
            IF DesignWorksheetHeader.INSERT THEN;
            ItemDesignWorksheetLine.RESET;
            ItemDesignWorksheetLine.SETRANGE(ItemDesignWorksheetLine."Item No", ItemDesignWorksheetHeader."Item No.");
            IF ItemDesignWorksheetLine.FINDSET THEN
                REPEAT
                    DesignWorksheetLine.INIT;
                    DesignWorksheetLine.TRANSFERFIELDS(ItemDesignWorksheetLine);
                    DesignWorksheetLine."Item No" := "No.";
                    DesignWorksheetLine."Document No." := "Document No.";
                    DesignWorksheetLine."Document Line No." := "Line No.";
                    DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::"Blanket Order";
                    IF DesignWorksheetLine.INSERT THEN;
                UNTIL ItemDesignWorksheetLine.NEXT = 0;
        END;
        COMMIT;

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::"Blanket Order");
        DesignWorksheetHeader.SETRANGE("Document No.", "Document No.");
        DesignWorksheetHeader.SETRANGE("Document Line No.", "Line No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        IF DesignWorksheetHeader.FINDFIRST THEN
            PAGE.RUNMODAL(60122, DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
    end;


    procedure MakeLines(var SalesLineparam: Record "Sales Line"): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Blanket Order");
        SalesLine.SETRANGE("Document No.", "Document No.");
        //NSS 301207
        SalesLine.SETRANGE("Line No.", "Line No.");
        //NSS
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);

        IF SalesLine.FINDFIRST THEN BEGIN
            //REPEAT
            SalesLine.TESTFIELD("Prod. Qty");
            SalesLine.TESTFIELD("Prod. Due Date");
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := SalesLine."Document No.";
            SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
            SalesPlanLine."Item No." := SalesLine."No.";

            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            SalesPlanLine.Description := SalesLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
            /*ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
            ReserveSalesline.FilterReservFor(ReservEntry,SalesLine);
            ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Reservation);
            IF ReservEntry.FINDSET THEN
              REPEAT
                IF ReservEntry2.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
                  CASE ReservEntry2."Source Type" OF
                    DATABASE::"Item Ledger Entry":
                      BEGIN
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Inventory;
                      END;
                    DATABASE::"Requisition Line":
                      BEGIN
                        ReqLine.GET(
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Batch Name",
                          ReservEntry2."Source Ref. No.");
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Planned;
                        SalesPlanLine."Expected Delivery Date" := ReqLine."Due Date";
                      END;
                    DATABASE::"Purchase Line":
                      BEGIN
                        PurchLine.GET(
                          ReservEntry2."Source Subtype",
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Ref. No.");
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::"Firm Planned";
                        SalesPlanLine."Expected Delivery Date" := PurchLine."Expected Receipt Date";
                      END;
                    DATABASE::"Prod. Order Line":
                      BEGIN
                        ProdOrderLine.GET(
                          ReservEntry2."Source Subtype",
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Prod. Order Line");
                        IF ProdOrderLine."Ending Date" > SalesPlanLine."Expected Delivery Date" THEN
                          SalesPlanLine."Expected Delivery Date" := ProdOrderLine."Ending Date";
                        IF ((ProdOrderLine.Status + 1) < SalesPlanLine."Planning Status") OR
                           (SalesPlanLine."Planning Status" = SalesPlanLine."Planning Status"::None)
                        THEN
                          SalesPlanLine."Planning Status" := ProdOrderLine.Status + 1;
                      END;
                  END;
              UNTIL ReservEntry.NEXT = 0;*/
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            /*CalculateDisposalPlan(
              SalesLine."Variant Code",
              SalesLine."Location Code",SalesLine."Bin Code");*/
            SalesPlanLine.INSERT;
            EXIT(SalesLine."Prod. Qty");
            //UNTIL SalesLine.NEXT = 0;
        END;

    end;


    procedure ValidateProdOrder();
    begin
        CALCFIELDS("Prod. Order Quantity");
        IF "Prod. Order Quantity" > Quantity THEN
            ERROR(Text001);
    end;


    procedure CustAttachments();
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", "Document No.");
        CustAttach.SETRANGE("Document Type", "Document Type");
        //message("Document Type");
        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
        //CustAttachments
    end;


    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(FALSE);
    end;


    local procedure CrossReferenceNoOnAfterValidat();
    begin
        InsertExtendedText(FALSE);
    end;


    local procedure QuantityOnAfterValidate();
    begin
        IF Reserve = Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            AutoReserve;
        END;
    end;


    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        IF Reserve = Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            AutoReserve;
        END;
    end;


    procedure CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean;
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            SalesLine.GET(
              SalesLine."Document Type"::"Blanket Order",
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            Item.GET(SalesLine."No.");
            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProdOrder2(SalesLine, NewStatus::Released, NewOrderType::ItemOrder, 1);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        UNTIL (SalesPlanLine.NEXT = 0);
    end;
}

