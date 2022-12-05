table 33000925 "Sales Bought Out Material List"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "Order","Blanket Order";
            DataClassification = CustomerContent;
        }
        field(2; "Document No"; Code[30])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order | "Blanket Order"));
            DataClassification = CustomerContent;
        }
        field(3; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Schedule Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; No; Code[20])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(7; Quanity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Qty Shipped"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "To Be Shipped Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Item Lead Time"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Planned Dispatch Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Asign Vendor"; Code[20])
        {
            TableRelation = Vendor WHERE("Updated in Cashflow" = CONST(true));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                if "Planned Dispatch Date" = 0D then
                  error('You cannot asign vendor as there is not dispatch plan!');
                */

            end;
        }
        field(13; "Stock At Store"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD(No),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('STR')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Stock At MCH"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD(No),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('MCH')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Stock At R&D Store"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD(No),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('R&D STR')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Stock At CS Store"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD(No),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('CS STR')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Qty On Purch Orders"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Qty. to Receive" WHERE("Document Type" = CONST(Order),
                                                                       "Location Code" = CONST('STR'),
                                                                       "Qty. to Receive" = FILTER(> 0),
                                                                       "No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(18; "Qty Under Inspection"; Decimal)
        {
            CalcFormula = Sum("Quality Item Ledger Entry"."Remaining Quantity" WHERE("Inspection Status" = CONST("Under Inspection"),
                                                                                      "Sent for Rework" = CONST(false),
                                                                                      "Remaining Quantity" = FILTER(> 0),
                                                                                      "Location Code" = CONST('STR'),
                                                                                      Accept = CONST(true),
                                                                                      "Item No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(19; "Issued Material Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Sell To Customer No"; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(21; "Sell To Customer Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Unit Of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(23; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(24; Type; Enum "Sales Line Type")
        {

        }
        field(25; "Purchase Remarks"; Option)
        {
            OptionCaption = '" ,Sales Configuration Pending,Purchase order placed Mat Exp,Call letters Pending,Purchase Prices under negotiations,Material Received,Material Supplied-Invoice Pending,PO will place before Mfg items Ready"';
            OptionMembers = " ","Sales Conformation Pending","Purchase order placed Mat Exp","Call letters Pending","Purchase Prices under negotiations","Material Received","Material Supplied-Invoice Pending","PO will place before Mfg items Ready";
            DataClassification = CustomerContent;
        }
        field(26; To_Be_Purch_Qty; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Description 2"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(28; "RDSO Inspection Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Pending By"; Option)
        {
            OptionMembers = " ","R&D",Sales,LMD,Customer,Purchase,CUS;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                // Added by Pranavi on 20-Feb-2016 for the tracking of pending by removed date
                IF (xRec."Pending By" IN[1,2,3,4,5,6]) AND ("Pending By" = 0) THEN
                  "Pending By Removed Date" := TODAY()
                ELSE  "Pending By Removed Date" := 0D;
                // end by pranavi
                */

            end;
        }
        field(30; "Purchase Order  Number"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Vendor Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(32; "Ordered Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33; "To Be Rec Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No", "Line No", "Schedule Line No")
        {
        }
        key(Key2; "Document Type", "Document No", "Asign Vendor", No, "Line No", "Schedule Line No")
        {
        }
        key(Key3; "Asign Vendor", "Document Type", "Document No", No, "Line No", "Schedule Line No")
        {
        }
        key(Key4; No)
        {
        }
    }

    fieldgroups
    {
    }
}

