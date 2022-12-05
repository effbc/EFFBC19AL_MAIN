page 60126 "Sale Order PO Details"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "SO Prod.Order Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        SalesLine.SETRANGE("Document No.", Rec."Sales Order No.");
        SalesLine.SETRANGE("Line No.", Rec."Sales Order Line No.");
        IF SalesLine.FINDFIRST THEN
            Rec."Sales Line Qty." := SalesLine.Quantity;
    end;

    trigger OnOpenPage();
    begin
        Rec.Type := Rec.Type::" ";
        Rec."No." := ' ';
    end;

    var
        SalesLine: Record "Sales Line";
}

