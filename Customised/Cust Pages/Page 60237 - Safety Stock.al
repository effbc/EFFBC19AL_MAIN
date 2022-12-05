page 60237 "Safety Stock"
{
    Editable = true;
    PageType = List;
    SourceTable = "Safety stock";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Product; Rec.Product)
                {
                    Editable = PageEditable;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = PageEditable;
                    ApplicationArea = All;
                }
                field("Product type"; Rec."Product type")
                {
                    Editable = PageEditable;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = PageEditable;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calc Safety Stock")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SS."Calc Safety Stock";
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You Do not have Rights!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You Do not have Rights!');
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You Do not have Rights!');
    end;

    trigger OnOpenPage();
    begin
        PageEditable := FALSE;
        IF USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            PageEditable := TRUE
        ELSE
            PageEditable := FALSE;
    end;

    var
        SS: Record "Safety stock";
        PageEditable: Boolean;
}

