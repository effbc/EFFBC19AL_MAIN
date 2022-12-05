page 56760 "Test Vendor List"
{
    SourceTable = Vendor;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        DtldVendLedgEntry.SETRANGE("Vendor No.", Rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
            }
            part(Control1102152007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1102152006; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1102152005; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1102152004; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

