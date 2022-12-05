tableextension 70000 PaymentTermsExt extends "Payment Terms"
{
    fields
    {
        field(60000; Rating; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
            end;
        }
        field(60001; "Update In Cashflow"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // UpdateInCashFlow(Rec);    // Added by Pranavi on 25-Jul-2015
            end;
        }
        field(60002; "Percentage 1"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
                // added by pranavi on 29-09-2016 for pvt payment terms integration
                if "Stage 1" = "Stage 1"::" " then
                    Error('Please enter Stage 1 value first!');
                // end by pranavi
            end;
        }
        field(60003; "Percentage 2"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
                // added by pranavi on 29-09-2016 for pvt payment terms integration
                if ("Percentage 1" = 0) then
                    Error('Percentage 1 must be entered first!');

                if "Stage 2" = "Stage 2"::" " then
                    Error('Please enter Stage 2 value first!');

                // end by pranavi
            end;
        }
        field(60004; "Stage 1"; Option)
        {
            OptionMembers = " ",Advance,Delivery,Credit,Against_RDSO_IC,Before_Delivery;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
            end;
        }
        field(60005; "Stage 2"; Option)
        {
            OptionMembers = " ",Advance,Delivery,Credit,Against_RDSO_IC,Before_Delivery;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
            end;
        }
        field(60006; Purchase; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
            end;
        }
        field(60007; Sales; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Update In Cashflow", false);
            end;
        }
        field(60008; "Percentage 3"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //pranavi
                TestField("Update In Cashflow", false);

                if ("Percentage 1" = 0) then
                    Error('Percentage 1 must be entered first!');

                if ("Percentage 2" = 0) then
                    Error('Percentage 2 must be entered first!');

                // added by pranavi on 29-09-2016 for pvt payment terms integration
                if "Stage 3" = "Stage 3"::" " then
                    Error('Please enter Stage 3 value first!');
                // end by pranavi
            end;
        }
        field(60009; "Stage 3"; Option)
        {
            OptionMembers = " ",Advance,Delivery,Credit,Against_RDSO_IC,Before_Delivery;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // TESTFIELD("Update In Cashflow",FALSE);     //pranavi
            end;
        }
        field(60010; DueDays; Integer)
        {
            Description = 'Added by sujani on 24-04-2018';
            DataClassification = CustomerContent;
        }
        field(60011; Description1; Text[100])
        {
            DataClassification = CustomerContent;
        }
        

    }
    keys
    {

        //Unsupported feature: PropertyChange on "Code(Key)". Please convert manually.

    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IdentityManagement.IsInvAppId THEN
      IF O365SalesInitialSetup.GET AND
         (O365SalesInitialSetup."Default Payment Terms Code" = Code)
      THEN
        ERROR(CannotRemoveDefaultPaymentTermsErr);

    WITH PaymentTermsTranslation DO BEGIN
      SETRANGE("Payment Term",Code);
      DELETEALL
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    {IF IdentityManagement.IsInvAppId THEN
    #2..9
    END;}
    */
    //end;


    //Unsupported feature: PropertyModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetLastModifiedDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
     SetLastModifiedDateTime;

    // added by pranavi on 29-09-2016 for pvt payment terms integration
    if not (Code in ['ASPERTENDR','ASPERMNC']) then
    begin
      if ("Percentage 1"+"Percentage 2"+"Percentage 3")<>100 then
        Error('PLEASE ENTER THE "PERCENTAGES" VALUES CORRECTLY ,SUM OF PERCENTAGE 1,PERCENTAGE 2,PERCENTAGE 3 SHOULD EQUAL TO 100');

      if ("Stage 1"="Stage 1"::Credit) or ("Stage 2"="Stage 2"::Credit) or ("Stage 3"="Stage 3"::Credit) then
      begin
        if Format("Due Date Calculation")='' then
          Error('PLEASE ENTER THE CREDIT PERIOD');
      end;

    end;
    // end by pranavi
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "TranslateDescription(PROCEDURE 1).PaymentTermsTranslation(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TranslateDescription : 462;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TranslateDescription : "Payment Term Translation";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "GetDescriptionInCurrentLanguage(PROCEDURE 2).Language(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //GetDescriptionInCurrentLanguage : 8;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GetDescriptionInCurrentLanguage : Language;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "GetDescriptionInCurrentLanguage(PROCEDURE 2).PaymentTermTranslation(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //GetDescriptionInCurrentLanguage : 462;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GetDescriptionInCurrentLanguage : "Payment Term Translation";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UsePaymentDiscount(PROCEDURE 3).PaymentTerms(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UsePaymentDiscount : 3;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UsePaymentDiscount : "Payment Terms";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "IdentityManagement(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IdentityManagement : 9801;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IdentityManagement : "Identity Management";
    //Variable type has not been exported.

    var
        "Purchase Header": Record "Purchase Header";
        PaymentTermsTranslation: Record "Payment Term Translation";
        // UserGRec: Record User;
        Stage1Txt: Option " ",Advance,Delivery,Credit;
        Stage2Txt: Option " ",Advance,Delivery,Credit;
        Stage3Txt: Option " ",Advance,Delivery,Credit;
        SalesFlag: Integer;
        PurchaseFlag: Integer;
        SalesHeader: Record "Sales Header";
        qry_text: Text;
}

