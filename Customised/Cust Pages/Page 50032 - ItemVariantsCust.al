page 50032 "Item Variants Cust"
{
    Caption = 'Item Variants';
    DataCaptionFields = "Item No.";
    PageType = List;
    SourceTable = "Item Variant Cust";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Make; Make)
                {
                    ApplicationArea = All;
                }
                field("Operating Temperature"; "Operating Temperature")
                {
                    ApplicationArea = All;
                }
                field("Storage Temperature"; "Storage Temperature")
                {
                    ApplicationArea = All;
                }
                field("Part No"; "Part No")
                {
                    ApplicationArea = All;
                }
                field(Package; Package)
                {
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Status"; "Item Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("V&ariant")
            {
                Caption = 'V&ariant';
                Image = ItemVariant;
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("Item No."), "Variant Code" = FIELD(Make);
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        /*
        IF UPPERCASE(USERID) IN ['EFFTRONICS\PARVATHI','EFFTRONICS\VIJAYA','SUPER','EFFTRONICS\ANUSHAG','EFFTRONICS\RAMALAKSHMI','EFFTRONICS\KARUNA','EFFTRONICS\NAGAGAYATRI','EFFTRONICS\SUPRIYA']  THEN
          CurrPage.EDITABLE:= TRUE
        ELSE
          CurrPage.EDITABLE:= FALSE;
        */

        //added by Vishnu Priya on 10-08-2019
        IF NOT (SMTP_MAIL.Permission_Checking(USERID, 'ITEM-VARIENT-RIGHTS'))
          THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
        //end by Vishnu Priya on 10-08-2019

    end;

    var
        SMTP_MAIL: Codeunit "Custom Events";
}

