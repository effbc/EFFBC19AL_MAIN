page 60270 "Customer Specification"
{
    // version B2BQTO

    Caption = 'Customer Specification';
    PageType = Worksheet;
    SourceTable = "Customer Specification";

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
                field("Lookup Code"; Rec."Lookup Code")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type ID"; Rec."Lookup Type ID")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type Name"; Rec."Lookup Type Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152006)
            {
                action(Specification)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        LookUpType.RESET;
                        //temporarily commented by vishnu priya on 22-09-2020
                        //LookUpType.SETRANGE("Lookup Type ID",3);
                        //LookUpType.SETRANGE("Lookup Type Name",'TERMS & CONDITIONS');
                        CLEAR(QuoteLookUpList);
                        QuoteLookUpList.SETRECORD(LookUpType);
                        QuoteLookUpList.SETTABLEVIEW(LookUpType);
                        QuoteLookUpList.LOOKUPMODE(TRUE);
                        QuoteLookUpList.CarryCustomer(Rec."Customer No.");
                        IF QuoteLookUpList.RUNMODAL = ACTION::LookupOK THEN;

                    end;
                }
            }
        }
    }

    var
        LookUpType: Record "Quote Lookup";
        QuoteLookUpList: Page "Quote LookUp List";
}

