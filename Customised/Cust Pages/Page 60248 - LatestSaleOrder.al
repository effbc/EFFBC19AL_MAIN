page 60248 LatestSaleOrder
{
    CardPageID = "Sales Order";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableTemporary = false;
    SourceTableView = SORTING("Document Type", "No.") ORDER(Descending) WHERE("No." = FILTER('*14-15*' & '<>*/L*'));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        //MESSAGE(FORMAT(Steps));
        EXIT(Steps);
    end;

    trigger OnOpenPage();
    begin
        NEXT := 2;
        FINDLAST;
    end;
}

