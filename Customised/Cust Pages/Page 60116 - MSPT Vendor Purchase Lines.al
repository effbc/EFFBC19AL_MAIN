page 60116 "MSPT Vendor Purchase Lines"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Vendor Purchase Lines

    Caption = 'MSPT Vendor Purchase Lines';
    PageType = ListPart;
    SourceTable = Date;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                }
                field("Vend.""MSPT Balance Due"""; Vend."MSPT Balance Due")
                {
                    AutoFormatType = 1;
                    Caption = '"Balance Due "';
                    DrillDown = true;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        ShowVendEntriesDue;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        SetDateFilter;
        Vend.CALCFIELDS("MSPT Balance Due");
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        EXIT(PeriodFormMgt.FindDate(Which, Rec, VendPeriodLength));
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        EXIT(PeriodFormMgt.NextDate(Steps, Rec, VendPeriodLength));
    end;

    trigger OnOpenPage();
    begin
        Rec.RESET;
    end;

    var
        Vend: Record Vendor;
        MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry";
        PeriodFormMgt: Codeunit PeriodFormManagement;
        VendPeriodLength: Option Day,Week,Month,Quarter,Year,Period;
        AmountType: Option "Net Change","Balance at Date";


    procedure Set(var NewVend: Record Vendor; NewVendPeriodLength: Integer; NewAmountType: Option "Net Change","Balance at Date");
    begin
        Vend.COPY(NewVend);
        VendPeriodLength := NewVendPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
    end;


    local procedure ShowVendEntries();
    begin
        /*SetDateFilter;
        MSPTVendLedgEntry.RESET;
        MSPTVendLedgEntry.SETCURRENTKEY("Vendor No.","Posting Date");
        MSPTVendLedgEntry.SETRANGE("Vendor No.",Vend."No.");
        MSPTVendLedgEntry.SETFILTER("Posting Date",Vend.GETFILTER("Date Filter"));
        MSPTVendLedgEntry.SETFILTER("Global Dimension 1 Code",Vend.GETFILTER("Global Dimension 1 Filter"));
        MSPTVendLedgEntry.SETFILTER("Global Dimension 2 Code",Vend.GETFILTER("Global Dimension 2 Filter"));
        Page.RUN(0,MSPTVendLedgEntry);
        */

    end;


    local procedure ShowVendEntriesDue();
    begin
        SetDateFilter;
        MSPTVendLedgEntry.RESET;
        //MSPTVendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
        MSPTVendLedgEntry.SETCURRENTKEY("Vendor No.", Open, "MSPT Due Date");
        MSPTVendLedgEntry.SETRANGE("Vendor No.", Vend."No.");
        MSPTVendLedgEntry.SETRANGE(Open, TRUE);
        MSPTVendLedgEntry.SETFILTER("MSPT Due Date", Vend.GETFILTER("Date Filter"));
        MSPTVendLedgEntry.SETFILTER("Global Dimension 1 Code", Vend.GETFILTER("Global Dimension 1 Filter"));
        MSPTVendLedgEntry.SETFILTER("Global Dimension 2 Code", Vend.GETFILTER("Global Dimension 2 Filter"));
        PAGE.RUN(0, MSPTVendLedgEntry);
    end;


    local procedure SetDateFilter();
    begin
        IF AmountType = AmountType::"Net Change" THEN
            Vend.SETRANGE("Date Filter", Rec."Period Start", Rec."Period End")
        ELSE
            Vend.SETRANGE("Date Filter", 0D, Rec."Period End");
    end;
}

