tableextension 70082 FixedAssetExt extends "Fixed Asset"
{
    fields
    {

        modify("FA Location Code")
        {
            trigger OnBeforeValidate()
            var
                FixedAssetTransfer: Record "Fixed Asset Transfer";
                NextEntryNo: Integer;
            //Text051: TextConst 'ENU=Enter the transfer reason';
            begin
                FixedAssetTransfer.Reset;
                FixedAssetTransfer.LockTable;
                if FixedAssetTransfer.Find('+') then
                    NextEntryNo := FixedAssetTransfer."Entry No."
                else
                    NextEntryNo := 0;

                if "FA Location Code" <> xRec."FA Location Code" then begin
                    FixedAssetTransfer.Init;
                    FixedAssetTransfer."Entry No." := NextEntryNo + 1;
                    FixedAssetTransfer."Fixed Asset No." := "No.";
                    FixedAssetTransfer."FA Location" := xRec."FA Location Code";
                    FixedAssetTransfer."FA New Location" := "FA Location Code";
                    FixedAssetTransfer.Date := WorkDate;
                    FixedAssetTransfer."User id" := UserId;
                    FixedAssetTransfer."Location Trns. Reason" := '';
                    FixedAssetTransfer.Insert;
                    Commit;
                    FixedAssetTransfer.SetRange(FixedAssetTransfer."Fixed Asset No.", "No.");
                    FixedAssetTransfer.SetRange(FixedAssetTransfer."Entry No.", FixedAssetTransfer."Entry No.");
                    if FixedAssetTransfer.Find('-') then
                        if PAGE.RunModal(60006, FixedAssetTransfer) = ACTION::LookupOK then;
                end;
            end;
        }
        modify("Responsible Employee")
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('EMPLOYEE CODES'));
            trigger OnBeforeValidate()
            var
                FixedAssetTransfer: Record "Fixed Asset Transfer";
                NextEntryNo: Integer;
            //Text060: TextConst 'ENU=Please Enter the Transfer Reason';
            begin
                FixedAssetTransfer.Reset;
                FixedAssetTransfer.LockTable;
                if FixedAssetTransfer.Find('+') then
                    NextEntryNo := FixedAssetTransfer."Entry No."
                else
                    NextEntryNo := 0;

                if "Responsible Employee" <> xRec."Responsible Employee" then begin
                    FixedAssetTransfer.Init;
                    FixedAssetTransfer."Entry No." := NextEntryNo + 1;
                    FixedAssetTransfer."Fixed Asset No." := "No.";
                    FixedAssetTransfer."Responsible Employee" := xRec."Responsible Employee";
                    FixedAssetTransfer."New Responsible Employee" := "Responsible Employee";
                    FixedAssetTransfer.Date := WorkDate;
                    FixedAssetTransfer."User id" := UserId;
                    //FixedAssetTransfer."Employee Trns. Reason" := '';
                    FixedAssetTransfer.Insert;
                    Commit;
                    FixedAssetTransfer.SetRange(FixedAssetTransfer."Fixed Asset No.", "No.");
                    FixedAssetTransfer.SetRange(FixedAssetTransfer."Entry No.", FixedAssetTransfer."Entry No.");
                    if FixedAssetTransfer.Find('-') then
                        if PAGE.RunModal(60007, FixedAssetTransfer) = ACTION::LookupOK then;
                end;
            end;
        }
        field(60001; "Location Trns. Reason"; Text[100])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Employee Trns. Reason"; Text[100])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "AMC No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "AMC Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "Service Tax Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Service Tax Groups".Code;
        }
        field(60006; Verified; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Verified then
                    "Verified Date" := Today;
            end;
        }
        field(60007; "Verified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60008; "QR Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60009; "Item Sub Sub Group Code"; Code[30])
        {
            TableRelation = "Item Sub Sub Group".Code WHERE("Item Sub Group Code" = FIELD("Item Sub Group Code"));
            DataClassification = CustomerContent;
        }
        field(60010; "Item Sub Group Code"; Code[20])
        {
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = CONST('B OUT'));
            DataClassification = CustomerContent;
        }
        field(60011; "Responsible Emp Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('EMPLOYEE CODES'),
                                                               Code = FIELD("Responsible Employee")));
            FieldClass = FlowField;
        }
        field(60012; "Responsible Employee1"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    trigger OnAfterInsert()
    begin
        // Added by Pranavi on 02-Nov-2016
        if "No." <> '' then begin
            "VAT Product Posting Group" := 'NO VAT';
            "FA Class Code" := 'TANGIBLE';
            "Gen. Prod. Posting Group" := 'FIXED AST.';
            "Excise Prod. Posting Group" := '12.5%';    // Need to be updated with excise % updated
            "Tax Group Code" := 'FIXED ASSE';
            //"Excise Accounting Type" := "Excise Accounting Type"::"With CENTVAT";
            FADeprBook1.Reset;
            FADeprBook1.SetRange(FADeprBook1."FA No.", "No.");
            if not FADeprBook1.FindFirst then begin
                FADeprBook.Init;
                FADeprBook."FA No." := "No.";
                FADeprBook."Depreciation Book Code" := 'COMPANY';
                FADeprBook."Depreciation Method" := FADeprBook."Depreciation Method"::"Declining-Balance 1";
            end;
            if CopyStr("No.", 1, 4) = 'COMP' then begin
                "FA Subclass Code" := 'COMPUTERS';
                FADeprBook."FA Posting Group" := 'COMPUTERS';
            end
            else
                if CopyStr("No.", 1, 3) = 'SW-' then begin
                    "FA Subclass Code" := 'SOFT WARE';
                    FADeprBook."FA Posting Group" := 'SOFTWARE';
                end
                else
                    if CopyStr("No.", 1, 3) = 'VEH' then begin
                        "FA Subclass Code" := 'VEHICLES';
                        FADeprBook."FA Posting Group" := 'VEHICLES';
                    end
                    else
                        if CopyStr("No.", 1, 3) = 'P&M' then begin
                            "FA Subclass Code" := 'PLANT &MAC';
                            FADeprBook."FA Posting Group" := 'PLA & MACH';
                        end
                        else
                            if CopyStr("No.", 1, 3) = 'O&E' then begin
                                "FA Subclass Code" := 'OFFICE';
                                FADeprBook."FA Posting Group" := 'OFF-EQUIP';
                            end
                            else
                                if CopyStr("No.", 1, 3) = 'MI-' then begin
                                    "FA Subclass Code" := 'MOBILE INS';
                                    FADeprBook."FA Posting Group" := 'MOBILE INS';
                                end
                                else
                                    if CopyStr("No.", 1, 4) = 'LAND' then begin
                                        "FA Subclass Code" := 'BUILDINGS';
                                        FADeprBook."FA Posting Group" := 'LAND';
                                    end
                                    else
                                        if CopyStr("No.", 1, 3) = 'GW-' then begin
                                            FADeprBook."FA Posting Group" := 'GOODWILL';
                                        end
                                        else
                                            if CopyStr("No.", 1, 3) = 'F&F' then begin
                                                "FA Subclass Code" := 'FURNITURES';
                                                FADeprBook."FA Posting Group" := 'FURN & FIX';
                                            end;
            FADeprBook1.Reset;
            FADeprBook1.SetRange(FADeprBook1."FA No.", "No.");
            if not FADeprBook1.FindFirst then
                FADeprBook.Insert;
        end;
        // End by Pranavi
    end;



    var
        FADeprBook1: Record "FA Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        "VAT Product Posting Group": Code[10];
        "Gen. Prod. Posting Group": Code[10];
        "Excise Prod. Posting Group": Code[10];
        "Tax Group Code": Code[10];
        "Excise Accounting Type": Option;
}

