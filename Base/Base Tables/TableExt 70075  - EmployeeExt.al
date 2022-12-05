tableextension 70075 EmployeeExt extends Employee
{
    DataCaptionFields = "E-Mail";
    fields
    {
        field(50010; "Job Title/Grade"; Code[10])
        {
            //TableRelation = "Pay Grade"."Designation Code";
            DataClassification = CustomerContent;
        }
        field(50011; "Department Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Project Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PROJECT'));
            DataClassification = CustomerContent;
        }
        field(50013; "Location Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('AREA'));
            DataClassification = CustomerContent;
        }
        field(50014; "Qualification Code"; Code[10])
        {
            TableRelation = Qualification;
            DataClassification = CustomerContent;
        }
        field(50015; "Sanctioning Incharge"; Code[20])
        {
            TableRelation = Employee."No." WHERE("Leave Date" = CONST(0D));
            DataClassification = CustomerContent;
        }
        field(50016; "Skill Code"; Code[10])
        {
            //TableRelation = "Pay Skill".Code;
            DataClassification = CustomerContent;
        }
        field(50017; "Branch Code"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50019; "Marital Status"; Enum MaritalStatus)
        {
            DataClassification = CustomerContent;

        }
        field(50020; "Spouse Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50021; "Marriage Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50022; "No of Children"; Integer)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50025; "Entitiled To Overtime"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50026; "Entitlement to ESI"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50027; "Entitlement to PF"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50030; "Home Page"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(50032; "Driving License No"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50033; "Valid Up To"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50034; Place; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50038; "PAN No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50039; "ESI No"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50040; "PF No"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50041; "ESI Dispensary"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50042; "Father/Husband"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50043; "Blood Group"; Enum BloodGroup)
        {
            DataClassification = CustomerContent;

        }
        field(50045; "Salary Stopped"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50046; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50050; "Payment Method"; Enum PaymentMethod)
        {
            DataClassification = CustomerContent;

        }
        field(50051; "Bank Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50052; "Bank Name"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50053; "Bank Branch"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50054; "Account Type"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50055; "Account No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50060; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50061; "Project Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50062; "Location Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50063; "Grade Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            // TableRelation = "Pay Grade";
        }
        field(50064; "Pay Element Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Pay Elements";
        }
        field(50065; "Qualification Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Pay Holidays";
        }
        field(50066; MonthFilter; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50067; YearFilter; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50068; TypeFilter; Enum TypeFilter)
        {
            DataClassification = CustomerContent;

        }
        field(50070; "Resignation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50071; "Leave Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50072; "Confirmation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50075; "Increment Effective Date"; Enum IncrementEffectiveDate)
        {
            DataClassification = CustomerContent;

        }
        field(50076; "Increment Month Interval"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50077; "Latest Pay Revision Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50078; "Latest Pay Effective Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50079; "No Of Month For Confirmation"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50081; MonthlyEmolumentTotal; Decimal)
        {
            /*
             CalcFormula = Sum("Pay Employee Pay Details"."Payable Amount" WHERE("Employee No" = FIELD("Employee No. Filter"),
                                                                                  Year = FIELD(YearFilter),
                                                                                  Month = FIELD(MonthFilter),
                                                                                  Type = FIELD(TypeFilter)));
             FieldClass = FlowField;
             */
        }
        field(50082; QualfiedForStatement217; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50083; QualfiedForStatement217AMT; Decimal)
        {
            Description = 'THIS FIELD IS USED IN STATEMENT REPORT JUST TO HOLD THE TOTAL ADDITION VALUE';
            DataClassification = CustomerContent;
        }
        field(50085; DaysDifference; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50089; "Status Tax"; Enum StatusTax)
        {
            DataClassification = CustomerContent;

        }
        field(50090; "Eligible Ded 80U"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50091; "TDS Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50092; "TDS Amount Actual"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50093; "TDS Ded US"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50095; Password; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(50096; "Recorded By"; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50105; "Occupation Code"; Code[20])
        {
            // TableRelation = "Pay Occupation Classification";
            DataClassification = CustomerContent;
        }
        field(50111; "ECS Bank Code No."; Text[9])
        {
            Caption = 'ECS Bank Code No.';
            DataClassification = CustomerContent;
        }
        field(50112; "ECS Bank Account Type"; Enum ECSBankAccountType)
        {
            Caption = 'ECS Bank Account Type';
            DataClassification = CustomerContent;

        }
        field(50113; "ECS Bank Ledger No"; Text[30])
        {
            Caption = 'ECS Bank Ledger No';
            DataClassification = CustomerContent;
        }
        field(50114; "Consent For Bulk Return"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50115; "Consent For ECS"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50116; "ECS Bank Account No."; Code[20])
        {
            Caption = 'ECS Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(50117; "ECS Bank Branch Name"; Text[30])
        {
            Caption = 'ECS Bank Branch Name';
            DataClassification = CustomerContent;
        }
        field(50118; "ECS Bank Name"; Text[30])
        {
            Caption = 'ECS Bank Name';
            DataClassification = CustomerContent;
        }
        field(50125; "Incentive %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50126; "Job Title Code"; Code[30])
        {
            //TableRelation = "Job Titles"."Job Code";
            DataClassification = CustomerContent;
        }
        field(50130; "PF Deduction on Actual Salary"; Boolean)
        {
            Caption = 'PF Deduction on Actual Salary';
            DataClassification = CustomerContent;
        }
        field(50131; "EPF Deduction on Salary Amount"; Boolean)
        {
            Caption = 'Employee''s PF Deduction on Salary Amount';
            DataClassification = CustomerContent;
        }
        field(50132; "VPF %"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Err001: Label 'Maximum limit defined in company policy is %1';
                Err002: Label 'Maximum limit for percentage value is 100';
            begin
            end;
        }
        field(50133; "VPF Amount"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Err003: Label 'Maximum limit defined in company policy is Rs %1';
                Err002: Label 'Negative values are not allowed';
            begin
            end;
        }
        field(50134; "PF Contribution Limit"; Decimal)
        {
            Caption = 'Employer''s PF Contribution Salary Limit';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Err001: Label 'Payroll Processing Month Date not defined';
                Err002: Label 'PF Policy not defined for current payroll processing month date : %1';
                Err003: Label 'PF Contribution Limit cannot be less than Rs %1';
            begin
            end;
        }
        field(50135; "PF %"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Err001: Label 'Mininmum value is %1';
            begin
            end;
        }
        field(50140; "Salary Processed"; Boolean)
        {
            Description = 'Checking for Salary Processing for the Processing Month';
            DataClassification = CustomerContent;
        }
        field(50145; "Salary Posted"; Boolean)
        {
            Description = 'Checking for Salary Posting for the Processing Month';
            DataClassification = CustomerContent;
        }
        field(50146; "Requested TDS Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50147; "Employee Posting Group 2"; Code[10])
        {
            Caption = 'Employee Posting Group';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(50148; "Employee Bus. Posting Group"; Code[10])
        {
            Caption = 'Employee Bus. Posting Group';
            //TableRelation = "Pay Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(50149; "Balance 2"; Decimal)
        {
            //CalcFormula = Sum("Detailed Employee Ledg. Entry".Amount WHERE("Employee No." = FIELD("No.")));
            //FieldClass = FlowField;
        }
        field(50150; "Balance (LCY)"; Decimal)
        {
            //CalcFormula = Sum("Detailed Employee Ledg. Entry"."Amount (LCY)" WHERE("Employee No." = FIELD("No.")));
            Caption = 'Balance (LCY)';
            //FieldClass = FlowField;
        }
        field(50151; "Net Change"; Decimal)
        {
            //CalcFormula = - Sum("Detailed Employee Ledg. Entry".Amount WHERE("Employee No." = FIELD("No."),
            // "Posting Date" = FIELD("Date Filter")));
            Caption = 'Net Change';
            //FieldClass = FlowField;
        }
        field(50152; "Net Change (LCY)"; Decimal)
        {
            //CalcFormula = - Sum("Detailed Employee Ledg. Entry"."Amount (LCY)" WHERE("Employee No." = FIELD("No."),
            //  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Net Change (LCY)';
            //FieldClass = FlowField;
        }
        field(50153; "Balance Due"; Decimal)
        {
            // CalcFormula = - Sum("Detailed Employee Ledg. Entry".Amount WHERE("Employee No." = FIELD("No."),
            //  "Initial Entry Due Date" = FIELD("Date Filter"),
            // "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance Due';
            //FieldClass = FlowField;
        }
        field(50154; "Balance Due (LCY)"; Decimal)
        {
            //CalcFormula = - Sum("Detailed Employee Ledg. Entry"."Amount (LCY)" WHERE("Employee No." = FIELD("No."),
            //  "Initial Entry Due Date" = FIELD("Date Filter"),
            //   "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance Due (LCY)';
            //FieldClass = FlowField;
        }
        field(50155; Payments; Decimal)
        {
            Caption = 'Payments';
            DataClassification = CustomerContent;
        }
        field(50156; Signature; BLOB)
        {
            DataClassification = CustomerContent;
        }
        field(50167; "Job Title1"; Text[40])
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnDelete()
    begin
        //MiscArticleInformation.SetRange("Employee No.", "No.");
        //MiscArticleInformation.DeleteAll; 
    end;
}

