tableextension 70071 SalesLineArchiveExt extends "Sales Line Archive"
{
    fields
    {
        field(60012; "Schedule Type"; Enum ScheduleType)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60020; "Material Reuired Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "CL_CNSGN  rcvd Qty"; Integer)
        {
            Description = 'added  by sujani for renucha mam';
            DataClassification = CustomerContent;
        }
        field(60025; "CL_CNSGN  rcvd Date1"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60110; "Supply Portion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60111; "Retention Portion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "Unitcost(LOA)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60118; MainCategory; Enum MainCategory)
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;

        }
        field(60119; SubCategory; Enum SubCategory)
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60120; Reason; Text[100])
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60121; Remarks; Text[100])
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60122; ProductGroup; Code[20])
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60123; Main_CATEGORY; Enum MainCATEGORY1)
        {
            DataClassification = CustomerContent;

        }
        field(60124; "Call Letter Status"; Enum CallLetterStatus)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;

        }
        field(60125; "RDSO Number"; Code[15])
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60126; Vertical; Enum Vertical)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60127; "Deviated Dispatch Date"; DateTime)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60128; "Dispatch Date"; DateTime)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60131; "Tentative RDSO Date"; Date)
        {
            Description = 'Added by Vishnu Priya on 14-12-2018';
            DataClassification = CustomerContent;
        }
        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
        field(95402; "Description 21"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(95403; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95401; "Description 1"; Text[200])
        {
            DataClassification = CustomerContent;
        }
    }

}

