table 60049 "Item wise Requirement"
{
    // version B2B1.0

    Caption = 'Job Budget Line Archive';
    LookupPageID = "Job Budget line Archive List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[30])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Required Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Qty. In Material Issues"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Req Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '"It is not allowed to rename %1. "';
        Text001: Label 'Delete this line and enter a new line.';
        Res: Record Resource;
        ResGr: Record "Resource Group";
        // ResCost: Record "Resource Cost";
        // ResPrice: Record "Resource Price";
        Item: Record Item;
        GLAcc: Record "G/L Account";
        Job: Record Job;
        ItemVariant: Record "Item Variant";
        // SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        // PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        LastBudgetEntryDate: Date;
        NextStep: Integer;
        "--B2B--": Integer;
        TotalTime: Decimal;
        Temp: Decimal;


    local procedure UpdateJobBudgetEntry();
    begin
    end;


    local procedure FindResUnitCost(CalledByFieldNo: Integer);
    begin
    end;


    local procedure FindResPrice(CalledByFieldNo: Integer);
    begin
    end;


    procedure BudjetAttachments();
    var
        BudjetAttach: Record Attachments;
    begin
    end;
}

