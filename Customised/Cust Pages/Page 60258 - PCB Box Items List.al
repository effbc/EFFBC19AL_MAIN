page 60258 "PCB Box Items List"
{
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "PCB Box data" = rm;
    SourceTable = "PCB Box data";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
                field(CPCB; Rec.CPCB)
                {
                    ApplicationArea = All;
                }
                field("CPCB Description"; Rec."CPCB Description")
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
                field(Box; Rec.Box)
                {
                    ApplicationArea = All;
                }
                field("BOX Sort"; Rec."BOX Sort")
                {
                    Caption = 'Item Seq No';
                    ApplicationArea = All;
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (STRLEN(Rec."Color Code") <> 6) AND (STRLEN(Rec."Color Code") <> 0) THEN BEGIN
                            ERROR('Please enter correct color code( it must have 6 letters ) ');
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        Rec.SETCURRENTKEY(Product, CPCB, "Item No.");
    end;
}

