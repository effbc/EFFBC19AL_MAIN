table 33000919 "CS Transaction Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Transaction ID"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Transaction Type"; Option)
        {
            OptionCaption = ',Change Status,Card Transfer,Customer card Transfer';
            OptionMembers = ,"Change Status","Card Transfer","Customer card Transfer";
            DataClassification = CustomerContent;
        }
        field(3; "Transfer From Location"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = FILTER(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // Added by Pranavi on 29-jan-2016 for responsible person tracking
                IF "Transfer From Location" = 'LED-GEN' THEN BEGIN
                    IF "User ID" <> '' THEN
                        "Responsible Persion" := "User ID"
                    ELSE
                        "Responsible Persion" := USERID;
                END
                ELSE
                    IF NOT ("Transfer From Location" IN ['H-OFF', 'SERVICE']) THEN BEGIN
                        DivisionGRec.RESET;
                        DivisionGRec.SETRANGE(DivisionGRec.Code, "Transfer From Location");
                        IF DivisionGRec.FINDFIRST THEN BEGIN
                            UserGRec.RESET;
                            UserGRec.SETRANGE(UserGRec.EmployeeID, DivisionGRec."Project Manager");
                            IF UserGRec.FINDFIRST THEN
                                "Responsible Persion" := UserGRec."User ID";
                        END;
                    END;
            end;
        }
        field(4; "Transfer To Location"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = FILTER(false), Code = FILTER(<> 'H-OFF'));
        }
        field(5; "Mode of Transport"; Option)
        {
            OptionCaption = '" ,Courier,Train,Bus,By Hand,VRL,Lorry,ANL"';
            OptionMembers = " ",Courier,Train,Bus,"By Hand",VRL,Lorry,ANL;
        }
        field(6; "Courier Details"; Code[100])
        {
        }
        field(7; "Transaction Status"; Option)
        {
            OptionCaption = '-,In-Transit,Received';
            OptionMembers = "-","In-Transit",Received;
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(9; "Posting Date"; Date)
        {
        }
        field(10; "User ID"; Code[30])
        {
        }
        field(11; "Created Date"; Date)
        {
        }
        field(12; Remarks; Code[100])
        {
        }
        field(13; "DC No"; Code[20])
        {
        }
        field(14; "Customer No"; Code[20])
        {
            Description = 'for led cards';
            TableRelation = Customer."No.";

            trigger OnValidate();
            begin
                IF CustGRec.GET("Customer No") THEN
                    "Customer Name" := CustGRec.Name;
            end;
        }
        field(15; "Responsible Persion"; Code[30])
        {
            Description = 'For LED Cards';
        }
        field(16; "Customer Name"; Code[50])
        {
            Description = 'For LED Cards';
        }
    }

    keys
    {
        key(Key1; "Transaction ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VISHNUPRIYA']) THEN BEGIN
            ERROR('You dont have rights to delete the transaction');
        END;

        // checkStatus;

        // IF "Transaction Status"="Transaction Status"::"In-Transit" THEN
        //   ERROR('Transaction was already posted. Cannot be deleted');

        CSTLineGRec.RESET;
        CSTLineGRec.SETFILTER(CSTLineGRec."Transaction ID", "Transaction ID");
        IF CSTLineGRec.FINDSET THEN BEGIN
            CSTLineGRec.DELETEALL;
        END;

        CSTLedgGRec.RESET;
        CSTLedgGRec.SETFILTER(CSTLedgGRec."Transaction ID", "Transaction ID");
        CSTLedgGRec.SETFILTER(CSTLedgGRec.Received, '%1', FALSE);
        IF CSTLedgGRec.FINDSET THEN BEGIN
            CSTLedgGRec.DELETEALL;
        END;
    end;

    trigger OnInsert();
    begin
        IF UPPERCASE(USERID) <> 'EFFTRONICS\VISHNUPRIYA' THEN
            checkStatus;

        code_Sample := 'CS TRANS';
        NoSeriesMgt.InitSeries(code_Sample, code_Sample, TODAY, "Transaction ID", code_Sample);
    end;

    trigger OnModify();
    begin
        IF UPPERCASE(USERID) <> 'EFFTRONICS\SUJANI' THEN
            checkStatus;
    end;

    trigger OnRename();
    begin
        IF UPPERCASE(USERID) <> 'EFFTRONICS\SUJANI' THEN
            checkStatus;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        code_Sample: Code[10];
        CSTLineGRec: Record "CS Transaction Line";
        CSTLedgGRec: Record "CS Stock Ledger";
        DivisionGRec: Record "Employee Statistics Group";

        UserGRec: Record "User Setup";
        CustGRec: Record Customer;


    procedure checkStatus();
    begin
        IF Status <> Status::Open THEN
            ERROR('Transaction must be in Open state to modify');
    end;
}

