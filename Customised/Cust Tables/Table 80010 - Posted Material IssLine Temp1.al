table 80010 "Posted Material IssLine Temp1"
{
    // version MI1.0

    DrillDownPageID = "Posted Material Issue Subform";
    LookupPageID = "Posted Material Issue Line";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TempTransferLine: Record "Material Issues Line" temporary;
            begin
            end;
        }
        field(4; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TransferHeader: Record "Transfer Header";
                Location: Record Location;
            begin
            end;
        }
        field(5; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(16; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                UnitOfMeasure: Record "Unit of Measure";
                UOMMgt: Codeunit "Unit of Measure Management";
            begin
            end;
        }
        field(24; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(25; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(26; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(27; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(30; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ItemVariant: Record "Item Variant";
            begin
            end;
        }
        field(31; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(32; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(33; "Item Rcpt. Entry No."; Integer)
        {
            Caption = 'Item Rcpt. Entry No.';
            DataClassification = CustomerContent;
        }
        field(36; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(37; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(39; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = CustomerContent;
        }
        field(40; "Material Issue No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Material Issue Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5705; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5753; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "Standard Qutantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(50003; "Overages %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(50004; "Avg. unit cost"; Decimal)
        {
            Caption = 'Unit Cost.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60000; "Inventory Issue Method"; Option)
        {
            OptionMembers = FIFO,FEFO;
            DataClassification = CustomerContent;
        }
        field(60001; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                 Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60007; "Production BOM No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;
        }
        field(60010; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            TableRelation = "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                      "Prod. Order No." = FIELD("Prod. Order No."),
                                                                      "Prod. Order Line No." = FIELD("Prod. Order Line No."));
            DataClassification = CustomerContent;
        }
        field(60012; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60013; "Issued DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60014; Station; Code[10])
        {
            TableRelation = Station;
            DataClassification = CustomerContent;
        }
        field(60015; "Station Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60024; Flag; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60025; Saleorderno; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(33000250; "Spec ID"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Accepted)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000252; "Quantity Rejected"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = CONST(Reject)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            Description = 'QC1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(33000256; "Qty. Sending To Quality"; Decimal)
        {
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000257; "Qty. Sent To Quality"; Decimal)
        {
            Description = 'QC1.0';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000258; "Qty. Sending To Quality(R)"; Decimal)
        {
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000259; "Spec Version"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key3; "Prod. Order No.", "Item No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key4; "Material Issue No.", "Item No.")
        {
        }
        key(Key5; "Prod. Order No.", "Prod. Order Line No.", "Item No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key6; "Document No.", "Item No.")
        {
        }
        key(Key7; "Item No.", "Transfer-from Code", "Issued DateTime")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        Body := '****  Auto Mail Generated From ERP  ****';
        // Mail_From := 'erp@efftronics.net';
        // Mail_To :=
        Recipient.Add('anilkumar@efftronics.net');
        Recipient.Add('anilkumar@efftronics.net');
        Recipient.Add('santhoshk@efftronics.net');
        Recipient.Add('warupa@efftronics.net');
        Recipient.Add('sreenu@efftronics.net');
        Recipient.Add('phani@efftronics.net');
        // Mail_To:='santhoshk@efftronics.net';
        USER.SetRange(USER."User ID", UserId);//B2B
        if USER.Find('-') then
            Subject := User."User ID" + '  is trying to Delete Posted Material Issues Line Records';//B2B
                                                                                                    // Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, '');

        EmailMessage.Create(Recipient, Subject, Body, false);
        Error('U Dont Have Permissions to Delete');
    end;

    var
        Recipient: list of [Text];
        Email: Codeunit Email;
        USER: Record "User Setup";
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: list of [Text];
        //Mail: Codeunit Mail;
        Subject: Text[250];
        EmailMessage: Codeunit "Email Message";

}

