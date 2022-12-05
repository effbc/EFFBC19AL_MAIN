page 50014 "Bought Out Items Planning"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Sales Bought Out Material List";

    layout
    {
        area(content)
        {
            field(SHowBattNChargr; SHowBattNChargr)
            {
                Caption = 'Show Batteries & Chargers';
                StyleExpr = TRUE;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    // Added by Pranavi on 24-Dec-2016 for show/not showing selection of batteries & chargers
                    IF SHowBattNChargr THEN BEGIN
                        Rec.RESET;
                        CurrPage.UPDATE;
                    END ELSE BEGIN
                        Rec.RESET;
                        Rec.SETFILTER(No, '<>%1&<>%2', 'ECBOUBT00004', 'BOICHAR00014');
                        CurrPage.UPDATE;
                    END;
                    // End by Pranavi
                end;
            }
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = ScheduleItemsColor;
                    ApplicationArea = All;
                }
                field("Sell To Customer No"; Rec."Sell To Customer No")
                {
                    Editable = false;
                    Style = Ambiguous;
                    StyleExpr = PlndDispDateColor;
                    ApplicationArea = All;
                }
                field("Sell To Customer Name"; Rec."Sell To Customer Name")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = LeadTimeColor;
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Schedule Line No"; Rec."Schedule Line No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quanity; Rec.Quanity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty Shipped"; Rec."Qty Shipped")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Be Shipped Qty"; Rec."To Be Shipped Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Lead Time"; Rec."Item Lead Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Planned Dispatch Date"; Rec."Planned Dispatch Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\BSATISH', 'EFFTRONICS\SARDHAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                            IF Rec."Schedule Line No" = 0 THEN BEGIN
                                SalesLin.RESET;
                                SalesLin.SETRANGE(SalesLin."Document No.", Rec."Document No");
                                SalesLin.SETRANGE(SalesLin."Line No.", Rec."Line No");
                                SalesLin.SETRANGE(SalesLin."No.", Rec.No);
                                IF SalesLin.FINDFIRST THEN BEGIN
                                    SalesLin."Planned Dispatch Date" := Rec."Planned Dispatch Date";
                                    SalesLin.MODIFY;
                                END;
                            END
                            ELSE BEGIN
                                SchdlLin.RESET;
                                SchdlLin.SETRANGE(SchdlLin."Document No.", Rec."Document No");
                                SchdlLin.SETRANGE(SchdlLin."Document Line No.", Rec."Line No");
                                SchdlLin.SETRANGE(SchdlLin."Line No.", Rec."Schedule Line No");
                                SchdlLin.SETRANGE(SchdlLin."No.", Rec.No);
                                IF SchdlLin.FINDFIRST THEN BEGIN
                                    SchdlLin."Planned Dispatch Date" := Rec."Planned Dispatch Date";
                                    SchdlLin.MODIFY;
                                END;
                            END;
                        END
                        ELSE BEGIN
                            MESSAGE('You do not have rights for Planning!');
                            ERROR('You do not have rights for Planning!');
                        END;
                    end;
                }
                field(To_Be_Purch_Qty; Rec.To_Be_Purch_Qty)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\ANANDA', 'EFFTRONICS\PARDHU', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN BEGIN
                            MESSAGE('You do not have rights for Planning!');
                            ERROR('You do not have rights for Planning!');
                        END;

                        IF Rec.To_Be_Purch_Qty > 0 THEN
                            IF Rec.To_Be_Purch_Qty > Rec."To Be Shipped Qty" THEN BEGIN
                                MESSAGE('You cannot enter more than ' + FORMAT(Rec."To Be Shipped Qty"));
                                ERROR('You cannot enter more than ' + FORMAT(Rec."To Be Shipped Qty"));
                            END;
                    end;
                }
                field("Asign Vendor"; Rec."Asign Vendor")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\ANANDA', 'EFFTRONICS\PARDHU', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN BEGIN
                            MESSAGE('You do not have rights for Planning!');
                            ERROR('You do not have rights for Planning!');
                        END;
                        IF Rec."Planned Dispatch Date" = 0D THEN BEGIN
                            MESSAGE('You cannot asign vendor as there is not dispatch plan!');
                            ERROR('You cannot asign vendor as there is not dispatch plan!');
                        END;
                    end;
                }
                field("Purchase Remarks"; Rec."Purchase Remarks")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Schedule Line No" = 0 THEN BEGIN
                            SalesLin.RESET;
                            SalesLin.SETRANGE(SalesLin."Document No.", Rec."Document No");
                            SalesLin.SETRANGE(SalesLin."Line No.", Rec."Line No");
                            SalesLin.SETRANGE(SalesLin."No.", Rec.No);
                            IF SalesLin.FINDFIRST THEN BEGIN
                                SalesLin."Purchase Remarks" := Rec."Purchase Remarks";
                                SalesLin.MODIFY;
                            END;
                        END
                        ELSE BEGIN
                            SchdlLin.RESET;
                            SchdlLin.SETRANGE(SchdlLin."Document No.", Rec."Document No");
                            SchdlLin.SETRANGE(SchdlLin."Document Line No.", Rec."Line No");
                            SchdlLin.SETRANGE(SchdlLin."Line No.", Rec."Schedule Line No");
                            SchdlLin.SETRANGE(SchdlLin."No.", Rec.No);
                            IF SchdlLin.FINDFIRST THEN BEGIN
                                SchdlLin."Purchase Remarks" := Rec."Purchase Remarks";
                                SchdlLin.MODIFY;
                            END;
                        END;
                    end;
                }
                field("Stock At Store"; Rec."Stock At Store")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stock At MCH"; Rec."Stock At MCH")
                {
                    ApplicationArea = All;
                }
                field("Stock At R&D Store"; Rec."Stock At R&D Store")
                {
                    ApplicationArea = All;
                }
                field("Stock At CS Store"; Rec."Stock At CS Store")
                {
                    ApplicationArea = All;
                }
                field("Qty On Purch Orders"; Rec."Qty On Purch Orders")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty Under Inspection"; Rec."Qty Under Inspection")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issued Material Qty"; Rec."Issued Material Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase Order  Number"; Rec."Purchase Order  Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Be Rec Qty"; Rec."To Be Rec Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pending By"; Rec."Pending By")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152014)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                ShowCaption = false;
                fixed(Control1102152013)
                {
                    ShowCaption = false;
                    group(Control1102152012)
                    {
                        ShowCaption = false;
                        field("TotalItems+FORMAT(COUNT)"; TotalItems + FORMAT(Rec.COUNT))
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152036)
                    {
                        ShowCaption = false;
                        field(LeadTimeColorText; LeadTimeColorText)
                        {
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152038)
                    {
                        ShowCaption = false;
                        field(ScheduleItemsText; ScheduleItemsText)
                        {
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152040)
                    {
                        ShowCaption = false;
                        field(PlndDispDateText; PlndDispDateText)
                        {
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102152042; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1102152041; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Lines")
            {
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    POAutomation.Get_BOI_Lines;
                end;
            }
            action("Show Spec")
            {
                Image = ShowSelected;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SCh2: Record Schedule2;
                    S_LineNo: Text;
                    loopbreak: Boolean;
                    SCh2Filter: Record Schedule2;
                    S_LineNoCode: Integer;
                    LoopCount: Integer;
                begin
                    LoopCount := 0;
                    loopbreak := FALSE;
                    S_LineNo := '';
                    SCh2.RESET;
                    SCh2.SETRANGE(SCh2."Document No.", Rec."Document No");
                    SCh2.SETRANGE(SCh2."Document Line No.", Rec."Line No");
                    IF SCh2.FINDSET THEN BEGIN
                        LoopCount := SCh2.COUNT;
                        REPEAT
                            IF (SCh2."Line No." >= Rec."Schedule Line No") THEN BEGIN
                                IF (SCh2."Document Line No." = SCh2."Line No.") OR (Rec."Schedule Line No" = SCh2."Line No.") THEN
                                    S_LineNo := S_LineNo + DELCHR(FORMAT(SCh2."Line No."), '=', ',') + '|'
                                ELSE
                                    IF SCh2."No." = '' THEN
                                        S_LineNo := S_LineNo + DELCHR(FORMAT(SCh2."Line No."), '=', ',') + '|'
                                    ELSE
                                        loopbreak := TRUE;
                            END;
                            LoopCount := LoopCount - 1;
                            IF LoopCount < 2 THEN
                                loopbreak := TRUE;
                        UNTIL (SCh2.NEXT = 0) OR (loopbreak = TRUE);
                    END;
                    IF STRLEN(S_LineNo) > 1 THEN
                        S_LineNo := COPYSTR(S_LineNo, 1, STRLEN(S_LineNo) - 1)
                    ELSE
                        IF Rec."Schedule Line No" > 0 THEN
                            S_LineNo := DELCHR(FORMAT(Rec."Schedule Line No"), '=', ',')
                        ELSE
                            S_LineNo := DELCHR(FORMAT(Rec."Line No"), '=', ',');
                    SCh2Filter.RESET;
                    SCh2Filter.SETRANGE(SCh2Filter."Document No.", Rec."Document No");
                    SCh2Filter.SETRANGE(SCh2Filter."Document Line No.", Rec."Line No");
                    SCh2Filter.SETFILTER(SCh2Filter."Line No.", S_LineNo);
                    IF SCh2Filter.FINDFIRST THEN
                        PAGE.RUN(60125, SCh2Filter);

                    //  SCh2.FILTERGROUP(2);

                    //  SCh2.FILTERGROUP(0);
                end;
            }
            action("Create Orders")
            {
                Ellipsis = false;
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ApplicationArea = All;

                trigger OnAction();
                var
                    TINVendors: Text;
                    BOIPlngGRec: Record "Sales Bought Out Material List";
                    Structure: Code[10];
                    Previous_Vendor: Code[20];
                    MinDate: Integer;
                    MaxDate: Integer;
                    Temp: Integer;
                    testvar: Integer;
                    "Count": Boolean;
                    Count1: Boolean;
                    BUFFER: Text[30];
                    Previous_Order: Code[30];
                    Previous_Item: Code[30];
                    Order_Qty: Decimal;
                    ItemsList: Text;
                    LoopCount: Integer;
                    SCh2: Record Schedule2;
                    S_LineNo: Text;
                    loopbreak: Boolean;
                    SCh2Filter: Record Schedule2;
                begin
                    IF USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\ANANDA', 'EFFTRONICS\PARDHU', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                        Rec.SETCURRENTKEY("Asign Vendor", "Document Type", "Document No", No, "Line No", "Schedule Line No");
                        Rec.SETFILTER("Asign Vendor", '<>%1', '');
                        IF Rec.FINDSET THEN
                            REPEAT
                                IF Previous_Vendor <> Rec."Asign Vendor" THEN BEGIN
                                    Previous_Vendor := Rec."Asign Vendor";
                                    Vendor.RESET;
                                    IF Vendor.GET(Rec."Asign Vendor") THEN BEGIN
                                        IF Vendor."Vendor Posting Group" = 'FOREIGN' THEN BEGIN
                                            CurrExchRate.RESET;
                                            CurrExchRate.SETRANGE(CurrExchRate."Currency Code", Vendor."Currency Code");
                                            IF CurrExchRate.FINDLAST THEN BEGIN
                                                IF CurrExchRate."Starting Date" < TODAY THEN BEGIN
                                                    ERROR('THERE IS NO CURRENCY EXCHANGE RATE FOR TODAY FOR CURRENCY: ' + CurrExchRate."Currency Code");
                                                END;
                                            END;
                                        END ELSE BEGIN
                                            /* IF (Vendor."T.I.N. No." = '') AND (Vendor."T.I.N Status" IN [Vendor."T.I.N Status"::" ", Vendor."T.I.N Status"::TINAPPLIED]) THEN
                                                 TINVendors := TINVendors + Vendor.Name + ', ';*/
                                        END;
                                    END;
                                END;
                            //IF To_Be_Purch_Qty = 0 THEN
                            //  ERROR('Please enter To Be Purchased Quanitity for '+Description+' in Order: '+"Document No"+'--'+FORMAT("Line No")+'--'+FORMAT("Schedule Line No"));
                            UNTIL Rec.NEXT = 0;
                        IF TINVendors <> '' THEN
                            ERROR('Please enter T.I.N Number in Vendor Card for :' + COPYSTR(TINVendors, 1, STRLEN(TINVendors) - 2) +
                                  'in Tax Information Tab!\IF TIN Not Applicable update TIN Status to TIN Invalid!');
                        Rec.SETCURRENTKEY(No);
                        Rec.SETFILTER("Asign Vendor", '<>%1', '');

                        IF Rec.FINDSET THEN
                            REPEAT
                                IF Previous_Item <> Rec.No THEN BEGIN
                                    Previous_Item := Rec.No;
                                    IF ItemGRec.GET(Rec.No) THEN BEGIN
                                        IF STRLEN(FORMAT(ItemGRec."Safety Lead Time")) = 0 THEN
                                            ItemsList := ItemsList + Rec.No + ', ';
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        IF ItemsList <> '' THEN
                            ERROR('There is no Safety Lead Time for following items: \' + COPYSTR(ItemsList, 1, STRLEN(ItemsList) - 2) + '\Please enter Safety Lead Time in Item card!');
                        Previous_Vendor := '';
                        Previous_Order := '';
                        Previous_Item := '';
                        "No. Of Order" := 0;
                        MinDate := 0;
                        MaxDate := 0;
                        Count := FALSE;
                        Count1 := FALSE;
                        Orders_List := '';
                        Rec.SETCURRENTKEY("Document Type", "Document No", "Asign Vendor", No, "Line No", "Schedule Line No");
                        Rec.SETFILTER("Asign Vendor", '<>%1', '');
                        Rec.SETFILTER(To_Be_Purch_Qty, '>%1', 0);
                        IF Rec.FINDSET THEN
                            REPEAT
                                IF (Previous_Order <> Rec."Document No") THEN BEGIN
                                    Previous_Order := Rec."Document No";
                                    Previous_Vendor := '';
                                    IF (Previous_Vendor <> Rec."Asign Vendor") THEN BEGIN
                                        Previous_Vendor := Rec."Asign Vendor";
                                        "No. Of Order" += 1;
                                        Vendor.RESET;
                                        IF Vendor.GET(Rec."Asign Vendor") THEN BEGIN
                                            //B2BUPG >>
                                            /*  IF Vendor.Structure <> '' THEN
                                                   Structure := Vendor.Structure
                                               ELSE BEGIN
                                                   CASE Vendor."Tax Area Code" OF
                                                       'PUCH CST':
                                                           Structure := 'PURC-CST';
                                                       'PUCH VAT':
                                                           Structure := 'PURC-VAT';
                                                   END;*/ //<<B2BUPG
                                        END;
                                        IF Vendor."Vendor Posting Group" = 'FOREIGN' THEN BEGIN
                                            //>>B2BUPG
                                            /* IF Vendor."Tax Area Code" <> '' THEN
                                                 Structure := Vendor."Tax Area Code"
                                             ELSE
                                                 Structure := Vendor.Structure;*/
                                            //<<B2BUPG
                                            CurrExchRate.RESET;
                                            CurrExchRate.SETRANGE(CurrExchRate."Currency Code", Vendor."Currency Code");
                                            IF CurrExchRate.FINDLAST THEN BEGIN
                                                IF CurrExchRate."Starting Date" < TODAY THEN
                                                    ERROR(' THERE IS NO CURRENCY EXCHANGE RATE FOR TODAY');
                                            END;
                                        END;
                                    END;

                                    PurchaseHeader.INIT;
                                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                                    PPSetup.GET;
                                    PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Order Nos.", WORKDATE, TRUE);
                                    //MESSAGE('purchase order no %1',PurchaseHeader."No.");
                                    Orders_List := Orders_List + PurchaseHeader."No." + ',';
                                    PurchaseHeader."Order Date" := TODAY;
                                    PurchaseHeader."Document Date" := TODAY;
                                    PurchaseHeader."Posting Date" := TODAY;
                                    PurchaseHeader."Buy-from Vendor No." := Rec."Asign Vendor";
                                    PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                                    PurchaseHeader."Sale Order No" := Rec."Document No";
                                    PurchaseHeader."Location Code" := 'STR';
                                    PurchaseHeader.VALIDATE("Location Code");
                                    PurchaseHeader."Shortcut Dimension 1 Code" := 'PRD-0010';
                                    PurchaseHeader."Packing Type" := 'STANDARD PACKING';
                                    // PurchaseHeader.Structure := Structure;
                                    PurchaseHeader.INSERT;

                                    PurchaseLine.INIT;
                                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                    PurchaseLine."Document No." := PurchaseHeader."No.";
                                    PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                    PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                    IF Rec.Type = Rec.Type::Item THEN
                                        PurchaseLine.Type := PurchaseLine.Type::Item
                                    ELSE
                                        IF Rec.Type = Rec.Type::"G/L Account" THEN
                                            PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                                        ELSE
                                            PurchaseLine.Type := PurchaseLine.Type::" ";
                                    PurchaseLine."No." := Rec.No;
                                    PurchaseLine.VALIDATE(PurchaseLine."No.");
                                    Previous_Item := Rec.No;
                                    PurchaseLine.Description := Rec.Description;
                                    MinDate := 0;
                                    MaxDate := 0;
                                    IF ItemGRec.GET(Rec.No) THEN BEGIN
                                        IF STRLEN(FORMAT(ItemGRec."Safety Lead Time")) > 0 THEN BEGIN
                                            BUFFER := '+' + FORMAT(ItemGRec."Safety Lead Time");
                                            PurchaseLine."Expected Receipt Date" := CALCDATE(BUFFER, TODAY);
                                            PurchaseLine."Deviated Receipt Date" := CALCDATE(BUFFER, TODAY);
                                            EVALUATE(Temp, COPYSTR(FORMAT(ItemGRec."Safety Lead Time"), 1, STRLEN(FORMAT(ItemGRec."Safety Lead Time")) - 1));
                                            MinDate := Temp;
                                            MaxDate := Temp;
                                        END;
                                    END;
                                    Order_Qty := Calc_Order_Qty(PurchaseLine."No.", Rec.To_Be_Purch_Qty);
                                    PurchaseLine.Quantity := Order_Qty;
                                    PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                    PurchaseLine."Location Code" := 'STR';
                                    PurchaseLine.VALIDATE("Location Code");
                                    PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                    PurchaseLine.INSERT;
                                    //PurchaseHeader.VALIDATE(PurchaseHeader.Structure); B2BUPG
                                    IF MinDate = 0 THEN
                                        MinDate := 3;
                                    IF PurchaseHeader."Requested Receipt Date" <> 0D THEN BEGIN
                                        IF PurchaseHeader."Requested Receipt Date" > (TODAY + (MinDate - 3)) THEN BEGIN
                                            PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                            PurchaseHeader.MODIFY;
                                        END;
                                    END ELSE BEGIN
                                        PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                        PurchaseHeader.MODIFY;
                                    END;
                                    IF PurchaseHeader."Expected Receipt Date" <> 0D THEN BEGIN
                                        IF PurchaseHeader."Expected Receipt Date" < (TODAY + MaxDate) THEN BEGIN
                                            PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                            PurchaseHeader.MODIFY;
                                        END;
                                    END ELSE BEGIN
                                        PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                        PurchaseHeader.MODIFY;
                                    END;
                                    // Start--Checking for Spec existance and inserting in PO
                                    LoopCount := 0;
                                    loopbreak := FALSE;
                                    S_LineNo := '';
                                    SCh2.RESET;
                                    SCh2.SETRANGE(SCh2."Document No.", Rec."Document No");
                                    SCh2.SETRANGE(SCh2."Document Line No.", Rec."Line No");
                                    IF SCh2.FINDSET THEN BEGIN
                                        LoopCount := SCh2.COUNT;
                                        REPEAT
                                            IF (SCh2."Line No." > Rec."Schedule Line No") THEN BEGIN
                                                IF SCh2."No." = '' THEN
                                                    S_LineNo := S_LineNo + DELCHR(FORMAT(SCh2."Line No."), '=', ',') + '|'
                                                ELSE
                                                    IF (SCh2."Document Line No." = SCh2."Line No.") OR (Rec."Schedule Line No" = SCh2."Line No.") THEN BEGIN
                                                    END ELSE
                                                        loopbreak := TRUE;
                                            END;
                                            LoopCount := LoopCount - 1;
                                            IF LoopCount < 2 THEN
                                                loopbreak := TRUE;
                                        UNTIL (SCh2.NEXT = 0) OR (loopbreak = TRUE);
                                    END;
                                    IF STRLEN(S_LineNo) > 1 THEN BEGIN
                                        S_LineNo := COPYSTR(S_LineNo, 1, STRLEN(S_LineNo) - 1);
                                        SCh2Filter.RESET;
                                        SCh2Filter.SETRANGE(SCh2Filter."Document No.", Rec."Document No");
                                        SCh2Filter.SETRANGE(SCh2Filter."Document Line No.", Rec."Line No");
                                        SCh2Filter.SETFILTER(SCh2Filter."Line No.", S_LineNo);
                                        IF SCh2Filter.FINDFIRST THEN
                                            REPEAT
                                                PurchaseLine.INIT;
                                                PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                                PurchaseLine."Document No." := PurchaseHeader."No.";
                                                PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                                PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                                PurchaseLine.Type := PurchaseLine.Type::" ";
                                                PurchaseLine.Description := SCh2Filter.Description;
                                                PurchaseLine."Location Code" := 'STR';
                                                PurchaseLine.VALIDATE("Location Code");
                                                PurchaseLine.INSERT;
                                            UNTIL SCh2Filter.NEXT = 0;
                                    END;
                                    // End--Checking for Spec existance and inserting in PO

                                END
                                ELSE BEGIN   // if Same Sale Order No.
                                    IF (Previous_Vendor <> Rec."Asign Vendor") THEN // if vendor changed
                                    BEGIN
                                        Previous_Vendor := Rec."Asign Vendor";
                                        "No. Of Order" += 1;
                                        Vendor.RESET;
                                        IF Vendor.GET(Rec."Asign Vendor") THEN BEGIN
                                            // >>B2BUPG
                                            /*  IF Vendor.Structure <> '' THEN
                                                  Structure := Vendor.Structure
                                              ELSE BEGIN
                                                  CASE Vendor."Tax Area Code" OF
                                                      'PUCH CST':
                                                          Structure := 'PURC-CST';
                                                      'PUCH VAT':
                                                          Structure := 'PURC-VAT';
                                                  END;
                                              END;*/ //<<B2BUPG
                                            IF Vendor."Vendor Posting Group" = 'FOREIGN' THEN BEGIN
                                                IF Vendor."Tax Area Code" <> '' THEN
                                                    Structure := Vendor."Tax Area Code"
                                                ELSE
                                                    //  Structure := Vendor.Structure;  B2BUPG
                                                    CurrExchRate.RESET;
                                                CurrExchRate.SETRANGE(CurrExchRate."Currency Code", Vendor."Currency Code");
                                                IF CurrExchRate.FINDLAST THEN BEGIN
                                                    IF CurrExchRate."Starting Date" < TODAY THEN
                                                        ERROR(' THERE IS NO CURRENCY EXCHANGE RATE FOR TODAY');
                                                END;
                                            END;
                                        END;

                                        PurchaseHeader.INIT;
                                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                                        PPSetup.GET;
                                        PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Order Nos.", WORKDATE, TRUE);
                                        //MESSAGE('purchase order no %1',PurchaseHeader."No.");
                                        Orders_List := Orders_List + PurchaseHeader."No." + ',';
                                        PurchaseHeader."Order Date" := TODAY;
                                        PurchaseHeader."Document Date" := TODAY;
                                        PurchaseHeader."Posting Date" := TODAY;
                                        PurchaseHeader."Buy-from Vendor No." := Rec."Asign Vendor";
                                        PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                                        PurchaseHeader."Sale Order No" := Rec."Document No";
                                        PurchaseHeader."Location Code" := 'STR';
                                        PurchaseHeader.VALIDATE("Location Code");
                                        PurchaseHeader."Shortcut Dimension 1 Code" := 'PRD-0010';
                                        PurchaseHeader."Packing Type" := 'STANDARD PACKING';
                                        //  PurchaseHeader.Structure := Structure;  B2BUPG
                                        PurchaseHeader.INSERT;

                                        PurchaseLine.INIT;
                                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                        PurchaseLine."Document No." := PurchaseHeader."No.";
                                        PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                        PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                        IF Rec.Type = Rec.Type::Item THEN
                                            PurchaseLine.Type := PurchaseLine.Type::Item
                                        ELSE
                                            IF Rec.Type = Rec.Type::"G/L Account" THEN
                                                PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                                            ELSE
                                                PurchaseLine.Type := PurchaseLine.Type::" ";
                                        PurchaseLine."No." := Rec.No;
                                        PurchaseLine.VALIDATE(PurchaseLine."No.");
                                        Previous_Item := Rec.No;
                                        PurchaseLine.Description := Rec.Description;
                                        MinDate := 0;
                                        MaxDate := 0;
                                        IF ItemGRec.GET(Rec.No) THEN BEGIN
                                            IF STRLEN(FORMAT(ItemGRec."Safety Lead Time")) > 0 THEN BEGIN
                                                BUFFER := '+' + FORMAT(ItemGRec."Safety Lead Time");
                                                PurchaseLine."Expected Receipt Date" := CALCDATE(BUFFER, TODAY);
                                                PurchaseLine."Deviated Receipt Date" := CALCDATE(BUFFER, TODAY);
                                                EVALUATE(Temp, COPYSTR(FORMAT(ItemGRec."Safety Lead Time"), 1, STRLEN(FORMAT(ItemGRec."Safety Lead Time")) - 1));
                                                MinDate := Temp;
                                                MaxDate := Temp;
                                            END;
                                        END;
                                        Order_Qty := Calc_Order_Qty(PurchaseLine."No.", Rec.To_Be_Purch_Qty);
                                        PurchaseLine.Quantity := Order_Qty;
                                        PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                        PurchaseLine."Location Code" := 'STR';
                                        PurchaseLine.VALIDATE("Location Code");
                                        PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                        PurchaseLine.INSERT;
                                        //PurchaseHeader.VALIDATE(PurchaseHeader.Structure);
                                        IF MinDate = 0 THEN
                                            MinDate := 3;
                                        IF PurchaseHeader."Requested Receipt Date" <> 0D THEN BEGIN
                                            IF PurchaseHeader."Requested Receipt Date" > (TODAY + (MinDate - 3)) THEN BEGIN
                                                PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                                PurchaseHeader.MODIFY;
                                            END;
                                        END ELSE BEGIN
                                            PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                            PurchaseHeader.MODIFY;
                                        END;
                                        IF PurchaseHeader."Expected Receipt Date" <> 0D THEN BEGIN
                                            IF PurchaseHeader."Expected Receipt Date" < (TODAY + MaxDate) THEN BEGIN
                                                PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                                PurchaseHeader.MODIFY;
                                            END;
                                        END ELSE BEGIN
                                            PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                            PurchaseHeader.MODIFY;
                                        END;
                                        // Start--Checking for Spec existance and inserting in PO
                                        LoopCount := 0;
                                        loopbreak := FALSE;
                                        S_LineNo := '';
                                        SCh2.RESET;
                                        SCh2.SETRANGE(SCh2."Document No.", Rec."Document No");
                                        SCh2.SETRANGE(SCh2."Document Line No.", Rec."Line No");
                                        IF SCh2.FINDSET THEN BEGIN
                                            LoopCount := SCh2.COUNT;
                                            REPEAT
                                                IF (SCh2."Line No." > Rec."Schedule Line No") THEN BEGIN
                                                    IF SCh2."No." = '' THEN
                                                        S_LineNo := S_LineNo + DELCHR(FORMAT(SCh2."Line No."), '=', ',') + '|'
                                                    ELSE
                                                        IF (SCh2."Document Line No." = SCh2."Line No.") OR (Rec."Schedule Line No" = SCh2."Line No.") THEN BEGIN
                                                        END ELSE
                                                            loopbreak := TRUE;
                                                END;
                                                LoopCount := LoopCount - 1;
                                                IF LoopCount < 2 THEN
                                                    loopbreak := TRUE;
                                            UNTIL (SCh2.NEXT = 0) OR (loopbreak = TRUE);
                                        END;
                                        IF STRLEN(S_LineNo) > 1 THEN BEGIN
                                            S_LineNo := COPYSTR(S_LineNo, 1, STRLEN(S_LineNo) - 1);
                                            SCh2Filter.RESET;
                                            SCh2Filter.SETRANGE(SCh2Filter."Document No.", Rec."Document No");
                                            SCh2Filter.SETRANGE(SCh2Filter."Document Line No.", Rec."Line No");
                                            SCh2Filter.SETFILTER(SCh2Filter."Line No.", S_LineNo);
                                            IF SCh2Filter.FINDFIRST THEN
                                                REPEAT
                                                    PurchaseLine.INIT;
                                                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                                    PurchaseLine."Document No." := PurchaseHeader."No.";
                                                    PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                                    PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                                    PurchaseLine.Type := PurchaseLine.Type::" ";
                                                    PurchaseLine.Description := SCh2Filter.Description;
                                                    PurchaseLine."Location Code" := 'STR';
                                                    PurchaseLine.VALIDATE("Location Code");
                                                    PurchaseLine.INSERT;
                                                UNTIL SCh2Filter.NEXT = 0;
                                        END;
                                        // End--Checking for Spec existance and inserting in PO
                                    END
                                    ELSE BEGIN    // Same Order and Same Vendor
                                        IF Previous_Item <> Rec.No THEN BEGIN
                                            Previous_Item := Rec.No;
                                            PurchaseLine.INIT;
                                            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                            PurchaseLine."Document No." := PurchaseHeader."No.";
                                            PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                            PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                            IF Rec.Type = Rec.Type::Item THEN
                                                PurchaseLine.Type := PurchaseLine.Type::Item
                                            ELSE
                                                IF Rec.Type = Rec.Type::"G/L Account" THEN
                                                    PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                                                ELSE
                                                    PurchaseLine.Type := PurchaseLine.Type::" ";
                                            PurchaseLine."No." := Rec.No;
                                            PurchaseLine.VALIDATE(PurchaseLine."No.");
                                            Previous_Item := Rec.No;
                                            PurchaseLine.Description := Rec.Description;
                                            MinDate := 0;
                                            MaxDate := 0;
                                            IF ItemGRec.GET(Rec.No) THEN BEGIN
                                                IF STRLEN(FORMAT(ItemGRec."Safety Lead Time")) > 0 THEN BEGIN
                                                    BUFFER := '+' + FORMAT(ItemGRec."Safety Lead Time");
                                                    PurchaseLine."Expected Receipt Date" := CALCDATE(BUFFER, TODAY);
                                                    PurchaseLine."Deviated Receipt Date" := CALCDATE(BUFFER, TODAY);
                                                    EVALUATE(Temp, COPYSTR(FORMAT(ItemGRec."Safety Lead Time"), 1, STRLEN(FORMAT(ItemGRec."Safety Lead Time")) - 1));
                                                    MinDate := Temp;
                                                    MaxDate := Temp;
                                                END;
                                            END;
                                            Order_Qty := Calc_Order_Qty(PurchaseLine."No.", Rec.To_Be_Purch_Qty);
                                            PurchaseLine.Quantity := Order_Qty;
                                            PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                            PurchaseLine."Location Code" := 'STR';
                                            PurchaseLine.VALIDATE("Location Code");
                                            PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                            PurchaseLine.INSERT;
                                            //PurchaseHeader.VALIDATE(PurchaseHeader.Structure); B2B UPG
                                            IF MinDate = 0 THEN
                                                MinDate := 3;
                                            IF PurchaseHeader."Requested Receipt Date" <> 0D THEN BEGIN
                                                IF PurchaseHeader."Requested Receipt Date" > (TODAY + (MinDate - 3)) THEN BEGIN
                                                    PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                                    PurchaseHeader.MODIFY;
                                                END;
                                            END ELSE BEGIN
                                                PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                                PurchaseHeader.MODIFY;
                                            END;
                                            IF PurchaseHeader."Expected Receipt Date" <> 0D THEN BEGIN
                                                IF PurchaseHeader."Expected Receipt Date" < (TODAY + MaxDate) THEN BEGIN
                                                    PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                                    PurchaseHeader.MODIFY;
                                                END;
                                            END ELSE BEGIN
                                                PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                                PurchaseHeader.MODIFY;
                                            END;
                                            // Start--Checking for Spec existance and inserting in PO
                                            LoopCount := 0;
                                            loopbreak := FALSE;
                                            S_LineNo := '';
                                            SCh2.RESET;
                                            SCh2.SETRANGE(SCh2."Document No.", Rec."Document No");
                                            SCh2.SETRANGE(SCh2."Document Line No.", Rec."Line No");
                                            IF SCh2.FINDSET THEN BEGIN
                                                LoopCount := SCh2.COUNT;
                                                REPEAT
                                                    IF (SCh2."Line No." > Rec."Schedule Line No") THEN BEGIN
                                                        IF SCh2."No." = '' THEN
                                                            S_LineNo := S_LineNo + DELCHR(FORMAT(SCh2."Line No."), '=', ',') + '|'
                                                        ELSE
                                                            IF (SCh2."Document Line No." = SCh2."Line No.") OR (Rec."Schedule Line No" = SCh2."Line No.") THEN BEGIN
                                                            END ELSE
                                                                loopbreak := TRUE;
                                                    END;
                                                    LoopCount := LoopCount - 1;
                                                    IF LoopCount < 2 THEN
                                                        loopbreak := TRUE;
                                                UNTIL (SCh2.NEXT = 0) OR (loopbreak = TRUE);
                                            END;
                                            IF STRLEN(S_LineNo) > 1 THEN BEGIN
                                                S_LineNo := COPYSTR(S_LineNo, 1, STRLEN(S_LineNo) - 1);
                                                SCh2Filter.RESET;
                                                SCh2Filter.SETRANGE(SCh2Filter."Document No.", Rec."Document No");
                                                SCh2Filter.SETRANGE(SCh2Filter."Document Line No.", Rec."Line No");
                                                SCh2Filter.SETFILTER(SCh2Filter."Line No.", S_LineNo);
                                                IF SCh2Filter.FINDFIRST THEN
                                                    REPEAT
                                                        PurchaseLine.INIT;
                                                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                                        PurchaseLine."Document No." := PurchaseHeader."No.";
                                                        PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                                        PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                                        PurchaseLine.Type := PurchaseLine.Type::" ";
                                                        PurchaseLine.Description := SCh2Filter.Description;
                                                        PurchaseLine."Location Code" := 'STR';
                                                        PurchaseLine.VALIDATE("Location Code");
                                                        PurchaseLine.INSERT;
                                                    UNTIL SCh2Filter.NEXT = 0;
                                            END;
                                            // End--Checking for Spec existance and inserting in PO
                                        END
                                        ELSE BEGIN
                                            // Start--Checking for Spec existance and inserting in PO
                                            LoopCount := 0;
                                            loopbreak := FALSE;
                                            S_LineNo := '';
                                            SCh2.RESET;
                                            SCh2.SETRANGE(SCh2."Document No.", Rec."Document No");
                                            SCh2.SETRANGE(SCh2."Document Line No.", Rec."Line No");
                                            IF SCh2.FINDSET THEN BEGIN
                                                LoopCount := SCh2.COUNT;
                                                REPEAT
                                                    IF (SCh2."Line No." > Rec."Schedule Line No") THEN BEGIN
                                                        IF SCh2."No." = '' THEN
                                                            S_LineNo := S_LineNo + DELCHR(FORMAT(SCh2."Line No."), '=', ',') + '|'
                                                        ELSE
                                                            loopbreak := TRUE;
                                                    END;
                                                    LoopCount := LoopCount - 1;
                                                    IF LoopCount < 2 THEN
                                                        loopbreak := TRUE;
                                                UNTIL (SCh2.NEXT = 0) OR (loopbreak = TRUE);
                                            END;
                                            IF STRLEN(S_LineNo) > 1 THEN BEGIN
                                                Previous_Item := Rec.No;
                                                PurchaseLine.INIT;
                                                PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                                PurchaseLine."Document No." := PurchaseHeader."No.";
                                                PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                                PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                                IF Rec.Type = Rec.Type::Item THEN
                                                    PurchaseLine.Type := PurchaseLine.Type::Item
                                                ELSE
                                                    IF Rec.Type = Rec.Type::"G/L Account" THEN
                                                        PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                                                    ELSE
                                                        PurchaseLine.Type := PurchaseLine.Type::" ";
                                                PurchaseLine."No." := Rec.No;
                                                PurchaseLine.VALIDATE(PurchaseLine."No.");
                                                Previous_Item := Rec.No;
                                                PurchaseLine.Description := Rec.Description;
                                                MinDate := 0;
                                                MaxDate := 0;
                                                IF ItemGRec.GET(Rec.No) THEN BEGIN
                                                    IF STRLEN(FORMAT(ItemGRec."Safety Lead Time")) > 0 THEN BEGIN
                                                        BUFFER := '+' + FORMAT(ItemGRec."Safety Lead Time");
                                                        PurchaseLine."Expected Receipt Date" := CALCDATE(BUFFER, TODAY);
                                                        PurchaseLine."Deviated Receipt Date" := CALCDATE(BUFFER, TODAY);
                                                        EVALUATE(Temp, COPYSTR(FORMAT(ItemGRec."Safety Lead Time"), 1, STRLEN(FORMAT(ItemGRec."Safety Lead Time")) - 1));
                                                        MinDate := Temp;
                                                        MaxDate := Temp;
                                                    END;
                                                END;
                                                Order_Qty := Calc_Order_Qty(PurchaseLine."No.", Rec.To_Be_Purch_Qty);
                                                PurchaseLine.Quantity := Order_Qty;
                                                PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                                PurchaseLine."Location Code" := 'STR';
                                                PurchaseLine.VALIDATE("Location Code");
                                                PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                                                PurchaseLine.INSERT;
                                                // PurchaseHeader.VALIDATE(PurchaseHeader.Structure); B2BUPG
                                                IF MinDate = 0 THEN
                                                    MinDate := 3;
                                                IF PurchaseHeader."Requested Receipt Date" <> 0D THEN BEGIN
                                                    IF PurchaseHeader."Requested Receipt Date" > (TODAY + (MinDate - 3)) THEN BEGIN
                                                        PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                                        PurchaseHeader.MODIFY;
                                                    END;
                                                END ELSE BEGIN
                                                    PurchaseHeader."Requested Receipt Date" := TODAY + (MinDate - 3);
                                                    PurchaseHeader.MODIFY;
                                                END;
                                                IF PurchaseHeader."Expected Receipt Date" <> 0D THEN BEGIN
                                                    IF PurchaseHeader."Expected Receipt Date" < (TODAY + MaxDate) THEN BEGIN
                                                        PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                                        PurchaseHeader.MODIFY;
                                                    END;
                                                END ELSE BEGIN
                                                    PurchaseHeader."Expected Receipt Date" := TODAY + MaxDate;
                                                    PurchaseHeader.MODIFY;
                                                END;
                                                S_LineNo := COPYSTR(S_LineNo, 1, STRLEN(S_LineNo) - 1);
                                                SCh2Filter.RESET;
                                                SCh2Filter.SETRANGE(SCh2Filter."Document No.", Rec."Document No");
                                                SCh2Filter.SETRANGE(SCh2Filter."Document Line No.", Rec."Line No");
                                                SCh2Filter.SETFILTER(SCh2Filter."Line No.", S_LineNo);
                                                IF SCh2Filter.FINDFIRST THEN
                                                    REPEAT
                                                        PurchaseLine.INIT;
                                                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                                                        PurchaseLine."Document No." := PurchaseHeader."No.";
                                                        PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                                                        PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                                        PurchaseLine.Type := PurchaseLine.Type::" ";
                                                        PurchaseLine.Description := SCh2Filter.Description;
                                                        PurchaseLine."Location Code" := 'STR';
                                                        PurchaseLine.VALIDATE("Location Code");
                                                        PurchaseLine.INSERT;
                                                    UNTIL SCh2Filter.NEXT = 0;
                                                // End--Checking for Spec existance and inserting in PO
                                            END
                                            ELSE BEGIN
                                                Order_Qty := Calc_Order_Qty(PurchaseLine."No.", Rec.To_Be_Purch_Qty);
                                                PurchaseLine.Quantity := PurchaseLine.Quantity + Order_Qty;
                                                PurchaseLine.MODIFY;
                                                //PurchaseHeader.VALIDATE(PurchaseHeader.Structure);
                                            END;
                                        END;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        IF STRLEN(Orders_List) > 0 THEN
                            Orders_List := COPYSTR(Orders_List, 1, STRLEN(Orders_List) - 1);
                        Rec.SETCURRENTKEY("Document Type", "Document No", "Asign Vendor", No, "Line No", "Schedule Line No");
                        Rec.SETFILTER("Asign Vendor", '<>%1', '');
                        Rec.SETFILTER(To_Be_Purch_Qty, '>%1', 0);
                        IF Rec.FINDSET THEN
                            REPEAT
                                Rec."Asign Vendor" := '';
                                Rec.To_Be_Purch_Qty := 0;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        Rec.RESET;
                        CurrPage.UPDATE;
                        IF Orders_List <> '' THEN
                            MESSAGE('Following Purchase Orders are Created: \' + Orders_List);
                    END ELSE
                        ERROR('You do not have rights for Planning!');

                END;


            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        LeadTimeColor := FALSE;
        ScheduleItemsColor := FALSE;
        PlndDispDateColor := FALSE;
        IF ItemGRec.GET(Rec.No) THEN
            IF STRLEN(FORMAT(ItemGRec."Safety Lead Time")) <= 0 THEN
                LeadTimeColor := TRUE;
        IF Rec."Schedule Line No" <> 0 THEN
            ScheduleItemsColor := TRUE;
        IF Rec."Planned Dispatch Date" = 0D THEN
            PlndDispDateColor := TRUE;
    end;

    trigger OnOpenPage();
    begin
        Rec.RESET;
        Rec.SETFILTER(No, '<>%1&<>%2', 'ECBOUBT00004', 'BOICHAR00014');
    end;

    var
        POAutomation: Codeunit "PO Automation";
        SalesLin: Record "Sales Line";
        SchdlLin: Record Schedule2;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ItemGRec: Record Item;
        GLAccntGRec: Record "G/L Account";
        CurrExchRate: Record "Currency Exchange Rate";
        Vendor: Record Vendor;
        "No. Of Order": Integer;
        PPSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit 396;
        MOQ_Temp: Decimal;
        Orders_List: Text;
        LeadTimeColor: Boolean;
        ScheduleItemsText: Label 'Schedule Line Items';
        ScheduleItemsColor: Boolean;
        PlndDispDateColor: Boolean;
        PlndDispDateText: Label 'No Plan Date';
        LeadTimeColorText: Label 'Items Dont Have Lead Time';
        TotalItems: Label '"Total : "';
        SHowBattNChargr: Boolean;


    procedure Calc_Order_Qty(ItemNo: Code[30]; Quantity: Decimal) Order_Qty: Decimal;
    var
        ITEM: Record Item;
        MOQ_Temp: Decimal;
    begin
        //Added by Pranavi to reset the order quantity.this effects when MOQ,EFF_MOQ,SPQ not defined in item card.
        Order_Qty := Quantity;
        IF ITEM.GET(ItemNo) THEN BEGIN
            IF ITEM.EFF_MOQ > 0 THEN
                MOQ_Temp := ITEM.EFF_MOQ
            ELSE
                MOQ_Temp := ITEM."Minimum Order Quantity";

            IF (MOQ_Temp > 0) AND (ITEM."Standard Packing Quantity" = 0) THEN BEGIN
                IF MOQ_Temp > 1 THEN BEGIN
                    IF Quantity < MOQ_Temp THEN
                        Order_Qty := MOQ_Temp
                    ELSE
                        Order_Qty := Quantity;
                END ELSE BEGIN
                    Order_Qty := Quantity;
                END;
            END ELSE
                IF (MOQ_Temp > 0) AND (ITEM."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                    IF MOQ_Temp > 1 THEN BEGIN
                        IF Quantity < MOQ_Temp THEN
                            Order_Qty := MOQ_Temp
                        ELSE BEGIN
                            IF MOQ_Temp = 1 THEN
                                Order_Qty := (Quantity DIV ITEM."Standard Packing Quantity") * ITEM."Standard Packing Quantity"
                            ELSE
                                Order_Qty := ((Quantity DIV ITEM."Standard Packing Quantity") + 1) * ITEM."Standard Packing Quantity"
                        END;
                    END ELSE
                        Order_Qty := Quantity;
                END ELSE
                    IF (MOQ_Temp > 0) AND (ITEM."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                        IF MOQ_Temp > 1 THEN BEGIN
                            IF Quantity < MOQ_Temp THEN
                                Order_Qty := MOQ_Temp
                            ELSE
                                Order_Qty := ((Quantity DIV MOQ_Temp) + 1) * MOQ_Temp
                        END ELSE
                            Order_Qty := Quantity;

                    END ELSE
                        IF (MOQ_Temp = 0) AND (ITEM."Standard Packing Quantity" > 0) THEN BEGIN
                            IF Quantity < ITEM."Standard Packing Quantity" THEN
                                Order_Qty := ITEM."Standard Packing Quantity"
                            ELSE
                                Order_Qty := ((Quantity DIV ITEM."Standard Packing Quantity") + 1) * ITEM."Standard Packing Quantity"
                        END;
        END;
    end;
}

