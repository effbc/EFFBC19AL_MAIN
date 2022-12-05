xmlport 50022 "Eff Item UOM"
{

    schema
    {
        textelement(ItemUnitofMeasures)
        {
            tableelement("<itemunitofmeasure>"; "Item Unit of Measure")
            {
                XmlName = 'ItemUnitofMeasure';
                fieldelement(ItemNo; "<ItemUnitofMeasure>"."Item No.")
                {
                }
                fieldelement(Code; "<ItemUnitofMeasure>".Code)
                {
                }
                fieldelement(QtyperUnitofMeasure; "<ItemUnitofMeasure>"."Qty. per Unit of Measure")
                {
                }
                fieldelement(Length; "<ItemUnitofMeasure>".Length)
                {
                }
                fieldelement(Width; "<ItemUnitofMeasure>".Width)
                {
                }
                fieldelement(Height; "<ItemUnitofMeasure>".Height)
                {
                }
                fieldelement(Cubage; "<ItemUnitofMeasure>".Cubage)
                {
                }
                fieldelement(Weight; "<ItemUnitofMeasure>".Weight)
                {
                }
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
}

