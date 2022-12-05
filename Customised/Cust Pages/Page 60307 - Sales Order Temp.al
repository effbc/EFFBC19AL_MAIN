page 60307 "Sales Order Temp"
{
    // version UPG1.3

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Orders Temp";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    procedure SetSelection(var SalesOrdersTemp: Record "Sales Orders Temp");
    begin
        CurrPage.SETSELECTIONFILTER(SalesOrdersTemp);
    end;
}

