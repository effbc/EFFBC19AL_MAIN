xmlport 50176 "Item Make and Part no"
{
    Format = VariableText;

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(OperatingTemperature; Item."Operating Temperature")
                {
                }
                fieldelement(StorageTemperature; Item."Storage Temperature")
                {
                }
                fieldelement(ESD; Item.ESD)
                {
                }
                fieldelement(ESDSensitive; Item."ESD Sensitive")
                {
                }
                fieldelement(ItemStatus; Item."Item Status")
                {
                }

                trigger OnAfterInsertRecord();
                begin

                    Item."Operating Temperature" := A2A.Ansi2Ascii(Item."Operating Temperature");
                    Item."Storage Temperature" := A2A.Ansi2Ascii(Item."Storage Temperature");
                    /*Item."Work area Temp &  Humadity":=A2A.Ansi2Ascii(Item."Work area Temp &  Humadity");
                    Item."Soldering Temp.":=A2A.Ansi2Ascii(Item."Soldering Temp.");
                     */

                end;
            }

            trigger OnBeforePassVariable();
            begin

                Item."Operating Temperature" := A2A.Ascii2Ansi(Item."Operating Temperature");
                Item."Storage Temperature" := A2A.Ascii2Ansi(Item."Storage Temperature");
                /*Item."Work area Temp &  Humadity":=A2A.Ascii2Ansi(Item."Work area Temp &  Humadity");
                Item."Soldering Temp.":=A2A.Ascii2Ansi(Item."Soldering Temp.");
                 */

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
        A2A: Codeunit "ANSI <-> ASCII converter";
}

