tableextension 70125 ManufacturingSetupExt extends "Manufacturing Setup"
{
    fields
    {
        field(60001; "Soldering Time Req.for BID"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Soldering Time Req.for DIP"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Soldering Cost per Hour"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Development Cost Per Hour"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "MI Transfer From Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(60006; "Total Fixing Points Time"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; "Total Soldering Time"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60008; "Production Location"; Code[10])
        {
            Description = 'B2B';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(60009; "No. of Units/Day"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60010; "Consider Exp. Order Material"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

}

