page 60032 "Item Wise Min. Req. Qty at Loc"
{
    PageType = Card;
    SourceTable = "Item Wise Min. Req. Qty at Loc";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Item; Rec.Item)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Type Of Module"; Rec."Type Of Module")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("AMC Qty"; Rec."AMC Qty")
                {
                    ApplicationArea = All;
                }
                field("Warranty Qty"; Rec."Warranty Qty")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Location"; Rec."Base Location")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Descirption; Rec.Descirption)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Qty"; Rec."Actual Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Minimum Stock Quantity"; Rec."Minimum Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Old Stock"; Rec."Old Stock")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    local procedure MinimumStockQuantityOnBeforeIn();
    begin
        IF (USERID <> 'EFFTRONICS\RAMADEVI') AND (USERID <> '07CS019') THEN
            ERROR('You have No Rights to Change Minimum Stock');
    end;


    local procedure MinimumStockQuantityOnInputCha(var Text: Text[1024]);
    begin
        "Old Stock" := "Minimum Stock Quantity";
    end;
}

