page 60136 "Quotation Comparision"
{
    // version POAU

    PageType = Worksheet;
    SourceTable = "Quotation Comparision";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(RFQNumber; RFQNumber)
            {
                // TableRelation= "Mech & Wirning Items"."Production Order No." WHERE (Quantity=CONST(false));//EFFUPG
                ApplicationArea = All;


                trigger OnValidate();
                begin
                    RFQNumberOnAfterValidate;
                end;
            }
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(ActualExpansionStatus; ActualExpansionStatus)
                {
                    Caption = 'Expand';
                    Editable = false;

                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ActualExpansionStatusOnPush;
                    end;
                }
                field("ICN No."; Rec."ICN No.")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Code"; Rec."Manufacturer Code")
                {
                    ApplicationArea = All;
                }
                field("Carry Out Action"; Rec."Carry Out Action")
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field("Amt. including Tax"; Rec."Amt. including Tax")
                {
                    BlankNumbers = BlankZero;
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field(Delivery; Rec.Delivery)
                {
                    ApplicationArea = All;
                }
                field(Quality; Rec.Quality)
                {
                    ApplicationArea = All;
                }
                field(Rating; Rec.Rating)
                {
                    BlankNumbers = BlankZero;
                    ApplicationArea = All;
                }
                field("Payment Term Code"; Rec."Payment Term Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    BlankNumbers = BlankZero;
                    ApplicationArea = All;
                }
                field("Total Weightage"; Rec."Total Weightage")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ApplicationArea = All;
                }
            }
            field(Control1102152050; '')
            {
                CaptionClass = Text19068734;
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Calculate Plan")
                {
                    Caption = '&Calculate Plan';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        POAutomation.InsertQuotationLines(RFQNumber);
                        QuoteCompare.RESET;
                        CurrPage.UPDATE(FALSE);

                        InitTempTable;
                        SetRecFilters;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(Action1102152011)
                {
                }
                action("C&arryout Action")
                {
                    Caption = 'C&arryout Action';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //REPORT.RUN(50057);
                        REPORT.RUN(50066);
                        QuotationComparisionDelete.DELETEALL;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    RunObject = Page "PCB Vendors List";
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group("E&xpand")
            {
                Caption = 'E&xpand';
                action("E&xpand All")
                {
                    Caption = 'E&xpand All';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ExpandAll;
                    end;
                }
                action("C&ollapse All")
                {
                    Caption = 'C&ollapse All';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InitTempTable;
                    end;
                }
                separator(Action1102152039)
                {
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Quotation Comparision")
                {
                    Caption = 'Quotation Comparision';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ReqLine.RESET;
                        //ReqLine.SETRANGE("Line No.","Line No.");
                        ReqLine.SETRANGE("RFQ No.", RFQNumber);
                        REPORT.RUN(50058, TRUE, FALSE, ReqLine);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        SetExpansionStatus;
        OnAfterGetCurrRecord;
        QuoteNoOnFormat;
        LocationCodeOnFormat;
        VendorNoOnFormat;
        TotalAmountOnFormat;
        DescriptionOnFormat;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        TempReqLine := Rec;

        WHILE (TempReqLine.NEXT <> 0) AND (TempReqLine.Level > Rec.Level) DO
            TempReqLine.DELETE(TRUE);
        TempReqLine := Rec;
        EXIT(TempReqLine.DELETE);
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    var
        Found: Boolean;
    begin
        TempReqLine.COPY(Rec);
        Found := TempReqLine.FIND(Which);
        Rec := TempReqLine;
        EXIT(Found);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Rec.MODIFY(TRUE);
        TempReqLine := Rec;
        IF Rec."Line No." <> 0 THEN
            TempReqLine.MODIFY;
        EXIT(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        ResultSteps: Integer;
    begin
        TempReqLine.COPY(Rec);
        ResultSteps := TempReqLine.NEXT(Steps);
        Rec := TempReqLine;
        EXIT(ResultSteps);
    end;

    trigger OnOpenPage();
    begin
        RFQNumber := Rec."RFQ No.";
        IF RFQNumber <> '' THEN
            IF NOT RFQNumbers.GET(RFQNumber) THEN
                RFQNumber := '';

        IF RFQNumber = '' THEN BEGIN
            RFQNumbers.SETRANGE(Quantity, Rec.Discount);
            IF RFQNumbers.FINDFIRST THEN
                RFQNumber := RFQNumbers."Production Order No."
            ELSE
                RFQNumber := '';
        END;
        SelectCurrentRFQNo;

        InitTempTable;
        SetRecFilters;
        CurrPage.UPDATE(FALSE);
    end;

    var
        ActualExpansionStatus: Integer;
        ReqLine: Record "Quotation Comparision";
        TempReqLine: Record "Quotation Comparision" temporary;
        RFQNumber: Code[20];
        RFQNumbers: Record "Mech & Wirning Items";
        QuoteCompare: Record "Quotation Comparision";
        QuotationComparision: Record "Quotation Comparision";
        QuotationComparisionDelete: Record "Quotation Comparision";
        POAutomation: Codeunit "PO Automation";

        "Quote No.Emphasize": Boolean;

        "Location CodeEmphasize": Boolean;

        "Vendor No.Emphasize": Boolean;

        "Total AmountEmphasize": Boolean;

        DescriptionEmphasize: Boolean;
        Text19068734: Label 'RFQ No.';


    local procedure IsExpanded(ActualReqLine: Record "Quotation Comparision"): Boolean;
    begin
        TempReqLine := ActualReqLine;
        IF TempReqLine.NEXT = 0 THEN
            EXIT(FALSE);
        EXIT(TempReqLine.Level > ActualReqLine.Level);
    end;


    local procedure ToggleExpandCollapse();
    var
        ReqLine: Record "Quotation Comparision";
    begin
        IF ActualExpansionStatus = 0 THEN BEGIN // Has children, but not expanded
            ReqLine.SETRANGE(Level, Rec.Level, Rec.Level + 1);
            ReqLine := Rec;
            IF ReqLine.NEXT <> 0 THEN
                REPEAT
                    IF ReqLine.Level > Rec.Level THEN BEGIN
                        TempReqLine := ReqLine;
                        IF TempReqLine.INSERT THEN;
                    END;
                UNTIL (ReqLine.NEXT = 0) OR (ReqLine.Level = Rec.Level);
        END ELSE
            IF ActualExpansionStatus = 1 THEN BEGIN // Has children and is already expanded
                TempReqLine := Rec;
                WHILE (TempReqLine.NEXT <> 0) AND (TempReqLine.Level > Rec.Level) DO
                    TempReqLine.DELETE;
            END;
        CurrPage.UPDATE;
    end;


    procedure SetExpansionStatus();
    begin
        CASE TRUE OF
            IsExpanded(Rec):
                ActualExpansionStatus := 1;
            Rec.Level = 0:
                ActualExpansionStatus := 0
            ELSE
                ActualExpansionStatus := 2;
        END;
    end;


    procedure InitTempTable();
    begin
        ReqLine.RESET;
        ReqLine.COPYFILTERS(TempReqLine);
        TempReqLine.DELETEALL;
        IF ReqLine.FINDSET THEN
            REPEAT
                IF ReqLine.Level = 0 THEN BEGIN
                    TempReqLine := ReqLine;
                    TempReqLine.INSERT;
                END;
            UNTIL ReqLine.NEXT = 0;
    end;


    local procedure ExpandAll();
    var
        ReqLine: Record "Quotation Comparision";
    begin
        ReqLine.RESET;
        ReqLine.COPYFILTERS(TempReqLine);
        TempReqLine.DELETEALL;

        IF ReqLine.FINDSET THEN
            REPEAT
                TempReqLine := ReqLine;
                TempReqLine.INSERT;
            UNTIL ReqLine.NEXT = 0;
    end;


    procedure SetRecFilters();
    begin
        Rec.RESET;
        Rec.FILTERGROUP(2);
        //SETRANGE(Level,0);
        Rec.FILTERGROUP(0);
        CurrPage.UPDATE(FALSE);
    end;


    local procedure SelectCurrentRFQNo();
    begin
        Rec.SETRANGE("RFQ No.", RFQNumber);
        CurrPage.UPDATE(FALSE);
    end;


    local procedure RFQNumberOnAfterValidate();
    begin
        SelectCurrentRFQNo;
    end;


    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        IF Rec.GET(Rec."Line No.") THEN BEGIN
            TempReqLine := Rec;
            IF Rec."Line No." <> 0 THEN
                TempReqLine.MODIFY
        END ELSE
            IF TempReqLine.GET(Rec."Line No.") THEN
                TempReqLine.DELETE;
    end;


    local procedure ActualExpansionStatusOnPush();
    begin
        ToggleExpandCollapse;
    end;


    local procedure QuoteNoOnFormat();
    begin
        IF Rec.Level = 0 THEN
            "Quote No.Emphasize" := TRUE
        ELSE
            "Quote No.Emphasize" := FALSE;
    end;


    local procedure LocationCodeOnFormat();
    begin
        IF Rec.Level = 0 THEN
            "Location CodeEmphasize" := TRUE
        ELSE
            "Location CodeEmphasize" := FALSE;
    end;


    local procedure VendorNoOnFormat();
    begin
        IF Rec.Level = 0 THEN
            "Vendor No.Emphasize" := TRUE
        ELSE
            "Vendor No.Emphasize" := FALSE;
    end;


    local procedure TotalAmountOnFormat();
    begin
        IF Rec.Level = 0 THEN
            "Total AmountEmphasize" := TRUE
        ELSE
            "Total AmountEmphasize" := FALSE;
    end;


    local procedure DescriptionOnFormat();
    begin
        IF Rec.Level = 0 THEN
            DescriptionEmphasize := TRUE
        ELSE
            DescriptionEmphasize := FALSE;
    end;
}

