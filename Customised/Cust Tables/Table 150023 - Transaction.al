table 150023 Transaction
{
    // version DEBUGW13.10.01,Rev01

    // LookupPageID = 150025;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Login Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Login Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Connection ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(6; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; Time; Time)
        {
            DataClassification = CustomerContent;
        }
        field(8; "User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(9; "Locking Rule Violations"; Boolean)
        {
            /*
             CalcFormula = Exist("Locking Rule Violation" WHERE("Login Date" = FIELD("Login Date"),
                                                                 "Login Time" = FIELD("Login Time"),
                                                                 "Connection ID" = FIELD("Connection ID"),
                                                                 "Transaction No." = FIELD("No.")));
                                                                 */
            Editable = false;
            // FieldClass = FlowField;
        }
        field(35; "Source Object"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Source Function/Trigger"; Text[132])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Source Text"; Text[132])
        {
            DataClassification = CustomerContent;
        }
        field(38; "Source Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Login Date", "Login Time", "Connection ID", "No.")
        {
        }
        key(Key2; Date, Time)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        /*
        TransactionLock.SetRange("Login Date", "Login Date");
        TransactionLock.SetRange("Login Time", "Login Time");
        TransactionLock.SetRange("Connection ID", "Connection ID");
        TransactionLock.SetRange("Transaction No.", "No.");
        TransactionLock.DeleteAll;
        */
    end;

    var
    //   TransactionLock: Record "Transaction Lock";
}

