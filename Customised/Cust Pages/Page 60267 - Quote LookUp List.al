page 60267 "Quote LookUp List"
{
    // version B2BQTO

    Caption = 'Quote LookUp List';
    PageType = Card;
    SourceTable = "Quote Lookup";
    SourceTableView = SORTING("Lookup Code") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Lookup Code"; Rec."Lookup Code")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type ID"; Rec."Lookup Type ID")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type Name"; Rec."Lookup Type Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field(FieldNo1; Rec.FieldNo1)
                {
                    ApplicationArea = All;
                }
                field(FieldNo2; Rec.FieldNo2)
                {
                    ApplicationArea = All;
                }
                field(FieldNo3; Rec.FieldNo3)
                {
                    ApplicationArea = All;
                }
                field(FieldNo4; Rec.FieldNo4)
                {
                    ApplicationArea = All;
                }
                field(FieldNo5; Rec.FieldNo5)
                {
                    ApplicationArea = All;
                }
                field(FieldNo6; Rec.FieldNo6)
                {
                    ApplicationArea = All;
                }
                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Terms LookUp"; Rec."Terms LookUp")
                {
                    ApplicationArea = All;
                }
                field("Schedule LookUp"; Rec."Schedule LookUp")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152008)
            {
                action(MarkAll)
                {
                    Caption = 'Mark All';
                    Image = Apply;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        Rec.MODIFYALL(Select, TRUE);
                    end;
                }
                action(UnMarkAll)
                {
                    Caption = 'UnMark All';
                    Image = UnApply;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.MODIFYALL(Select, FALSE);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.Select := FALSE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN

            IF CustNoGVar <> '' THEN BEGIN

                CustomerSpecification.RESET;
                CustomerSpecification.SETRANGE("Customer No.", CustNoGVar);
                IF CustomerSpecification.FINDLAST THEN
                    NoGvar := CustomerSpecification."No." + 1
                ELSE
                    NoGvar := 1;

                QuoteLookup.RESET;
                QuoteLookup.SETRANGE(Select, TRUE);
                IF QuoteLookup.FINDSET THEN
                    REPEAT
                        CustomerSpecification2.RESET;
                        CustomerSpecification2.SETRANGE("Lookup Type ID", QuoteLookup."Lookup Type ID");
                        CustomerSpecification2.SETFILTER("Lookup Code", '%1', QuoteLookup."Lookup Code");
                        CustomerSpecification2.SETRANGE("Customer No.", CustNoGVar);
                        IF NOT CustomerSpecification2.FINDFIRST THEN BEGIN
                            CustomerSpecification.INIT;
                            CustomerSpecification."No." := NoGvar;
                            CustomerSpecification."Lookup Code" := QuoteLookup."Lookup Code";
                            CustomerSpecification."Lookup Type ID" := QuoteLookup."Lookup Type ID";
                            CustomerSpecification."Lookup Type Name" := QuoteLookup."Lookup Type Name";
                            CustomerSpecification.Description := QuoteLookup.Description;
                            CustomerSpecification."Customer No." := CustNoGVar;
                            NoGvar += 1;
                            CustomerSpecification.INSERT;
                        END;
                        QuoteLookup.Select := FALSE;
                        QuoteLookup.MODIFY;
                    UNTIL QuoteLookup.NEXT = 0;
            END;

            IF SalesQuoteGVar <> '' THEN BEGIN
                SalesQuoteSpecification.RESET;
                SalesQuoteSpecification.SETRANGE("Sales Quote No.", SalesQuoteGVar);
                IF SalesQuoteSpecification.FINDLAST THEN
                    NumGVar := SalesQuoteSpecification."No." + 1
                ELSE
                    NumGVar := 1;

                QuoteLookup.RESET;
                QuoteLookup.SETRANGE(Select, TRUE);
                IF QuoteLookup.FINDSET THEN
                    REPEAT
                        SalesQuoteSpecification2.RESET;
                        SalesQuoteSpecification2.SETRANGE("Lookup Type ID", QuoteLookup."Lookup Type ID");
                        SalesQuoteSpecification2.SETFILTER("Lookup Code", '%1', QuoteLookup."Lookup Code");
                        SalesQuoteSpecification2.SETRANGE("Sales Quote No.", SalesQuoteGVar);
                        IF NOT SalesQuoteSpecification2.FINDFIRST THEN BEGIN
                            SalesQuoteSpecification.INIT;
                            SalesQuoteSpecification."No." := NumGVar;
                            SalesQuoteSpecification."Lookup Code" := QuoteLookup."Lookup Code";
                            SalesQuoteSpecification."Lookup Type ID" := QuoteLookup."Lookup Type ID";
                            SalesQuoteSpecification."Lookup Type Name" := QuoteLookup."Lookup Type Name";
                            SalesQuoteSpecification.Description := QuoteLookup.Description;
                            SalesQuoteSpecification."Sales Quote No." := SalesQuoteGVar;
                            NumGVar += 1;
                            SalesQuoteSpecification.INSERT;
                        END;
                        QuoteLookup.Select := FALSE;
                        QuoteLookup.MODIFY;
                    UNTIL QuoteLookup.NEXT = 0;
                SalesQuoteSpecification.RESET;
                SalesQuoteSpecification.SETRANGE("No.", 0);
                IF SalesQuoteSpecification.FINDFIRST THEN
                    SalesQuoteSpecification.DELETE;

            END;
        END;
        SalesQuoteSpecification.RESET;
        SalesQuoteSpecification.SETRANGE("No.", 0);
        IF SalesQuoteSpecification.FINDFIRST THEN
            SalesQuoteSpecification.DELETE;
    end;

    var
        QuoteLookup: Record "Quote Lookup";
        CustomerSpecification: Record "Customer Specification";
        NoGvar: Integer;
        CustomerSpecification2: Record "Customer Specification";
        PrevLookupCode: Code[20];
        CustNoGVar: Code[20];
        SalesQuoteGVar: Code[20];
        SalesQuoteSpecification: Record "Sales Quote Specification";
        SalesQuoteSpecification2: Record "Sales Quote Specification";
        NumGVar: Integer;

    procedure CarryCustomer(CustLPar: Code[20]);
    begin
        CustNoGVar := CustLPar;
    end;


    procedure CarrySalesQuoteNo(LSalQuote: Code[20]);
    begin
        SalesQuoteGVar := LSalQuote;
    end;
}

