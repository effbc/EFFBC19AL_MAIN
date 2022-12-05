xmlport 50179 "Item Variant"
{
    Format = VariableText;

    schema
    {
        textelement(ItemVariants)
        {
            tableelement("<itemvariant>"; "Item Variant")
            {
                XmlName = 'ItemVariant';
                fieldelement(ItemNo; "<ItemVariant>"."Item No.")
                {
                }
                fieldelement(Description; "<ItemVariant>".Description)
                {
                }
                /*  fieldelement(Make; "<ItemVariant>".Make)
                  {
                  }
                  fieldelement(PartNo; "<ItemVariant>"."Part No")
                  {
                  }*/
                fieldelement(Package; "<ItemVariant>".Package)
                {
                }
                fieldelement(ItemStatus; "<ItemVariant>"."Item Status")
                {
                }
                fieldelement(OperatingTemperature; "<ItemVariant>"."Operating Temperature")
                {
                }
                fieldelement(StorageTemperature; "<ItemVariant>"."Storage Temperature")
                {
                }
                fieldelement(Humidity; "<ItemVariant>".Humidity)
                {
                }
                fieldelement(ESDSensitive; "<ItemVariant>"."ESD Sensitive")
                {
                }
                fieldelement(ESD; "<ItemVariant>".ESD)
                {
                }
                fieldelement(NoofPins; "<ItemVariant>"."No. of Pins")
                {
                }
                fieldelement(NoofSolderingPoints; "<ItemVariant>"."No. of Soldering Points")
                {
                }
                fieldelement(WorkareaTempHumadity; "<ItemVariant>"."Work area Temp &  Humadity")
                {
                }
                fieldelement(SolderingTemp; "<ItemVariant>"."Soldering Temp.")
                {
                }
                fieldelement(SolderingTimeSec; "<ItemVariant>"."Soldering Time (Sec)")
                {
                }
                fieldelement(Priority; "<ItemVariant>".Priority)
                {
                }

                trigger OnAfterGetRecord();
                begin

                    "<ItemVariant>"."Operating Temperature" := A2A.Ascii2Ansi("<ItemVariant>"."Operating Temperature");
                    "<ItemVariant>"."Storage Temperature" := A2A.Ascii2Ansi("<ItemVariant>"."Storage Temperature");
                    "<ItemVariant>"."Work area Temp &  Humadity" := A2A.Ascii2Ansi("<ItemVariant>"."Work area Temp &  Humadity");
                    "<ItemVariant>"."Soldering Temp." := A2A.Ascii2Ansi("<ItemVariant>"."Soldering Temp.");
                end;

                trigger OnAfterInsertRecord();
                begin

                    "<ItemVariant>"."Operating Temperature" := A2A.Ansi2Ascii("<ItemVariant>"."Operating Temperature");
                    "<ItemVariant>"."Storage Temperature" := A2A.Ansi2Ascii("<ItemVariant>"."Storage Temperature");
                    "<ItemVariant>"."Work area Temp &  Humadity" := A2A.Ansi2Ascii("<ItemVariant>"."Work area Temp &  Humadity");
                    "<ItemVariant>"."Soldering Temp." := A2A.Ansi2Ascii("<ItemVariant>"."Soldering Temp.");
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
        A2A: Codeunit "ANSI <-> ASCII converter";
}

