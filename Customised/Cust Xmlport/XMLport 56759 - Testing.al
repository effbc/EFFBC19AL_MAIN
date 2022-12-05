xmlport 56759 Testing
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Item_Prices)
        {
            tableelement(Item; Item)
            {
                AutoSave = false;
                XmlName = 'ItemRecord';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(UnitPrice; Item."Unit Price")
                {
                }

                trigger OnBeforeInsertRecord();
                begin
                    ItemRec.Init;
                    ItemRec."No." := Item."No.";
                    ItemRec."Unit Price" := Item."Unit Price";
                    ItemRec.Insert;
                end;
            }
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
        ItemRec: Record Item;
}

