pageextension 70030 CompanyInformationExt extends "Company Information"
{
    layout
    {
        addafter("Home Page")
        {
            field("Phone No. 2"; Rec."Phone No. 2")
            {
                ApplicationArea = All;
            }
        }
        addbefore("VAT Registration No.")
        {
            /*field("Composition2"; Composition)
            {
                ApplicationArea = All;
            }*/ //  B2B UPG
            field("C.S.T.Date"; Rec."C.S.T.Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("System Indicator Text")
        {
            group(Insurance)
            {
                CaptionML = ENU = 'Insurance',
                            ENN = 'Service Tax';
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Policy Name"; Rec."Insurance Policy Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {

    }

}

