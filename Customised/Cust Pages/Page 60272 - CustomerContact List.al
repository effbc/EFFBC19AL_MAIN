page 60272 "Customer/Contact List"
{
    // version B2BQTO

    PageType = List;
    SourceTable = "Customer/Contact Data";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Customer\Contact"; Rec."Customer\Contact")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Email Id"; Rec."Email Id")
                {
                    ApplicationArea = All;
                }
                field("Mail Send"; Rec."Mail Send")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin

        /*Customer.RESET;
         Customer.SETRANGE("No.",);
         IF Customer.FINDSET THEN
           REPEAT
             CustomerContactData.INIT;
             CustomerContactData."No." := NoLVar;
             CustomerContactData."Sales Quote No." := QuoteNoGVar;
             CustomerContactData."Customer\Contact" := Customer."No.";
             CustomerContactData."Email Id" := Customer."E-Mail";
             CustomerContactData.Name := Customer.Name;
             CustomerContactData.Place := Customer.City;
             CustomerContactData.Type := CustomerContactData.Type::Customer;
             CustomerContactData.INSERT;
             NoLVar +=1;
             Customer."Make A Quote" := FALSE;
             Customer.MODIFY;
           UNTIL Customer.NEXT = 0;
       END;
       */

    end;

    var
        SH: Record "Sales Header";
        cus: Record Customer;
        id: Integer;
        QuoteNoGVar: Code[20];
        PageVar: Page "Sales Quote";


    procedure SendQuoteNo(QuoLpar: Code[20]);
    begin
        QuoteNoGVar := QuoLpar;
    end;
}

