xmlport 60001 Item_Details
{
    // version NAVW16.00

    // //Deleted Var(BNManagementCodeunitCodeunit8000) B2B

    Caption = 'Item';
    Encoding = UTF8;
    FormatEvaluate = Legacy;

    schema
    {
        tableelement(Item; Item)
        {
            MaxOccurs = Unbounded;
            XmlName = 'Item';
            fieldelement("ERP_ITEM_NO."; Item."No.")
            {
            }
            fieldelement(ITEM_DESCRIPTION; Item.Description)
            {
            }
            fieldelement(UOM; Item."Base Unit of Measure")
            {
                textattribute(LEAD_TIME)
                {

                    trigger OnBeforePassVariable();
                    begin
                        if Format(Item."Safety Lead Time") <> '' then
                            LEAD_TIME := CopyStr(Format(Item."Safety Lead Time"), 1, StrLen(Format(Item."Safety Lead Time")) - 1);
                    end;
                }
            }
            textelement(UNIT_COST)
            {

                trigger OnBeforePassVariable();
                begin
                    UNIT_COST := Format(Round(Item."Item Final Cost", 0.01));
                end;
            }
            textelement(MAIN_STR_STOCK)
            {
                textattribute(MAIN_STR_STOCK_VALUE)
                {

                    trigger OnBeforePassVariable();
                    begin
                        MAIN_STR_STOCK_VALUE := Format(Round(Stock_at_Stores * Item."Item Final Cost", 0.01));
                    end;
                }

                trigger OnBeforePassVariable();
                begin

                    MAIN_STR_STOCK := Format(Stock_at_Stores);
                end;
            }
            fieldelement(RD_STOCK; Item."Stock at RD Stores")
            {
                textattribute(RD_STOCK_VALUE)
                {

                    trigger OnBeforePassVariable();
                    begin
                        RD_STOCK_VALUE := Format(Round(Item."Stock at RD Stores" * Item."Item Final Cost", 0.01));
                    end;
                }
            }
            fieldelement(CS_STOCK; Item."Stock at CS Stores")
            {
                textattribute(CS_STOCK_VALUE)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CS_STOCK_VALUE := Format(Round(Item."Stock at CS Stores" * Item."Item Final Cost", 0.01));
                    end;
                }
            }
            fieldelement(MCH_STOCK; Item."Stock At MCH Location")
            {
                textattribute(MCH_STOCK_VALUE)
                {

                    trigger OnBeforePassVariable();
                    begin
                        MCH_STOCK_VALUE := Format(Round(Item."Stock At MCH Location" * Item."Item Final Cost", 0.01));
                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                Stock_at_Stores := Item_Stock.ITEM_STOCK(Item."No.");
                if (Stock_at_Stores + Item."Stock at RD Stores" + Item."Stock at CS Stores" + Item."Stock At MCH Location") = 0 then
                    currXMLport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        Stock_at_Stores: Decimal;
        Item_Stock: Codeunit "item stock at stores1";
        "Stock value": Decimal;
}

