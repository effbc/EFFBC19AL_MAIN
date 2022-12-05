table 33000940 "Order Stage"
{
    Permissions = TableData 60119 = rimd;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        ENN = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        ENN = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        ENN = 'Type';
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)',
                              ENN = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(4; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        ENN = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                SalesLine: Record 37;
                PrepaymentMgt: Codeunit 441;
                ProductionBOMHeader: Record 99000771;
                VersionMgt: Codeunit 99000756;
                SalesHeaderRDSO: Record 36;
                PrdOrder: Record 5405;
                rpoQty: Integer;
            begin
            end;
        }
        field(5; Description; Text[200])
        {
            CaptionML = ENU = 'Description',
                        ENN = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Quantity',
                        ENN = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            var
                ItemLedgEntry: Record 32;
                SalesHeader2: Record 36;
                ReturnRcptLine: Record 6661;
                PrdOrder: Record 5405;
                rpoQty: Integer;
                uom: Record 5404;
            begin
            end;
        }
        field(7; "Outstanding Quantity"; Decimal)
        {
            CaptionML = ENU = 'Outstanding Quantity',
                        ENN = 'Outstanding Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(8; SubCategory; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ,Design&Schematic,Tentative BOM,Material Exp Date,PCB''s Garbers,Procurement PCB Receving Date,H/W Clearence,Final PCB BOM,Sample Housing,Final Housing Clearence,Mechanical BOM,Wiring BOM,Final Product BOM,Installation BOM,Prod Plan Release Date,Test Code,Test Zigs,Final F/W,Prod Ready Date,Dispatch Date,Installation Date"';
            OptionMembers = " ","Design&Schematic","Tentative BOM","Material Exp Date","PCB's Garbers","Procurement PCB Receving Date","H/W Clearence","Final PCB BOM","Sample Housing","Final Housing Clearence","Mechanical BOM","Wiring BOM","Final Product BOM","Installation BOM","Prod Plan Release Date","Test Code","Test Zigs","Final F/W","Prod Ready Date","Dispatch Date","Installation Date";
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ,Completed,Pending,Inprogress,N/A"';
            OptionMembers = " ",Completed,Pending,Inprogress,"N/A";
        }
        field(10; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Key"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Creation Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Reg Stages"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ,Planned,Under Procurement,PRD Plan Released Date,UnderProduction,Registered for Insp,RDSO Inprogress,RDSO Completed,Exp Product Ready Date,Ready For Dispatch,Material Send on DC(Bill Pending)"';
            OptionMembers = " ",Planned,"Under Procurement","PRD Plan Released Date",UnderProduction,"Registered for Insp","RDSO Inprogress","RDSO Completed","Exp Product Ready Date","Ready For Dispatch","Material Send on DC(Bill Pending)";
        }
        field(14; "Stage Wise Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", Type, "No.", Description, Quantity, "Outstanding Quantity", SubCategory, "Reg Stages", Status, "Completion Date", "Key", "Creation Date", "Stage Wise Remarks")
        {
        }
    }

    fieldgroups
    {
    }
}

