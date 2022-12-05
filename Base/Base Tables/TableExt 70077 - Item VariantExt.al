tableextension 70077 ItemVariantExt extends "Item Variant"
{

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Make', ENN = 'Make';
            TableRelation = Make.Make;
        }

        modify("Item No.")
        {
            TableRelation = Item."No.";
        }

        modify(Description)
        {

            CaptionML = ENU = 'Part no';
        }
        modify("Description 2")
        {

            CaptionML = ENU = 'Description';
        }
        field(50000; "Product type"; Code[10])
        {
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = CONST('FPRODUCT'));
            DataClassification = CustomerContent;
        }
        field(50001; Package; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "No. of Pins"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "No. of Soldering Points"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Operating Temperature"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Storage Temperature"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50006; Humidity; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(50007; "ESD Sensitive"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50008; ESD; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50009; "Work area Temp &  Humadity"; Code[25])
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Soldering Time (Sec)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Soldering Temp."; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(50012; Priority; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Item Status"; Enum ItemStatus)
        {
            DataClassification = CustomerContent;
        }
        //B2BPGOn15Nov2022>>>
        field(50015; "Part No1"; Code[40])
        {
            DataClassification = CustomerContent;
        }//B2BPGOn15Nov2022>>>
    }
}

