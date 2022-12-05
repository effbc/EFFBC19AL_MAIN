table 60119 "Order Stages"
{
    Permissions = TableData 60119=rimd;

    fields
    {
        field(1;"Document No.";Code[20])
        {
            CaptionML = ENU='Document No.',
                        ENN='Document No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            CaptionML = ENU='Line No.',
                        ENN='Line No.';
            DataClassification = ToBeClassified;
        }
        field(3;Type;Option)
        {
            CaptionML = ENU='Type',
                        ENN='Type';
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU=' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)',
                              ENN=' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(4;"No.";Code[20])
        {
            CaptionML = ENU='No.',
                        ENN='No.';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                SalesLine : Record 37;
                PrepaymentMgt : Codeunit 441;
                ProductionBOMHeader : Record 99000771;
                VersionMgt : Codeunit 99000756;
                SalesHeaderRDSO : Record 36;
                PrdOrder : Record 5405;
                rpoQty : Integer;
            begin
            end;
        }
        field(5;Description;Text[200])
        {
            CaptionML = ENU='Description',
                        ENN='Description';
            DataClassification = ToBeClassified;
        }
        field(6;Quantity;Decimal)
        {
            BlankZero = true;
            CaptionML = ENU='Quantity',
                        ENN='Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:5;

            trigger OnValidate();
            var
                ItemLedgEntry : Record 32;
                SalesHeader2 : Record 36;
                ReturnRcptLine : Record 6661;
                PrdOrder : Record 5405;
                rpoQty : Integer;
                uom : Record 5404;
            begin
            end;
        }
        field(7;"Outstanding Quantity";Decimal)
        {
            CaptionML = ENU='Outstanding Quantity',
                        ENN='Outstanding Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:5;
            Editable = true;
        }
        field(8;SubCategory;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Under design,Raw Mat,PCB''s,Mechanical,Wiring,Material Exp Date,Final BOM Approved,Test Zig''s,DOCS Status,Firmware,Software,Prod Plan Release Date,MFG Time,Product Ready Date,Dispacth Date';
            OptionMembers = ,"Under design","Raw Mat","PCB's",Mechanical,Wiring,"Material Exp Date","Final BOM Approved","Test Zig's","DOCS Status",Firmware,Software,"Prod Plan Release Date","MFG Time","Product Ready Date","Dispacth Date";
        }
        field(9;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Yes,No';
            OptionMembers = ,Yes,No;
        }
        field(10;"Completion Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Key";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.",Type,"No.",Description,Quantity,"Outstanding Quantity",SubCategory,Status,"Completion Date")
        {
        }
    }

    fieldgroups
    {
    }
}

