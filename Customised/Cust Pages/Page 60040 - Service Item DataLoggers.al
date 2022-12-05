page 60040 "Service Item DataLoggers"
{
    // version B2B1.0

    PageType = Worksheet;
    SourceTable = "Item Wise Min. Req. Qty at Loc";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        ServiceItem.SETFILTER(ServiceItem."No.", '<>%1', Rec."Base Location");
                        IF PAGE.RUNMODAL(0, ServiceItem) = ACTION::LookupOK THEN BEGIN
                            Rec.Location := ServiceItem."No.";
                            Rec.Item := ServiceItem."Item No.";
                            Rec.Descirption := ServiceItem."Serial No.";
                        END;
                    end;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Descirption; Rec.Descirption)
                {
                    ApplicationArea = All;
                }
                field("Minimum Stock Quantity"; Rec."Minimum Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Warranty Qty"; Rec."Warranty Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        ServiceItemInsert.SETRANGE("No.", Rec."Base Location");
        IF ServiceItemInsert.FINDFIRST THEN;
    end;

    var
        NetworkDataloggers: Record "Item Wise Min. Req. Qty at Loc";
        ServiceItem: Record "Service Item";
        NetworkDataloggersInsert: Record "Item Wise Min. Req. Qty at Loc";
        ServiceItemInsert: Record "Service Item";
}

