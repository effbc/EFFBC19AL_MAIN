pageextension 70248 UserCardExt extends "User Card"
{
    layout
    {

        addafter("Office 365 Authentication")
        {
            group(Others)
            {
                /*field(levels; levels)
                {
                    ApplicationArea = All;
                }
                field(Dept; Dept)
                {
                    ApplicationArea = All;
                }
                field(MailID; MailID)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
                field(EmployeeID; EmployeeID)
                {
                    ApplicationArea = All;
                }
                field(Tams_Dept; Tams_Dept)
                {
                    ApplicationArea = All;
                }
                field(Dimension; Dimension)
                {
                    ApplicationArea = All;
                }*/

            }
        }
        addafter(Permissions)
        {
            group("Other Required Fields")
            {
                field("Dept."; Department)
                {
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    ApplicationArea = All;
                }
                field(Mobile_no; Mobile_no)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {



        modify(AcsSetup)
        {
            Promoted = true;
            PromotedIsBig = true;


        }
        modify(ChangePassword)
        {
            Promoted = true;
            PromotedIsBig = true;


        }
        modify(ChangeWebServiceAccessKey)
        {
            Promoted = true;
            PromotedIsBig = true;



        }
        addafter(ChangeWebServiceAccessKey)
        {
            action(Autofill)
            {
                Image = Apply;
                ApplicationArea = All;

                trigger OnAction();
                begin

                    Error_str := 'Enter the Following Fields: ';
                    IF (Department = '') THEN
                        Error_str := Error_str + 'Department; ';
                    IF (rec."Full Name" = '') THEN
                        Error_str := Error_str + 'Full Name; ';
                    /* IF (EmployeeID = '') THEN
                        Error_str := Error_str + 'EmployeeID; '; */ //B2B UPG
                    /*IF (MailID = '') THEN
                      Error_str := Error_str+'MailID; ';*/  // Commented by Rakesh as trainees don't have E-mail ID

                    IF (Error_str = 'Enter the Following Fields: ') THEN BEGIN
                        IF UserSetup.GET(Rec."User Name") THEN BEGIN
                            /* UserSetup."Current UserId" := EmployeeID;
                            UserSetup."E-Mail" := MailID; */ //B2B UPG
                            UserSetup.MODIFY;
                        END
                        ELSE BEGIN
                            UserSetup.INIT;
                            UserSetup."User ID" := rec."User Name";
                            UserSetup."Allow Posting From" := TODAY;
                            UserSetup."Allow Posting To" := TODAY;
                            /* UserSetup."Current UserId" := EmployeeID;
                            UserSetup."E-Mail" := MailID; */ //B2B UPG
                            UserSetup.INSERT;
                        END;

                        // Data into Employee
                        /* IF EmployeeGRec.GET(EmployeeID) THEN BEGIN
                            EmployeeGRec."First Name" := rec."Full Name";
                            EmployeeGRec."E-Mail" := MailID;
                            EmployeeGRec."Global Dimension 1 Code" := Department;
                            EmployeeGRec."Mobile Phone No." := Mobile_no;
                            EmployeeGRec.MODIFY;
                        END 
                        ELSE BEGIN
                            EmployeeGRec.INIT;
                            EmployeeGRec."No." := EmployeeID; 
                            EmployeeGRec."First Name" := Rec."Full Name";
                            EmployeeGRec."E-Mail" := MailID; 
                            EmployeeGRec."Global Dimension 1 Code" := Department;
                            EmployeeGRec."Mobile Phone No." := Mobile_no;
                            EmployeeGRec.INSERT;
                        END;*/ //B2B UPG

                        //data into Resource
                        /*IF ResourceGRec.GET(EmployeeID) THEN BEGIN
                            ResourceUOM.RESET;
                            ResourceUOM.SETFILTER(ResourceUOM."Resource No.", EmployeeID);
                            ResourceUOM.SETFILTER(ResourceUOM.Code, 'HOUR');
                            IF NOT ResourceUOM.FINDFIRST THEN BEGIN
                                ResourceUOM.INIT;
                                ResourceUOM."Resource No." := EmployeeID;
                                ResourceUOM.Code := 'HOUR';
                                ResourceUOM."Qty. per Unit of Measure" := 1;
                                ResourceUOM."Related to Base Unit of Meas." := TRUE;
                                ResourceUOM.INSERT;
                            END;
                            ResourceGRec."User Id" := Rec."User Name";
                            ResourceGRec.Name := Rec."Full Name";
                            ResourceGRec."Search Name" := Rec."Full Name";
                            ResourceGRec."Global Dimension 1 Code" := Department;
                            ResourceGRec."Base Unit of Measure" := 'HOUR';
                            ResourceGRec."Gen. Prod. Posting Group" := 'MISC';
                            IF (Dept = 'CS') AND (COPYSTR(Dimension, 1, 3) = 'CUS') THEN
                                ResourceGRec."VAT Prod. Posting Group" := 'NO VAT';
                            ResourceGRec.MODIFY;
                        END
                        ELSE BEGIN
                            ResourceUOM.RESET;
                            ResourceUOM.INIT;
                            ResourceUOM."Resource No." := EmployeeID;
                            ResourceUOM.Code := 'HOUR';
                            ResourceUOM."Qty. per Unit of Measure" := 1;
                            ResourceUOM."Related to Base Unit of Meas." := TRUE;
                            ResourceUOM.INSERT;

                            ResourceGRec.RESET;
                            ResourceGRec.INIT;
                            ResourceGRec."No." := EmployeeID;
                            ResourceGRec."User Id" := rec."User Name";
                            ResourceGRec.Name := Rec."Full Name";
                            ResourceGRec."Search Name" := rec."Full Name";
                            ResourceGRec."Global Dimension 1 Code" := Department;
                            ResourceGRec."Base Unit of Measure" := 'HOUR';
                            ResourceGRec."Gen. Prod. Posting Group" := 'MISC';
                            ResourceGRec.INSERT;
                        END;
                        //MESSAGE(Department);
                        DimValue.RESET;
                        DimValue.SETFILTER(DimValue.Code, EmployeeID);
                        IF NOT DimValue.FINDFIRST THEN BEGIN
                            // Finding Last Dimenison Value ID>>
                            DimValue2.RESET;
                            DimValue2.SETCURRENTKEY("Dimension Value ID");
                            IF DimValue2.FINDLAST THEN;
                            // Finding Last Dimenison Value ID<<
                            DimValue."Dimension Code" := 'EMPLOYEE CODES';
                            DimValue.Code := EmployeeID;
                            DimValue.Name := Rec."Full Name";
                            DimValue."Dimension Value Type" := DimValue."Dimension Value Type"::Standard;
                            DimValue."Dimension Value ID" := DimValue2."Dimension Value ID" + 1;
                            DimValue.INSERT;
                        END;
                        MESSAGE('Data Entered into User Setup, Employee, Resource Tables');
                    END
                    ELSE
                        ERROR(Error_str);*/
                    // end by rakesh

                    end;
                end;
            }
        }

    }
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        // Rev01 >>
        /*  
          UserSetup.RESET;
          UserSetup.SETRANGE("User ID","User Name");
          IF NOT UserSetup.FINDFIRST THEN BEGIN

          END;
          */
        // Rev01 <<

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        // Added by Rakesh for automation of Dept. and Phone. no on 15-Apr-14
        // start
        /* IF Department = '' THEN BEGIN
            EmployeeGRec.RESET;
            EmployeeGRec.SETRANGE("No.", EmployeeID);
            IF EmployeeGRec.FINDFIRST THEN BEGIN
                IF EmployeeGRec."Global Dimension 1 Code" <> '' THEN
                    Department := EmployeeGRec."Global Dimension 1 Code";
                IF EmployeeGRec."Mobile Phone No." <> '' THEN
                    Mobile_no := EmployeeGRec."Mobile Phone No.";
            END;
        END; */ //B2B UPG
        // end by Rakesh
    end;




    var
        UserSetup: Record "User Setup";
        EmployeeGRec: Record Employee;
        ResourceGRec: Record Resource;
        ResourceUOM: Record "Resource Unit of Measure";
        Department: Text[20];
        Mobile_no: Text[30];
        Error_str: Text[250];
        DimValue: Record "Dimension Value";
        DimValue2: Record "Dimension Value";





}

