table 33000905 "PCB Vendors"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Vendor No."; Code[10])
        {
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*vendor.RESET;
                vendor.SETFILTER(vendor."No.","Vendor No.");
                IF vendor.FINDFIRST THEN
                "Vendor Name":=vendor.Name;
                 */

            end;
        }
        field(2; "Vendor Name"; Text[60])
        {
            DataClassification = CustomerContent;
        }
        field(3; "No. of Sides"; Option)
        {
            OptionMembers = SSIDE,DSIDE,"4L","6L",ML;
            DataClassification = CustomerContent;
        }
        field(4; "PCB Thickness"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Copper Clad Thickness"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Min PCB Qty"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*pcb.RESET;
                IF "Vendor No."='' THEN
                  ERROR('Select Vendor No.');
                IF "PCB Thickness"=0 THEN
                   ERROR('Enter PCB Thickness');
                IF "Copper Clad Thickness"=0 THEN
                   ERROR('Enter Copper Clad Thickness');
                
                pcb.SETFILTER(pcb."Vendor No.","Vendor No.");
                //pcb.SETFILTER(pcb."No. of Sides","No. of Sides");
                pcb.SETFILTER(pcb."Copper Clad Thickness",FORMAT("Copper Clad Thickness"));
                pcb.SETFILTER(pcb."PCB Thickness",FORMAT("PCB Thickness"));
                pcb.SETFILTER(pcb."Min PCB Qty",'<=%1',"Min PCB Qty");
                pcb.SETFILTER(pcb."Max PCB Qty",'>=%1',"Min PCB Qty");
                
                IF pcb.FINDFIRST THEN
                  ERROR('not valid Qty');
                 */

            end;
        }
        field(7; "Max PCB Qty"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*pcb.RESET;
                IF "Vendor No."='' THEN
                  ERROR('Select Vendor No.');
                IF "PCB Thickness"=0 THEN
                   ERROR('Enter PCB Thickness');
                IF "Copper Clad Thickness"=0 THEN
                   ERROR('Enter Copper Clad Thickness');
                
                pcb.SETFILTER(pcb."Vendor No.","Vendor No.");
                //pcb.SETFILTER(pcb."No. of Sides","No. of Sides");
                pcb.SETFILTER(pcb."Copper Clad Thickness",FORMAT("Copper Clad Thickness"));
                pcb.SETFILTER(pcb."PCB Thickness",FORMAT("PCB Thickness"));
                pcb.SETFILTER(pcb."Min PCB Qty",'<=%1',"Max PCB Qty");
                pcb.SETFILTER(pcb."Max PCB Qty",'>=%1',"Max PCB Qty");
                
                IF pcb.FINDFIRST THEN
                  ERROR('not valid Qty');
                 */

            end;
        }
        field(8; "Min PCB Area"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*pcb.RESET;
                IF "Vendor No."='' THEN
                  ERROR('Select Vendor No.');
                IF "No. of Sides"=0 THEN
                   ERROR('Enter PCB Thickness');
                IF "PCB Thickness"=0 THEN
                   ERROR('Enter Copper Clad Thickness');
                
                
                pcb.SETFILTER(pcb."Vendor No.","Vendor No.");
                //pcb.SETFILTER(pcb."No. of Sides","No. of Sides");
                pcb.SETFILTER(pcb."PCB Thickness",FORMAT("PCB Thickness"));
                pcb.SETFILTER(pcb."No. of Sides",FORMAT("No. of Sides"));
                
                pcb.SETFILTER(pcb."Copper Clad Thickness",'=%1',"Copper Clad Thickness");
                //pcb.SETFILTER(pcb."Max PCB Qty",'=%1',"Min PCB Qty");
                
                //pcb.SETFILTER(pcb."Min PCB Qty",'=%1',"Max PCB Qty");
                pcb.SETFILTER(pcb."Min PCB Qty",'=%1',"Min PCB Qty");
                
                
                
                
                
                
                pcb.SETFILTER(pcb."Max PCB Qty",'<=%1',"Max PCB Qty");
                pcb.SETFILTER(pcb."Min PCB Area",'>=%1',"Max PCB Qty");
                
                IF pcb.FINDFIRST THEN
                  ERROR('Check Quantity and Area');
                */

            end;
        }
        field(9; "Max PCB Area"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*pcb.RESET;
                IF "Vendor No."='' THEN
                  ERROR('Select Vendor No.');
                IF "No. of Sides"=0 THEN
                   ERROR('Enter PCB Thickness');
                IF "PCB Thickness"=0 THEN
                   ERROR('Enter Copper Clad Thickness');
                
                pcb.SETFILTER(pcb."Vendor No.","Vendor No.");
                //pcb.SETFILTER(pcb."No. of Sides","No. of Sides");
                pcb.SETFILTER(pcb."PCB Thickness",FORMAT("PCB Thickness"));
                pcb.SETFILTER(pcb."No. of Sides",FORMAT("No. of Sides"));
                
                //pcb.SETFILTER(pcb."Min PCB Qty",'=%1',"Min PCB Qty");
                //pcb.SETFILTER(pcb."Max PCB Qty",'=%1',"Min PCB Qty");
                //pcb.SETFILTER(pcb."Min PCB Qty",'=%1',"Max PCB Qty");
                //pcb.SETFILTER(pcb."Max PCB Qty",'=%1',"Max PCB Qty");
                
                //pcb.SETFILTER(pcb."Min PCB Area",'<=%1',"Max PCB Area");
                //pcb.SETFILTER(pcb."Max PCB Area",'>=%1',"Max PCB Area");
                
                pcb.SETFILTER(pcb."Max PCB Qty",'<=%1',"Max PCB Qty");
                pcb.SETFILTER(pcb."Max PCB Qty",'>=%1',"Min PCB Area");
                
                
                //pcb.SETFILTER(pcb."Min PCB Area",'>=%1',"Min PCB Area");
                //pcb.SETFILTER(pcb."Min PCB Area",'<=%1',"Min PCB Area");
                
                
                //pcb.SETFILTER(pcb."Max PCB Area",'>=%1',"Max PCB Area");
                //pcb.SETFILTER(pcb."Max PCB Area",'<=%1',"Max PCB Area");
                
                
                
                IF pcb.FINDFIRST THEN
                  ERROR('Check Quantity and Area');
                */

            end;
        }
        field(10; "Price per Sq.m"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Fast Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Super Fast Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Fast Lead Time"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Super Fast Lead Time"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Quotation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16; Type; Option)
        {
            OptionMembers = " ",AL,CEM3,FR1,FR2,GLEPFR4,METAL,"PAPER EPOXY";
            DataClassification = CustomerContent;
        }
        field(17; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(18; White; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; Green; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(20; Black; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; Blue; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "No. of Sides", "Vendor Name", "PCB Thickness", "Copper Clad Thickness", "Min PCB Area", "Max PCB Area", "Min PCB Qty", "Max PCB Qty", "Price per Sq.m", "Fast Price", "Quotation Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
         IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\SUVARCHALADEVI']) THEN
            Error('You do not right to delete!');
    end;

    trigger OnInsert();
    begin
       IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\VANIDEVI','EFFTRONICS\RENUKACH','EFFTRONICS\SUVARCHALADEVI']) THEN
            Error('You do not right to insert!');
    end;

    trigger OnModify();
    begin
        IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\VANIDEVI','EFFTRONICS\RENUKACH','EFFTRONICS\SUVARCHALADEVI']) THEN
            Error('You do not right to modify!');
    end;

    trigger OnRename();
    begin
         IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\VANIDEVI','EFFTRONICS\RENUKACH','EFFTRONICS\SUVARCHALADEVI']) THEN
            Error('You do not right to rename!');
    end;

    var
        pcb: Record "PCB Vendors";
        no: Text[30];
        vendor: Record Vendor;
        vendor_deliver_details: Record "PCB Vendor Details";
}

